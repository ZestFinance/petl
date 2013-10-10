require 'spec_helper'

describe "Petl" do

  module TestETL
    extend Petl
    extend self

    def source_count
      1
    end

    def destination_count
      1
    end

    def extract
      []
    end

    def transform data
      data
    end

    def load data
    end
  end

  describe TestETL do

    describe '#verify' do
      before do
        @logger = double
      end

      context "counts don't match" do
        before do
          TestETL.stub(:source_count).and_return(1)
          TestETL.stub(:destination_count).and_return(2)
        end

        it "logs the error" do
          @logger.should_receive(:error).with(/counts don't match/i).once
          @logger.should_receive(:info).twice
          described_class.verify @logger
        end
      end

      it "logs the source count" do
        @logger.should_receive(:info).with(/source count\s*1/).once
        @logger.should_receive(:info).once
        described_class.verify @logger
      end

      it "logs the destination count" do
        @logger.should_receive(:info).once
        @logger.should_receive(:info).with(/destination count\s*1/).once
        described_class.verify @logger
      end
    end

    context '#perform' do
      before do
        @logger = double
      end

      context "with batching" do
        module BatchETL
          extend Petl
          extend self

          def batch
            true
          end

          def source_count
            1
          end

          def destination_count
            1
          end

          def extract &block
            yield []
          end

          def transform data
            data
          end

          def load data
          end
        end

        before do
          @logger.stub(:info)
        end

        it 'yields to extract' do
          BatchETL.should_receive(:extract).and_yield []
          BatchETL.perform @logger
        end
      end

      it 'logs the start time, end time and time elapsed' do
        @logger.should_receive(:info).with(/starting/i).once
        @logger.should_receive(:info).once
        @logger.should_receive(:info).once
        @logger.should_receive(:info).with(/finished.*took/i).once

        described_class.perform @logger
      end
    end
  end
end
