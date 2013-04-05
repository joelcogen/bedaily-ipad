class TeamController < UITableViewController
  CELLID = 'team_cells'

  def viewDidLoad
    view.dataSource = view.delegate = self
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(true, animated: true)
  end

  def tableView(tableView, numberOfRowsInSection: section)
    Teammate::All.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELLID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: CELLID)
      cell
    end

    teammate = Teammate::All[indexPath.row]
    cell.textLabel.text = teammate.display_name
    cell.accessoryType = teammate.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone
    cell
  end

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
    teammate = Teammate::All[indexPath.row]
    navigationController.pushViewController(teammate_controller, animated:true)
    teammate_controller.showDetailsForTeammate(teammate)
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    teammate = Teammate::All[indexPath.row]
    teammate.toggle_selected
    view.reloadRowsAtIndexPaths([indexPath], withRowAnimation: false)
  end

  def teammate_controller
    @teammate_controller ||= TeammateController.alloc.init
  end
end
