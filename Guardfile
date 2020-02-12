# guard

ignore(/.git/)
ignore(/.idea/)
ignore(/.rspec_status/)
ignore(/Gemfile.lock/)
ignore(/node_modules/)

watch(/.*/) do |file|
  puts "\n" + '=' * 80 + "\n"
  puts "file: #{file[0]}"
  system "rubocop --auto-correct #{file}"
  puts "\n" + '-' * 80 + "\n"
  system 'rspec'
end
