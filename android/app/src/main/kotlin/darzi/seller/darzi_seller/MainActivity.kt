package darzi.seller.darzi_seller

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen
import androidx.annotation.Nullable

class MainActivity: FlutterActivity() {

    @Nullable
    override fun provideSplashScreen(): SplashScreen? {
        return MySplashScreen() //Your Custom Splash Screen
    }


}


internal class MySplashScreen : SplashScreen {
    @Nullable
    override fun createSplashView(context: Context, @Nullable savedInstanceState: Bundle?): View {
        return LayoutInflater.from(context).inflate(R.layout.splash, null, false)
    }

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        onTransitionComplete.run()
    }
}
