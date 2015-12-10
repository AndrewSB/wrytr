/* @flow */
'use strict'

import React from 'react-native';
var {
  Component,
  View,
  TouchableHighlight,
  Text,
} = React;
import {FBSDKLoginManager} from 'react-native-fbsdklogin';

export default class SocialIcons extends Component {
  render() {
    return (
      <View style={styles.container}>
        <TouchableHighlight style={[styles.button, styles.twitter]}>
          <Text style={styles.whiteText}>twitter</Text>
        </TouchableHighlight>
        <TouchableHighlight style={[styles.button, styles.facebook]} onPress={this._facebook}>
          <Text style={styles.whiteText}>facebook</Text>
        </TouchableHighlight>
        <TouchableHighlight style={[styles.button, styles.email]}>
          <Text>email</Text>
        </TouchableHighlight>
      </View>
    );
  }

  _facebook() {
    FBSDKLoginManager.logInWithReadPermissions(['public_profile', 'email', 'user_friends'], (error, result) => {
      if (error) {
        alert('error logging in');
      } else {
        alert('loggedin')
      }
    });
  }
}

var styles = React.StyleSheet.create({
	container: {
		flex: 1,
    padding: 5,
  },
  button: {
    borderRadius: 20,
    paddingVertical: 11,
    paddingHorizontal: 33,
  },
  facebook: { backgroundColor: '#3B5998', },
  whiteText: { color: '#fff', },
  twitter: { backgroundColor: '#55ACEE' },
  email: { backgroundColor: '#fff' },
});
