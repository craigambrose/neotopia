Given('I read {string}') do |string|
  expect(page).to have_content(string)
end

Then('I answer {string}') do |string|
  slowly_fill_in('text-responder', with: string + "\n")
end

Then('I choose {string}') do |string|
  click_button(string.downcase)
end

def slowly_fill_in(locator, options)
  with = options.delete(:with)
  field = find(:fillable_field, locator, options)
  with.each_char do |char|
    field.native.send_keys(char)
    sleep(0.1)
  end
end

When('I fill in:') do |table|
  table.rows_hash.each do |key, value|
    slowly_fill_in key.downcase, with: value
  end
  click_button 'submit'
end
