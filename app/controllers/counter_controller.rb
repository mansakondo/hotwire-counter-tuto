class CounterController < ApplicationController
  def show
    render :show, locals: {
      counter_count: counter_count.value
    }
  end

  def increment
    counter_count.increment

    respond_to do |format|
      format.turbo_stream { render_partial_update }

      format.html { redirect_to root_url }
    end
  end

  def decrement
    counter_count.decrement

    respond_to do |format|
      format.turbo_stream { render_partial_update }

      format.html { redirect_to root_url }
    end
  end

  private
    # We use Kredis to store and retrieve the counter's state
    def counter_count
      @counter_count ||= Kredis.counter "counter:count"
    end

    def render_partial_update
      render turbo_stream: turbo_stream.update("counter-count",
        counter_count.value
      )
    end
end
