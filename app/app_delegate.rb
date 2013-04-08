class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @datasource = TeamDatasource.new
    @window.rootViewController = SplitController.alloc.initWithDatasource(@datasource)

    @window.makeKeyAndVisible
    true
  end

  def applicationWillResignActive(application)
    @datasource.save!
  end
end
