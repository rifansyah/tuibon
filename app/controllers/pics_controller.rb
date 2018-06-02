include Magick

class PicsController < ApplicationController
    def index
        @pics = Pic.all
    end

    def show
        @pic = Pic.find(params[:id])
    end

    def new
        @pic = Pic.new
    end

    def create
        @pic = Pic.new(pic_params)
        @pic.title = Time.now().strftime("%S%M%H%d%m%y")
        @pic.description = ""

        @pic.image.instance_write(:file_name, Time.now().strftime("%S%M%H%d%m%y") + ".png")

        @twibbon = Twibbon.new(twib_params)
        @twibbon.title = Time.now().strftime("%S%M%H%d%m%y")

        if @pic.save and @twibbon.save
            generate_twibbon(pic_params[:image], twib_params[:twib_image], @pic.image.url)
            redirect_to @pic
        else
            render "new"
        end
    end

    def download
        @pic = Pic.find(params[:id])
        url = "public/" + @pic.image.url.split('?')[0].to_str
        send_file url, tipe: "application/png", x_sendfile:true
    end

    private
    def pic_params
        params.require(:pic).permit(:title, :description, :image)
    end

    private
    def twib_params
        params.require(:twibbon).permit(:title, :twib_image)
    end

    private
    def generate_twibbon(pic, twib, photo_url)
        photo = Image.from_blob(pic.read).first
        twibbon = Image.from_blob(twib.read).first

        tw_height = Float(twibbon.rows)
        tw_width = Float(twibbon.columns)
        ph_height = Float(photo.rows)
        ph_width = Float(photo.columns)
        scale_ratio = 0

        if ph_height < ph_width
            scale_ratio = tw_height / ph_height
        else
            scale_ratio = tw_width / ph_width
        end

        photo.scale!(scale_ratio)

        ph_height = Float(photo.rows)
        ph_width = Float(photo.columns)

        photo.crop!((ph_width / 2) - (tw_width / 2), (ph_height / 2) - (tw_height / 2) , tw_height, tw_width)

        photo.composite!(twibbon, 0, 0, OverCompositeOp)
        
        photo_url = photo_url.split('?')
        photo.write('public' + photo_url[0])

    end
end
