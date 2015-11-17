/* @flow */
'use strict';

import React from 'react-native';

import HomeView from './views/main/HomeView.js';
import LoginView from './views/login/LoginView.js';

class wrytr extends React.Component {
	constructor(props) {
		super(props);

		console.log('constructor called');

		this.state = {loggedIn: true};
	}

	render() {
		console.log('render called');

		return (
			<HomeView />
		);

		// return this.state.loggedIn ? (<HomeView />) (<LoginView />);
	}
}

var styles = React.StyleSheet.create({
	container: {
		flex: 1,
		flexDirection: 'row',
		justifyContent: 'center',
		alignItems: 'center',
		marginTop: 2,
		marginBottom: 2,
	},
	centerText: {
		textAlign: 'center',
	},
});

export default wrytr;
