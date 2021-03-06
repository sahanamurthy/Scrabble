module Scrabble
  class Scoring
    LETTER_SCORES = {"a" => 1, "c" => 3, "b" => 3, "e" => 1, "d" => 2, "g" => 2,
             "f" => 4, "i" => 1, "h" => 4, "k" => 5, "j" => 8, "m" => 3,
             "l" => 1, "o" => 1, "n" => 1, "q" => 10, "p" => 3, "s" => 1,
             "r" => 1, "u" => 1, "t" => 1, "w" => 4, "v" => 4, "y" => 4,
             "x" => 8, "z" => 10}

    def self.tie_breaker(tie_words)
      tie_words.each do |word|
        if word.length == 7
          return word
        else
          # The & calls to_proc on the object
          # Returns a proc object that expects a parameter and calls a method
          # parameter is the tie_words and the method is length
          return tie_words.min_by(&:length)
        end
      end
    end

    def self.score(word)
      # Word gets changed into an Array by the chars method
      # The *  splat operator expands an Array (the word array) into a list of arguments
      # those arguments (the letters) get converted to the appropriate value that corresponds with LETTER_SCORES
      # last, the sum method adds up the list of integers
      word_score = LETTER_SCORES.values_at(*word.downcase.chars).sum
      word.length == 7 ? word_score += 50 : word_score
    end

    def self.highest_score_from(words)
      unless words.class == Array && words.length > 0
        raise ArgumentError
      end
      scores_and_words = words.group_by { |word| score(word) }
      highest_words = scores_and_words.max_by { |score, word_list| score }
      highest_words[1].length > 1 ? tie_breaker(highest_words[1]) : highest_words[1].join
    end
  end
end
