/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  Image,
  StyleSheet,
  Text,
  View,
} = React;

var MOCKED_DATA = [
  {title: 'Title', year: '2015', posters: {
    thumbnail: 'http://i.imgur.com/UePbdph.jpg'
  }},
]
var RT_REQUEST_URL = "https://raw.githubusercontent.com/facebook/react-native/master/docs/MoviesExample.json"


var AwesomeProject = React.createClass({
  getInitalState: function() {
    return {
      movies: null;
    };
  },
  componentDidMount: function() {
    this.fetchData();
  },
  fetchData: function() {
    fetch(RT_REQUEST_URL)
      .then((response) => response.json())
      .then((responseData) => {
        this.setState({
          movies: responseData.movies,
        });
      })
      .done();
  },
  render: function() {
    if (!this.state.movies) {
      return this.renderLoadingView();
    },

    var movie = MOCKED_DATA[0]
    return (
      <View style={styles.container}>
        <Image
          source={{uri: movie.posters.thumbnail}}
          style={styles.thumbnail}
        />
        <View style={styles.rightContainer}>
          <Text style={styles.title}>{movie.title}</Text>
          <Text style={styles.year}>{movie.year}</Text>
        </View>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  thumbnail: {
    width: 53,
    height: 81,
  },
  rightContainer: {
    flex: 1,
  },
  title: {
    fontSize: 20,
    marginBottom: 8,
    textAlign: 'center',
  },
  year: {
    textAlign: 'center',
  },
});

AppRegistry.registerComponent('AwesomeProject', () => AwesomeProject);
