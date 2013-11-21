define (require) ->

		Backbone								= require 'backbone'
		Experiment01Controller	= require 'cs!app/modules/experiment01/experiment01Controller'
		AppModel								= require 'cs!app/entities/abstract/appModel'

		class Router extends Backbone.Router

			initialize: () ->
				@appModel = new AppModel()
			
			routes:
				'': 'experiment01'
			
			experiment01: () ->
				experiment01Controller = new Experiment01Controller(@appModel)
				experiment01Controller.start()

		Router