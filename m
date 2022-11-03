Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E53C433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 06:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKCGGu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 02:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiKCGGs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 02:06:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A419C23
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 23:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678CC61D43
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 06:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C28C433C1;
        Thu,  3 Nov 2022 06:06:45 +0000 (UTC)
Date:   Thu, 3 Nov 2022 02:06:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 05/10] cxl: add monitor function for event trace
 events
Message-ID: <20221103020643.6ac71b93@rorschach.local.home>
In-Reply-To: <166742403256.2654617.15551316837123337120.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
        <166742403256.2654617.15551316837123337120.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 02 Nov 2022 14:20:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:
> ---
>  cxl/meson.build |    1 
>  cxl/monitor.c   |  140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 141 insertions(+)
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
> index 000000000000..85559d9a4b94
> --- /dev/null
> +++ b/cxl/monitor.c
> @@ -0,0 +1,140 @@
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
> +static const char *cxl_system = "cxl";
> +
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

 "crate"? Been coding a bit too much Rust lately?

> +		goto inst_err;
> +	}
> +
> +	fd = tracefs_instance_file_open(inst, "trace_pipe", -1);

I'm curious to why you are opening trace_pipe?

> +	if (fd < 0) {
> +		rc = fd;
> +		err(&monitor, "tracefs_instance_file_open() err: %d\n", rc);
> +		goto inst_file_err;
> +	}
> +
> +	memset(&ev, 0, sizeof(ev));
> +	ev.events = EPOLLIN;
> +	ev.data.fd = fd;

Is it a way to know if there's something to read?

-- Steve

> +
> +	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) != 0) {
> +		rc = -errno;
> +		err(&monitor, "epoll_ctl() error: %d\n", rc);
> +		goto epoll_ctl_err;
> +	}
> +
> +	rc = cxl_event_tracing_enable(inst, cxl_system);
> +	if (rc < 0) {
> +		err(&monitor, "cxl_trace_event_enable() failed: %d\n", rc);
> +		goto event_en_err;
> +	}
> +
> +	memset(&ectx, 0, sizeof(ectx));
> +	ectx.system = cxl_system;
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

