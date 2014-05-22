# Load the PEM file from S3
AWS.config(
  access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
)
APN.certificate = AWS::S3.new.buckets['nochat'].objects["#{ Rails.env }/apple_push_notification.pem"].read
APN.passphrase = ENV['APN_PEM_PASSPHRASE']

