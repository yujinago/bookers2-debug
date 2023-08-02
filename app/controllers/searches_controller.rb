class SearchesController < ApplicationController
    def search
        @range = params[:range]
        @word = params[:word]
        @search = params[:search]
        if @range == "User"
            @users = User.looks(@search, @word)
        else
            @books = Book.looks(@search, @word)
        end
    end
end
