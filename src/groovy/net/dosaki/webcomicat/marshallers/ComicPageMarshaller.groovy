package net.dosaki.webcomicat.marshallers

import net.dosaki.webcomicat.ComicPage
import grails.converters.JSON

class ComicPageMarshaller {
    void register() {
        JSON.registerObjectMarshaller(ComicPage) { cp ->
            return [
                id: cp?.id,
                author:cp?.author?.username,
                title:cp?.title,
                sequence:cp?.sequence,
                releaseDate:cp?.releaseDate,
                description:cp?.description,
                chapter:cp?.chapter
            ]
        }
    }
}
