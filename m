Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B0C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 06:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKCGI1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 02:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCGI0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 02:08:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4675F45
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 23:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96BBEB82623
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 06:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF90C433C1;
        Thu,  3 Nov 2022 06:08:21 +0000 (UTC)
Date:   Thu, 3 Nov 2022 02:08:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 08/10] cxl: add an optional pid check to event
 parsing
Message-ID: <20221103020819.6e9ec973@rorschach.local.home>
In-Reply-To: <166742404957.2654617.13465219167688999810.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
        <166742404957.2654617.13465219167688999810.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 02 Nov 2022 14:20:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When parsing CXL events, callers may only be interested in events
> that originate from the current process. Introduce an optional
> argument to the event trace context: event_pid. When event_pid is
> present, only include events with a matching pid in the returned
> JSON list. It is not a failure to see other, non matching results.
> Simply skip those.
> 
> The initial use case for this is the listing of media errors,
> where only the media-errors requested by this process are wanted.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/event_trace.c |   18 ++++++++++++++++++
>  cxl/event_trace.h |    1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index bcd4f8b2968e..0be6317e6ada 100644
> --- a/cxl/event_trace.c
> +++ b/cxl/event_trace.c
> @@ -166,6 +166,19 @@ err_jevent:
>  	return rc;
>  }
>  
> +static bool cxl_match_pid(struct tep_event *event, struct tep_record *record,
> +			  int pid)
> +{
> +	unsigned long long val;
> +
> +	if (tep_get_common_field_val(NULL, event, "common_pid", record, &val, 0))

There's also a way to get the pid directly:

   pid = tep_data_pid(tep, record);

-- Steve

> +		return false;
> +	if (pid != (int)val)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
>  		int cpu, void *ctx)
>  {
> @@ -180,6 +193,11 @@ static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record
>  			return 0;
>  	}
>  
> +	if (event_ctx->event_pid) {
> +		if (!cxl_match_pid(event, record, event_ctx->event_pid))
> +			return 0;
> +	}
> +
>  	if (event_ctx->parse_event)
>  		return event_ctx->parse_event(event, record, &event_ctx->jlist_head);
>  
> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
> index 17d922f922c1..64f07854b91b 100644
> --- a/cxl/event_trace.h
> +++ b/cxl/event_trace.h
> @@ -15,6 +15,7 @@ struct event_ctx {
>  	const char *system;
>  	struct list_head jlist_head;
>  	const char *event_name;					/* optional */
> +	int event_pid;						/* optional */
>  	int (*parse_event)(struct tep_event *event, struct tep_record *record,
>  			   struct list_head *jlist_head);	/* optional */
>  };
> 

