require File.expand_path("../random_word", __FILE__)

class Hangman
  def initialize
    @game_over = false
    @guessed_letters = []
    @random_word = RandomWord.new
    @wrong_guesses_left = 10
  end

  def play!
    random_word = @word
    @random_letters = random_word.chars.to_a
    print_instructions
    play_loop
  end

  def play_loop
    while !@game_over
      puts self
      get_letter
      already_guessed?
      @guessed_letters << @letter
      if have_lives? && !won?
        get_response

      elsif won?
        puts "#{@random_word}"
        puts "You are victorious human. For now..."
        puts "The word was in fact #{@random_word}"
        game_end
      else
        lost
      end
    end
  end

  def game_end
    @game_over = true
  end

  def lost
  	puts self
    puts "Hhaha, the computer remains the winner"
    puts "The right word was: #{@random_word}"
    game_end
  end

  def won?
    (@random_letters - @guessed_letters).length == 0
  end

  def have_lives?
    @turns > 1
  end

  def already_guessed?
    if @guessed_letters.include? @letter
      puts "You have already guessed the letter #{@letter}"
      play_loop
    end
  end

  def get_response
    if @letter.size != 1
      puts "This is not a valid input"
    elsif @random_letters.include? @letter
      puts "Yes, this word does include #{@letter}"
    else
      @turns -= 1
      puts "This word does not contain your letter #{@letter}. You have #{@turns} guesses left."
    end
  end

  def get_letter
    @letter = gets.chomp.downcase
  end

  def print_instructions
    puts "Welcome to Hangman... "
    puts "Guess a letter please"
  end

  def to_s
    output = ""

    t = @turns

    ascii = <<-eos
    _____
    |    #{t<7 ? '|':' '}
    |    #{t<6 ? 'O':' '}
    |   #{t<2 ? '/':' '}#{t<5 ? '|':' '}#{t<1 ? '\\':' '}
    |   #{t<4 ? '/':' '} #{t<3 ? '\\':' '}
    |
    ===
    eos

    output << ascii

    @random_letters.each do |l|
      output << (@guessed_letters.include?(l) ? l : '__') + ' '
    end
    output
  end
end
