Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2725C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 06:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiKCGBH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 02:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKCGAy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 02:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C241A38D
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 23:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E65461D4B
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 06:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF5C433C1;
        Thu,  3 Nov 2022 06:00:34 +0000 (UTC)
Date:   Thu, 3 Nov 2022 02:00:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 03/10] cxl: add common function to enable event trace
Message-ID: <20221103020032.47cb3da7@rorschach.local.home>
In-Reply-To: <166742402130.2654617.9308255604215496136.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
        <166742402130.2654617.9308255604215496136.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 02 Nov 2022 14:20:21 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a common function for cxl command to enable event tracing for the
> instance created. The interested "systems" will be enabled for tracing
> as well.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/event_trace.c |   21 +++++++++++++++++++++
>  cxl/event_trace.h |    1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index cf63d2346f6e..d59e54c33df6 100644
> --- a/cxl/event_trace.c
> +++ b/cxl/event_trace.c
> @@ -200,3 +200,24 @@ int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx)
>  	tep_free(tep);
>  	return rc;
>  }
> +
> +int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system)
> +{
> +	int rc;
> +	char *path;
> +
> +	rc = asprintf(&path, "events/%s/enable", system);
> +	if (rc == -1)
> +		return -errno;
> +
> +	rc = tracefs_instance_file_write(inst, path, "1");
> +	free(path);
> +	if (rc == -1)
> +		return -errno;

Latest libtracefs has:

	tracefs_event_enable(inst, system, NULL);

That enables all events for a system in the instance "inst".

-- Steve


> +
> +	if (tracefs_trace_is_on(inst))
> +		return 0;
> +
> +	tracefs_trace_on(inst);
> +	return 0;
> +}
> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
> index 582882c1eb35..0258b8dc65a3 100644
> --- a/cxl/event_trace.h
> +++ b/cxl/event_trace.h
> @@ -20,5 +20,6 @@ struct event_ctx {
>  };
>  
>  int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
> +int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
>  
>  #endif
> 

