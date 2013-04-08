class DailyController < UIViewController
  TIME_PER_USER = 30
  TEXT_COLOR = UIColor.colorWithRed(50.0/255.0, green:79.0/255.0, blue:133.0/255.0, alpha:1.0)

  def initWithDatasourceAndTableView(datasource, tableView)
    init

    @datasource = datasource
    @tableView = tableView

    self
  end

  def start
    unless @current_teammate # real stop, not paused
      @datasource.randomize
      @tableView.reloadData
      @current_teammate = -1
      donext
    end

    @timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: 'timerFired', userInfo: nil, repeats: true)
    @start_button.enabled = false
    @stop_button.enabled = true
    @skip_button.enabled = true
  end

  def donext
    @current_teammate += 1
    stop(true) and return if @current_teammate == @datasource.team.size
    @current_time = TIME_PER_USER

    update_name_label
    update_timer_label
    @timer_label.textColor = TEXT_COLOR
  end

  def stop_pressed
    stop
  end

  def stop(force = false)
    force ||= @timer.nil?
    if @timer
      @timer.invalidate
      @timer = nil
    end
    if force
      @current_teammate = nil
      @current_time = nil
      update_name_label
      update_timer_label

      @datasource.reload
      @tableView.reloadData

      @stop_button.enabled = false
      @skip_button.enabled = false
    end
    @start_button.enabled = true
  end

  def timerFired
    if @current_time > 0
      @current_time -= 1
      update_timer_label
      if @current_time < 4
        @timer_label.textColor = UIColor.redColor
      end
    else
      donext
    end
  end

  def update_timer_label
    @timer_label.text = @current_time.to_s
  end

  def update_name_label
    @name_label.text = @current_teammate ? @datasource.team[@current_teammate].display_name : ""
  end

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor

    view.addSubview(@start_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.setTitle("Start", forState: UIControlStateNormal)
      button.addTarget(self, action: :start, forControlEvents: UIControlEventTouchDown)
      button.frame = [[20, 20], [210, 40]]
    end)
    view.addSubview(@stop_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.setTitle("Stop", forState: UIControlStateNormal)
      button.addTarget(self, action: :stop_pressed, forControlEvents: UIControlEventTouchDown)
      button.frame = [[245, 20], [210, 40]]
      button.enabled = false
    end)
    view.addSubview(@skip_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |button|
      button.setTitle("Skip", forState: UIControlStateNormal)
      button.addTarget(self, action: :donext, forControlEvents: UIControlEventTouchDown)
      button.frame = [[470, 20], [210, 40]]
      button.enabled = false
    end)

    view.addSubview(@name_label = UILabel.alloc.initWithFrame([[20, 200], [660, 100]]).tap do |label|
      label.text = ""
      label.font = UIFont.boldSystemFontOfSize(100)
      label.textAlignment = NSTextAlignmentCenter
      label.textColor = TEXT_COLOR
    end)

    view.addSubview(@timer_label = UILabel.alloc.initWithFrame([[20, 500], [660, 100]]).tap do |label|
      label.text = ""
      label.font = UIFont.boldSystemFontOfSize(50)
      label.textAlignment = NSTextAlignmentCenter
      label.textColor = TEXT_COLOR
    end)
  end
end

