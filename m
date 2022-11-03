Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE5C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 16:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKCQjT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiKCQiq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 12:38:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B01EAE7
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667493336; x=1699029336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7ypOHg2W8WKULeeQZJjPFXRblkRnjn8ZAfEpMbFb/E=;
  b=G9u94GGEEd56HADXJkNbu2fp/Yg0mamGzzHg3WDqv2BbtIEbejsq62UW
   /5B2KHaFL/kcj9uJrrzEs1qTzCvbpaD1AIivmU0Lhit4U19z8e4vQaWrp
   GqQcrHqAwqPblWIFy9vCZl03TQLd1mc9FIP+GmWdkzJpcicBy3F1aZUlh
   9B7j/lQtMaxDfQKyvYeefyhmKLxGR0Wc58TB99kUHHfhlX6AaPAM9OTh/
   Z4dCpF8SXCOJUmrSE9QmSzREV4ifl1qx8sEPrB2VBlByI5x30MnEfxBde
   dEXv9nKXV08VT0ZrWNQlPxtUkpDl4176+WD6L1PXIEolOcGnSG2kdSZLd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336431915"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="336431915"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:34:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="760003818"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="760003818"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.56.14]) ([10.212.56.14])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 09:34:56 -0700
Message-ID: <0e5ea705-e109-313f-8c76-fcbd21fe519f@intel.com>
Date:   Thu, 3 Nov 2022 09:34:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 05/10] cxl: add monitor function for event trace events
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
 <166742403256.2654617.15551316837123337120.stgit@djiang5-desk3.ch.intel.com>
 <20221103020643.6ac71b93@rorschach.local.home>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221103020643.6ac71b93@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/2/2022 11:06 PM, Steven Rostedt wrote:
> On Wed, 02 Nov 2022 14:20:32 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>> ---
>>   cxl/meson.build |    1
>>   cxl/monitor.c   |  140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 141 insertions(+)
>>   create mode 100644 cxl/monitor.c
>>
>> diff --git a/cxl/meson.build b/cxl/meson.build
>> index c59876262e76..eb8b2b1070ed 100644
>> --- a/cxl/meson.build
>> +++ b/cxl/meson.build
>> @@ -8,6 +8,7 @@ cxl_src = [
>>     'json.c',
>>     'filter.c',
>>     'event_trace.c',
>> +  'monitor.c',
>>   ]
>>   
>>   cxl_tool = executable('cxl',
>> diff --git a/cxl/monitor.c b/cxl/monitor.c
>> new file mode 100644
>> index 000000000000..85559d9a4b94
>> --- /dev/null
>> +++ b/cxl/monitor.c
>> @@ -0,0 +1,140 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2022, Intel Corp. All rights reserved.
>> +/* Some bits copied from ndctl monitor code */
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <json-c/json.h>
>> +#include <libgen.h>
>> +#include <time.h>
>> +#include <dirent.h>
>> +#include <ccan/list/list.h>
>> +#include <util/json.h>
>> +#include <util/util.h>
>> +#include <util/parse-options.h>
>> +#include <util/parse-configs.h>
>> +#include <util/strbuf.h>
>> +#include <sys/epoll.h>
>> +#include <sys/stat.h>
>> +#include <traceevent/event-parse.h>
>> +#include <tracefs/tracefs.h>
>> +#include <cxl/libcxl.h>
>> +
>> +/* reuse the core log helpers for the monitor logger */
>> +#ifndef ENABLE_LOGGING
>> +#define ENABLE_LOGGING
>> +#endif
>> +#ifndef ENABLE_DEBUG
>> +#define ENABLE_DEBUG
>> +#endif
>> +#include <util/log.h>
>> +
>> +#include "event_trace.h"
>> +
>> +static const char *cxl_system = "cxl";
>> +
>> +static struct monitor {
>> +	struct log_ctx ctx;
>> +	FILE *log_file;
>> +	bool human;
>> +} monitor;
>> +
>> +static int monitor_event(struct cxl_ctx *ctx)
>> +{
>> +	int fd, epollfd, rc = 0, timeout = -1;
>> +	struct epoll_event ev, *events;
>> +	struct tracefs_instance *inst;
>> +	struct event_ctx ectx;
>> +	int jflag;
>> +
>> +	events = calloc(1, sizeof(struct epoll_event));
>> +	if (!events) {
>> +		err(&monitor, "alloc for events error\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	epollfd = epoll_create1(0);
>> +	if (epollfd == -1) {
>> +		rc = -errno;
>> +		err(&monitor, "epoll_create1() error: %d\n", rc);
>> +		goto epoll_err;
>> +	}
>> +
>> +	inst = tracefs_instance_create("cxl_monitor");
>> +	if (!inst) {
>> +		rc = -errno;
>> +		err(&monitor, "tracefs_instance_crate( failed: %d\n", rc);
> 
>   "crate"? Been coding a bit too much Rust lately?

Ooops. Will fix.

> 
>> +		goto inst_err;
>> +	}
>> +
>> +	fd = tracefs_instance_file_open(inst, "trace_pipe", -1);
> 
> I'm curious to why you are opening trace_pipe?
> 
>> +	if (fd < 0) {
>> +		rc = fd;
>> +		err(&monitor, "tracefs_instance_file_open() err: %d\n", rc);
>> +		goto inst_file_err;
>> +	}
>> +
>> +	memset(&ev, 0, sizeof(ev));
>> +	ev.events = EPOLLIN;
>> +	ev.data.fd = fd;
> 
> Is it a way to know if there's something to read?

Yes. Since trace_pipe() is the read once data stream, seems like the 
right place to put the epoll on. Is that the wrong way to do this?

> 
> -- Steve
> 
>> +
>> +	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) != 0) {
>> +		rc = -errno;
>> +		err(&monitor, "epoll_ctl() error: %d\n", rc);
>> +		goto epoll_ctl_err;
>> +	}
>> +
>> +	rc = cxl_event_tracing_enable(inst, cxl_system);
>> +	if (rc < 0) {
>> +		err(&monitor, "cxl_trace_event_enable() failed: %d\n", rc);
>> +		goto event_en_err;
>> +	}
>> +
>> +	memset(&ectx, 0, sizeof(ectx));
>> +	ectx.system = cxl_system;
>> +	if (monitor.human)
>> +		jflag = JSON_C_TO_STRING_PRETTY;
>> +	else
>> +		jflag = JSON_C_TO_STRING_PLAIN;
>> +
>> +	while (1) {
>> +		struct jlist_node *jnode, *next;
>> +
>> +		rc = epoll_wait(epollfd, events, 1, timeout);
>> +		if (rc < 0) {
>> +			rc = -errno;
>> +			if (errno != EINTR)
>> +				err(&monitor, "epoll_wait error: %d\n", -errno);
>> +			break;
>> +		}
>> +
>> +		list_head_init(&ectx.jlist_head);
>> +		rc = cxl_parse_events(inst, &ectx);
>> +		if (rc < 0)
>> +			goto parse_err;
>> +
>> +		if (list_empty(&ectx.jlist_head))
>> +			continue;
>> +
>> +		list_for_each_safe(&ectx.jlist_head, jnode, next, list) {
>> +			notice(&monitor, "%s\n",
>> +				json_object_to_json_string_ext(jnode->jobj, jflag));
>> +			list_del(&jnode->list);
>> +			json_object_put(jnode->jobj);
>> +			free(jnode);
>> +		}
>> +	}
>> +
>> +parse_err:
>> +	rc = cxl_event_tracing_disable(inst);
>> +event_en_err:
>> +epoll_ctl_err:
>> +	close(fd);
>> +inst_file_err:
>> +	tracefs_instance_free(inst);
>> +inst_err:
>> +	close(epollfd);
>> +epoll_err:
>> +	free(events);
>> +	return rc;
>> +}
>>
> 
