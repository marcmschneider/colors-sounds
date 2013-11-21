define (require) ->

	BaseView					= require 'cs!app/base/views/baseView'
	layout						= require 'hbs!app/classes/message/templates/layout'
	messageTemplate		= require 'hbs!app/classes/message/templates/messageTemplate'
	$									= require 'jquery'

	class Message extends BaseView

		events:
			'click .button': 'close'

		close: () ->
			@$el.html ''

		show: (title = '', text = '', button = 'OK') ->
			@title = title
			@text = text
			@button = button
			
			@$el.html layout()
			
			@$message = @$el.find('.message')
			
			@render()

		render: () ->
			html = messageTemplate
				title: @title
				text: @text
				button: @button
			
			@$message.html html
			
			$('body').append @el

	Message