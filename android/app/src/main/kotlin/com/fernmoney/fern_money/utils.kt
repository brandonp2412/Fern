package com.fernmoney.fern_money

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.database.sqlite.SQLiteDatabase
import android.util.Log
import java.io.File
import java.util.Calendar
import org.json.JSONObject

fun scheduleBackups(context: Context) {
    val backupIntent = Intent(context, BackupReceiver::class.java).apply {
        setPackage(context.packageName)
    }

    val pendingIntent = PendingIntent.getBroadcast(
        context, 0, backupIntent,
        PendingIntent.FLAG_IMMUTABLE
    )

    val calendar: Calendar = Calendar.getInstance().apply {
        set(Calendar.HOUR_OF_DAY, 2)
        set(Calendar.MINUTE, 0)
        set(Calendar.SECOND, 0)
        if (timeInMillis < System.currentTimeMillis()) {
            add(Calendar.DAY_OF_YEAR, 1)
            pendingIntent.send()
        }
    }

    val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
    alarmManager.setInexactRepeating(
        AlarmManager.RTC_WAKEUP,
        calendar.timeInMillis,
        AlarmManager.INTERVAL_DAY,
        pendingIntent
    )
}

fun appDocumentsDir(context: Context): File {
    val parentDir = context.filesDir.parentFile
    return File(parentDir, "app_flutter")
}

fun openDb(context: Context): SQLiteDatabase? {
    val dbFile = File(appDocumentsDir(context), "fern_cache.sqlite")
    Log.d("auto backup", "dbFile=${dbFile.absolutePath}")
    if (!dbFile.exists()) return null
    return SQLiteDatabase.openDatabase(dbFile.absolutePath, null, 0)
}

fun writeSettings(context: Context, automaticBackups: Boolean, backupUri: String?) {
    val settingsFile = File(appDocumentsDir(context), "backup_settings.json")
    val json = JSONObject()
    json.put("automaticBackups", automaticBackups)
    json.put("backupUri", backupUri)
    settingsFile.writeText(json.toString())
}

fun getSettings(context: Context): Pair<Boolean, String?> {
    val settingsFile = File(appDocumentsDir(context), "backup_settings.json")
    if (!settingsFile.exists()) return Pair(false, null)

    return try {
        val json = JSONObject(settingsFile.readText())
        val automaticBackups = json.optBoolean("automaticBackups", false)
        val backupUri = if (json.isNull("backupUri")) null else json.getString("backupUri")
        Pair(automaticBackups, backupUri)
    } catch (e: Exception) {
        Pair(false, null)
    }
}
