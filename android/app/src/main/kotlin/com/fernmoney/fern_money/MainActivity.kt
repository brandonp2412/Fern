package com.fernmoney.fern_money

import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var channel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val (automaticBackups, backupUri) = getSettings(context)
        if (automaticBackups && backupUri != null) {
            scheduleBackups(context)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, FLUTTER_CHANNEL)
        channel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "pick" -> {
                    pick()
                    result.success(true)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun pick() {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE)
        activity.startActivityForResult(intent, WRITE_REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != WRITE_REQUEST_CODE) return

        data?.data?.also { uri ->
            val contentResolver = applicationContext.contentResolver
            val takeFlags: Int =
                Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
            contentResolver.takePersistableUriPermission(uri, takeFlags)
            Log.d("auto backup", "uri=$uri")
            writeSettings(context, true, uri.toString())
            scheduleBackups(context)
        }
    }

    companion object {
        const val FLUTTER_CHANNEL = "com.fernmoney.fern_money/android"
        const val WRITE_REQUEST_CODE = 43
    }
}
