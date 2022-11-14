Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE4BC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiKNUw1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiKNUw0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:52:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0400917436
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA31DB812AC
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 20:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0209C433D6;
        Mon, 14 Nov 2022 20:52:19 +0000 (UTC)
Date:   Mon, 14 Nov 2022 15:53:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 01/10] cxl: add helper function to parse trace event
 to json object
Message-ID: <20221114155301.78b1729b@gandalf.local.home>
In-Reply-To: <Y3Kow67Pr1aVoIey@aschofie-mobl2>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
        <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
        <20221103014834.10d126bc@rorschach.local.home>
        <27786f64-b35a-ef82-0e93-55ee608f64ca@intel.com>
        <Y2Vgbl/5Gudpa4bP@iweiny-desk3>
        <20221114123238.3263ab61@gandalf.local.home>
        <Y3Kow67Pr1aVoIey@aschofie-mobl2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Nov 2022 12:44:51 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> Hi Steve,
> 
> I tried to use the uuid_t type in another TRACE event (cxl_poison), and
> ran into the problem mentioned above.
> 
> It seems to be a problem in libtraceevent (or a user error ;))

Correct. When I said trace-cmd, I really meant libtraceevent, but I tend to
blur the two as libtracevenet was born out of trace-cmd.

> 
> When we have:
> 	TP_STRUCT__entry
> 		__field_struct(uuid_t, hdr_uuid)
> 
> 	TP__fast_assign
> 		memcpy(&__entry->hdr.uuid, &(hdr).id, sizeof(uuid_t));
> 
> 	TP_printk("uuid= %pU",  &__entry->hdr.uuid)
> 
> Libtraceevent fails to handle that "&" in "&__entry->hrd.uuid" when
> creating the pretty print string. It fails in process_op() and then
> later in pretty_print() prefaces the string w '[[FAILED TO PARSE]"
> follwed by the raw values.
> 
> If I omit that '&', it works. But - I get unacceptable compiler
> warnings from the kernel build - trying to assign to %p.
> 
> So, it's really not 'trace-cmd' per se that is failing, that is
> just where the failure is visible.

Right.

> 
> The 'other' way that we view these CXL events are through monitor
> and ndctl, where we pull the fields directly from the event, and
> don't care about that TP_printk string. uuid_t works fine in that
> case.
> 
> CXL events were not the first to use uuid_t. I see events/afs.h
> using it also. I don't see a difference in their syntax, that would
> makes it work there, while CXL fails. Maybe you do.

I'm guessing they don't work ;-)

> 
> I don't have the environment up at the moment, so I'm just spewing
> from notes and memory. If you need actual duplication, ask me again.
> 
> Thanks for helping w this Steve!
> 

No problem.

I'll can add this to a test event and then update libtraceevent to handle
it. I'm currently working on a new release of the libraries anyway.

-- Steve
