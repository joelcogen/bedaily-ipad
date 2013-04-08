class DailyController < UIViewController
  def initWithDatasourceAndTableView(datasource, tableView)
    init

    @datasource = datasource
    @tableView = tableView

    self
  end

  def start
    @datasource.randomize
    @tableView.reloadData
  end

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor

    view.addSubview(UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.setTitle("Start", forState: UIControlStateNormal)
      button.addTarget(self, action: :start, forControlEvents: UIControlEventTouchDown)
      button.frame = [[20, 20], [210, 40]]
    end)
    view.addSubview(UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.setTitle("Stop", forState: UIControlStateNormal)
      button.addTarget(self, action: :start, forControlEvents: UIControlEventTouchDown)
      button.frame = [[245, 20], [210, 40]]
    end)
    view.addSubview(UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.setTitle("Skip", forState: UIControlStateNormal)
      button.addTarget(self, action: :start, forControlEvents: UIControlEventTouchDown)
      button.frame = [[470, 20], [210, 40]]
    end)
  end
end

