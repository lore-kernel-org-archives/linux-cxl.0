Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46566ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Sep 2022 18:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiISS0r (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiISS0q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Sep 2022 14:26:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE28DEAA
        for <linux-cxl@vger.kernel.org>; Mon, 19 Sep 2022 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663612004; x=1695148004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p/UZnG5CIUWn2T5JgCP2KgDO1SMu46nDha85ch7yM1U=;
  b=SHXi8CqGw0fRfeKOydzGAOak5bJH0aK7y319S9mu5bYZnU1VVRIhtRL2
   k1K81ajC7mFFmpVhWg1tmcIvMHSL+my6pav/dh60zJ5U6VVk6pYmD/2Li
   m1iMps5g0jcGR9pjvnz23ZXmtlnDmVbuSKa6s3JLKKpiduBJRlQKKuHfv
   YgX5+XUXQ/pDqLjATOYpraoKjRJ3rRlmwghbxQRXfjkme9QMbuzMpAyWS
   YWF1ZjtVrfKe1WlkNIz7b7vZGlKLfYLzyYxSpqEGWUzNqLhA6icRmzv2t
   Ikl8t/FJqzSVVDgUhE7n141b/yfNYWpgSkyt2t3WHnlkTIRkWt9oquc6Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299473909"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="299473909"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 11:26:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="569756514"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.167.58])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 11:26:43 -0700
Date:   Mon, 19 Sep 2022 11:26:42 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 5/7] ndctl: cxl: add monitor function for event trace
 events
Message-ID: <Yyi0YrojneNScwsK@aschofie-mobl2>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <166318849861.3087953.11165630490819410564.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166318849861.3087953.11165630490819410564.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Sep 14, 2022 at 01:48:18PM -0700, Dave Jiang wrote:
> Add function that creates an event trace instance and utilize the cxl event
> trace common functions to extract interested events from the trace buffer.
> The monitoring function will pend on an epoll fd and wait for new events
> to appear in the trace buffer.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/meson.build |    1 
>  cxl/monitor.c   |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 cxl/monitor.c
> 
> diff --git a/cxl/meson.build b/cxl/meson.build
> index c59876262e76..eb8b2b1070ed 100644
> --- a/cxl/meson.build
> +++ b/cxl/meson.build
> @@ -8,6 +8,7 @@ cxl_src = [
>    'json.c',
>    'filter.c',
>    'event_trace.c',
> +  'monitor.c',
>  ]
>  
>  cxl_tool = executable('cxl',
> diff --git a/cxl/monitor.c b/cxl/monitor.c
> new file mode 100644
> index 000000000000..2ab2e249f575
> --- /dev/null
> +++ b/cxl/monitor.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2022, Intel Corp. All rights reserved.
> +/* Some bits copied from ndctl monitor code */
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <json-c/json.h>
> +#include <libgen.h>
> +#include <time.h>
> +#include <dirent.h>
> +#include <ccan/list/list.h>
> +#include <util/json.h>
> +#include <util/util.h>
> +#include <util/parse-options.h>
> +#include <util/parse-configs.h>
> +#include <util/strbuf.h>
> +#include <sys/epoll.h>
> +#include <sys/stat.h>
> +#include <traceevent/event-parse.h>
> +#include <tracefs/tracefs.h>
> +#include <cxl/libcxl.h>
> +
> +/* reuse the core log helpers for the monitor logger */
> +#ifndef ENABLE_LOGGING
> +#define ENABLE_LOGGING
> +#endif
> +#ifndef ENABLE_DEBUG
> +#define ENABLE_DEBUG
> +#endif
> +#include <util/log.h>
> +
> +#include "event_trace.h"
> +
> +const char *systems[] = { "cxl_events", "cxl_aer", NULL };
> +

Hi Dave,

So - I'm co-mingling feedback to this patch, with Ira's events patch,
and the poison patches I have in progress. We're all in flight, and
this seems like a good sync point.

I expected all CXL trace events will be defined in one header file:
include/trace/event/cxl.h

The enabling would spring, per event type, from there - so, to
enable 'cxl_aer' 

echo 1 > /sys/kernel/debug/tracing/events/cxl/cxl_aer/enable

I think your definition of *systems[] probably stands, but needs to
be prefixed with 'cxl/' and then filtered same.

Alison

> +static struct monitor {
> +	struct log_ctx ctx;
> +	FILE *log_file;
> +	bool human;
> +} monitor;
> +
> +static int monitor_event(struct cxl_ctx *ctx)
> +{
> +	int fd, epollfd, rc = 0, timeout = -1;
> +	struct epoll_event ev, *events;
> +	struct tracefs_instance *inst;
> +	struct event_ctx ectx;
> +	int jflag;
> +
> +	events = calloc(1, sizeof(struct epoll_event));
> +	if (!events) {
> +		err(&monitor, "alloc for events error\n");
> +		return -ENOMEM;
> +	}
> +
> +	epollfd = epoll_create1(0);
> +	if (epollfd == -1) {
> +		rc = -errno;
> +		err(&monitor, "epoll_create1() error: %d\n", rc);
> +		goto epoll_err;
> +	}
> +
> +	inst = tracefs_instance_create("cxl_monitor");
> +	if (!inst) {
> +		rc = -errno;
> +		err(&monitor, "tracefs_instance_crate( failed: %d\n", rc);
> +		goto inst_err;
> +	}
> +
> +	fd = tracefs_instance_file_open(inst, "trace_pipe", -1);
> +	if (fd < 0) {
> +		rc = fd;
> +		err(&monitor, "tracefs_instance_file_open() err: %d\n", rc);
> +		goto inst_file_err;
> +	}
> +
> +	memset(&ev, 0, sizeof(ev));
> +	ev.events = EPOLLIN;
> +	ev.data.fd = fd;
> +
> +	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) != 0) {
> +		rc = -errno;
> +		err(&monitor, "epoll_ctl() error: %d\n", rc);
> +		goto epoll_ctl_err;
> +	}
> +
> +	rc = cxl_event_tracing_enable(inst, systems);
> +	if (rc < 0) {
> +		err(&monitor, "cxl_trace_event_enable() failed: %d\n", rc);
> +		goto event_en_err;
> +	}
> +
> +	ectx.systems = systems;
> +	if (monitor.human)
> +		jflag = JSON_C_TO_STRING_PRETTY;
> +	else
> +		jflag = JSON_C_TO_STRING_PLAIN;
> +
> +	while (1) {
> +		struct jlist_node *jnode, *next;
> +
> +		rc = epoll_wait(epollfd, events, 1, timeout);
> +		if (rc < 0) {
> +			rc = -errno;
> +			if (errno != EINTR)
> +				err(&monitor, "epoll_wait error: %d\n", -errno);
> +			break;
> +		}
> +
> +		list_head_init(&ectx.jlist_head);
> +		rc = cxl_parse_events(inst, &ectx);
> +		if (rc < 0)
> +			goto parse_err;
> +
> +		if (list_empty(&ectx.jlist_head))
> +			continue;
> +
> +		list_for_each_safe(&ectx.jlist_head, jnode, next, list) {
> +			notice(&monitor, "%s\n",
> +				json_object_to_json_string_ext(jnode->jobj, jflag));
> +			list_del(&jnode->list);
> +			json_object_put(jnode->jobj);
> +			free(jnode);
> +		}
> +	}
> +
> +parse_err:
> +	rc = cxl_event_tracing_disable(inst);
> +event_en_err:
> +epoll_ctl_err:
> +	close(fd);
> +inst_file_err:
> +	tracefs_instance_free(inst);
> +inst_err:
> +	close(epollfd);
> +epoll_err:
> +	free(events);
> +	return rc;
> +}
> 
> 
