########## Angkan Baidya ##########
########## 112309655 #############
########## abaidya #############

$pirateColors = [:blue, :green, :purple, :gold]
$maxPlayersAllowed = 5
$minPlayersAllowed = 2
$playerNames = ["Joy", "Nan", "Sat"]

class MerchantShip
  def initialize(value)
    @value = value
  end
  attr_reader :value

end

class PirateShip
  def initialize(color, attack_value)
    @color = color
    @attack_value = attack_value
  end
  attr_reader :color, :attack_value

end

class Captain
  def initialize(color)
    @color = color
  end
  attr_reader :color
end

class Admiral
  @@__instance = nil
  def initialize
    if @@__instance != nil
      raise RuntimeError
    else
      @@__instance
    end
  end

  def self.get_instance
    if @@__instance == nil
      Admiral.new()
    else
      return @@__instance
    end
  end
end

class Player
  def initialize(name)
    @name = name
    @merchant_ships_at_sea = []
    @merchant_ships_captured = []
    @hand = []
    @merchant_pirates = {}
    @dealer = false

  end
  attr_accessor :name
  attr_accessor :merchant_ships_at_sea
  attr_accessor :merchant_ships_captured
  attr_accessor :merchant_pirates
  attr_accessor :dealer
  attr_accessor :hand

  def deal(game_state)
    @dealer = true
    game_state.deck.cards = game_state.deck.cards.shuffle
    game_state.players.each do |i|
      while i.hand.length < 6
        cardtoadd = game_state.deck.cards.pop
        unless i.hand.include? cardtoadd
          i.hand.append(cardtoadd)
        else
          game_state.deck.cards.append(cardtoadd)
          game_state.deck.cards.shuffle
        end

      end
    end

  end

  def draw_card(game)
    card_to_add = game.deck.cards.pop
    @hand.append(card_to_add)
  end

  def float_merchant(card)
    if card.class != MerchantShip
      return false
    end
    @hand.each do |i|
      if i == card
        @merchant_ships_at_sea.append(i)
        @hand.delete(i)
        return true
      end
    end
    return false
  end

  def play_pirate(pirate_card, merchant_card, pl)
    if pirate_card.class != PirateShip
      return false
    end
    if merchant_card.class != MerchantShip
      return false
    end
    unless @hand.include? pirate_card
      return false
    end
    unless pl.merchant_ships_at_sea.include? merchant_card
      return false
    end
    color = pirate_card.color
    if pl.merchant_pirates.length != 0
      pl.merchant_pirates.keys.each do |x|
        if pl.merchant_pirates[x][0][0] == self
          if pl.merchant_pirates[x][0][1].color != color
            return false
          end
        end
      end
    end
    pairlist = [self, pirate_card]
    unless pl.merchant_pirates.include? merchant_card
      pl.merchant_pirates[merchant_card] = []
    end
    pl.merchant_pirates[merchant_card] << (pairlist)
    @hand.delete(pirate_card)
    return true
  end

  def play_captain(captain_card, merchant_card, pl)
    unless @hand.include? captain_card
      return false
    end
    unless pl.merchant_ships_at_sea.include? merchant_card
      return false
    end
    color = captain_card.color
    if pl.merchant_pirates.length != 0
      pl.merchant_pirates.keys().each do |x|
        if pl.merchant_pirates[x][0][0] == self
          if pl.merchant_pirates[x][0][1].color != color
            return false
          end
        end
      end
    end
    pairlist = [self, captain_card]
    unless pl.merchant_pirates.include? merchant_card
      pl.merchant_pirates[merchant_card] = []
    end
    pl.merchant_pirates[merchant_card] << pairlist
    @hand.delete(captain_card)
    return true
  end

  def play_admiral(admiral_card, merchant_card)
    checkformerchant = false
    unless @hand.include? admiral_card
      return false
    end
    if @merchant_pirates.length <1
      return false
    end
    @merchant_pirates.keys.each do |x|
      if x == merchant_card
        checkformerchant = true
      end
    end
    if checkformerchant == false
      return false
    end
    pairlist = [self, admiral_card]
    unless @merchant_pirates.include? merchant_card
      @merchant_pirates[merchant_card] = []
    end
    @merchant_pirates[merchant_card]<< pairlist
    @hand.delete(admiral_card)
    return true
  end
end

class Deck
  @@__instance = nil
  def initialize
    if @@__instance != nil
      raise RuntimeError
    else
      @cards = []
      merchant8pts = MerchantShip.new(8)
      @cards.append(merchant8pts)
      merchant7pts = MerchantShip.new(7)
      @cards.append(merchant7pts)
      (0...2).each do |i|
        merchant6pts = MerchantShip.new(6)
        @cards.append(merchant6pts)
      end

      (0...5).each { |i|

        merchant5pts = MerchantShip.new(5)
        merchant4pts = MerchantShip.new(4)
        merchant2pts = MerchantShip.new(2)
        @cards.append(merchant5pts)
        @cards.append(merchant4pts)
        @cards.append(merchant2pts)
      }
      (0...6).each { |i|
        merchant3pts = MerchantShip.new(3)
        @cards.append(merchant3pts)

      }
      admiralCard = Admiral.get_instance
      @cards.append(admiralCard)
      (0...2).each { |i|
        pirateCard1 = PirateShip.new("blue", 1)
        pirateCard4 = PirateShip.new("blue", 4)
        @cards.append(pirateCard1)
        @cards.append(pirateCard4)
      }
      (0...4).each { |i|
        pirateCard2 = PirateShip.new("blue", 2)
        pirateCard3 = PirateShip.new("blue", 3)
        @cards.append(pirateCard2)
        @cards.append(pirateCard3)
      }
      (0...2).each { |i|
        pirateCard1 = PirateShip.new("green", 1)
        pirateCard4 = PirateShip.new("green", 4)
        @cards.append(pirateCard1)
        @cards.append(pirateCard4)
      }
      (0...4).each { |i|
        pirateCard2 = PirateShip.new("green", 2)
        pirateCard3 = PirateShip.new("green", 3)
        @cards.append(pirateCard2)
        @cards.append(pirateCard3)
      }
      (0...2).each { |i|
        pirateCard1 = PirateShip.new("purple", 1)
        pirateCard4 = PirateShip.new("purple", 4)
        @cards.append(pirateCard1)
        @cards.append(pirateCard4)
      }
      (0...4).each { |i|
        pirateCard2 = PirateShip.new("purple", 2)
        pirateCard3 = PirateShip.new("purple", 3)
        @cards.append(pirateCard2)
        @cards.append(pirateCard3)
      }
      (0...2).each { |i|
        pirateCard1 = PirateShip.new("gold", 1)
        pirateCard4 = PirateShip.new("gold", 4)
        @cards.append(pirateCard1)
        @cards.append(pirateCard4)
      }
      (0...4).each { |i|
        pirateCard2 = PirateShip.new("gold", 2)
        pirateCard3 = PirateShip.new("gold", 3)
        @cards.append(pirateCard2)
        @cards.append(pirateCard3)
      }

      captainBlue = Captain.new("blue")
      captainGreen = Captain.new("green")
      captainPurple = Captain.new("purple")
      captainGold = Captain.new("gold")
      @cards.append(captainBlue)
      @cards.append(captainGreen)
      @cards.append(captainPurple)
      @cards.append(captainGold)
      @@__instance
    end

  end
  attr_accessor :cards


  def self.get_instance
    if @@__instance == nil
      Deck.new()
    else
      return @@__instance
    end
  end


end



class Game
  def initialize(deck)
    @deck = deck
    @players = []
    @current_player = Player

  end
  attr_accessor :deck
  attr_accessor :players
  attr_accessor :current_player

  def create_players(names, min_players, max_players)
    playerlist = []
    if names.length < min_players or names.length > max_players
      raise RuntimeError.new
    end
    names.each do |x|
      playermade = Player.new(x)
      playerlist.append(playermade)
    end
    @players = playerlist
    end

  def random_player
    return @players.sample
  end

  def start
    counter = 0
    dealerindex = 0
    @players.each do |x|
      if x.dealer == true
        dealerindex = counter
      else
        counter = counter +1
      end

    end
    if dealerindex == 0
      @current_player = @players[-1]
      return @players[-1]
    else
      @current_player = @players[dealerindex-1]
      return @players[dealerindex-1]
    end
    end

  def next
    counter = 0
    playerindex = 0
    @players.each do |x|
      if x == @current_player
        playerindex = counter
      else
        counter = counter +1
      end

    end
    if playerindex == @players.length - 1
      @current_player = @players[0]
      return @players[0]
    end
    @current_player = @players[playerindex +1]
    return @players[playerindex +1]
    end

  

  def choose_player(pos)
    if pos > @players.length
      return nil
    end
    indextochoose = pos -1
    return @players[indextochoose]
  end

  def capture_merchant_ships
    highestplayer = nil 
    highestvalue = nil
    samescorecheck = true
    @players.each do |i|
      if i.merchant_pirates.length == 0 and i.merchant_ships_at_sea.length > 0
        i.merchant_ships_at_sea.each do |ship|
          samescorecheck = false
          i.merchant_ships_captured.append(ship)
          i.merchant_ships_at_sea.delete(ship)
        end
      end
      if i.merchant_pirates.length == 0
        next

      else
        i.merchant_pirates.keys.each do |x|
          playerdict = {}
          valuedict = {}
          typeofattacker = i.merchant_pirates[x][-1][1]
          playerofattack = i.merchant_pirates[x][-1][0]
          numberofiterations = i.merchant_pirates[x].length
          highestvalue = 0
          if typeofattacker.class == Admiral or typeofattacker.class == Captain
            playerofattack.merchant_ships_captured.append(x)
            i.merchant_ships_at_sea.delete(x)
            next
          end
          (0...numberofiterations).each do |values|
            currentplayer = i.merchant_pirates[x][values][0]
            currentcardtype = i.merchant_pirates[x][values][1]
            currentcardvalue = currentcardtype.attack_value
            if playerdict.include? currentplayer
              playerdict[currentplayer] << currentcardvalue
            else
              playerdict[currentplayer] = []
              playerdict[currentplayer] << currentcardvalue
            end
          end
          playerdict.keys.each do |player|
            currentp = player
            currentnumber = 0
            playerdict[player].each do |numbers|
              currentnumber = numbers+ currentnumber
            end
            unless valuedict.include? currentp
              valuedict[currentp] = []
            end
            valuedict[currentp] << currentnumber
          end
          valuedict.keys.each do |z|
            current_player = z
            current_score = valuedict[z][0]
            if highestplayer == nil
              highestplayer = z
              highestvalue = valuedict[z][0]
            end
            if current_score < highestvalue
              samescorecheck = false
            end
            if current_score > highestvalue
              highestvalue = current_score
              highestplayer = current_player
              samescorecheck = false
            end
          end
          if samescorecheck == true and valuedict.length > 1
            next
          end
          highestplayer.merchant_ships_captured.append(x)
          i.merchant_ships_at_sea.delete(x)
          i.merchant_pirates.delete(x)

        end

      
    end
    
    end
    end

  def show_winner
    pairlist = []
    @players.each do |i|
      valueofgold = 0
      i.merchant_ships_captured.each do |x|
        valueofgold = x.value + valueofgold
      end
      listtoadd = [i, valueofgold]
      pairlist.append(listtoadd)
    end
    return pairlist
  end
end

