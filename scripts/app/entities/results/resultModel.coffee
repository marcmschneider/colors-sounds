define (require) ->

	Backbone = require 'backbone'

	class ResultModel extends Backbone.Model

		defaults:
			playedTone: ''
			chosenColor: ''

	ResultModel