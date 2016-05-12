# A helper class for encryption
#
# @author [buntekuh]
#
class EncryptionService
  #
  # Encrypts a string prefixed with a seed using SHA2
  # @param string [type] the string to encrypt
  #
  # @return [String] encrypted string
  def self.seed_and_encrypt string
    seed = generate_seed
    [seed, encrypt_with_seed(seed, string)]
  end

  # Generates a seed for password encryption
  #
  # @return [String] memoized random token
  def self.generate_seed
    SecureRandom.base64(44).tr('+/=', 'xyz')
  end

  # Encrypts a string prefixed with a seed using SHA2
  #
  # @return [String] encrypted string

  #
  # Encrypts a string prefixed with a seed using SHA2
  # @param seed [String] seed to strengthen encryption
  # @param string [type] the string to encrypt
  #
  # @return [String] encrypted string
  def self.encrypt_with_seed(seed, string)
    Digest::SHA2.hexdigest("--#{seed}--#{string}--")
  end

  # Generates a token
  # @param length [Integer] length of generated token, defaults to 10
  # 
  # @return [String] generated token
  def self.generate_token length = 10
    SecureRandom.hex(length)
  end

  def self.generate_session_token
    generate_token 32
  end
end