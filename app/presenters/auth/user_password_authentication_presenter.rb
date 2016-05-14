module Auth
  class UserPasswordAuthenticationPresenter < BasePresenter

    def form
      v.form_for(context, url: v.sessions_path(context), as: 'session') do |f|
        presenter = BasePresenter.factory f, v
        yield presenter
      end
    end
  end
end