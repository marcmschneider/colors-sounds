define (require) ->

	Backbone = require 'backbone'

	class AppModel extends Backbone.Model

		defaults:
			'experimentCanvas': '.experimentCanvas'

	AppModel