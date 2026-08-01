package com.fernmoney.fern_money

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == "android.intent.action.BOOT_COMPLETED") {
            val (automaticBackups, backupUri) = getSettings(context)
            if (!automaticBackups || backupUri == null) return
            scheduleBackups(context)
        }
    }
}
