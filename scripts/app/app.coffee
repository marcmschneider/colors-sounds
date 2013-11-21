define (require) ->

	Backbone	= require 'backbone'
	Router		= require 'cs!app/router'

	class App

		start: () ->
			
			router = new Router()

			Backbone.history.start()

	App