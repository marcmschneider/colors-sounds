define (require) ->

	Wreqr = require 'backbone.wreqr'

	eventAggregator = new Wreqr.EventAggregator()

	eventAggregator