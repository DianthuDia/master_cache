require 'spec_helper'

# migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:test_types) {|t| t.string :name; t.integer :position; t.string :master_name; t.integer :sort_order}
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up

describe MasterCache::ModelExtension do
  before { class TestType < ActiveRecord::Base; end }
 # after { TestType.delete_all }
  after { Object.send :remove_const, :TestType }

  describe '.master_cache' do
    context 'called' do
      before { class TestType < ActiveRecord::Base; master_cache end }
      before { class TestUser < ActiveRecord::Base; end }
      after { Object.send :remove_const, :TestUser }

      it { TestType.should be_const_defined 'INSTANCES' }
      it { TestUser.should_not be_const_defined 'INSTANCES' }
    end
    
    context 'no call' do
      it { TestType.should_not be_const_defined 'INSTANCES' }
    end
  end

  describe "'all_name' option" do
    context 'no set' do
      before { class TestType < ActiveRecord::Base; master_cache end }
      it { TestType.should be_const_defined 'INSTANCES' }
    end
    
    context "set 'ALL_DATA'" do
      before { class TestType < ActiveRecord::Base; master_cache :all_name => 'ALL_DATA' end }
      it { TestType.should be_const_defined 'ALL_DATA' }
    end
  end
  
  describe "'const_name' option" do
    context 'no set' do
      before { TestType.create :name => 'APPLE'}
      before { class TestType < ActiveRecord::Base; master_cache end }
      it { TestType.should be_const_defined 'APPLE' }
      it { TestType.should be_method_defined 'apple?' }
    end
    
    context 'set :master_name' do
      context "a record don't have :master_name" do
        before { TestType.create :name => 'APPLE'}
        before { class TestType < ActiveRecord::Base; master_cache :const_name => :master_name end }
        it { TestType.should_not be_const_defined 'APPLE' }
        it { TestType.should_not be_method_defined 'apple?' }
      end

      context "a record have :master_name" do
        before { TestType.create :master_name => 'APPLE'}
        before { class TestType < ActiveRecord::Base; master_cache :const_name => :master_name end }
        it { TestType.should be_const_defined 'APPLE' }
        it { TestType.should be_method_defined 'apple?' }
      end
    end
  end
  
  describe "'order_name' option" do
    context 'no set' do
      before { 3.downto(1){|i| TestType.create :position => i} }
      before { class TestType < ActiveRecord::Base; master_cache end }
      it { TestType.all.first.position.should be 1}
    end
    
    context 'set :sort_order' do
      context "a record don't have :sort_order" do
        before { 3.downto(1){|i| TestType.create :position => i} }
        before { class TestType < ActiveRecord::Base; master_cache :order_name => :sort_order end }
        subject { TestType.all.first }
        its(:position) { should_not be 1}
        its(:sort_order) { should_not be 1}
      end
      
      context "a record have :sort_order" do
        before { 3.downto(1){|i| TestType.create :sort_order => i} }
        before { class TestType < ActiveRecord::Base; master_cache :order_name => :sort_order end }
        subject { TestType.all.first }
        its(:position) { should_not be 1}
        its(:sort_order) { should be 1}
      end
    end
  end
end
