class TeammateController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    view.addSubview(display_name_field)
    view.addSubview(spoken_name_field)
  end

  def display_name_field
    @display_name_field ||= UITextField.alloc.initWithFrame([[10, 30], [300, 40]]).tap do |first|
      first.borderStyle = UITextBorderStyleRoundedRect
      first.font = UIFont.systemFontOfSize(14)
      first.minimumFontSize = 17
      first.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      first.adjustsFontSizeToFitWidth = true
      first.placeholder = "Display name"
      first.delegate = self
    end
  end

  def spoken_name_field
    @spoken_name_field ||= UITextField.alloc.initWithFrame([[10, 80], [300, 40]]).tap do |last|
      last.borderStyle = UITextBorderStyleRoundedRect
      last.font = UIFont.systemFontOfSize(14)
      last.minimumFontSize = 17
      last.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      last.adjustsFontSizeToFitWidth = true
      last.placeholder = "Spoken name"
      last.delegate = self
    end
  end

  def showDetailsForTeammate(teammate)
    @teammate = teammate
    if !teammate
      self.title = "New teammate"
      display_name_field.text = ""
      spoken_name_field.text = ""
    else
      self.title = @teammate.display_name
      display_name_field.text = @teammate.display_name
      spoken_name_field.text = @teammate.spoken_name
    end
  end

  def textFieldShouldReturn(text_field)
    if text_field == display_name_field
      spoken_name_field.becomeFirstResponder
    else
      display_name_field.becomeFirstResponder
    end
  end

  def viewWillDisappear(animated)
    super
    if @teammate
      @teammate.display_name = display_name_field.text
      @teammate.spoken_name = spoken_name_field.text
      @teammate.save
    end
  end
end
