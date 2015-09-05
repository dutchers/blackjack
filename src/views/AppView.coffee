class window.AppView extends Backbone.View
  template: _.template '
    <button class="btn btn-default hit-button">Hit</button> <button class="btn btn-default stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': 'hitter'
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @model.get('playerHand').on 'stand', => 
                            @model.get('dealerHand').models[0].flip()
                            $('button').prop('disabled', true)
                            @dealerShit()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  hitter: -> 
    @model.get('playerHand').hit()
    score = @model.get('playerHand').scores()[0]
    if score > 21
      @model.get('playerHand').bust()
      @$el.children().detach()
      new AppView(model: new App()).$el.appendTo 'container'
    if score is 21
      $('button').prop('disabled', true)
      @model.get('dealerHand').models[0].flip()
      @dealerShit()

  dealerShit: ->
    console.log "The pen is BLUE"
    dealerScore = @model.get('dealerHand').scores()[0]

    if dealerScore is 21
      alert "dealer sucks!"
    while @model.get('dealerHand').scores()[0] < 17
      console.log @model.get('dealerHand')
      @model.get('dealerHand').hit()
    if @model.get('dealerHand').scores()[0] > 21
      alert "The diller bust\'d rurl hard. like rurly"
    else if @model.get('dealerHand').scores()[0] > @model.get('playerHand').scores()[0]
      alert "The dilller has wonne. hes being a smug asshole about it."
    else if @model.get('dealerHand').scores()[0] is @model.get('playerHand').scores()[0]
      alert "PUSH IT. PUSH IT RURL GOOD."
    else
      alert "Congratulations! You\'ve won! Someone should get you a beer bro."
    @$el.children().detach()
    new AppView(model: new App()).$el.appendTo '.container'

