require 'byebug'

class ComputerPlayer
    attr_accessor :name, :known_pos, :matched_cards, :previous_guess, :previous_pos

    def initialize(name = "Jessica")
      @name = name
      @known_pos = {}
      @previous_guess = nil
      @matched_cards = {}
    end

    def receive_revealed_card(pos,value)
      #debugger
      if found_match?(pos, value)
          old_pos = @known_pos.select{|key, v| v == value }.keys[0]
          receive_match([old_pos,pos],value)
      end
      @known_pos[pos] = value unless @known_pos.keys.include?(pos)
      if @previous_guess.nil?
        @previous_guess = value
      else
        @previous_guess = nil
      end
    end

    def found_match?(pos, value)
      @known_pos.values.include?(value) && !@known_pos.keys.include?(pos)
    end

    def receive_match(pos, value)
      @matched_cards[pos[0]]= value
      @matched_cards[pos[1]]= value
    end

    def no_matches?()
      @matched_cards.keys.empty?
    end

    def has_match?(previous_guess)

      !@matched_cards.empty? && @matched_cards.values.include?(@previous_guess)
    end

    def get_guess()
      
      guess = nil
      if @previous_guess.nil?
        if no_matches?
          guess = [rand(4), rand(4)]
        else
          guess = @matched_cards.keys.sample
        end
      else
        if has_match?(@previous_guess)
          #debugger

          @matched_cards.delete(previous_pos)
          guess = @matched_cards.select{|key,_| @matched_cards[key] == @previous_guess}.keys[0]
          @matched_cards.delete(guess)
        else
          guess = [rand(4), rand(4)]
        end
      end
      @previous_pos = guess
      return guess
    end

  end
