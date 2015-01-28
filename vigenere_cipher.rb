#  Vigenere Cipher requires a key and a message. It works like this:
#
#  Key:
#      REDDIT
#  Message:
#      TODAYISMYBIRTHDAY
#
#   REDDITREDDITREDDI
#   TODAYISMYBIRTHDAY
#   -----------------
#   ksgdgbjqbeqkklgdg
#
#  Using a 0 based alphabet (A=0), R is the 17th letter of the alphabet and
#  T is the 19th letter of the alphabet. (17 + 19) mod 26 = 11 which is where
#  K resides in the alphabet. Repeat for each key/message letter combination
#  until done.
#
#  Today's problem of the day is two part. The first part is to implement
#  a Vigenère cipher in the programming language of your choice. Feel free
#  to post solutions or links to solutions in the comments.
#
#  The second part is to try and implement something to crack the message
#  below (the key is 5 or less characters).
#
#  zejfokhtmsrmelcpodwhcgaw

require_relative 'dictionary'
require_relative 'decoder'
require_relative 'encoder'
require_relative 'cracker'

class VigenereCipher
  LETTERS = ('a'..'z').to_a
  ONLY_LETTERS_GSUB = /[^a-zA-Z]/
  DICTIONARY_FILE = 'words' # UNIX has a great dictionary file located at /usr/share/dict/words

  attr_reader :encoder, :decoder, :cracker

  def initialize(args = {})
    args = defaults.merge(args)
    @encoder = args[:encoder]
    @decoder = args[:decoder]
    @cracker = args[:cracker]
  end

  def crack(code)
    cracker.new(code: code).crack
  end

  def decode(key, code)
    decoder.new(key: key, code: code).decode
  end

  def encode(key, message)
    encoder.new(key: key, message: message).encode
  end

  private

  def defaults
    { encoder: Encoder,
      decoder: Decoder,
      cracker: Cracker }
  end
end
