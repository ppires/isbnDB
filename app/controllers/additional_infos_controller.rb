class AdditionalInfosController < ApplicationController
  # GET /additional_infos
  # GET /additional_infos.json
  def index
    @additional_infos = AdditionalInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @additional_infos }
    end
  end

  # GET /additional_infos/1
  # GET /additional_infos/1.json
  def show
    @additional_info = AdditionalInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @additional_info }
    end
  end

  # GET /additional_infos/new
  # GET /additional_infos/new.json
  def new
    @additional_info = AdditionalInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @additional_info }
    end
  end

  # GET /additional_infos/1/edit
  def edit
    @additional_info = AdditionalInfo.find(params[:id])
  end

  # POST /additional_infos
  # POST /additional_infos.json
  def create
    @additional_info = AdditionalInfo.new(params[:additional_info])

    respond_to do |format|
      if @additional_info.save
        format.html { redirect_to @additional_info, notice: 'Additional info was successfully created.' }
        format.json { render json: @additional_info, status: :created, location: @additional_info }
      else
        format.html { render action: "new" }
        format.json { render json: @additional_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /additional_infos/1
  # PUT /additional_infos/1.json
  def update
    @additional_info = AdditionalInfo.find(params[:id])

    respond_to do |format|
      if @additional_info.update_attributes(params[:additional_info])
        format.html { redirect_to @additional_info, notice: 'Additional info was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @additional_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additional_infos/1
  # DELETE /additional_infos/1.json
  def destroy
    @additional_info = AdditionalInfo.find(params[:id])
    @additional_info.destroy

    respond_to do |format|
      format.html { redirect_to additional_infos_url }
      format.json { head :ok }
    end
  end
end
