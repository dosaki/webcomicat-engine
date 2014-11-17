package net.dosaki.webcomicat.marshallers

import net.dosaki.webcomicat.User
import grails.converters.JSON

class UserMarshaller {
    void register() {
        JSON.registerObjectMarshaller(User) { u ->
            return [
                id: u?.id,
                username: u?.username,
                password: "",
                enabled: u?.enabled,
                accountExpired: u?.accountExpired,
                accountLocked: u?.accountLocked,
            ]
        }
    }
}
