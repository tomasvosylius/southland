#define set_filename(%0) 				new const UNIQUE_FUNCTION<p_FileName...>[54] = %0; forward UNIQUE_FUNCTION<p_FileFunction...>(); public UNIQUE_FUNCTION<p_FileFunction...>() return 1
#define filename 	 	 				UNIQUE_FUNCTION<p_FileName...>

#define DURATION_MS(%1)     			(DURATION(%1) * 1000)
#define DURATION(%1)        			(DURATION_PT:%1,0)
#define DURATION_PT:%1,     			(%1:DURATION)+_:DURATION_PT:

#define second%1:DURATION
#define seconds%1:DURATION
#define minute%1:DURATION   			* DURATION_MINUTE
#define minutes%1:DURATION  			* DURATION_MINUTE
#define hour%1:DURATION     			* DURATION_HOUR
#define hours%1:DURATION    			* DURATION_HOUR
#define day%1:DURATION      			* DURATION_DAY
#define days%1:DURATION     			* DURATION_DAY
#define week%1:DURATION     			* DURATION_WEEK
#define weeks%1:DURATION    			* DURATION_WEEK
#define month%1:DURATION    			* DURATION_MONTH
#define months%1:DURATION   			* DURATION_MONTH
#define year%1:DURATION     			* DURATION_YEAR
#define years%1:DURATION    			* DURATION_YEAR 

#define ReturnPlayerHealth(%0)	 		(GetPlayerHealth((%0), Float:I@), Float:I@)
#define ReturnPlayerArmour(%0)			(GetPlayerArmour((%0), Float:I@), Float:I@)
#define ReturnLocationName(%0,%1) 		(GetCoords2DZone((%0),(%1),Q@,32), Q@) 								

/*#if defined call
	#undef call
#endif

#define call%0On%1(%2)					printf("[%s]: called On"#%1"("#%2")", filename), ALS_DO:ALS_G_INT<%1>(%2)							
#define CallLocalFunctionEx(%0) 		printf("[%s]: called "#%0"", filename) , CallLocalFunction(%0)				*/
