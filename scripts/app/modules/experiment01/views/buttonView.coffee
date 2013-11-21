define (require) ->

	BaseView = require 'cs!app/base/views/baseView'

	class ButtonView extends BaseView

		className: 'button'

		renderText: (text) ->
			@$el.html text

		events:
			'click': () ->
				@vent.trigger 'experiment01:clickButton'

		render: () ->
			@$el.html('Start')
			@

	ButtonView