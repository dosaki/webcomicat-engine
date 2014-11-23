package net.dosaki.webcomicat

import grails.converters.JSON

import grails.plugin.springsecurity.annotation.Secured


@Secured(['permitAll'])
class GeneralController {

    def index(){
        redirect action:"about"
    }
    def about(){
        render view:"about"
    }
}
