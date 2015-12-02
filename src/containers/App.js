/* @flow */
'use strict';

import React from 'react-native';
import { Parse } from 'parse';
import ParseReact from 'parse-react';

import Home from './Home';
import Login from './Login';

class wrytr extends React.Component {
	state: {
		loggedIn: true,
	}

	constructor(props) {
		super(props);
		Parse.initialize(
			"31keZgv6smp8SZrly3bz8TXMcKPlDZCc2bR8ZiYi",
			"3eifd9LmknvyJMkOOFHEqutI3qFhvyn57wNdE4sr"
		);

		// let currentUser = Parse.User.currentUserAsync;

		this.state = { loggedIn: false };
		// this.setState({ loggedIn: false });
	}

	render() {
		return this.state.loggedIn ? <Home /> : <Login />;
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
