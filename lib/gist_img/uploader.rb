module GistImg
    class Uploader

        AUTH_FILE = ENV['HOME']+'/.gist-img'

        def initialize github, filename=AUTH_FILE
            @github = github
            @filename = filename
            @contents = Hash[*File.read(@filename).split(/[: \n]+/)]
        end

        def create_gist filename, options = {}
            if @contents["master_gid"].nil?
                create_master_gist
            end
        end

        def create_master_gist options = {}
            response = @github.gists.create('public' => true,
                                            'description' => 'My image uploads',
                                            'files' =>  { 'master.png' =>
                                                          {'content' => content
                                                          }
            } )
            File.open(@filename, "a") { |file| file.write("master_gid:#{response.id}") }
        end

        def gist_options is_public, description, content, gid
            options = {
                'public' => is_public
                'description' => description || "Upload from gist-up"
                ''
            
            }
        end
    end
end

