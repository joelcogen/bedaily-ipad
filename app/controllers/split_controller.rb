class SplitController < UISplitViewController
  def init
    super

    self.viewControllers = [
      UINavigationController.alloc.initWithRootViewController(TeamController.alloc.init),
      DailyController.alloc.init
    ]

    self
  end
end
