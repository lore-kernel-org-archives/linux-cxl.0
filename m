Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B90ECAAD8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 21:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiIUVJH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIUVJH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 17:09:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7FA285E
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663794545; x=1695330545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2LiO0PZ26Kh+yNpDIoXkOxtWfl77zUEx/B3YMK9csr4=;
  b=n0OtWfbesiXaUi9I9H9dbitwk9LI8FN3gHZIsGQMIh3hw9VVOf5VYBmg
   zMJllurZ/avMMkvHQGO+FbFHf8afLqpxtNjPKH1jFYoLNauTXAEl/Js+W
   Df7H6kg3BGBmEqz1C37ao5VIBwsiUDn/vXjoorMU0sPcXx2o58jEgXPCO
   GGco+EUnLjSMg7GkipME587VNF2Edh8O62ze1IictxsRiCWBENRAoOLaB
   DweVWVy/IhgrJYeHywZpBqPH7qjmHmHzfKQsybDag8KJDHJ0fZhopC/io
   aUDjVIXceJlHgwfYwtGy+ciqMI/mvt0QSKtPjn9fLimzDx04q+MiYipfS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364103578"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="364103578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:09:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="619519971"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.138.80])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:09:04 -0700
Date:   Wed, 21 Sep 2022 14:09:03 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        nafonten@amd.com, nvdimm@lists.linux.dev
Subject: Re: [PATCH v2 2/9] cxl: add helper to parse through all current
 events
Message-ID: <Yyt9b99nWEaM5jEF@aschofie-mobl2>
References: <166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com>
 <166363120598.3861186.12071132915910252601.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166363120598.3861186.12071132915910252601.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On Mon, Sep 19, 2022 at 04:46:46PM -0700, Dave Jiang wrote:
> Add common function to iterate through and extract the events in the
> current trace buffer. The function uses tracefs_iterate_raw_events() from
> libtracefs to go through all the events loaded into a tep_handle. A
> callback is provided to the API call in order to parse the event. For cxl
> monitor, an array of interested "systems" is provided in order to filter
> for the interested events.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/event_trace.c |   33 +++++++++++++++++++++++++++++++++
>  cxl/event_trace.h |    7 +++++++
>  cxl/meson.build   |    1 +
>  meson.build       |    2 ++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index ffa2a9b9b036..430146ce66f5 100644
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
> @@ -164,3 +165,35 @@ err_jevent:
>  	free(jnode);
>  	return rc;
>  }
> +
> +static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
> +		int cpu, void *ctx)
> +{
> +	struct event_ctx *event_ctx = (struct event_ctx *)ctx;
> +	int rc;
> +
> +	/* Filter out all the events that the caller isn't interested in. */
> +	if (strcmp(event->system, event_ctx->system) != 0)
> +		return 0;
> +

While integrating w poison events, I find I'd like to filter on 
tep_event->name == "cxl_poison" here.

Something like this:

+	if (event_ctx->name) {
+		if (strcmp(event->name, event_ctx->name) != 0)
+			return 0;
+	}
 
along w this:

struct event_ctx {
 	const char *system;
+	const char *name;
 	struct list_head jlist_head;
 };

I guess an all|1 option won't suffice for users wanting a subset.
See how that fits it w your needs for monitor command. I can always
filter after the fact if this type of change is not generally useful.

Thanks,
Alison


> +	rc = cxl_event_to_json_callback(event, record, &event_ctx->jlist_head);
> +	if (rc < 0)
> +		return rc;
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
> index 00975a0b5680..2fbefa1586d9 100644
> --- a/cxl/event_trace.h
> +++ b/cxl/event_trace.h
> @@ -11,4 +11,11 @@ struct jlist_node {
>  	struct list_node list;
>  };
>  
> +struct event_ctx {
> +	const char *system;
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
