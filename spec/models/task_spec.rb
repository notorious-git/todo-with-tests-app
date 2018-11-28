require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "#toggle_complete!" do
    it "should switch complete to true if it was false" do
      task = Task.create(name: "Mow the lawn", description: "Use the lawnmower Luke", priority: 2, deadline: 1.day.ago, complete: false, duration: 60, favorite: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end

    it "should switch complete to false if it was true" do
      task = Task.create(name: "Mow the lawn", description: "Use the lawnmower Luke", priority: 2, deadline: 1.day.ago, complete: true, duration: 60, favorite: false)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end
end
