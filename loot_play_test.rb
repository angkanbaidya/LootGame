########## Angkan Baidya ##########
########## 112309655 #############
########## abaidya #############

require 'test/unit'
require 'test/unit/assertions'
require_relative "./loot.rb"


class Loot_play_test < Test::Unit::TestCase

  def test_min_max_players
    newgame = Game.new(Deck.get_instance)
    maxPlayersAllowed = 5
    minPlayersAllowed = 2
    playerNames = ["Joy", "Nan", "Sat","July","Josh","Jake","Adam"]
    assert_raises(RuntimeError) do
      newgame.create_players(playerNames,minPlayersAllowed,maxPlayersAllowed)
    end

  end
  def test_cards_after_deal_and_dealer
    othergametwo = Game.new(Deck.get_instance)
    maxPlayersAllowed = 5
    minPlayersAllowed = 2
    playerNames = ["Joy", "Nan", "Sat"]
    othergametwo.create_players(playerNames,minPlayersAllowed,maxPlayersAllowed)
    dealer = othergametwo.random_player
    dealer.deal(othergametwo)
    firstplayer = othergametwo.start
    assert_equal(6,firstplayer.hand.length,"Must deal 6 cards!")
    assert_false(firstplayer.dealer,"First Player cannot be dealer!")
  end

  def test_float_merchant_not_in_hand
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    testship = MerchantShip.new(7)
    player1.hand.append(testship)
    assert_false(player1.float_merchant(shipatsea),"Card must be in hand!")
  end

  def test_real_float_merchant
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    testship = MerchantShip.new(7)
    player1.hand.append(shipatsea)
    assert_true(player1.float_merchant(shipatsea),"Card must be in hand!")

  end

  def test_fake_float_merchant
    otherother = Game.new(Deck.get_instance)
    maxPlayersAllowed = 5
    minPlayersAllowed = 2
    playerNames = ["Joy", "Nan", "Sat"]
    otherother.create_players(playerNames,minPlayersAllowed,maxPlayersAllowed)
    firstplayer = otherother.random_player
    fakemerchant = PirateShip.new("green",3)
    assert_false(firstplayer.float_merchant(fakemerchant),"Card must be a merchant!")
  end

  def test_fake_pirate_not_a_pirate
    fakepirate = MerchantShip.new(5)
    fakemerchant = MerchantShip.new(6)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    assert_false(player1.play_pirate(fakepirate,fakemerchant,player2),"Pirate is not a pirate!")

  end

  def test_pirate_not_in_hand
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    player1.merchant_ships_at_sea.append(shipatsea)
    pirateforhand = PirateShip.new("green",3)
    piratetotest = PirateShip.new("gold",3)
    player2.hand.append(pirateforhand)
    assert_false(player2.play_pirate(piratetotest,shipatsea,player1),"pirate not in hand!")

  end

  def test_merchant_ship_not_in_sea
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    pirateforhand = PirateShip.new("green",3)
    player2.hand.append(pirateforhand)
    assert_false(player2.play_pirate(pirateforhand,shipatsea,player1),"merchant not at sea")



  end

  def test_pirate_played_with_no_previous_color
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    player1.merchant_ships_at_sea.append(shipatsea)
    pirateforhand = PirateShip.new("green",3)
    player2.hand.append(pirateforhand)
    assert_true(player2.play_pirate(pirateforhand,shipatsea,player1),"Must play correct pirate card!")


  end

  def test_pirate_played_with_previous_color
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    player1.merchant_ships_at_sea.append(shipatsea)
    pirateforhand = PirateShip.new("green",3)
    secondpirateforhand = PirateShip.new("brown",3)
    player2.hand.append(pirateforhand)
    player2.play_pirate(pirateforhand,shipatsea,player1)
    assert_false(player2.play_pirate(secondpirateforhand,shipatsea,player1),"Must be same color when attacking again!")
  end

  def test_captain_not_in_hand
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    captaincard1 = Captain.new("brown")
    testcard = PirateShip.new("green",5)
    merchantotest = MerchantShip.new(7)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    assert_false(player2.play_captain(captaincard1,merchantotest,player1),"Captain must be in hand")
  end

  def test_captain_with_diff_color
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    player1.merchant_ships_at_sea.append(shipatsea)
    pirateforhand = PirateShip.new("green",3)
    captaincard = Captain.new("brown")
    player2.hand.append(pirateforhand)
    player2.hand.append(captaincard)
    player2.play_pirate(pirateforhand,shipatsea,player1)
    assert_false(player2.play_captain(captaincard,shipatsea,player1),"Captain card must be same color as previous attack!")
  end

  def test_captain_card_real
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    shipatsea = MerchantShip.new(6)
    player1.merchant_ships_at_sea.append(shipatsea)
    pirateforhand = PirateShip.new("green",3)
    captaincard = Captain.new("green")
    player2.hand.append(pirateforhand)
    player2.hand.append(captaincard)
    player2.play_pirate(pirateforhand,shipatsea,player1)
    assert_true(player2.play_captain(captaincard,shipatsea,player1))
  end

  def test_admiral_not_in_hand
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    admiral = Admiral.get_instance
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)
    player1.hand.append(testcard2)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    player2.play_pirate(testcard,merchantotest,player1)
    assert_false(player1.play_admiral(admiral,merchantotest),"Admiral must be in hand!")

  end

  def test_admiral_not_defended
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    admiral = Admiral.get_instance
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)
    player1.hand.append(testcard2)
    player1.hand.append(admiral)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    assert_false(player1.play_admiral(admiral,merchantotest),"Admiral must be defending")
  end

  def test_correct_admiral
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    admiral = Admiral.get_instance
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)


    player1.hand.append(testcard2)
    player1.hand.append(admiral)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    player2.play_pirate(testcard,merchantotest,player1)
    assert_true(player1.play_admiral(admiral,merchantotest))
  end

  def choose_player_out_of_bounds
    otherother = Game.new(Deck.get_instance)
    maxPlayersAllowed = 5
    minPlayersAllowed = 2
    playerNames = ["Joy", "Nan", "Sat"]
    otherother.create_players(playerNames,minPlayersAllowed,maxPlayersAllowed)
    assert_nil(otherother.choose_player(4),"out of bounds!")
  end

  def choose_player_in_bounds
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("Jake")
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)
    assert_equal(player1,otherother.choose_player(1),"player must be the one selected")
  end

  def test_if_merchant_not_attacked
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)
    player1.hand.append(testcard2)
    player1.float_merchant(testcard2)
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.capture_merchant_ships
    assert_equal(testcard2,player1.merchant_ships_captured[0],"Merchant not attacked!")
  end

  def test_start_picks_right_person_if_edge
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("John")
    player1.dealer = true
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)
    assert_equal(otherother.players[-1],otherother.start,"Must wrap around!")
  end

  def test_start_picks_if_in_middle
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("John")
    player2.dealer = true
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)
    assert_equal(otherother.players[0],otherother.start)
  end

  def test_next_picks_right_person_if_normal
    otherother = Game.new(Deck.get_instance())
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("John")
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)
    otherother.current_player = player1
    assert_equal(otherother.players[1],otherother.next)
  end

  def test_next_picks_right_person_if_edge
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("John")
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)
    otherother.current_player =player3
    assert_equal(otherother.players[0],otherother.next)
  end

  def test_capture_merchant_ships_with_admiral_and_captain
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    admiral = Admiral.get_instance
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)
    captaintotest = Captain.new("green")
    player1.hand.append(testcard2)
    player1.hand.append(admiral)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    player2.hand.append(captaintotest)
    otherother.players.append(player1)
    otherother.players.append(player2)

    player2.play_pirate(testcard,merchantotest,player1)
    player1.play_admiral(admiral,merchantotest)
    player2.play_captain(captaintotest,merchantotest,player1)
    otherother.capture_merchant_ships
    assert_equal(merchantotest,player2.merchant_ships_captured[0])
  end

  def test_capture_merchant_ships_with_admiral
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    admiral = Admiral.get_instance
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)

    player1.hand.append(testcard2)
    player1.hand.append(admiral)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    otherother.players.append(player1)
    otherother.players.append(player2)

    player2.play_pirate(testcard,merchantotest,player1)
    player1.play_admiral(admiral,merchantotest)
    otherother.capture_merchant_ships
    assert_equal(merchantotest,player1.merchant_ships_captured[0])
  end

  def test_capture_merchant_ships_with_pirates_only_once
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("Tyler")
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)
    testcard3 = PirateShip.new("blue",6)
    player1.hand.append(testcard2)
    player3.hand.append(testcard3)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)

    player2.play_pirate(testcard,merchantotest,player1)
    player3.play_pirate(testcard3,merchantotest,player1)
    otherother.capture_merchant_ships
    assert_equal(merchantotest,player3.merchant_ships_captured[0])
  end

  def test_capture_merchant_ships_with_pirates_multiple
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("Tyler")
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)
    testcard3 = PirateShip.new("blue",6)
    testcard4 = PirateShip.new("green",7)
    player2.hand.append(testcard4)
    player1.hand.append(testcard2)
    player3.hand.append(testcard3)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)

    player2.play_pirate(testcard,merchantotest,player1)
    player3.play_pirate(testcard3,merchantotest,player1)
    player2.play_pirate(testcard4,merchantotest,player1)
    otherother.capture_merchant_ships
    assert_equal(merchantotest,player2.merchant_ships_captured[0])
  end

  def test_equal_value_pirate
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("Tyler")
    shipatsea = MerchantShip.new(6)
    player1.merchant_ships_at_sea.append(shipatsea)
    pirateforhand = PirateShip.new("green",3)
    secondpirateforhand = PirateShip.new("brown",3)

    player2.hand.append(pirateforhand)
    player3.hand.append(secondpirateforhand)
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)

    player2.play_pirate(pirateforhand,shipatsea,player1)
    player3.play_pirate(secondpirateforhand,shipatsea,player1)
    otherother.capture_merchant_ships
    assert_equal(1,player1.merchant_pirates.length,"Equal value so no one wins the ship!")
  end

  def test_winners
    otherother = Game.new(Deck.get_instance)
    player1 = Player.new("John")
    player2 = Player.new("Joe")
    player3 = Player.new("Tyler")
    testcard = PirateShip.new("green",5)
    testcard2 = MerchantShip.new(5)
    merchantotest = MerchantShip.new(7)
    testcard3 = PirateShip.new("blue",6)
    testcard4 = PirateShip.new("green",7)
    player2.hand.append(testcard4)
    player1.hand.append(testcard2)
    player3.hand.append(testcard3)
    player1.merchant_ships_at_sea.append(merchantotest)
    player2.hand.append(testcard)
    otherother.players.append(player1)
    otherother.players.append(player2)
    otherother.players.append(player3)

    player2.play_pirate(testcard,merchantotest,player1)
    player3.play_pirate(testcard3,merchantotest,player1)
    player2.play_pirate(testcard4,merchantotest,player1)
    otherother.capture_merchant_ships
    listofwinner=[[player1,0],[player2,7],[player3,0]]
    assert_equal(listofwinner,otherother.show_winner)
  end

end
