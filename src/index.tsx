import { NativeModules } from 'react-native';

type ZendeskSupportLocale = 'es' | 'en';

type ZendeskSupportType = {
  openTickets(subject: string): Promise<boolean>;
  initialization(
    appId: string,
    clientId: string,
    zendeskUrl: string,
    locale?: ZendeskSupportLocale | undefined
  ): Promise<boolean>;
};

const { ZendeskSupport } = NativeModules;

export default ZendeskSupport as ZendeskSupportType;
