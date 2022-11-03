Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE8C433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKCQRU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCQRT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 12:17:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA118363
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667492237; x=1699028237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a68qGBIkwHWx9NAu9rg9GAge5eJKGG5VYg2nfhNUrzw=;
  b=e8uFP5t67QF/ts9oBUsek6DDUtLh2MvTdQbcmYO/UPtOxI4mLhqPB7Wt
   QDP+WcM4AnFXv0U8BvrHxxFbWtjJSNftuEu3qkEqwCl3OB6Yt8jUiWmeZ
   fZkzm4MQ9KGfJP4Zykm632cqkg2bCT6xxrtzhQrdRBv9KhN55gA0DJy/Z
   HrBeYPhf/FKYctUwAgvX94FbLmDYyj8FP7mGnB+BYYJ0dx7nXr8/ORgZq
   WWPt+ba4VS0ZKpEcE4sjqTGXHBba2cSdybPYSS7DXM+gs00pwtCjChYjD
   Y3tb5qBc8gItcC0NEZWZdIn889CiojDKxEhoq/JupOzfw0wPWvO2sMlD2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293052072"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="293052072"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:15:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="612708594"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="612708594"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.56.14]) ([10.212.56.14])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:15:03 -0700
Message-ID: <27786f64-b35a-ef82-0e93-55ee608f64ca@intel.com>
Date:   Thu, 3 Nov 2022 09:15:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 01/10] cxl: add helper function to parse trace event to
 json object
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
 <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
 <20221103014834.10d126bc@rorschach.local.home>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221103014834.10d126bc@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/2/2022 10:48 PM, Steven Rostedt wrote:
> On Wed, 02 Nov 2022 14:20:09 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add the helper function that parses a trace event captured by
>> libtraceevent in a tep handle. All the parsed fields are added to a json
>> object. The json object is added to the provided list in the input parameter.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   cxl/event_trace.c |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   cxl/event_trace.h |   14 ++++
>>   cxl/meson.build   |    2 +
>>   meson.build       |    1
>>   4 files changed, 183 insertions(+)
>>   create mode 100644 cxl/event_trace.c
>>   create mode 100644 cxl/event_trace.h
>>
>> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
>> new file mode 100644
>> index 000000000000..803df34452f3
>> --- /dev/null
>> +++ b/cxl/event_trace.c
>> @@ -0,0 +1,166 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2022, Intel Corp. All rights reserved.
>> +#include <stdio.h>
>> +#include <json-c/json.h>
>> +#include <util/json.h>
>> +#include <util/util.h>
>> +#include <util/parse-options.h>
>> +#include <util/parse-configs.h>
>> +#include <util/strbuf.h>
>> +#include <util/sysfs.h>
>> +#include <ccan/list/list.h>
>> +#include <ndctl/ndctl.h>
>> +#include <ndctl/libndctl.h>
>> +#include <sys/epoll.h>
>> +#include <sys/stat.h>
>> +#include <libcxl.h>
>> +#include <uuid/uuid.h>
>> +#include <traceevent/event-parse.h>
>> +#include "json.h"
>> +#include "event_trace.h"
>> +
>> +#define _GNU_SOURCE
>> +#include <string.h>
>> +
>> +static struct json_object *num_to_json(void *num, int size)
>> +{
>> +	if (size <= 4)
>> +		return json_object_new_int(*(int *)num);
>> +
>> +	return util_json_object_hex(*(unsigned long long *)num, 0);
>> +}
>> +
>> +static int cxl_event_to_json_callback(struct tep_event *event,
>> +		struct tep_record *record, struct list_head *jlist_head)
>> +{
>> +	struct tep_format_field **fields;
>> +	struct json_object *jevent, *jobj, *jarray;
>> +	struct jlist_node *jnode;
>> +	int i, j, rc = 0;
>> +
>> +	jnode = malloc(sizeof(*jnode));
>> +	if (!jnode)
>> +		return -ENOMEM;
>> +
>> +	jevent = json_object_new_object();
>> +	if (!jevent) {
>> +		rc = -ENOMEM;
>> +		goto err_jevent;
>> +	}
>> +	jnode->jobj = jevent;
>> +
>> +	fields = tep_event_fields(event);
>> +	if (!fields) {
>> +		rc = -ENOENT;
>> +		goto err;
>> +	}
>> +
>> +	jobj = json_object_new_string(event->system);
>> +	if (!jobj) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +	json_object_object_add(jevent, "system", jobj);
>> +
>> +	jobj = json_object_new_string(event->name);
>> +	if (!jobj) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +	json_object_object_add(jevent, "event", jobj);
>> +
>> +	jobj = json_object_new_uint64(record->ts);
>> +	if (!jobj) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +	json_object_object_add(jevent, "timestamp", jobj);
>> +
>> +	for (i = 0; fields[i]; i++) {
>> +		struct tep_format_field *f = fields[i];
>> +		int len;
>> +		char *tmp;
>> +
>> +		tmp = strcasestr(f->type, "char[]");
> 
> Instead of looking for strings, you could use the field flags.
> 
> 	f->flags & TEP_FIELD_IS_STRING

Thanks for the review Steve. This is good to know! I will update.

> 
>> +		if (tmp) { /* event field is a string */
>> +			char *str;
>> +
>> +			str = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
>> +			if (!str)
>> +				continue;
>> +
>> +			jobj = json_object_new_string(str);
>> +			if (!jobj) {
>> +				rc = -ENOMEM;
>> +				goto err;
>> +			}
>> +
>> +			json_object_object_add(jevent, f->name, jobj);
>> +		} else if (f->arraylen) { /* data array */
> 
> 		} else if (f->flags & TEP_FIELD_IS_ARRAY) {
> 
>   too.

Will update.

> 
>> +			unsigned char *data;
>> +			int chunks;
>> +
>> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
>> +			if (!data)
>> +				continue;
>> +
>> +			jarray = json_object_new_array();
>> +			if (!jarray) {
>> +				rc = -ENOMEM;
>> +				goto err;
>> +			}
>> +
>> +			chunks = f->size / f->elementsize;
>> +			for (j = 0; j < chunks; j++) {
>> +				jobj = num_to_json(data, f->elementsize);
>> +				if (!jobj) {
>> +					json_object_put(jarray);
>> +					return -ENOMEM;
>> +				}
>> +				json_object_array_add(jarray, jobj);
>> +				data += f->elementsize;
>> +			}
>> +
>> +			json_object_object_add(jevent, f->name, jarray);
>> +		} else { /* single number */
>> +			unsigned char *data;
>> +
>> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
>> +			if (!data)
>> +				continue;
>> +
>> +			/* check to see if we have a UUID */
>> +			tmp = strcasestr(f->type, "uuid_t");
> 
> I didn't even know event fields for uuid existed.

Ira figured out that you can you can use __field_struct() to accommodate 
uuid_t. Here's what he changed below:

diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
index 6777a1119e68..22fcd677b6d0 100644
--- a/include/trace/events/cxl.h
+++ b/include/trace/events/cxl.h
@@ -68,7 +68,7 @@ TRACE_EVENT(cxl_overflow,
#define CXL_EVT_TP_entry                                       \
         __string(dev_name, dev_name)                            \
         __field(int, log)                                       \
-       __array(u8, hdr_uuid, UUID_SIZE)                        \
+       __field_struct(uuid_t, hdr_uuid)                        \
         __field(u32, hdr_flags)                                 \
         __field(u16, hdr_handle)                                \
         __field(u16, hdr_related_handle)                        \
@@ -79,7 +79,7 @@ TRACE_EVENT(cxl_overflow,
#define CXL_EVT_TP_fast_assign(dname, l, hdr)                   \
         __assign_str(dev_name, (dname));                        \
         __entry->log = (l);                                     \
-       memcpy(__entry->hdr_uuid, &(hdr).id, UUID_SIZE);        \
+       memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));  \
         __entry->hdr_length = (hdr).length;                     \
         __entry->hdr_flags = get_unaligned_le24((hdr).flags);   \
         __entry->hdr_handle = le16_to_cpu((hdr).handle);        \
@@ -93,7 +93,7 @@ TRACE_EVENT(cxl_overflow,
                 "handle=%x related_handle=%x maint_op_class=%u" \
                 " : " fmt,                                      \
                __get_str(dev_name),cxl_event_log_type_str(__entry->log), \
-               __entry->hdr_timestamp, __entry->hdr_uuid, 
__entry->hdr_length, \
+               __entry->hdr_timestamp, &__entry->hdr_uuid, 
__entry->hdr_length,        \
                 show_hdr_flags(__entry->hdr_flags), 
__entry->hdr_handle,        \
                 __entry->hdr_related_handle, 
__entry->hdr_maint_op_class,       \
                 ##__VA_ARGS__)

> 
> -- Steve
> 
>> +			if (tmp) {
>> +				char uuid[SYSFS_ATTR_SIZE];
>> +
>> +				uuid_unparse(data, uuid);
>> +				jobj = json_object_new_string(uuid);
>> +				if (!jobj) {
>> +					rc = -ENOMEM;
>> +					goto err;
>> +				}
>> +
>> +				json_object_object_add(jevent, f->name, jobj);
>> +				continue;
>> +			}
>> +
>> +			jobj = num_to_json(data, f->elementsize);
>> +			if (!jobj) {
>> +				rc = -ENOMEM;
>> +				goto err;
>> +			}
>> +
>> +			json_object_object_add(jevent, f->name, jobj);
>> +		}
>> +	}
>> +
>> +	list_add_tail(jlist_head, &jnode->list);
>> +	return 0;
>> +
>> +err:
>> +	json_object_put(jevent);
>> +err_jevent:
>> +	free(jnode);
>> +	return rc;
>> +}
