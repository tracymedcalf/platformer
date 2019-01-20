wizard = {
collisionFilter = function (item,other)
    if other.y >= item.y + item.h then
        return 'slide'
    end
    return 'cross'
end;
}
return wizard
