#!/usr/bin/env lua
local function version(img, pkg, cmd)
    cmd = string.format(
        "podman run --rm --entrypoint pacman %s -%si %s"
            .. " | grep ^Version"
            .. " | sed 's/^[^:]*: //'",
        img, cmd, pkg)
    return assert(io.popen(cmd):read("a")):gsub("\n*$", "")
end

for _, x in ipairs{
    {"proxy", "nginx"},
    {"static", "nginx"},
    {"postgresql", "postgresql"},
    {"synapse", "matrix-synapse"},
    {"git-uwsgi", "uwsgi"},
    {"git-nginx", "nginx"},
    {"nextcloud-memcached", "memcached"},
    {"nextcloud-php", "nextcloud"},
    {"nextcloud-php", "php-legacy"},
    {"nextcloud-php", "php-legacy-fpm"},
    {"nextcloud-nginx", "nginx"},
    {"gitlab-redis", "redis"},
    {"gitlab-gitaly", "gitlab"},
    {"gitlab-puma", "gitlab"},
} do
    local img , pkg = table.unpack(x)
    local latest = version("arch", pkg, "S")
    local current = version(img, pkg, "Q")
    io.write(img, " ", pkg, " ", current)
    if current ~= latest then
        io.write(" -> ", latest)
    end
    io.write("\n")
end
