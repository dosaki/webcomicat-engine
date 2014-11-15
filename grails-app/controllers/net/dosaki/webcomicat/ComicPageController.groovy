package net.dosaki.webcomicat

import grails.converters.JSON
import org.hibernate.criterion.CriteriaSpecification

import grails.plugin.springsecurity.annotation.Secured


@Secured(['permitAll'])
class ComicPageController {
    def getAllComicPages() {
        render comicPageService.getAllComicPages() as JSON
    }
}
