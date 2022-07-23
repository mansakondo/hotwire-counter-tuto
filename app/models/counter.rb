class Counter
  include Kredis::Attributes

  kredis_counter :count,
    key: "counter:count",
    after_change: :broadcast_update

  class << self
    def count
      new.count
    end
  end

  def broadcast_update
    Turbo::StreamsChannel.broadcast_update_to "counter",
      target: "counter-count",
      content: count.value
  end
end
