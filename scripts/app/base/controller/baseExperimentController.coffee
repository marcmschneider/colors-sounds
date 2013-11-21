define (require) ->

	$ = require 'jquery'
	Vent = require 'cs!app/classes/vent'

	class BaseExperimentController

		constructor: (appModel) ->
			@appModel = appModel
			
			@canvas = @appModel.get('experimentCanvas')
			@$canvas = $(@canvas)

			@vent = Vent
			
			@clearHtml()

		clearHtml: () ->
			$(@canvas).html ''

	BaseExperimentController