class Api::V1::FollowsController < ApplicationController
    def index
        @follows = Follow.all
        render json: @follows
    end

    def show
        @follow = Follow.find_by(id: params[:id])
    end

    def new
        @follow = Follow.new
    end

    def create
        @follow = Follow.create(follow_params)
    end

    def edit
        @follow = Foloow.find_by(id: params[:id])
    end

    def update
        @follow = Follow.find_by(id: params[:id])
        @follow.update
    end

    def destroy
        @follow = Follow.find_by(id: params[:id])
        @follow.destroy
    end

    private 
        def follow_params
            params.require(:follow).permit(:id, :user_id, :followee_id)
        end

end
