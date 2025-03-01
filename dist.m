function dist = dist(p1, p2)
    a1 = p1(1);
    b1 = p1(2);
    c1 = p1(3);
    a2 = p2(1);
    b2 = p2(2);
    c2 = p2(3);
    dist = sqrt((a2-a1)^2+(b2-b1)^2+(c2-c1)^2);
end