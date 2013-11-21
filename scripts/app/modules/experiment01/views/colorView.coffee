define (require) ->

	BaseView = require 'app/base/views/baseView'

	class ColorView extends BaseView

		className: 'color-box'

		setSelected: () ->
			@selected = true
			@$el.addClass 'selected'

		unsetSelected: () ->
			@selected = false
			@$el.removeClass 'selected'

		events:
			'click': () ->
				@vent.trigger 'colorView:click',
					@model, @

		render: () ->
			color = @model.get('color')

			@$el.css
				'background-color': color
				'width': @arguments.boxWidth + '%'

			@

	ColorView