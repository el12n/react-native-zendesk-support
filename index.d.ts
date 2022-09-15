declare type ZendeskSupportLocale = 'es' | 'en';
declare type ZendeskSupportType = {
  openTickets(subject: string): Promise<boolean>;
  initialization(
    appId: string,
    clientId: string,
    zendeskUrl: string,
    token: string,
    locale?: ZendeskSupportLocale | undefined
  ): Promise<boolean>;
};
declare const _default: ZendeskSupportType;
export default _default;
