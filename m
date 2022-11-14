Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C2FC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbiKNUo4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbiKNUoz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:44:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9A821A7
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668458694; x=1699994694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rin/EUiKkyOwiBimA95Idk6JWhrFehR80H4gkasUPNM=;
  b=iTAHHFGyBJd2YZIVSyDIjd+shb1spLHArujeZtXNSb4/fkWkKNrPFiWP
   KyM4pLhYNFAioXWT1MzjeeRd23zUMMfKtjv8RFwqF4tJAAIsnW3bOGw1f
   X01W8jEVvhKFsUelfWRUIKz64d5V1JORvpapWTKMW2T5jNww5GSVHOiF+
   zub/yXL6fEOOIvZKencaRbXs7x+aSl67MaXGNOaUsRZ2A1POuuG8szDJS
   IBzCKtzZdU5DSKx/+htQZJxqYIwP4nkZ+Ib3a7omnIAdpMWkdbInJMR6/
   jSg5KJtVd3uDZ6EPldd9Bm10lE1pOuUi9hIttx4c9P/G1kQjslyoXIVr1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292476807"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292476807"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:44:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="883686836"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="883686836"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.56.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:44:53 -0800
Date:   Mon, 14 Nov 2022 12:44:51 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 01/10] cxl: add helper function to parse trace event
 to json object
Message-ID: <Y3Kow67Pr1aVoIey@aschofie-mobl2>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
 <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
 <20221103014834.10d126bc@rorschach.local.home>
 <27786f64-b35a-ef82-0e93-55ee608f64ca@intel.com>
 <Y2Vgbl/5Gudpa4bP@iweiny-desk3>
 <20221114123238.3263ab61@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114123238.3263ab61@gandalf.local.home>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 14, 2022 at 12:32:38PM -0500, Steven Rostedt wrote:
> On Fri, 4 Nov 2022 11:56:46 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > > Ira figured out that you can you can use __field_struct() to accommodate
> > > uuid_t. Here's what he changed below:  
> > 
> > I guess this is a hack.  I looked into creating a new entry specifier and saw
> > that __field_struct did what I needed.
> > 
> > It all seems to work fine until Alison pointed out this morning that trace-cmd
> > can't seem to parse this.
> > 
> > :-/
> 
> If it works in a trace file, it should work in trace-cmd. If it does not,
> then trace-cmd needs to be fixed (unless it needs more information from the
> kernel, which it might).
> 
> > 
> > So now I'm not sure what is technically correct.  I've never used trace-cmd
> > before and this all works fine on the cmd line and with this monitor command.
> > 
> > Is this messing up trace-cmd?
> 
> If you see an issue, would you be able to send me a trace.dat file that
> includes the failed parsing?
> 
> That is:
> 
>  trace-cmd record -e <your-event>
> 
> Do something to trigger your event.
> 
> Then send me the produced trace.dat file that fails to parse from the
>  trace-cmd report.

Hi Steve,

I tried to use the uuid_t type in another TRACE event (cxl_poison), and
ran into the problem mentioned above.

It seems to be a problem in libtraceevent (or a user error ;))

When we have:
	TP_STRUCT__entry
		__field_struct(uuid_t, hdr_uuid)

	TP__fast_assign
		memcpy(&__entry->hdr.uuid, &(hdr).id, sizeof(uuid_t));

	TP_printk("uuid= %pU",  &__entry->hdr.uuid)

Libtraceevent fails to handle that "&" in "&__entry->hrd.uuid" when
creating the pretty print string. It fails in process_op() and then
later in pretty_print() prefaces the string w '[[FAILED TO PARSE]"
follwed by the raw values.

If I omit that '&', it works. But - I get unacceptable compiler
warnings from the kernel build - trying to assign to %p.

So, it's really not 'trace-cmd' per se that is failing, that is
just where the failure is visible.

The 'other' way that we view these CXL events are through monitor
and ndctl, where we pull the fields directly from the event, and
don't care about that TP_printk string. uuid_t works fine in that
case.

CXL events were not the first to use uuid_t. I see events/afs.h
using it also. I don't see a difference in their syntax, that would
makes it work there, while CXL fails. Maybe you do.

I don't have the environment up at the moment, so I'm just spewing
from notes and memory. If you need actual duplication, ask me again.

Thanks for helping w this Steve!

Alison

-- Steve



> 
> Thanks!
> 
> -- Steve
