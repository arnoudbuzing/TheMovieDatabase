(* ::Package:: *)

(* ::Section:: *)
(*THE MOVIE DATABASE*)


(* ::Subsubsection:: *)
(*BEGIN*)


BeginPackage["TheMovieDatabase`"];


ToExpression/@ {"getCertifications","getChanges","getCollection","getCompany","getConfiguration","getCredits","getDiscover","getFind","getGenres","getKeyword","getLists","getMovie","getNetwork","getPerson","getProviders","getReview","getSearch","getTelevision","getTelevisionEpisode","getTelevisionEpisodeGroup","getTelevisionSeason","getTrending"};


Begin["Private`"];


base="https://api.themoviedb.org/3/";


get[url_]:=Module[{request,response},
request=HTTPRequest[URLBuild[url,{"api_key"->SystemCredential["TMDB"]}]];
response=URLRead[request];
Dataset[ImportByteArray[response["BodyByteArray"],"RawJSON"]]
]


(* ::Subsubsection:: *)
(*GET /certification/.../list*)


getCertifications[model:Alternatives["movie","tv"]]:=Module[{url},
url=URLBuild[{base,"certification",model,"list"}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /.../changes*)


getChanges[model:Alternatives["movie","tv","person"]]:=Module[{url},
url=URLBuild[{base,model,"changes"}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /collection/{collection_id}*)


getCollection[id_,Optional[opt:Alternatives["images","translations"],Nothing]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"collection",idString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /company/{company_id}*)


getCompany[id_,Optional[opt:Alternatives["images","translations"],Nothing]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"company",idString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /configuration*)


getConfiguration[Optional[opt:Alternatives["countries","jobs","languages","primary_translations","timezones"],Nothing]]:=Module[{url},
url=URLBuild[{base,"configuration",opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /credit/{credit_id}*)


getCredits[id_]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"credit",idString}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /discover/...*)


(* ::Item:: *)
(*complicated search query syntax: https://developers.themoviedb.org/3/discover/movie-discover*)


getDiscover[model:Alternatives["movie","tv"],query_List]:=Module[{url},
url=URLBuild[{base,"discover",model},query];
get[url]
]


(* ::Subsubsection:: *)
(*GET /find/{external_id}*)


getFind[id_,source:Alternatives["imdb_id","freebase_mid","freebase_id","tvdb_id","tvrage_id","facebook_id","twitter_id","instagram_id"]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"find",idString},{"external_source"->source}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /genre/.../list*)


getGenres[model:Alternatives["movie","tv","person"]]:=Module[{url},
url=URLBuild[{base,"genre",model,"list"}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /keyword/{keyword_id}*)


getKeyword[id_]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"keyword",idString}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /list/{list_id}*)


getLists[id_,Optional[opt:"item_status",Nothing]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"list",idString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /movie/{movie_id}*)


getMovie[m:Alternatives["latest","now_playing","popular","top_rated","upcoming"]]:=Module[{url},
url=URLBuild[{base,"movie",m}];
get[url]]


getMovie[id_,Optional[opt:Alternatives["account_states","alternative_titles","changes","credits","external_ids","images","keywords","lists","recommendations","release_dates","reviews","similar","translations","videos","watch/providers"],Nothing]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"movie",idString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /network/{network_id}*)


getNetwork[id_,Optional[opt:Alternatives["images","alternative_names"],Nothing]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"network",idString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /trending/{media_type}/{time_window}*)


getTrending[model:Alternatives["all","movie","tv","person"],window:Alternatives["day","week"]]:=Module[{url},
url=URLBuild[{base,"trending",model,window}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /person/{person_id}*)


getPerson[m:Alternatives["latest","popular"]]:=Module[{url},
url=URLBuild[{base,"person",m}];
get[url]]


getPerson[id_,Optional[opt:Alternatives["changes","movie_credits","tv_credits","combined_credits","external_ids","images","tagged_images","translations",""],Nothing]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"person",idString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /review/{review_id}*)


getReview[id_]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"review",idString}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /search/...*)


getSearch[model:Alternatives["company","collection","keyword","movie","multi","person","tv"],query_String]:=Module[{url},
url=URLBuild[{base,"search",model},{"query"->query}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /tv/{tv_id}*)


getTelevision[m:Alternatives["latest","airing_today","on_the_air","top_rated","popular"]]:=Module[{url},
url=URLBuild[{base,"tv",m}];
get[url]]


getTelevision[id_,Optional[opt:Alternatives["account_states","aggregate_credits","alternative_titles","changes","content_ratings","credits","episode_groups","external_ids","images","keywords","lists","recommendations","release_dates","reviews","screened_theatrically","similar","translations","videos","watch/providers"],Nothing]]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"tv",idString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /tv/{tv_id}/season/{season_number}*)


getTelevisionSeason[tvid_,seasonid_,Optional[opt:Alternatives["account_states","aggregate_credits","changes","credits","external_ids","images","translations","videos"],Nothing]]:=Module[{tvidString,seasonidString,url},
tvidString=ToString[tvid];
seasonidString=ToString[seasonid];
url=URLBuild[{base,"tv",tvidString,"season",seasonidString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /tv/{tv_id}/season/{season_number}/episode/{episode_number}*)


getTelevisionEpisode[tvid_,seasonid_,episodeid_,Optional[opt:Alternatives["account_states","credits","changes","credits","external_ids","images","translations","videos"],Nothing]]:=Module[{tvidString,seasonidString,episodeidString,url},
tvidString=ToString[tvid];
seasonidString=ToString[seasonid];
episodeidString=ToString[episodeid];
url=URLBuild[{base,"tv",tvidString,"season",seasonidString,"episode",episodeidString,opt}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /tv/episode_group/{id}*)


getTelevisionEpisodeGroup[id_]:=Module[{idString,url},
idString=ToString[id];
url=URLBuild[{base,"tv","episode_group",idString}];
get[url]
]


(* ::Subsubsection:: *)
(*GET /watch/providers/regions*)


getProviders[model:Alternatives["region","movie","tv"]]:=Module[{url},
url=URLBuild[{base,"watch","providers",model}];
get[url]
]


(* ::Subsubsection:: *)
(*END*)


End[];


EndPackage[];
