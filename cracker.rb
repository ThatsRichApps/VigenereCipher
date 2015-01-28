require_relative 'decoder'

class Cracker
  attr_reader :code, :dictionary, :max_key_size, :decoder
  LETTERS = ('a'..'z').to_a

  def initialize(args)
    @dictionary = args[:dictionary] || Dictionary.new('words')
    @code = args[:code]
    @max_key_size = args[:max_key_size] || 14
    @decoder = args[:decoder] || Decoder
  end

  def decode(key, code)
    decoder.new(key: key, code: code).decode
  end

  def words_and_messages
    dictionary.words_by_size(3, max_key_size).each_with_object({}) do |word, obj|
      obj[word] = decode(word, code.downcase)
    end
  end

  def reject_and_accept_words(all_words, keys_and_msgs)
    all_words.reject! { |word| keys_and_msgs.values.grep(/#{word}/).empty? }
    reg = "(#{Regexp.union(all_words)})"
    vals = keys_and_msgs.values.grep(/^(#{reg})+$/)
    vals.each_with_object({}) { |val, obj| obj[keys_and_msgs.key(val)] = val }
  end

  def crack
    puts 'Cracking...'
    all_words = dictionary.all_words.dup
    reject_and_accept_words(all_words, words_and_messages)
  end
end
