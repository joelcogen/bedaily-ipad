class TeamDatasource
  CELLID = 'team_cells'

  attr_reader :team

  def initialize
    Teammate.load!
    reload
  end

  def reload
    @team = Teammate.order(:display_name).all
  end

  def randomize
    return if @team.size < 2
    random_team = @team.dup
    while random_team.select(&:selected) == @team.select(&:selected) || random_team.first == @team.first || random_team.last == @team.last
      random_team = @team.sort { |t1, t2| !t1.selected ? 1 : (!t2.selected ? -1 : rand(3) - 1) }
    end
    @team = random_team
  end

  def save!
    Teammate.save!
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @team.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELLID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: CELLID)
      cell
    end

    teammate = @team[indexPath.row]
    cell.textLabel.text = teammate.display_name
    cell.accessoryType = teammate.selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone
    cell.editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton
    cell
  end

  def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    if editingStyle == UITableViewCellEditingStyleDelete
      @team[indexPath.row].delete
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationAutomatic)
    end
  end
end
