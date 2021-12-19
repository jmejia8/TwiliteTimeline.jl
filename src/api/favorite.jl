const BASE_API_URL = "https://api.twitter.com/1.1/"
"""
    favorite(a::Authentictor, p::ParamsPostTweet)

Try to collect tweets based on given object of type Autenticator and ParamsPostTweet. The `favorite` is a wrapper around the `oauth_request_resource` method from `OAuth` package which is responsible for sending the `get` request to the `statuses/update.json`.

# Example
```
# Here Twitter OAuth token and secret is stored as environment varialbe whith name
# CKEY, CSEC, OTOK, OSEC
julia> creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
julia> resource_params = ParamsPostTweet("asdf asdf asdf Test tweet")
julia> tweets = favorite(creds, resource_params);
```
That should return 100 latest tweets from the profile @realDonaldTrump.
"""
function favorite(tweet, a::Authentictor)
    if "id" ∉ collect(keys(tweet))
        error("Required value: id")
    end
    
    url = joinpath(BASE_API_URL, "favorites/create.json")

    # paramter convertion to dictionary
    params = Dict("id" => string(tweet["id"])) 

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


function favorited(tweet)
    ks = collect(keys(tweet))
    
    if "favorited" ∉ ks
        error("Tweet has a bad format.")
    end

    return tweet["favorited"]
end

function get_favorite(a::Authentictor, p::ParamsGetTweets)
    url = joinpath(BASE_API_URL, "favorites/list.json")
    params = params_to_dict(p)

    resp = oauth_request_resource(
        url,
        "GET",
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

