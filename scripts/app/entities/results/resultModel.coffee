define (require) ->

	Backbone = require 'backbone'

	class ResultModel extends Backbone.Model

		defaults:
			expectedTone: ''
			choosenTone: ''
			choosenColor: ''

	ResultModel