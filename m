Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BC6C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 05:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKCFsl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 01:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCFsk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 01:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9D1929F
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 22:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D04A61D4A
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 05:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EDAC433C1;
        Thu,  3 Nov 2022 05:48:36 +0000 (UTC)
Date:   Thu, 3 Nov 2022 01:48:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 01/10] cxl: add helper function to parse trace event
 to json object
Message-ID: <20221103014834.10d126bc@rorschach.local.home>
In-Reply-To: <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
        <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 02 Nov 2022 14:20:09 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the helper function that parses a trace event captured by
> libtraceevent in a tep handle. All the parsed fields are added to a json
> object. The json object is added to the provided list in the input parameter.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/event_trace.c |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/event_trace.h |   14 ++++
>  cxl/meson.build   |    2 +
>  meson.build       |    1 
>  4 files changed, 183 insertions(+)
>  create mode 100644 cxl/event_trace.c
>  create mode 100644 cxl/event_trace.h
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> new file mode 100644
> index 000000000000..803df34452f3
> --- /dev/null
> +++ b/cxl/event_trace.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2022, Intel Corp. All rights reserved.
> +#include <stdio.h>
> +#include <json-c/json.h>
> +#include <util/json.h>
> +#include <util/util.h>
> +#include <util/parse-options.h>
> +#include <util/parse-configs.h>
> +#include <util/strbuf.h>
> +#include <util/sysfs.h>
> +#include <ccan/list/list.h>
> +#include <ndctl/ndctl.h>
> +#include <ndctl/libndctl.h>
> +#include <sys/epoll.h>
> +#include <sys/stat.h>
> +#include <libcxl.h>
> +#include <uuid/uuid.h>
> +#include <traceevent/event-parse.h>
> +#include "json.h"
> +#include "event_trace.h"
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +
> +static struct json_object *num_to_json(void *num, int size)
> +{
> +	if (size <= 4)
> +		return json_object_new_int(*(int *)num);
> +
> +	return util_json_object_hex(*(unsigned long long *)num, 0);
> +}
> +
> +static int cxl_event_to_json_callback(struct tep_event *event,
> +		struct tep_record *record, struct list_head *jlist_head)
> +{
> +	struct tep_format_field **fields;
> +	struct json_object *jevent, *jobj, *jarray;
> +	struct jlist_node *jnode;
> +	int i, j, rc = 0;
> +
> +	jnode = malloc(sizeof(*jnode));
> +	if (!jnode)
> +		return -ENOMEM;
> +
> +	jevent = json_object_new_object();
> +	if (!jevent) {
> +		rc = -ENOMEM;
> +		goto err_jevent;
> +	}
> +	jnode->jobj = jevent;
> +
> +	fields = tep_event_fields(event);
> +	if (!fields) {
> +		rc = -ENOENT;
> +		goto err;
> +	}
> +
> +	jobj = json_object_new_string(event->system);
> +	if (!jobj) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +	json_object_object_add(jevent, "system", jobj);
> +
> +	jobj = json_object_new_string(event->name);
> +	if (!jobj) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +	json_object_object_add(jevent, "event", jobj);
> +
> +	jobj = json_object_new_uint64(record->ts);
> +	if (!jobj) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +	json_object_object_add(jevent, "timestamp", jobj);
> +
> +	for (i = 0; fields[i]; i++) {
> +		struct tep_format_field *f = fields[i];
> +		int len;
> +		char *tmp;
> +
> +		tmp = strcasestr(f->type, "char[]");

Instead of looking for strings, you could use the field flags.

	f->flags & TEP_FIELD_IS_STRING

> +		if (tmp) { /* event field is a string */
> +			char *str;
> +
> +			str = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
> +			if (!str)
> +				continue;
> +
> +			jobj = json_object_new_string(str);
> +			if (!jobj) {
> +				rc = -ENOMEM;
> +				goto err;
> +			}
> +
> +			json_object_object_add(jevent, f->name, jobj);
> +		} else if (f->arraylen) { /* data array */

		} else if (f->flags & TEP_FIELD_IS_ARRAY) {

 too.

> +			unsigned char *data;
> +			int chunks;
> +
> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
> +			if (!data)
> +				continue;
> +
> +			jarray = json_object_new_array();
> +			if (!jarray) {
> +				rc = -ENOMEM;
> +				goto err;
> +			}
> +
> +			chunks = f->size / f->elementsize;
> +			for (j = 0; j < chunks; j++) {
> +				jobj = num_to_json(data, f->elementsize);
> +				if (!jobj) {
> +					json_object_put(jarray);
> +					return -ENOMEM;
> +				}
> +				json_object_array_add(jarray, jobj);
> +				data += f->elementsize;
> +			}
> +
> +			json_object_object_add(jevent, f->name, jarray);
> +		} else { /* single number */
> +			unsigned char *data;
> +
> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
> +			if (!data)
> +				continue;
> +
> +			/* check to see if we have a UUID */
> +			tmp = strcasestr(f->type, "uuid_t");

I didn't even know event fields for uuid existed.

-- Steve

> +			if (tmp) {
> +				char uuid[SYSFS_ATTR_SIZE];
> +
> +				uuid_unparse(data, uuid);
> +				jobj = json_object_new_string(uuid);
> +				if (!jobj) {
> +					rc = -ENOMEM;
> +					goto err;
> +				}
> +
> +				json_object_object_add(jevent, f->name, jobj);
> +				continue;
> +			}
> +
> +			jobj = num_to_json(data, f->elementsize);
> +			if (!jobj) {
> +				rc = -ENOMEM;
> +				goto err;
> +			}
> +
> +			json_object_object_add(jevent, f->name, jobj);
> +		}
> +	}
> +
> +	list_add_tail(jlist_head, &jnode->list);
> +	return 0;
> +
> +err:
> +	json_object_put(jevent);
> +err_jevent:
> +	free(jnode);
> +	return rc;
> +}
