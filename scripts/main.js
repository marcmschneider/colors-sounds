requirejs.config({

	urlArgs: 'bust=' + (new Date()).getTime(),

	paths: {
		// requirejs plugins and its depencencies
		'cs': '../components/require-cs/cs',
		'hbs': '../components/require-handlebars-plugin/hbs',
		'domReady': '../components/requirejs-domready/domReady',

		// other dependencies
		'coffee-script': '../components/require-cs/coffee-script',
		'i18nprecompile': '../components/require-handlebars-plugin/hbs/i18nprecompile',
		'handlebars': '../components/handlebars/handlebars',
		'json2': '../components/json2/json2',

		'jquery.transit': '../components/jquery.transit/jquery.transit',

		// core libraries and its depencencies
		'jquery': '../components/jquery/jquery',
		'underscore': '../components/underscore/underscore',
		'backbone.wreqr': '../components/backbone.wreqr/lib/amd/backbone.wreqr',
		'backbone': '../components/backbone/backbone',

		// Midi dependencies
		'AudioDetect': 'vendor/midi/js/MIDI/AudioDetect',
		'LoadPlugin': 'vendor/midi/js/MIDI/LoadPlugin',
		'Plugin': 'vendor/midi/js/MIDI/Plugin',
		'Player': 'vendor/midi/js/MIDI/Player',
		'DOMLoader.XMLHttp': 'vendor/midi/js/Window/DOMLoader.XMLHttp',
		'DOMLoader.script': 'vendor/midi/js/Window/DOMLoader.script',
		'Base64': 'vendor/midi/inc/Base64',
		'base64binary': 'vendor/midi/inc/base64binary',
	},

	shim: {
		// Shim Midi dependencies
		'AudioDetect': {
			exports: 'AudioDetect'
		},
		'LoadPlugin': {
			exports: 'LoadPlugin'
		},
		'Plugin': {
			exports: 'Plugin'
		},
		'Player': {
			exports: 'Player'
		},
		'DOMLoader.XMLHttp': {
			exports: 'DOMLoader.XMLHttp'
		},
		'DOMLoader.script': {
			exports: 'DOMLoader.script'
		},
		'Base64': {
			exports: 'Base64'
		},
		'base64binary': {
			exports: 'base64binary'
		},

		// Shim dependencies
		'handlebars': {
			exports: 'Handlebars'
		},
		'json2': {
			exports: 'JSON'
		},
		'jquery': {
			exports: '$'
		},
		'jquery.transit': {
			deps: ['jquery'],
			exports: '$'
		},
		'underscore': {
			exports: '_'
		},
		'backbone': {
			deps: ['jquery', 'json2', 'underscore'],
			exports: 'Backbone'
		}
	},

	hbs: {
		templateExtension: 'hbs',
		disableI18n: true
	}
});

require(['domReady', 'cs!app/app'], function(domReady, App) {
	'use strict';

	domReady(function () {
		var app = new App();
		app.start();
	});
});
