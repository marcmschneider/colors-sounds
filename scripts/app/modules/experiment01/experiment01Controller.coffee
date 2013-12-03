define (require) ->

	BaseExperimentController	= require 'cs!app/base/controller/baseExperimentController'
	ButtonView								= require 'cs!app/modules/experiment01/views/buttonView'
	ColorsView								= require 'cs!app/modules/experiment01/views/colorsView'
	ColorsCollection					= require 'cs!app/entities/colors/colorsCollection'
	Sound											= require 'cs!app/classes/sound'
	Message										= require 'cs!app/classes/message/message'
	ResultsCollection					= require 'cs!app/entities/results/resultsCollection'
	layout										= require 'hbs!app/modules/experiment01/templates/layout'
	resultTemplate						= require 'hbs!app/modules/experiment01/templates/resultTemplate'
	$													= require 'jquery'

	shuffle = (a) ->
		for i in [a.length-1..1]
			j = Math.floor Math.random() * (i + 1)
			[a[i], a[j]] = [a[j], a[i]]
		a

	class Experiment01Controller extends BaseExperimentController

		start: (url) ->

			if url
				@url = url

			@user = @appModel.get 'user'
			
			usr = @user.split('-').join(' ')
			@username = usr.replace /\b./g, (m) -> m.toUpperCase()

			@gameIsStarted = false
			@round = 0
			@clickedColor = ''

			@resultsCollection = new ResultsCollection()

			@message = new Message()

			@sound = new Sound () =>

				@getColorsCollection (colorsCollection) =>

					@notes = []

					for model in colorsCollection.models
						note = model.get('tone')
						@notes.push note
						
					@allRounds = colorsCollection.length
					@layout()
					@startViews(colorsCollection)

		welcomeMessage: () ->
			title = 'Welcome ' + @username
			text = 'Listen to the sound and click on the color that sounds right for you.'
			@message.show title, text

		getColorsCollection: (callback) ->
			
			new ColorsCollection().fetch
				reset: true
				success: (data) ->
					callback(data)
				error: () ->
					console.log 'error with fetching colorsCollection'

		layout: () ->
			@$canvas.append layout
			@$colors = @$canvas.find('.colors-region')
			@$footer = @$canvas.find('.footer')

		startViews: (colorsCollection) ->

			# Button View
			@buttonView = new ButtonView()
			@$footer.append @buttonView.render().el
			@vent.on 'experiment01:clickButton', @clickButton

			# ColorsView
			@colorsView = new ColorsView
				collection: colorsCollection
			@$colors.append @colorsView.render().el
			@vent.on 'colorsView:colorView:click', @clickColorView

			@welcomeMessage()

		clickColorView: (model, view) =>
			if @gameIsStarted
				@colorsView.unsetAllSelected()

				view.setSelected()

				@clickedColor = model.get('color')

		clickButton: () =>
			@gameEngine()

		gameEngine: () ->
			
			if !@clickedColor && @round != 0
				title = 'Please select a color!'
				@message.show title
			else
				@round++
				@doRound()

		saveResults: () ->
			@resultsCollection.add
				chosenColor: @clickedColor
				playedTone: @notes[@round-2]

		doRound: () ->
			if !@gameIsStarted
				shuffle @notes
				@gameIsStarted = true
			else
				@saveResults()

			@updateButton()

			@clickedColor = ''
			@colorsView.unsetAllSelected()

			if @round >= @allRounds + 1
				@round = 0
				@gameIsStarted = false
				@buttonView.renderText 'Start'

				@showResult()

				if @url
					@sendResult()

				@resultsCollection.reset()
			else
				@playNextNote()

		sendResult: () ->
			$.ajax
				type: 'POST'
				url: @url
				data:
					'user': @user
					'data': @resultsCollection.toJSON()
				error: (e) ->
					# console.info e
				success: (e) ->
					# console.info e

		showResult: () ->

			resultMessageTemplate = require 'hbs!apps/modules/experiment01/templates/resultMessage'

			html = resultMessageTemplate
							user: @user
							name: @username

			for model in @resultsCollection.models
				html += resultTemplate
					chosenColor: model.get('chosenColor')
					playedTone: model.get('playedTone')

			@message.show 'Thank you ' + @username, html, 'Restart'

		playNextNote: () ->
			@sound.playNote @notes[@round-1]

		updateButton: () ->
			if @round == 0
				@buttonView.renderText 'Start'

			else if @round >= @allRounds
				@buttonView.renderText 'Done'

			else
				@buttonView.renderText 'Next'
			

	Experiment01Controller