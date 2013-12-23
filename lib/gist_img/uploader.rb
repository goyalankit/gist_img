module GistImg
    class Uploader
        require 'pathname'

        AUTH_FILE = ENV['HOME']+'/.gist-img'
        def initialize github, filename=AUTH_FILE
            @github = github
            @filename = filename
            @contents = Hash[*File.read(@filename).split(/[: \n]+/)]
        end

        def create_master_gist
            response = @github.gists.create('public' => true,
                                            'description' => 'My image uploads',
                                            'files' =>  { 'master.txt' =>
                                                          {'content' => 'My Image Uploads. Created By GistImgUploader'
                                                          }
            } )
            File.open(@filename, "w") { |file| file.write("master_gid:#{response.id}") }
        end
    end

end

