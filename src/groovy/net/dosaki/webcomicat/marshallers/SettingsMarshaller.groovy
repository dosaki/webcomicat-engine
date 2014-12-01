package net.dosaki.webcomicat.marshallers

import net.dosaki.webcomicat.Settings
import grails.converters.JSON

class SettingsMarshaller {
    void register() {
        JSON.registerObjectMarshaller(Settings) { s ->
            return [
                comicTitle: s.comicTitle,
                aboutComic:s.getAboutComic(),
                mainAuthor: s.mainAuthor,
                mainAuthorEmail: s.mainAuthorEmail,
                aboutAuthor:s.getAboutAuthor(),
                profileImage:s.getProfileImageName(),
                favicon:s.getFaviconName(),
            ]
        }
    }
}
