#!/usr/bin/env coffee

_ = require './lambda'


_modifiers =
	modifier: (value) ->
		this.option_name = value


_create_modifier = (name, action) ->
	(args...) ->
		config_copy = _.clone @_config
		action.apply config_copy, args
		new Chainable config_copy, name


class Chainable
	constructor: (@_config = {}, @_last = '') ->

	for name, action of _modifiers
		this.prototype[name] = _create_modifier name, action

	process_config: (config) -> {}

	done: ->

		config = @config
		# process config and build result value
		result = process_config config
		return result


class OptionAChainable extends Chainable
	option_b: new Chainable (option_a: true, option_b: true), 'option_b'


class RawChainable extends Chainable
	option_a: new OptionAChainable option_a: true, 'option_a'
	option_b: new Chainable option_b: true, 'option_b'


module.exports = exports = RawChainable
