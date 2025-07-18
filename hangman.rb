require 'yaml'

class Game
  MAX_ATTEMPTS = 6

  attr_accessor :word, :correct_guesses, :incorrect_guesses, :attempts_left

  def initialize(word)
    @word = word.downcase
    @correct_guesses = []
    @incorrect_guesses = []
    @attempts_left = MAX_ATTEMPTS
  end

  def display_progress
  puts "\nWord : " + word.chars.map { |c| correct_guesses.include?(c) ? c : '_'}.join(' ')
  puts "Incorrect guesses: #{incorrect_guesses.join(', ')}"
  puts "Attempts left: #{attempts_left}"
  end

  def guess(letter)
    letter = letter.downcase
    return puts 'You already guessed that.' if correct_guesses.include?(letter) || incorrect_guesses.include?(letter)

    if word.include?(letter)
      correct_guesses << letter
      puts "Correct!"
    else
      incorrect_guesses << letter
      self.attempts_left -= 1
      puts "Incorrect!"
    end
  end

  def won?
    word.chars.all?{ |c| correct_guesses.include?(c)}
  end

  def lost?
    attempts_left <= 0
  end

  def save_game(filename)
    Dir.mkdir('saves') unless Dir.exist?('saves')
    File.open("saves/#{filename}.yml", 'w') { |f| f.write(YAML.dump(self))}
    puts "Game saved to saves/#{filename}.yml"
  end

  def self.load_game(filename)
    YAML.load_file(filename, permitted_classes: [Game])
  end
end

def load_dictionary
  file = File.read("google-10000-english-no-swears.txt").split("\n")
  file.select { |word| word.length.between?(5,12) }
end

def new_game
  word = load_dictionary.sample
  Game.new(word)
end

def list_saved_games
  Dir.mkdir('saves') unless Dir.exist?('saves')
  Dir.entries('saves').select { |f| f.end_with?('.yml') }.map { |f| f.gsub('.yml', '') }
end

def start
  puts 'Welcome to Hangman!'
  puts '1. New Game'
  puts '2. Load Game'
  print 'Choose Option: '
  choice = gets.chomp

  game = nil

  if choice == '1'
    game = new_game
  elsif choice == '2'
    saves = list_saved_games
    
    if saves.empty?
      puts 'No saved games found.'
      return
    end

    puts 'Saved Games: '
    saves.each_with_index { |save, i | puts "#{i + 1}. #{save}" }
    print 'Choose save to load: '
    index = gets.chomp.to_i - 1
    if index.between?(0, saves.size - 1)
      game = Game.load_game("saves/#{saves[index]}.yml")
    else
      puts 'Invalid Selection.'
      return
    end
  else 
    puts 'Invalid Choice.'
  end
  
  play(game) if game
end

def play(game)
  until game.won? || game.lost?
    game.display_progress
    print "Enter a letter (or type 'save' to save): "
    input = gets.chomp
    
    if input.downcase == 'save'
      print 'Enter file name to save: '
      filename = gets.chomp.strip
      game.save_game(filename)
      puts 'Game saved. Goodbye!'
      break
    elsif input.length == 1 && input.match?(/[a-z]/i)
      game.guess(input)
    else
      puts 'Invalid input.'
    end
  end
  
  if game.won?
    puts "\n🎉 Congratulations! You guessed the word: #{game.word}"
  elsif game.lost?
    puts "\n💀 You lost. The word was: #{game.word}"
  end
end

start
