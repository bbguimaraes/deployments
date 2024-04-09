#!/usr/bin/env lua
local all <const> = {
    "postgresql", "static", "synapse", "git", "nextcloud", "mastodon", "gitlab",
}

local t <const> = {
    postgresql = "postgresql/postgresql.sh",
    static = "static/static.sh",
    synapse = "synapse/synapse.sh",
    git = {"git-uwsgi", "git-nginx"},
    nextcloud = {"nextcloud-memcached", "nextcloud-php", "nextcloud-nginx"},
    gitlab = {
        "gitlab-redis", "gitlab-gitaly", "gitlab-sidekiq", "gitlab-workhorse",
        "gitlab-puma",
    },
    mastodon = {
        "mastodon-redis", "mastodon-sidekiq", "mastodon-streaming",
        "mastodon-puma", "mastodon-nginx",
    },
    proxy = "proxy/proxy.sh",
    ["git-uwsgi"] = "git/uwsgi.sh",
    ["git-nginx"] = "git/nginx.sh",
    ["nextcloud-memcached"] = "nextcloud/memcached.sh",
    ["nextcloud-nginx"] = "nextcloud/nginx.sh",
    ["nextcloud-php"] = "nextcloud/php.sh",
    ["gitlab-redis"] = "gitlab/redis.sh",
    ["gitlab-gitaly"] = "gitlab/gitaly.sh",
    ["gitlab-sidekiq"] = "gitlab/sidekiq.sh",
    ["gitlab-workhorse"] = "gitlab/workhorse.sh",
    ["gitlab-puma"] = "gitlab/puma.sh",
    ["mastodon-redis"] = "mastodon/redis.sh",
    ["mastodon-sidekiq"] = "mastodon/sidekiq.sh",
    ["mastodon-streaming"] = "mastodon/streaming.sh",
    ["mastodon-puma"] = "mastodon/puma.sh",
    ["mastodon-nginx"] = "mastodon/nginx.sh",
}

if #arg == 0 then
    arg = all
end
for _, k in ipairs(arg) do
    local v <const> = t[k]
    if not v then
        error("invalid option: " .. k)
    end
    if type(v) == "string" then
        assert(os.execute(v))
    else
        for _, vv in ipairs(v) do
            assert(os.execute(t[vv]))
        end
    end
end
