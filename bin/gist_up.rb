#!/usr/bin/env ruby

require 'gist_img'

auth   = GistImg::Authentication.new
github = auth.authenticate_and_get_client

up = GistImg::Uploader.new github
up.create_master_gist
