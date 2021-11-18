########## Angkan baidya ##########
########## 112309655 #############
########## abaidya #############

require 'test/unit'
require 'test/unit/assertions'
require_relative "./loot.rb"


class Loot_deck_test < Test::Unit::TestCase

  def test_deck_multiple_instance
    deck1 = Deck.get_instance
    assert_raises(RuntimeError) do
      decktwo = Deck.new
    end
  end

  def test_total_cards
    deck1 = Deck.get_instance
    assert_equal(78,deck1.cards.length,"Not enough cards!")
  end

  def test_total_merchant_cards
    counter = 0
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == MerchantShip
        counter = counter + 1
      end
    end
    assert_equal(25,counter,"not enough merchant cards")
  end

  def test_total_pirate_cards
    counter = 0
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == PirateShip
        counter = counter + 1
      end
    end
    assert_equal(48,counter,"Not enough pirate ships!")
  end

  def test_total_admiral_cards
    counter = 0
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == Admiral
        counter = counter + 1
      end
    end
    assert_equal(1,counter,"Too many admiral cards!")
  end

  def test_total_pirate_captain_cards
    counter = 0
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == Captain
        counter = counter + 1
      end
    end
    assert_equal(4,counter,"too many admiral cards!")
  end

  def test_pirate_captain_color
    correctcolor = false
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == Captain
        if (i.color == "blue") or (i.color == "purple" ) or (i.color == "green") or (i.color == "gold")
          correctcolor = true
        else
          correctcollor = false
        end
      end
    end
    assert_true(correctcolor,"not correct colors!")
  end

  def test_merchant_numbers
    correctnumbers = false
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == MerchantShip
        if (i.value == 2) or (i.value == 3) or (i.value ==4 ) or (i.value == 5 )or (i.value ==6 ) or (i.value ==7 )or (i.value ==8 )
          correctnumbers = true
        else
          correctnumbers = false
        end
      end
    end
    assert_true(correctnumbers,"not correct colors!")
  end

  def test_pirate_color
    correctcolor = false
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == PirateShip
        if (i.color == "blue") or (i.color == "purple" ) or (i.color == "green") or (i.color == "gold")
          correctcolor = true
        else
          correctcollor = false
        end
      end
    end
    assert_true(correctcolor,"not correct colors!")
  end

  def test_merchant_each_gold_value
    twocounter = 0
    threecounter = 0
    fourcounter = 0
    fivecounter = 0
    sixcounter =0
    sevencounter = 0
    eightcounter = 0
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == MerchantShip
        if  i.value == 2
          twocounter = twocounter + 1
        end
        if  i.value == 3
          threecounter = threecounter + 1
        end
        if  i.value == 4
          fourcounter = fourcounter + 1
        end
        if i.value == 5
          fivecounter = fivecounter + 1
        end
        if i.value == 6
          sixcounter = sixcounter + 1
        end
        if i.value == 7
          sevencounter = sevencounter + 1
        end
        if i.value == 8
          eightcounter = eightcounter + 1
        end
      end

    end
    assert_equal(5,twocounter,"Not correct amount of 2 cards")
    assert_equal(6,threecounter,"Not correct amount of 3 cards")
    assert_equal(5,fourcounter,"Not correct amount of 4 cards")
    assert_equal(5,fivecounter,"Not correct amount of 5 cards")
    assert_equal(2,sixcounter,"Not correct amount of 6 cards")
    assert_equal(1,sevencounter,"Not correct amount of 7 cards")
    assert_equal(1,eightcounter,"Not correct amount of 8 cards")
  end

  def test_pirate_each_attack_value
    onecounter = 0
    twocounter = 0
    threecounter = 0
    fourcounter = 0
    deck = Deck.get_instance
    deck.cards.each do |i|
      if i.class == PirateShip
        if i.attack_value == 1
          onecounter = onecounter +1
        end
        if  i.attack_value == 2
          twocounter = twocounter + 1
        end
        if  i.attack_value == 3
          threecounter = threecounter + 1
        end
        if  i.attack_value == 4
          fourcounter = fourcounter + 1
        end
      end

    end
    assert_equal(8,onecounter,"Not correct amount of 1 attack strength")
    assert_equal(16,twocounter,"Not correct amount of 2 attack strength")
    assert_equal(16,threecounter,"Not correct amount of 3 attack strength")
    assert_equal(8,fourcounter,"Not correct amount of 4 attack strength")
  end

end