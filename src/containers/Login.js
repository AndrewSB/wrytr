/* @flow */
'use strict';

import React from 'react-native';
var {
	View,
	Text,
	Image,
	Dimensions,
} = React;
import SocialIcons from '../components/SocialIcons'

class LoginView extends React.Component {
	constructor(props) {
		super(props);
	}

	render() {
		var wrytrWrittenLogo = require('./../../img/wrytr-logo.png');
		return (
			<View style={[styles.container]}>
				<Image style={styles.writtenLogo} source={wrytrWrittenLogo} />
				<Text style={styles.subtitleText}>Use your words</Text>
				<SocialIcons />
			</View>
		);
		return (
			<View style={styles.container}>
				<FBSDKLoginButton
					onLoginFinished={(error, result) => {
						if (error) {
							alert('error logging in ' + error);
						} else {
							alert('Logged in');
						}
					}}
					onLogoutFinished={() => alert('Logged out.')}
					readPermissions={['public_profile', 'email', 'user_friends']}
				/>
			</View>
		);
	}
};

var styles = React.StyleSheet.create({
	container: {
		flex: 1,
		flexDirection: 'column',
		justifyContent: 'center',
		alignItems: 'center',
		position: 'relative',
		backgroundColor: '#54BFA8',
	},
	writtenLogo: {
		width: (Dimensions.get('window').width * 0.7),
		resizeMode: Image.resizeMode.contain,
	},
	subtitleText: {
		color: 'white',
		margin: 1,
	},
});

export default LoginView;
