class Encoder
  attr_accessor :key, :message
  LETTERS = ('a'..'z').to_a

  def initialize(args)
    @key = args[:key]
    @message = args[:message]
  end

  def encode
    new_key = cycle.chars
    new_key.each_index.each_with_object('') do |ind, obj|
      obj << LETTERS[(LETTERS.index(new_key[ind]) + LETTERS.index(message[ind])) % 26]
    end
  end

  def cycle
    key.chars.cycle.inject('') do |acc, letter|
      return acc if acc.length == message.length
      acc << letter
    end
  end
end
