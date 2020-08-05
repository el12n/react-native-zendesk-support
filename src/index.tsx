import { NativeModules } from 'react-native';

type ZendeskSupportType = {
  multiply(a: number, b: number): Promise<number>;
};

const { ZendeskSupport } = NativeModules;

export default ZendeskSupport as ZendeskSupportType;
