from errors.Exceptions import *
from login.models import PseudoUser
import jwt
from companybackend.settings import SECRET_KEY
class AuthorizerServices:
    @staticmethod
    def getToken(reqBod):
        if "jwtToken" not in reqBod:
            raise TokenMissingError
        else:
            return reqBod["jwtToken"]
    @staticmethod
    def checkToken(token):
        #TODO: check expired tokens
        try:
            jwtcontent = jwt.decode(token, SECRET_KEY)
        except:
            raise AuthenticationError("Invalid Token Format")
        if "timestamp" not in jwtcontent or "uid" not in jwtcontent:
            raise AuthenticationError("Correct fields not inside jwt payload")
        else:
            tstamp = jwtcontent["timestamp"]
            uid = jwtcontent["uid"]

            try:
                currUser = PseudoUser.objects.get(pseudoname=uid)
            except PseudoUser.DoesNotExist:
                raise AuthenticationError("User could not be found")
            if currUser.token!=token:
                raise AuthenticationError("Mismatched tokens")
            else:
                return currUser
    @staticmethod
    def findOwner(reqBody):
        try:
            jwttoken = AuthorizerServices.getToken(reqBody)
        except:
            return None
        try:
            owner = AuthorizerServices.checkToken(jwttoken)
        except:
            return None
        return owner