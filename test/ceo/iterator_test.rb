require 'test_helper'

describe CEO::Iterator do
  include AcceptanceHelper

  before do
    @filterable = [:id, :name]
    Apple.destroy_all

    @fruit = Fruit.create(edible: true)
    @apple = Apple.create(
      name: 'Granny Smith',
      fruit_id: @fruit.id
    )
    @banana = Banana.create(
      name: 'Ripe Banana',
      stage: 1
    )
  end

  describe '#all' do
    it 'should return a hash of all objects with the specified keys/queries' do

      @iterator = CEO::Iterator.new(
        Apple,
        per_page: 10,
        query: %w(fruit.edible)
      )

      edible = @iterator.all.first['Edible']
      assert_equal @fruit.edible, edible
    end

    it 'should be paginated' do
      60.times { Apple.create }
      assert_equal 50, CEO::Iterator.new(Apple, per_page: 50).all.count
    end

    it 'should return 20 records by default' do
      24.times { Apple.create }
      assert_equal 20, CEO::Iterator.new(Apple).all.count
    end

    it 'should return an enum attribute as a string' do
      @iterator = CEO::Iterator.new(
        Banana,
        per_page: 10,
        query: %w(stage)
      )

      stage = @iterator.all.first['Stage']
      assert_equal @banana.stage, stage
    end
  end

  describe '#query_eval' do
    it 'should give a correct title for queries over 2 in length' do
      assert_equal(
        { 'Foo Bar' => true },
        CEO::Iterator.new(Apple).query_eval(
          @apple, 'fruit.foo.bar'
        )
      )
    end

    it 'should return none if the association does not exist' do
      assert_equal(
        'None',
        CEO::Iterator.new(Apple).query_eval(Apple.new, 'fruit.face.foo')['Face Foo']
      )
    end
  end

  describe '.filter' do
    describe 'only filter' do
      it 'should return only the allowed keys' do
        actual = CEO::Iterator.filter(
          [:unsafe, :don_t_include] + @filterable,
          only: @filterable
        )
        assert_equal @filterable.map(&:to_s), actual
      end

      it 'should return back the array if no keys are specified' do
        assert_equal @filterable, CEO::Iterator.filter(@filterable, only: [])
      end
    end

    describe 'except filter' do
      it 'should not return the blacklisted keys' do
        actual = CEO::Iterator.filter(@filterable, except: [:id])
        assert_equal [:name].map(&:to_s), actual
      end
    end

    it 'should filter "only" first because only+except is mutually exclusive' do
      actual = CEO::Iterator.filter(@filterable, only: [:id], except: [:id])
      assert_equal ['id'], actual
    end
  end
end
