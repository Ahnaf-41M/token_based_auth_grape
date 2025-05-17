class MountAPI < Grape::API
  mount AuthAPI
  mount BaseAPI
  mount UserAPI
  mount CompanyAPI
end
