module GistImg
    class Authentication

        AUTH_FILE = ENV['HOME']+'/.gist-img'

        def initialize filename=AUTH_FILE
            @filename = filename
        end

        def has_token?
            return false unless File.exist?(@filename)

            contents = Hash[*File.read(@filename).split(/[: \n]+/)]
            @auth_token = contents.empty? ? nil : contents["token"]
            return !@auth_token.nil?
        end

        def authenticate_and_get_client
            if has_token?
                github = create_client_from_token
                return github if github.authenticated?
            else
                return authenticate
            end
        end

        def authenticate
            print "Please enter you Github username: "
            username = gets.chomp

            print "Please enter you Github password: "
            password = gets.chomp

            github = ::Github.new basic_auth: "#{username}:#{password}"
            response = github.oauth.create 'scopes' => ['gist'], 'note' => 'gist_img_cli'

            write_token_to_file response.token
            return github
        end

        def write_token_to_file token
            File.open(AUTH_FILE, "a") { |file| file.write("token:#{token}")}
        end

        def create_client_from_token
            Github.new oauth_token: @auth_token
        end
    end
end
