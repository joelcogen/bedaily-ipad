class TeammateController < UIViewController
  def loadView
    self.view = UIWebView.alloc.init
  end

  def showDetailsForTeammate(teammate)
    navigationItem.title = teammate.display_name
    url = NSURL.alloc.initWithString('http://perdu.com')
    request = NSURLRequest.requestWithURL(url)
    view.loadRequest(request)
  end
end
