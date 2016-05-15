module Auth
  class UserPasswordAuthenticationPresenter < BasePresenter

    def form
      v.form_for(context, url: v.sessions_path(context), as: 'session') do |f|
        yield BasePresenter.factory(f, v)
      end
    end
  end
end