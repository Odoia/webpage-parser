class WebpageVisit
  attr_reader :file_arg

  def initialize
    @file_arg = ARGV.first
  end

  def call
    return puts 'file error' if do_hash_with_file.nil?

    current_file_hash = do_hash_with_file
    total = total_visits(current_file_hash)
    unique = total_unique_visits(current_file_hash)

    puts print_result(total, type: 1)
    puts "\n"
    puts print_result(unique, type: 2)
  end

  def do_hash_with_file
    return if file_arg.nil?

    file_name = File.basename(file_arg)
    file_path = File.dirname(file_arg)
    path = File.expand_path(file_name, file_path)
    file = File.open(path)
    log_hash = {}

    until file.eof?
      current_line = file.gets.chomp
      next unless validate_line(current_line)

      splited_log = current_line.split(' ')
      key = splited_log.first
      value = splited_log.last

      log_hash[key].nil? ? log_hash[key] = [value] : log_hash[key].push(value)
    end

    file.close
    log_hash
  end

  def total_visits(hash)
    cloned_hash = hash.clone
    hash_with_total_values = cloned_hash.each { |key, value| cloned_hash[key] = value.count }
    hash_with_total_values.sort_by { |_k, v| v }.reverse
  end

  def total_unique_visits(hash)
    cloned_hash = hash.clone
    hash_with_total_values = cloned_hash.each { |key, value| cloned_hash[key] = value.uniq.count }
    hash_with_total_values.sort_by { |_k, v| v }.reverse
  end

  def print_result(result_to_print, type: 1)
    result_to_print.map do |tv|
      "-> #{tv.first} #{tv.last} #{type_hash[type]}"
    end
  end

  def type_hash
    {
      1 => 'views',
      2 => 'unique views'
    }
  end

  def validate_line(file)
    regex = /[a-z,0-9] [0-9]/i
    file.match(regex).to_s.length == 3
  end
end

w = WebpageVisit.new
w.call

