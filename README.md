# react-native-zendesk-support

A wrapper for the ZendeskSupport SDK for both android and ios.

## Getting started

If you are using `react-native >= 0.60` you just need to do a simple:

```shell
yarn add react-native-zendesk-support
```

Or if are using npm:


```shell
npm i react-native-zendesk-support --save
```

## Usage

```js
import ZendeskSupport from "react-native-zendesk-support";

// Initialize the Zendesk Support SDK in the following form, at the very beginning of your app:
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