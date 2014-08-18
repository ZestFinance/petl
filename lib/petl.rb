require "petl/version"

module Petl
  def perform logger = Rails.logger
    if batch
      batch_perform logger
    else
      not_batch_perform logger
    end
  end

  def extract
    raise NotImplementedError.new "#{self}#extract not implemented."
  end

  def transform(_rows)
    raise NotImplementedError.new "#{self}#transform not implemented."
  end

  def load(_rows)
    raise NotImplementedError.new "#{self}#load not implemented."
  end

  def source_count
    raise NotImplementedError.new "#{self}#source_count not implemented."
  end

  def destination_count
    raise NotImplementedError.new "#{self}#destination_count not implemented."
  end

  def verify logger = Rails.logger
    if source_count != destination_count
      logger.error "#{self}: counts don't match"
    end

    logger.info "#{self}: source count        #{source_count}"
    logger.info "#{self}: destination count   #{destination_count}"
  end

  def batch
    false
  end

  private

  def not_batch_perform logger = Rails.logger
    with_profiling logger do
      load(transform(extract))
      verify logger
    end
  end

  def batch_perform logger = Rails.logger
    with_profiling logger do
      extract do |batch|
        load(transform batch)
      end
      verify logger
    end
  end

  def with_profiling logger, &block
    start_time = Time.now
    logger.info "#{self} starting at #{start_time}"

    yield block

    logger.info "#{self} finished at #{Time.now}. Took #{(Time.now - start_time).round} seconds"
  end
end
