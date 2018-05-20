#ifndef CCURL_SHIM_H
#define CCURL_SHIM_H

#import <curl/curl.h>
#include <stdint.h>

typedef size_t (*write_callback_t)(char *ptr, size_t size, size_t nmemb, void *userdata);


static inline CURLcode curl_easy_setopt_string(CURL *handle, CURLoption option, const char *parameter)
{
    return curl_easy_setopt(handle, option, parameter);
}

static inline CURLcode curl_easy_setopt_int(CURL *handle, CURLoption option, int parameter)
{
    return curl_easy_setopt(handle, option, parameter);
}

static inline CURLcode curl_easy_setopt_binary(CURL *handle, CURLoption option, const uint8_t *parameter)
{
    return curl_easy_setopt(handle, option, parameter);
}

static inline CURLcode curl_easy_setopt_write_function(CURL *handle, CURLoption option, write_callback_t parameter)
{
    return curl_easy_setopt(handle, option, parameter);
}

static inline CURLcode curl_easy_setopt_pointer(CURL *handle, CURLoption option, void *parameter)
{
    return curl_easy_setopt(handle, option, parameter);
}

static inline CURLcode curl_easy_setopt_slist(CURL *handle, CURLoption option, struct curl_slist *parameter)
{
    return curl_easy_setopt(handle, option, parameter);
}

static inline CURLcode curl_easy_getinfo_long(CURL *curl, CURLINFO info, long *result)
{
    return curl_easy_getinfo(curl, info, result);
}

#endif

