assert = chai.assert
expect = chai.expect

describe "Rules", ->
	deck = null
	hand = null

	beforeEach ->
  	deck = new Deck()
  	hand = deck.dealPlayer()

  describe "Bust", ->
		it "should return an alert when user score exceeds 21", ->
			hand.hit()
			hand.hit()
			hand.hit()
			console.log(hand.scores()[0])
			expect(hand.scores()[0]).to.be.above 21

	describe "Bust", ->
		it "should not be able to hit after user busts", ->
			hand.hit()
			hand.hit()
			hand.hit()
			scoreVal = hand.scores()[0]
			hand.hit()
			expect(hand.scores()[0]).to.equal scoreVal


