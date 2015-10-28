/* @flow */
'use strict';

import React from 'react-native';
var {
	View,	
	Text,
} = React;

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
				<Text style={styles.centerText}>yo</Text>
			</View>
		);
	}

	renderLoginView() {
	return (
		<View style={styles.container}>
			<Text style={styles.centerText}>not yo</Text>
		</View>
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
