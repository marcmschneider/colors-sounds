define (require) ->

	Backbone		= require 'backbone'
	ColorsModel	= require 'cs!app/entities/colors/colorModel'

	class ColorsCollection extends Backbone.Collection

		model: ColorsModel

		url: 'scripts/app/data/colors.json'