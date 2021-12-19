function create_friendship(params, a::Authentictor)

    if "screen_name" ∉ collect(keys(user))
        error("Required value: screen_name")
    end
    
    url = joinpath(BASE_API_URL, "friendships/create.json")

    # Response Object
    resp = oauth_request_resource(
        url,
        "POST",
        params,
        a.consumer_key,
        a.consumer_secret,
        a.oauth_token,
        a.oauth_secret
    )

    if resp.status == 200
        newdata = JSON.parse(String(resp.body))
        return newdata
    else
        error("Twitter API returned $(resp.status) status")
    end
    
end

function destroy_friendship(params, a::Authentictor)
    url = joinpath(BASE_API_URL, "friendships/destroy.json")

    # Response Object
    resp = oauth_request_resource(
        url,
        "POST",
        params,
        a.consumer_key,
        a.consumer_secret,
        a.oauth_token,
        a.oauth_secret
    )

    if resp.status == 200
        newdata = JSON.parse(String(resp.body))
        return newdata
    else
        error("Twitter API returned $(resp.status) status")
    end
    
end


function update_friendship(params, a::Authentictor)
    url = joinpath(BASE_API_URL, "friendships/update.json")

    # Response Object
    resp = oauth_request_resource(
        url,
        "POST",
        params,
        a.consumer_key,
        a.consumer_secret,
        a.oauth_token,
        a.oauth_secret
    )

    if resp.status == 200
        newdata = JSON.parse(String(resp.body))
        return newdata
    else
        error("Twitter API returned $(resp.status) status")
    end
    
end

function get_friends(params, a::Authentictor)
    url = joinpath(BASE_API_URL, "friends/list.json")

    # Response Object
    resp = oauth_request_resource(
        url,
        "POST",
        params,
        a.consumer_key,
        a.consumer_secret,
        a.oauth_token,
        a.oauth_secret
    )

    if resp.status == 200
        newdata = JSON.parse(String(resp.body))
        return newdata
    else
        error("Twitter API returned $(resp.status) status")
    end
    
end


