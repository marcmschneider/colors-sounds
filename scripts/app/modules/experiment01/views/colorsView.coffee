define (require) ->

	BaseView		= require 'cs!app/base/views/baseView'
	ColorView		= require 'cs!app/modules/experiment01/views/colorView'

	class ColorsView extends BaseView

		className: 'colors'

		unsetAllSelected: () ->
			for views in @colorView
				views.unsetSelected()

		start: () ->
			@colorView = []
			@vent.on 'colorView:click', (model, view) =>
				@vent.trigger 'colorsView:colorView:click', model, view

		render: () ->
			boxWidth = 100 / @collection.models.length

			for key, colorModel of @collection.models
				@colorView[key] = new ColorView
					model: colorModel
					boxWidth: boxWidth

				@$el.append @colorView[key].render().el

			@

	ColorsView