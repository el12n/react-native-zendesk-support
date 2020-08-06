package com.reactnativezendesksupport

import android.content.Context
import android.content.Intent
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import zendesk.core.AnonymousIdentity
import zendesk.core.Identity
import zendesk.core.Zendesk
import zendesk.support.Support
import zendesk.support.request.RequestActivity
import zendesk.support.requestlist.RequestListActivity

class ZendeskSupportModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return "ZendeskSupport"
  }

  @ReactMethod
  fun initialization(appId: String, clientId: String, zendeskUrl: String, locale: String? = null, promise: Promise) {
    val context: Context = reactApplicationContext.applicationContext
    val identity: Identity = AnonymousIdentity()

    Zendesk.INSTANCE.init(context, zendeskUrl, appId, clientId)
    Zendesk.INSTANCE.setIdentity(identity)
    Support.INSTANCE.init(Zendesk.INSTANCE)

    promise.resolve(true)
  }

  @ReactMethod
  fun openTickets(subject: String, promise: Promise) {
    val context: Context = reactApplicationContext.applicationContext
    val config = RequestActivity.builder().withRequestSubject(subject).withTags("Android").config()
    val intent: Intent = RequestListActivity.builder()
      .intent(context, config)

    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

    context.startActivity(intent)

    promise.resolve(true)
  }

}
