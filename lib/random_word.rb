class RandomWord
  attr_reader :word
  WORDS = %w(programming monkey business ruby style guide)

  def initialize
    @word = WORDS.sample
  end
end
