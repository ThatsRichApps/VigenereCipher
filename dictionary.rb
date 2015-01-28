class Dictionary
  EXTRA_WORDS = %w(a i is as at be ed he ho in it jo jr la re ok mo mr si sr st
                   no my me ma if hi ha go ex do db by ax an of oh or ow ox pi
                   so to uh um up us vs we yo)

  attr_reader :word_list

  def initialize(file)
    @word_list = File.read(file).downcase
  end

  def all_words
    @all_words ||= (word_list.scan(/^\w{3,}$/) + EXTRA_WORDS).uniq
  end

  def words_by_size(min, max)
    (word_list.scan(/^\w{#{min},#{max}}$/)).uniq
  end
end
