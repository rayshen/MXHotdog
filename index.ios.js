/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';

class MXVersionManager extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Image style={styles.logo} source={require('./assets/logo.png')} />
        <Text style={styles.instructions}>
          SCORPION DATA
        </Text>
        <Text style={styles.welcome}>
          this is a demo for version manage! current:1.0.1
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginTop:10,
    marginBottom: 5,
  },
  logo:{
    height:100,
    width:100,
  }
});

AppRegistry.registerComponent('MXVersionManager', () => MXVersionManager);
