package net.dosaki.webcomicat.marshallers

import net.dosaki.webcomicat.Chapter
import grails.converters.JSON

class ChapterMarshaller {
    void register() {
        JSON.registerObjectMarshaller(Chapter) { c ->
            return [
                id: c?.id,
                title: c?.title,
                sequence: c?.sequence
            ]
        }
    }
}
