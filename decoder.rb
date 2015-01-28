class Decoder
  attr_accessor :key, :code
  LETTERS = ('a'..'z').to_a

  def initialize(args)
    @key = args[:key]
    @code = args[:code]
  end

  def decode
    new_key = cycle.chars
    new_key.each_index.each_with_object('') do |ind, obj|
      obj << LETTERS[(LETTERS.index(code[ind]) % 26) - (LETTERS.index(new_key[ind]))]
    end
  end

  def cycle
    key.chars.cycle.inject('') do |acc, letter|
      return acc if acc.length == code.length
      acc << letter
    end
  end
end
