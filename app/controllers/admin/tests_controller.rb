class Admin::TestsController < Admin::BaseController

  before_action :set_test, only: %i[show edit update destroy start update_inline]
  before_action :set_tests, only: %i[index update_inline]

  def index
    #byebug

  end

  def show

  end

  def new
    @test = Test.new
  end

  def create

    @test = Test.new(test_params)
    @test = current_user.author_tests.build(test_params)

    if @test.save
      redirect_to admin_tests_path, notice: t('.success')
    else
      render :new
    end

  end

  def edit

  end

  def destroy

    @test.destroy
    redirect_to admin_tests_path
  end

  def update

    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def set_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def set_user
    @user = User.first
  end

  def send_log_message
    logger.info("Action [#{action_name}] wasfinished")
  end

  def log_execute_time
    start = Time.now
    yield
    finish = Time.now - start

    logger.info("Execution time: #{finish * 1000}ms")
  end

  def rescue_with_test_not_found
    render plain: 'Tets was not found'
  end
end
