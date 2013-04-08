class SplitController < UISplitViewController
  def initWithDatasource(datasource)
    init

    team_controller = TeamController.alloc.initWithDatasource(datasource)

    self.viewControllers = [
      UINavigationController.alloc.initWithRootViewController(team_controller),
      DailyController.alloc.initWithDatasourceAndTableView(datasource, team_controller.tableView)
    ]

    self
  end
end
