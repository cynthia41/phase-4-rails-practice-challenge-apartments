class TenantsController < ApplicationController
    def index
        tenants = Tenant.all
        render json: tenants
      end
    
      def show
        tenant = Tenant.find_by(id: params[:id])
        if tenant
          render json: tenant, status: :ok
        else
          render json: { error: "Oops! Tenant not found" }, status: :not_found
        end
      end
    
      def create
        tenant = Tenant.new(tenant_params)
        if tenant.save
          render json: tenant, status: :created
        else
          render json: { errors: tenant.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def update
        tenant = find_tenant
        if tenant
          if tenant.update(tenant_params)
            render json: tenant, status: :ok
          else
            render json: { errors: tenant.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "Oops! Tenant not found" }, status: :not_found
        end
      end
    
      def destroy
        tenant = find_tenant
        if tenant
          tenant.destroy
          head :no_content
        else
          render json: { error: "Oops! Tenant not found" }, status: :not_found
        end
      end
  
      private
      def find_tenant
          Tenant.find_by(id: params[:id])
      end
    
      private
    
      def tenant_params
        params.permit(:name, :age)
      end
end
