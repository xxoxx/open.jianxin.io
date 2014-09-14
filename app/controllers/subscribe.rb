OpenJianxinIo::App.controllers :subscribe do

  get :send do
    @title = '邮件发送成功'
    @ignore_subscribe = true
    send_mail('confirm', current_account, '来自简信的确认信息', render(:verify, layout: 'mail'))
    render :send, layout: 'application'
  end

  get :verify do
    @title = '订阅确认成功'
    user = load_url(params)
    unless user
      halt 404
    end
    set_current_account user
    user.update_attributes subscribed: true
    render :verified, layout: 'application'
  end

  get :unsubscribe do
    @title = '您已经取消订阅'
    user = load_url(params)
    unless user
      halt 404
    end
    set_current_account user
    user.update_attributes subscribed: false
    render :unsubscribe, layout: 'application'
  end

end
