function cd(pos, input, data)
    if not minetest.check_player_privs(data.player, "computers_filesystem") then
        return "ERROR: permision denied"
    end
    local path = computers.devicepath .. "/" .. minetest.hash_node_position(pos) .. data.element.pwd

    if input and input ~= "" and not input:find("/") and not input:find("\\") then
        if input == ".." then
            local uri = data.element.pwd:split("/")
            uri[#uri] = nil
            data.element.pwd = "/" .. table.concat(uri, "/")
            if data.element.pwd == "/" then data.element.pwd = "" end
            return "sucess"
        else
            for _, folder in pairs(minetest.get_dir_list(path, true)) do
                if folder == input then
                    data.element.pwd = data.element.pwd .. "/" .. input
                    return "sucess"
                end
            end
            return "ERROR: path not found"
        end
    else
        return "invalid or missing input"
    end
end

return cd