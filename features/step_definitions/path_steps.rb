Given('I visit Neotopia') do
  visit '/'
end

Then("I'm redirected to {string}") do |url|
  sleep(1)
  expect(page.current_url).to start_with(url)
end
