namespace :time_window do
  require 'table_print'
  require 'logger'

  desc 'list'
  task :list,[:tenant_id] => :environment do
    tid = args.fetch(:tenant_id)
    raise ArgumentError.new "Missing required :tenant_id." unless tid

    tp TimeWindow.where(tenant_id: tid).all, :id, :label,
       { start_time: { time_format: '%H:%M'} }, { end_time: { time_format: '%H:%M'} },
       :created_at, :updated_at
  end

  desc 'delete'
  task :delete,[:id] => :environment do
    id = args.fetch(:id)
    raise ArgumentError.new "Missing required :id." unless id

    tw = TimeWindow.where(id: id).first
    raise ArgumentError.new "Invalid object for ##{id}." unless tw

    tw.destroy!
  end

  desc 'export'
  task :export, [:tenant_id, :destination] => :environment do
    tid = args.fetch(:tenant_id)
    raise ArgumentError.new "Missing required :tenant_id." unless tid

    fn = args.fetch(:destination, "#{tid}_#{Time.now.strftime '%Y%m%dT%H%M%S'}.json")
    File.write(fn, TimeWindow.where(tenant_id: tid).all.to_json, mode: 'w+')
  end

  desc 'import'
  task :import, [:tenant_id, :source] => :environment do
    tid = args.fetch(:tenant_id)
    raise ArgumentError.new "Missing required :tenant_id." unless tid

    fn = args.fetch(:source)
    raise ArgumentError.new "Missing required :source." unless fn
    raise ArgumentError.new "Could not find #{fn}." unless File.exists? fn

    data = JSON::parse(File.read(fn))
    logger = Logger.new('logistic')
    data.each_with_index do |attrs, index|
      begin
        TimeWindow.create!(attrs.except(:id))
      rescue => e
        logger.info "While processing #{index}, #{attrs.inspect}:"
        logger.error e
      end
    end
  end

end
