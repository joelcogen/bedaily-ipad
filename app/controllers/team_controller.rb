class TeamController < UITableViewController
  CELLID = 'team_cells'

  def viewDidLoad
    view.dataSource = view.delegate = self
    navigationController.navigationBar.topItem.rightBarButtonItem = editButtonItem
  end

  def tableView(tableView, numberOfRowsInSection: section)
    Teammate.all.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELLID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: CELLID)
      cell
    end

    teammate = Teammate.all[indexPath.row]
    cell.textLabel.text = teammate.display_name
    cell.accessoryType = teammate.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone
    cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton
    cell
  end

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
    teammate = Teammate.all[indexPath.row]
    navigationController.pushViewController(teammate_controller, animated:true)
    teammate_controller.showDetailsForTeammate(teammate)
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    teammate = Teammate.all[indexPath.row]
    teammate.toggle_selected
    view.reloadRowsAtIndexPaths([indexPath], withRowAnimation: false)
  end

  def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    if editingStyle == UITableViewCellEditingStyleDelete
      Teammate.all[indexPath.row].delete
      view.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationAutomatic)
    end
  end

  def teammate_controller
    @teammate_controller ||= TeammateController.alloc.init
  end
end
