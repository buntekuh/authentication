require 'test_helper'

class EncryptionServiceTest < ActiveSupport::TestCase
  test 'seed_and_encrypt' do
    string = 'hallo'
    seed, encrypted = EncryptionService.seed_and_encrypt string
    assert_equal EncryptionService.encrypt_with_seed(seed, string), encrypted
    assert (seed =~ /^[a-zA-Z0-9]+$/)
  end

  test 'generate_seed' do
    assert (EncryptionService.generate_seed =~ /^[a-zA-Z0-9]+$/)
  end

  test 'encrypt_with_seed' do
    seed = 'xyz'
    string = 'abc'

    assert_equal Digest::SHA2.hexdigest("--#{seed}--#{string}--"), EncryptionService.encrypt_with_seed(seed, string)
  end

  test 'generate_token' do
    assert_equal 10, EncryptionService.generate_token(5).length
    token = EncryptionService.generate_token
    assert_equal 20, token.length
    assert (token =~ /^[a-f0-9]+$/)
  end

  test 'generate_session_token' do
    token = EncryptionService.generate_session_token
    assert_equal 64, token.length
    assert (token =~ /^[a-f0-9]+$/)
  end
end
