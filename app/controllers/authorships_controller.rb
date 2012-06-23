class AuthorshipsController < ApplicationController
  # GET /authorships
  # GET /authorships.json
  def index
    @authorships = Authorship.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authorships }
    end
  end

  # GET /authorships/1
  # GET /authorships/1.json
  def show
    @authorship = Authorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @authorship }
    end
  end

  # GET /authorships/new
  # GET /authorships/new.json
  def new
    @authorship = Authorship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authorship }
    end
  end

  # GET /authorships/1/edit
  def edit
    @authorship = Authorship.find(params[:id])
  end

  # POST /authorships
  # POST /authorships.json
  def create
    @authorship = Authorship.new(params[:authorship])

    respond_to do |format|
      if @authorship.save
        format.html { redirect_to @authorship, notice: 'Authorship was successfully created.' }
        format.json { render json: @authorship, status: :created, location: @authorship }
      else
        format.html { render action: "new" }
        format.json { render json: @authorship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /authorships/1
  # PUT /authorships/1.json
  def update
    @authorship = Authorship.find(params[:id])

    respond_to do |format|
      if @authorship.update_attributes(params[:authorship])
        format.html { redirect_to @authorship, notice: 'Authorship was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @authorship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authorships/1
  # DELETE /authorships/1.json
  def destroy
    @authorship = Authorship.find(params[:id])
    @authorship.destroy

    respond_to do |format|
      format.html { redirect_to authorships_url }
      format.json { head :ok }
    end
  end
end
