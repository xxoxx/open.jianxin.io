OpenJianxinIo::App.controllers :todo do

  get :index, map: '/' do
    @title = '开发计划'
    render :index, layout: 'application'
  end
end
