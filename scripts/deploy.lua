#!/usr/bin/env lua
local all <const> = {
    "postgresql", "static", "synapse", "git", "nextcloud", "gitlab",
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
        os.execute(v)
    else
        for _, vv in ipairs(v) do
            os.execute(t[vv])
        end
    end
end