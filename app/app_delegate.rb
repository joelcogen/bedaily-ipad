class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    # UIScreen describes the display our app is running on
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    #dailyController = DailyController.alloc.initWithNibName(nil, bundle: nil)
    #teamController = TeamController.alloc.initWithNibName(nil, bundle: nil)

    @window.rootViewController = SplitController.alloc.init

    @window.makeKeyAndVisible
    true
  end
end
