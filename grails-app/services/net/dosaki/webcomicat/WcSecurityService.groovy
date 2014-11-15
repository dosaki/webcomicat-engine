package net.dosaki.webcomicat

class WcSecurityService{
    def springSecurityService
    def passwordEncoder

    public User getCurrentUser(){
        return springSecurityService.getCurrentUser();
    }

    public User getUserFromPrincipal(principal){
        return User.findUserByUsername(principal.username);
    }

    public boolean passwordMatch(rawPassword, encodedPassword){
        return passwordEncoder.matches(encodedPassword, rawPassword, null)
    }

    public boolean verifyCurrentUserPassword(rawPassword){
        User currentUser = getCurrentUser();
        return passwordMatch(rawPassword, currentUser.encodedPassword)
    }
}
