# react-native-zendesk-support

A wrapper for the ZendeskSupport SDK for both android and ios.

## Installation

```sh
npm install react-native-zendesk-support
```

#### iOS Configuration

Configure the project:
```
cd ios && pod init
```

Add the next line to your **PodFile**:
```diff
+ pod 'react-native-zendesk-support', :path => '../node_modules/react-native-zendesk-support/ios'
```

Install the react-native-zendesk-support pod:
```
pod install
```

## Usage

```js
import ZendeskSupport from "react-native-zendesk-support";

// Initialize the Zendesk Support SDK in the following form:
const result = await ZendeskSupport.initialization(
    appId: string,
    clientId: string,
    zendeskUrl: string,
    locale?: ZendeskSupportLocale | undefined);

/* 
* Later just call the next method when you want to launch
* the Request List, with its native capability to create new
* tickets and answer current tickets...
*/
const result = await ZendeskSupport.openTickets("Your subject");
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
