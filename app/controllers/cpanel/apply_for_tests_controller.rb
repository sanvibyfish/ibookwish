class Cpanel::ApplyForTestsController < Cpanel::ApplicationController

  # GET /categories
  # GET /categories.json
  def index
    @apply_for_tests = ApplyForTest.all.desc(:created_at).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apply_for_tests }
    end
  end

end
