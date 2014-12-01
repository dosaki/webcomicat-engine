package net.dosaki.webcomicat

import grails.converters.JSON

import grails.plugin.springsecurity.annotation.Secured


@Secured(['permitAll'])
class GeneralController {
    def index(){
        redirect action:"about"
    }
    def about(){
        def settings = Settings.get(1)
        if(!settings.favicon){

        }
        render view:"about",
                model:[
                    "settings": settings,
                    "current": "about"
                ]
    }
}
