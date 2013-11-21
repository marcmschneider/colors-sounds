define (require) ->

	# Midi depencencies
	require 'AudioDetect'
	require 'LoadPlugin'
	require 'Plugin'
	require 'Player'
	require 'DOMLoader.XMLHttp'
	require 'DOMLoader.script'
	require 'Base64'
	require 'base64binary'

	class Sound

		constructor: (callback) ->

			MIDI.loadPlugin
				soundfontUrl: 'scripts/vendor/midi/soundfont/'
				instrument: 'acoustic_grand_piano'
				callback: () ->
					# Midi is ready
					callback()

		playNote: (note) ->
			
			key = @_midiKeyFromNote note.toUpperCase()
			delay = 0
			velocity = 127

			MIDI.setVolume 0, 127
			MIDI.noteOn 0, key, velocity, delay
			MIDI.noteOff 0, key, delay + 0.75

		_midiKeyFromNote: (note) ->
			MIDI.keyToNote[note]

	Sound