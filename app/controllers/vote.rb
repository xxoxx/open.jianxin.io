OpenJianxinIo::App.controllers :vote do

  get :index do
    render :index, layout: 'vote'
  end

end
