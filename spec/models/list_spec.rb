require 'rails_helper'

RSpec.describe List, type: :model do
  describe "#complete_all_tasks!" do
    it "should mark all tasks from a list as complete" do
      list = List.create(name: "Chores")
      Task.create(list_id: list.id, complete: false)
      Task.create(list_id: list.id, complete: false)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe "#snooze_all_tasks!" do
    it "should increase each task deadline by 1 hour" do
      # setup
      list = List.create
      Task.create(list_id: list.id, deadline: Time.new(2018, 1, 1))
      Task.create(list_id: list.id, deadline: Time.new(2018, 1, 1))
      Task.create(list_id: list.id, deadline: Time.new(2018, 1, 1))
      # run method
      list.snooze_all_tasks!
      # check expectations
      list.tasks.each do |task|
        expect(task.deadline).to eq(Time.new(2018,1,1) + 1.hour)
      end
    end
  end

  describe '#total_duration' do
    it 'should return the sum of the duration of all the tasks' do
      # setup
      list = List.create(name: "Chores")
      Task.create(duration: 50, list_id: list.id)
      Task.create(duration: 100, list_id: list.id)
      # run code
      result = list.total_duration
      # check expectations
      expect(result).to eq(150)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of all incomplete tasks' do
      # setup
      list = List.create(name: "Chores")
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      # run code
      incomplete_tasks = list.incomplete_tasks
      # check expectations
      expect(incomplete_tasks.count).to eq(2)
      incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end

  describe '#favorite_tasks' do
    it 'should return an array of all favorite tasks' do
      # setup
      list = List.create(name: "Chores")
      Task.create(favorite: true, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      Task.create(favorite: false, list_id: list.id)
      # run code
      favorite_tasks = list.favorite_tasks
      # check expectations
      expect(favorite_tasks.count).to eq(1)
      favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end

end
