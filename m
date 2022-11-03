Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9FEC433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 06:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKCGCk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 02:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKCGCj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 02:02:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED801902F
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 23:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F322B82623
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 06:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9903C433D6;
        Thu,  3 Nov 2022 06:02:35 +0000 (UTC)
Date:   Thu, 3 Nov 2022 02:02:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v3 04/10] cxl: add common function to disable event
 trace
Message-ID: <20221103020234.63fd7ab2@rorschach.local.home>
In-Reply-To: <166742402697.2654617.15955710715103932892.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
        <166742402697.2654617.15955710715103932892.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 02 Nov 2022 14:20:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a common function for cxl command that disables the event trace for the
> instance created.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/event_trace.c |    8 ++++++++
>  cxl/event_trace.h |    1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index d59e54c33df6..bcd4f8b2968e 100644
> --- a/cxl/event_trace.c
> +++ b/cxl/event_trace.c
> @@ -221,3 +221,11 @@ int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system)
>  	tracefs_trace_on(inst);
>  	return 0;
>  }
> +
> +int cxl_event_tracing_disable(struct tracefs_instance *inst)
> +{
> +	if (!tracefs_trace_is_on(inst))
> +		return 0;

Why bother checking if tracing is on or not. It's not any more
efficient. You're not eliminating a system call. You are actually
adding another one.

-- Steve


> +
> +	return tracefs_trace_off(inst);
> +}
> diff --git a/cxl/event_trace.h b/cxl/event_trace.h
> index 0258b8dc65a3..17d922f922c1 100644
> --- a/cxl/event_trace.h
> +++ b/cxl/event_trace.h
> @@ -21,5 +21,6 @@ struct event_ctx {
>  
>  int cxl_parse_events(struct tracefs_instance *inst, struct event_ctx *ectx);
>  int cxl_event_tracing_enable(struct tracefs_instance *inst, const char *system);
> +int cxl_event_tracing_disable(struct tracefs_instance *inst);
>  
>  #endif
> 

