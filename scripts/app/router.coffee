define (require) ->

		Backbone								= require 'backbone'
		Experiment01Controller	= require 'cs!app/modules/experiment01/experiment01Controller'
		AppModel								= require 'cs!app/entities/abstract/appModel'
		$												= require 'jquery'

		class Router extends Backbone.Router

			initialize: () ->
				@appModel = new AppModel()
			
			routes:
				''										: 'start'
				'experiment01/:user'	: 'experiment01'

			start: () ->
				template = require 'hbs!app/modules/start/templates/intro'
				$('.experimentCanvas').html template

				self = @

				$('.intro-button').on 'click', (e) =>
					val = $('input[name="user"]').val().split(' ').join('-').toLowerCase()
					self.navigate 'experiment01/' + val, true

			experiment01: (user) ->
				@appModel.set
					'user' : user
				
				experiment01Controller = new Experiment01Controller(@appModel)
				
				url = 'http://solanki.ch/colors/backend.php'
				experiment01Controller.start(url)

		Router