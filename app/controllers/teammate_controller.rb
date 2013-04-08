class TeammateController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    view.addSubview(display_name_field)
    view.addSubview(spoken_name_field)
    navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
      UIBarButtonSystemItemCancel,
      target: self,
      action: :cancel)

    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
      UIBarButtonSystemItemDone,
      target: self,
      action: :done)
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
    self.title = @teammate.display_name || "New teammate"
    display_name_field.text = @teammate.display_name
    display_name_field.becomeFirstResponder
    spoken_name_field.text = @teammate.spoken_name
  end

  def textFieldShouldReturn(text_field)
    if text_field == display_name_field
      spoken_name_field.becomeFirstResponder
    else
      display_name_field.becomeFirstResponder
    end
  end

  def done
    @teammate.display_name = display_name_field.text
    @teammate.spoken_name = spoken_name_field.text
    @teammate.save

    navigationController.popViewControllerAnimated(true)
  end

  def cancel
    navigationController.popViewControllerAnimated(true)
  end
end
