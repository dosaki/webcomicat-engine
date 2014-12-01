package net.dosaki.webcomicat

import grails.converters.JSON

import grails.plugin.springsecurity.annotation.Secured


@Secured(['ROLE_ADMIN'])
class ImageController {
    def upload() {
        def file = request.getFile('file')
        def image = Image.findByName(params.name)

        if(!image){
            image = new Image(name:params.name);
        }

        image.file = file.bytes
        image.extension = file.getContentType()

        if(image.validate()){
            image.save(flush:true)
            render "ok"
        }
        else{
            response.sendError(500, image.errors as JSON)
        }
    }

    @Secured(['permitAll'])
    def get(){
        def image = Image.findByName(params.id)

        if(image){
            response.contentType = image.extension
            response.contentLength = image.file.size()
            OutputStream out = response.outputStream
            out.write(image.file)
            out.close()
        }
        else{
            render false
        }
    }
}
