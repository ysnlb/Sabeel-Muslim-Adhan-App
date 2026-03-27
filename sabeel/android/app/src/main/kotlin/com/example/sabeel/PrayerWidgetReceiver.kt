package com.example.prayer_app
import com.example.sabeel.R

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class PrayerWidgetReceiver : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.prayer_widget_layout).apply {
                setTextViewText(R.id.widget_city, widgetData.getString("city", "Prayer Times") ?: "Prayer Times")
                setTextViewText(R.id.widget_fajr, widgetData.getString("fajr", "--:--") ?: "--:--")
                setTextViewText(R.id.widget_sunrise, widgetData.getString("sunrise", "--:--") ?: "--:--")
                setTextViewText(R.id.widget_dhuhr, widgetData.getString("dhuhr", "--:--") ?: "--:--")
                setTextViewText(R.id.widget_asr, widgetData.getString("asr", "--:--") ?: "--:--")
                setTextViewText(R.id.widget_maghrib, widgetData.getString("maghrib", "--:--") ?: "--:--")
                setTextViewText(R.id.widget_isha, widgetData.getString("isha", "--:--") ?: "--:--")
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}