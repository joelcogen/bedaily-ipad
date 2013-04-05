class DailyController < UIViewController
  def loadView
    self.view = UIWebView.alloc.init
    url = NSURL.alloc.initWithString('http://www.belighted.com')
    request = NSURLRequest.requestWithURL(url)
    view.loadRequest(request)
  end
end

