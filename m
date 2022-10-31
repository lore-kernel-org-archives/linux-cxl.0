Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13287ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJaUFz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJaUFz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 16:05:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4413E33
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667246753; x=1698782753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oh4MtSI5JjzPlT7Z5kLZUfjdDafkwj6DM2D0qPO9tJc=;
  b=DPO75N/G9GNlByPN7SH5ptZRjD0K+0AyHDdtf8kmFOBBrFCU9kcLO5Qv
   HFUtpXYs/eFGaNtV5Zp7OKNTqNbcR4eJvYbbMWyDJyI5qPht3GyV92KXD
   qEfK2U7mxGCUyeBsshQgYZAxc3DMb60rsYBWxLYgvGrrUEpJzekJpeBnP
   zhg0b23tHQT5yin7Gq5hAM7DoDfNhO+eYSmNgEGM4YoZ1X/+ToaNBEC/t
   0OTI7QLjMpR4NJVCQSumw/03+T3odeCjjMGQq5urPHfe/9VLLjbVL5gP6
   Nx6PuIb/WlCbEUYlFe4d60rTddT59rsjLS50+qkyNddlpGyEF78Bqo4UU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310078413"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="310078413"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:05:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="584775112"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="584775112"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.58.216])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:05:35 -0700
Date:   Mon, 31 Oct 2022 13:05:34 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 2/7] ndctl: cxl: add helper to parse through all current
 events
Message-ID: <Y2Aqjiw3t3lpeJdo@aschofie-mobl2>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <166318848131.3087953.17609964424559300800.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166318848131.3087953.17609964424559300800.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Sep 14, 2022 at 01:48:01PM -0700, Dave Jiang wrote:
> Add common function to iterate through and extract the events in the
> current trace buffer. The function uses tracefs_iterate_raw_events() from
> libtracefs to go through all the events loaded into a tep_handle. A
> callback is provided to the API call in order to parse the event. For cxl
> monitor, an array of interested "systems" is provided in order to filter
> for the interested events.

Also been testing this one, and WFM. I'll look for the addition of the
caller defined parsing callback in the next rev.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/event_trace.c |   35 +++++++++++++++++++++++++++++++++++
>  cxl/event_trace.h |    7 +++++++
>  cxl/meson.build   |    1 +
>  meson.build       |    2 ++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index ffa2a9b9b036..d5e67b55a4d8 100644
> --- a/cxl/event_trace.c
> +++ b/cxl/event_trace.c
> @@ -16,6 +16,7 @@
>  #include <libcxl.h>
>  #include <uuid/uuid.h>
>  #include <traceevent/event-parse.h>
> +#include <tracefs/tracefs.h>
>  #include "json.h"
>  #include "event_trace.h"
>  
> @@ -164,3 +165,37 @@ err_jevent:
>  	free(jnode);
>  	return rc;
>  }
> +
> +static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
> +		int cpu, void *ctx)
> +{
> +	struct event_ctx *event_ctx = (struct event_ctx *)ctx;
> +	int rc, i;
> +
> +	/* Filter out all the events that the caller isn't interested in. */
> +	for (i = 0; event_ctx->systems[i]; i++) {
> +		if (strcmp(event->system, event_ctx->systems[i]) != 0)
> +			continue;
> +
> +		rc = cxl_event_to_json_callback(event, record, &event_ctx->jlist_head);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
> +{
> +	struct tep_handle *tep;
> +	int rc;
> +
> +	tep = tracefs_local_events(NULL);
> +	if (!tep)
> +		return -ENOMEM;
> +
> +	rc = tracefs_iterate_raw_events(tep, inst, NULL, 0,
> +			cxl_event_parse_cb, ectx);
> +	tep_free(tep);
> +	return rc;
> +}
> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
> index 00975a0b5680..98cfbb4602e1 100644
> --- a/cxl/event_trace.h
> +++ b/cxl/event_trace.h
> @@ -11,4 +11,11 @@ struct jlist_node {
>  	struct list_node list;
>  };
>  
> +struct event_ctx {
> +	const char **systems;
> +	struct list_head jlist_head;
> +};
> +
> +int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
> +
>  #endif
> diff --git a/cxl/meson.build b/cxl/meson.build
> index 8c7733431613..c59876262e76 100644
> --- a/cxl/meson.build
> +++ b/cxl/meson.build
> @@ -21,6 +21,7 @@ cxl_tool = executable('cxl',
>      json,
>      versiondep,
>      traceevent,
> +    tracefs,
>    ],
>    install : true,
>    install_dir : rootbindir,
> diff --git a/meson.build b/meson.build
> index f611e0bdd7f3..c204c8ac52de 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -143,6 +143,8 @@ libudev = dependency('libudev')
>  uuid = dependency('uuid')
>  json = dependency('json-c')
>  traceevent = dependency('libtraceevent')
> +tracefs = dependency('libtracefs')
> +
>  if get_option('docs').enabled()
>    if get_option('asciidoctor').enabled()
>      asciidoc = find_program('asciidoctor', required : true)
> 
> 
