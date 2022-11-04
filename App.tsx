/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React from 'react';
import {
  View,
  StyleSheet,
  requireNativeComponent,
  Button,
  SafeAreaView,
  NativeModules,
} from 'react-native';
const {NotificationsMethods} = NativeModules;

const PushNotificationsDynamicIsland: any = requireNativeComponent(
  'PushNotificationsDynamicIsland',
);

const App = () => {
  return (
    <View style={styles.container}>
      <PushNotificationsDynamicIsland
        // isDevMoodEnabled={true}
        style={styles.manager}
      />
      <SafeAreaView>
        <Button
          title="Push Notification from React Native"
          onPress={() => {
            NotificationsMethods.pushTestNotifications();
          }}
        />
      </SafeAreaView>
    </View>
  );
};

export const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  manager: {
    flex: 1,
  },
});

export default App;
