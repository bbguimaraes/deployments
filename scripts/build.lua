#!/usr/bin/env lua
local t <const> = {
    postgresql = "postgresql/postgresql",
    proxy = "proxy/nginx",
    static = "static/nginx",
    synapse = "synapse/synapse",
    git = {"git-nginx", "git-uwsgi"},
    nextcloud = {"nextcloud-memcached", "nextcloud-nginx", "nextcloud-php"},
    gitlab = {"gitlab-gitaly", "gitlab-puma", "gitlab-redis"},
    mastodon = {"mastodon-puma", "mastodon-nginx"},
    ["git-nginx"] = "git/nginx",
    ["git-uwsgi"] = "git/uwsgi",
    ["nextcloud-memcached"] = "nextcloud/memcached",
    ["nextcloud-nginx"] = "nextcloud/nginx",
    ["nextcloud-php"] = "nextcloud/php",
    ["gitlab-gitaly"] = "gitlab/gitaly",
    ["gitlab-puma"] = "gitlab/puma",
    ["gitlab-redis"] = "gitlab/redis",
    ["mastodon-puma"] = "mastodon/puma",
    ["mastodon-nginx"] = "mastodon/nginx",
}

local dep <const> = {
    ["mastodon-puma"] = {"mastodon-nginx"},
}

local function tag_prev(tag)
    assert(os.execute(
        string.format("podman tag -t %s:latest %s:prev", tag, tag)))
end

local function build(tag, dir)
    assert(os.execute(
        string.format("podman build -t %s %s", tag, dir)))
    local d <const> = dep[tag]
    if not d then
        return
    end
    for _, tag in ipairs(d) do
        build(tag, t[tag])
    end
end

if #arg == 0 then
    for k, v in pairs(t) do
        if type(v) == "string" then
            build(k, v)
        end
    end
else
    for _, k in ipairs(arg) do
        local v <const> = t[k]
        if not v then
            error("invalid option: " .. k)
        end
        if type(v) == "string" then
            build(k, v)
        else
            for _, vv in ipairs(v) do
                build(vv, t[vv])
            end
        end
    end
end
