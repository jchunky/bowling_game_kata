# guard

ignore(/.git/)

watch(/.*/) do |file, _|
  # system "rubocop --auto-correct #{file}"
  system 'bundle exec rspec'
end
