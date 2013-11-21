define (require) ->

	Backbone		= require 'backbone'
	ResultModel	= require 'cs!app/entities/results/resultModel'

	class ResultCollection extends Backbone.Collection

		model: ResultModel

	ResultCollection