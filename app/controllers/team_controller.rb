class TeamController < UITableViewController
  def initWithDatasource(datasource)
    init
    @datasource = datasource
    self
  end

  def viewDidLoad
    view.dataSource = @datasource
    view.delegate = self
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
      UIBarButtonSystemItemAdd,
      target: self,
      action: :addTeammate)
  end

  def viewDidAppear(animated)
    super
    NSNotificationCenter.defaultCenter.addObserver(self, selector: 'dataDidChange:',
                                                         name: 'MotionModelDataDidChangeNotification',
                                                         object: nil)
  end

  def dataDidChange(notification)
    if notification.object.is_a?(Teammate)
      @datasource.reload
      view.reloadData unless notification.userInfo[:action] == "delete"
    end
  end

  def addTeammate
    editTeammate(Teammate.new)
  end

  def editTeammate(teammate)
    navigationController.pushViewController(teammate_controller, animated: true)
    teammate_controller.showDetailsForTeammate(teammate)
  end

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
    editTeammate(@datasource.team[indexPath.row])
    @editing_teammate_index = indexPath
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    teammate = @datasource.team[indexPath.row]
    teammate.toggle_selected
    view.reloadRowsAtIndexPaths([indexPath], withRowAnimation: false)
  end

  def teammate_controller
    @teammate_controller ||= TeammateController.alloc.init
  end
end
