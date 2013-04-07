class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    Teammate.load!

    @window.rootViewController = SplitController.alloc.init

    @window.makeKeyAndVisible
    true
  end

  def applicationWillResignActive(application)
    Teammate.save!
  end
end
