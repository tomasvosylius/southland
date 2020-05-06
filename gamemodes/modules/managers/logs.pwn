/*
 *  Tomas Vosylius
 * 	www.crp.lt logs.pwn
 */


#define PLACE_TYPE_BUSINESS 1
#define PLACE_TYPE_HOUSE 	2
#define PLACE_TYPE_BANK 	3

/*#define log_init() 						new __log_string[512]
#define log_add(%0,%1,%2,%3) 			mysql_format(log_chandler, __log_string, 512, "INSERT INTO `"%0"` ("%1") VALUES ("%2")",%3)
#define log_push() 						mysql_tquery(log_chandler, __log_string, "LogAdded")*/


#define log_init(%0)					new __log_string[658] , bool:__log_vs = false , bool:__log_E = !!%0
#define log_set_table(%0)				format(__log_string, 56, "INSERT INTO `"%0"`")
#define log_set_keys(%0) 				mysql_format(log_chandler, __log_string, 256, "%s ("%0") VALUES (", __log_string)
#define log_set_values(%0,%1)			__log_vs = true, mysql_format(log_chandler, __log_string, 658, "%s"%0")", __log_string, %1)
#define log_push() 						__log_E && __log_vs && strlen(__log_string) && mysql_tquery(log_chandler, __log_string, "LogAdded")
#define log_reuse()						strmid(__log_string, "", 0, 0)

forward LogAdded();
public LogAdded()
{
	return 1;
}									