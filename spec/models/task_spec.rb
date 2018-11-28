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

  describe "#toggle_favorite!" do
    it "should switch favorite to false if it was true" do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it "should switch favorite to true if it was false" do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe "#overdue?" do
    it "should return true if the deadline passed and the task is not complete" do
      task = Task.create(deadline: 1.day.ago, complete: false)
      result = task.overdue?
      expect(result).to eq(true)
    end

    it "should return false if the deadline passed but the task is complete" do
      task = Task.create(deadline: 1.day.ago, complete: true)
      result = task.overdue?
      expect(result).to eq(false)
    end

    it "should return false if the deadline has not passed" do
      task = Task.create(deadline: 1.day.from_now)
      result = task.overdue?
      expect(result).to eq(false)
    end
  end

  describe "#increment_priority!" do
    it "should increase priority by 1" do
      task = Task.create(priority: 4)
      task.increment_priority!
      expect(task.priority).to eq(5)
    end

    it "should not increase priority past 10" do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe "#decrement_priority!" do
    it "should decrease priority by 1" do
      task = Task.create(priority: 4)
      task.decrement_priority!
      expect(task.priority).to eq(3)
    end

    it "should not decrease priority past 1" do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe "#snooze_hour!" do
    it "should increase deadline by 1 hour" do
      the_deadline = 1.day.ago
      task = Task.create(deadline: the_deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(the_deadline + 1.hour)
    end
  end
end
