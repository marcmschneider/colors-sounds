define (require) ->

	Backbone	= require 'backbone'
	Vent			= require 'cs!app/classes/vent'

	class BaseView extends Backbone.View

		initialize: () ->
			@vent = Vent
			@arguments = arguments[0]

			@start()

		start: () ->

	BaseView