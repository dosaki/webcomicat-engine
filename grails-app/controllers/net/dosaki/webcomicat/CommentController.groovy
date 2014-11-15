package net.dosaki.webcomicat

import grails.converters.JSON
import org.hibernate.criterion.CriteriaSpecification


class CommentController {
    def newComment() {
        def newComment=new Comment()
        newComment.properties=request.JSON.comment
        newComment.save()
        if(!newComment.hasErrors())
            render newComment as JSON
        else
            render newComment.errors
    }

    def getAllCommentsForPage() {
        def c = Comment.createCriteria()
        def commentList = c.list {
            resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP);
            eq("comicPage", request.JSON.comicPage)

            order("datePosted", "asc")
        }

        render commentList as JSON
    }
}
