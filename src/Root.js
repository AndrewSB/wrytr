/* @flow */
'use strict';

import React from 'react-native';
var {
	View,	
	Text,
} = React;

import {FBSDKLoginButton} from 'react-native-fbsdklogin';
import LoginView from './views/LoginView.js'

class wrytr extends React.Component {
	constructor(props) {
		super(props);

		console.log('constructor called');

		this.state = {loggedIn: false};
	}

	render() {
		console.log('render called');

		if (!this.state.loggedIn) {
			return this.renderLoginView();
		}

		return (
			<View style={styles.container}>
				<Text style={styles.centerText}>welcome</Text>
			</View>
		);
	}

	renderLoginView() {
		return (
			<LoginView />
		);
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
