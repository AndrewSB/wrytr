/* @flow */
'use strict';

import React from 'react-native';
var {
	View,	
	Text,
} = React;
import {FBSDKLoginButton} from 'react-native-fbsdklogin';

class LoginView extends React.Component {
	constructor(props) {
		super(props);

		console.log('login view constructed');
	}

	render() {
		return (
			<View style={[styles.container, styles.loginBackground]}>
				<Text style={styles.headerText}>wrytr</Text>
				<Text style={styles.subtitleText}>Use your words</Text>
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
		flexDirection: 'row',
		justifyContent: 'center',
		alignItems: 'center',
	},
	loginBackground: {
	 backgroundColor: '#54BFA8',
	},
	headerText: {
		color: 'white',
	},
	subtitleText: {
		color: 'white',
	},
});

export default LoginView;
