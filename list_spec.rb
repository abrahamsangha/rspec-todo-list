require "rspec"

require_relative "list"

describe List do
  let(:completed_task) { double("task", complete: true)}
  let(:incomplete_task) { double("task", complete: false)}
  let(:list) { List.new("Spring Cleaning", [incomplete_task, incomplete_task, completed_task]) }

  describe '#initialize' do
    it 'creates a list object' do
      expect(list).to eq list
    end

    it "requires at least one argument" do
      expect { List.new }.to raise_error(ArgumentError)
    end

    it 'raises an argument error if passed more than two parameters' do
      expect { Array.new('this', 'and', []) }.to raise_error ArgumentError
    end
  end

  describe '#add_task' do
    it 'should increase the length of tasks by one' do
      expect { list.add_task(completed_task) }.to change{list.tasks.length}.by(1)
    end
  end

  describe '#complete_task' do
    it 'should call complete! on task' do
      allow(incomplete_task).to receive(:complete!)
      incomplete_task.should_receive(:complete!)
      list.complete_task(0)
    end

    it 'raises an argument if there is no task at index' do
      expect{ list.complete_task(8) }.to raise_error NoMethodError
    end
  end

  describe '#delete_task' do
    it 'deletes the correct task' do
      expect { list.delete_task(0) }.to change{list.tasks.length}.by(-1)
    end
  end

context 'list size' do

    before do
      allow(completed_task).to receive(:complete?).and_return(true)
      allow(incomplete_task).to receive(:complete?).and_return(false)
    end

    describe '#completed_tasks' do
      it 'returns an array of completed tasks' do
        expect(list.completed_tasks.size).to eq 1
      end
    end

    describe '#incomplete_tasks' do
      it 'returns an array of incomplete tasks' do
        expect(list.incomplete_tasks.size).to eq 2
      end
    end
  end
end
