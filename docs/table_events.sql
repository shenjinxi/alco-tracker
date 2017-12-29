-- если несколько проектов, то первыичный ключ будет (projectId, date, uid)
-- DROP TABLE IF EXISTS events;
CREATE TABLE IF NOT EXISTS events
(
    id UInt64,
    projectId UInt32,
    name String,
    uid UInt64,
    ip String,
    userAgent String,
    page_url String,
    page_referrer String,
    page_title String,
    session_type String,
    session_engine String,
    session_num UInt16,
    session_hasMarks UInt8,
    session_marks_key Array(String),
    session_marks_value Array(String),
    session_start UInt64,
    session_refHost String,
    lib_name String,
    lib_libver UInt32,
    lib_snippet UInt32,
    client_type String,
    client_name String,
    client_version String,
    client_tz String,
    client_ts UInt64,
    client_tzOffset Int32,
    client_platform String,
    client_product String,
    browser_if Array(UInt8),
    browser_wh_w UInt16,
    browser_wh_h UInt16,
    browser_sr_tot_w UInt16,
    browser_sr_tot_h UInt16,
    browser_sr_avail_w UInt16,
    browser_sr_avail_h UInt16,
    browser_sr_asp UInt16,
    browser_sr_oAngle UInt16,
    browser_sr_oType String,
    country_iso String,
    country_name_ru String,
    country_name_en String,
    region_iso String,
    region_name_ru String,
    region_name_en String,
    city_id UInt32,
    city_name_ru String,
    city_name_en String,
    os_name String,
    os_version String,
    os_platform String,
    device_type String,
    device_brand String,
    device_model String,
    campaign String,
    source String,
    timestamp UInt64,
    dateTime DateTime,
    date Date,
    isBot UInt8,
    data_key Array(String),
    data_value Array(String)

) ENGINE = MergeTree(date, (date, uid), 8192);




