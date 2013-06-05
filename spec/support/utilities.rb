# This file was manually created to define a method
# to be used in the test-suite
# This can specifically be found in
# spec/requests/static_pages_spec.rb

def full_title(page_title)
  base_title = "My Dysfunctional Workplace"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end