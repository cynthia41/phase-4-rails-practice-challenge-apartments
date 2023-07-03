class LeasesController < ApplicationController
    def index
        leases = Lease.all
        render json: leases, status: :ok
    end

    def create
      lease = Lease.new(lease_params)
      if lease.save
        render json: lease, status: :created
      else
        render json: { errors: lease.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      lease = find_lease
      if lease
        lease.destroy
        head :no_content
      else
        render json: { error: "Oops! Lease not found" }, status: :not_found
      end
    end
  
    private
  
    def find_lease
      Lease.find_by(id: params[:id])
    end
  
    def lease_params
      params.permit(:apartment_id, :tenant_id, :rent)
    end
end
