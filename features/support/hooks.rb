Before do |scenario|
  MockenizeService.delete "/_mockenize/mocks/all", nil
  MockenizeService.delete "/_mockenize/proxies/all", nil
  MockenizeService.delete "/_mockenize/scripts/all", nil
  MockenizeService.delete "/_mockenize/logs/all", nil
end
