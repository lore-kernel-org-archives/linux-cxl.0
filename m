Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96962C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 15:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKCP5t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKCP5t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 11:57:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B113E29
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667491068; x=1699027068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GS4G1jbbd415QdWw6dech2UmciYc6IfzJdXIYA+O6Rc=;
  b=eFYOm/XcDQDGK2sRrk+gpVAQBoltRwiccAcLAUWbLKgR0HHUS7MePEQU
   4kGamstfaBpzx4x0jPDqr5VSzefIIqlcqNXjkblGvwj7o9dhQcvYxKb6R
   P1N5ItcszhwIhRE09UeOzU92+J9d8gO9NG9zri1VM8qZUIAc2DOhPl7d5
   oS6bXepLoRq7W/K1RZwFnMJimoGyNlre79nxiHh7td4EEWeGJFtOfokzB
   lbBk6SbphuJLMSFQxJfiEw71jkbF2vtBj1tNcK2JU/EnEK730C+Y9JPOt
   qaqsDmcG/6pROUwZESNEsO0ArR8Kjy20T6GkvTJe4F9k1wFZ2IAQ4Ev72
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396028323"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="396028323"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:57:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="666020008"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="666020008"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.164.233])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:57:47 -0700
Date:   Thu, 3 Nov 2022 08:57:45 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 08/10] cxl: add an optional pid check to event parsing
Message-ID: <Y2Pk+XUhaPLA6cDZ@aschofie-mobl2>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
 <166742404957.2654617.13465219167688999810.stgit@djiang5-desk3.ch.intel.com>
 <20221103020819.6e9ec973@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103020819.6e9ec973@rorschach.local.home>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Nov 03, 2022 at 02:08:19AM -0400, Steven Rostedt wrote:
> On Wed, 02 Nov 2022 14:20:49 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When parsing CXL events, callers may only be interested in events
> > that originate from the current process. Introduce an optional
> > argument to the event trace context: event_pid. When event_pid is
> > present, only include events with a matching pid in the returned
> > JSON list. It is not a failure to see other, non matching results.
> > Simply skip those.
> > 
> > The initial use case for this is the listing of media errors,
> > where only the media-errors requested by this process are wanted.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  cxl/event_trace.c |   18 ++++++++++++++++++
> >  cxl/event_trace.h |    1 +
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> > index bcd4f8b2968e..0be6317e6ada 100644
> > --- a/cxl/event_trace.c
> > +++ b/cxl/event_trace.c
> > @@ -166,6 +166,19 @@ err_jevent:
> >  	return rc;
> >  }
> >  
> > +static bool cxl_match_pid(struct tep_event *event, struct tep_record *record,
> > +			  int pid)
> > +{
> > +	unsigned long long val;
> > +
> > +	if (tep_get_common_field_val(NULL, event, "common_pid", record, &val, 0))
> 
> There's also a way to get the pid directly:
> 
>    pid = tep_data_pid(tep, record);

I saw that and thought I'd lost the required tep_handle a couple of
layers back. Of course, it's in the tep_event too!
Will do, Thanks!

> 
> -- Steve
> 
> > +		return false;
> > +	if (pid != (int)val)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record,
> >  		int cpu, void *ctx)
> >  {
> > @@ -180,6 +193,11 @@ static int cxl_event_parse_cb(struct tep_event *event, struct tep_record *record
> >  			return 0;
> >  	}
> >  
> > +	if (event_ctx->event_pid) {
> > +		if (!cxl_match_pid(event, record, event_ctx->event_pid))
> > +			return 0;
> > +	}
> > +
> >  	if (event_ctx->parse_event)
> >  		return event_ctx->parse_event(event, record, &event_ctx->jlist_head);
> >  
> > diff --git a/cxl/event_trace.h b/cxl/event_trace.h
> > index 17d922f922c1..64f07854b91b 100644
> > --- a/cxl/event_trace.h
> > +++ b/cxl/event_trace.h
> > @@ -15,6 +15,7 @@ struct event_ctx {
> >  	const char *system;
> >  	struct list_head jlist_head;
> >  	const char *event_name;					/* optional */
> > +	int event_pid;						/* optional */
> >  	int (*parse_event)(struct tep_event *event, struct tep_record *record,
> >  			   struct list_head *jlist_head);	/* optional */
> >  };
> > 
> 
