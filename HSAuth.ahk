; Official HS DEVS AUTH AutoHotkey SDK
class HSAuth {
    __New(name, ownerid, secret, version := "1.0") {
        this.name := name
        this.ownerid := ownerid
        this.secret := secret
        this.version := version
        this.apiUrl := "https://auth.hsdevs.pro/api/1.3/"
        this.sessionId := ""
        this.isInitialized := false
        this.UserData := {}
    }

    Init() {
        body := "type=init&name=" . this.name . "&ownerid=" . this.ownerid . "&ver=" . this.version
        res := this.Post(body)
        if (InStr(res, """success"":true")) {
            RegExMatch(res, """sessionid"":""([^""]+)""", match)
            this.sessionId := match1
            this.isInitialized := true
            return true
        }
        return false
    }

    License(key) {
        if (!this.isInitialized && !this.Init())
            return false
        body := "type=license&key=" . key . "&sessionid=" . this.sessionId . "&name=" . this.name . "&ownerid=" . this.ownerid
        res := this.Post(body)
        if (InStr(res, """success"":true")) {
            RegExMatch(res, """expiry"":""([^""]+)""", match)
            this.UserData.expires_at := match1
            return true
        }
        return false
    }

    Post(body) {
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("POST", this.apiUrl, false)
        whr.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        whr.Send(body)
        return whr.ResponseText
    }
}
