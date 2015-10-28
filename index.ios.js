/* @flow */
'use strict';

import React from 'react-native';
import wrytr from './src/Root.js';
import { Parse } from 'parse';

Parse.initialize(
	"31keZgv6smp8SZrly3bz8TXMcKPlDZCc2bR8ZiYi", 
	"3eifd9LmknvyJMkOOFHEqutI3qFhvyn57wNdE4sr"
);

React.AppRegistry.registerComponent('wrytr', () => wrytr);
