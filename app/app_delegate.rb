class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    Teammate.load!

    Teammate.create(
      display_name: "JCO",
      spoken_name: "Joel"
    )
    Teammate.create(
      display_name: "SAM",
      spoken_name: "Stephan"
    )

    @window.rootViewController = SplitController.alloc.init

    @window.makeKeyAndVisible
    true
  end

  def applicationWillResignActive(application)
    Teammate.save!
  end
end
