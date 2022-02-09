Needs["PacletTools`"]

pi = Import["TheMovieDatabase/PacletInfo.wl"];
v = ToExpression /@ StringSplit[ pi["Version"] , "." ];
v[[3]] += 1;
v = ToString /@ v;
v = StringRiffle[v,"."];
pi = PacletObject[ Join[ First[pi], <| "Version" -> v |> ] ];
Export["TheMovieDatabase/PacletInfo.wl",pi];

PacletBuild["TheMovieDatabase"]


