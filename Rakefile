# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'get auth token from google calendar'
task :get_token do
  require 'fileutils'
  require 'google/apis/calendar_v3'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'

  SCOPE               = Google::Apis::CalendarV3::AUTH_CALENDAR
  OOB_URI             = 'urn:ietf:wg:oauth:2.0:oob'
  CLIENT_SECRETS_PATH = 'client_id.json'
  CREDENTIALS_PATH    = File.join(Dir.pwd, '.credentials', 'calendar.yaml')

  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))
  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +
              "resulting code after authorization\n"
    puts url
    puts ""
    print "code> "
    code = STDIN.gets
    credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
  end
end

task :rooms do
  require 'fileutils'
  require 'google/apis/calendar_v3'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'


  SCOPE               = Google::Apis::CalendarV3::AUTH_CALENDAR
  OOB_URI             = 'urn:ietf:wg:oauth:2.0:oob'
  CLIENT_SECRETS_PATH = 'client_id.json'
  CREDENTIALS_PATH    = File.join(Dir.pwd, '.credentials', 'calendar.yaml')

  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))
  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)

  # Initialize the API
  service = Google::Apis::CalendarV3::CalendarService.new
  service.client_options.application_name = "APPLICATION_NAME"
  service.authorization = credentials

  # Fetch the next 10 events for the user
  response = service.list_calendar_lists(
    max_results: 100,
    show_hidden: true)
=begin
  calendar_id,
                                max_results: 10,
                                single_events: true,
                                order_by: 'startTime',
                                time_min: Time.now.iso8601)
=end
  puts "Upcoming events:"
  puts "No upcoming events found" if response.items.empty?
  response.items.each do |calendar|
    p calendar.summary
  end
end
