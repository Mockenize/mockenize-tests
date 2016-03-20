Before do |scenario|
  MockenizeService.delete "/_mocks/all", nil
  MockenizeService.delete "/_proxies/all", nil
  MockenizeService.delete "/_scripts/all", nil
  MockenizeService.delete "/_logs/all", nil
end
