require 'spec_helper'

describe MasterCache::Configuration do
  shared_examples_for 'a configure object' do
    context 'by default' do
      it { should eq default }
    end

    context 'configured via config block' do
      before do
        MasterCache.configure {|c| c.send "#{config_name}=", other}
      end

      it { should eq other }

      after do
        MasterCache.configure {|c| c.send "#{config_name}=", default}
      end
    end
  end

  describe '#all_name' do
    subject { MasterCache.config.all_name }
    let(:config_name) { :all_name }
    let(:default) { 'INSTANCES' }
    let(:other) { 'ALL_DATA' }
    it_behaves_like 'a configure object'
  end
  
  describe '#const_name' do
    subject { MasterCache.config.const_name }
    let(:config_name) { :const_name }
    let(:default) { :name }
    let(:other) { :master_name }
    it_behaves_like 'a configure object'
  end
  
  describe '#order_name' do
    subject { MasterCache.config.order_name }
    let(:config_name) { :order_name }
    let(:default) { :position }
    let(:other) { :sort_order }
    it_behaves_like 'a configure object'
  end
end

