Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F447C43219
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 17:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiKNRcC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiKNRcB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 12:32:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EDE27DFB
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 09:32:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5896CE115E
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 17:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A503C433D7;
        Mon, 14 Nov 2022 17:31:56 +0000 (UTC)
Date:   Mon, 14 Nov 2022 12:32:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3 01/10] cxl: add helper function to parse trace event
 to json object
Message-ID: <20221114123238.3263ab61@gandalf.local.home>
In-Reply-To: <Y2Vgbl/5Gudpa4bP@iweiny-desk3>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
        <166742400990.2654617.4918438509154032997.stgit@djiang5-desk3.ch.intel.com>
        <20221103014834.10d126bc@rorschach.local.home>
        <27786f64-b35a-ef82-0e93-55ee608f64ca@intel.com>
        <Y2Vgbl/5Gudpa4bP@iweiny-desk3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 4 Nov 2022 11:56:46 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> > Ira figured out that you can you can use __field_struct() to accommodate
> > uuid_t. Here's what he changed below:  
> 
> I guess this is a hack.  I looked into creating a new entry specifier and saw
> that __field_struct did what I needed.
> 
> It all seems to work fine until Alison pointed out this morning that trace-cmd
> can't seem to parse this.
> 
> :-/

If it works in a trace file, it should work in trace-cmd. If it does not,
then trace-cmd needs to be fixed (unless it needs more information from the
kernel, which it might).

> 
> So now I'm not sure what is technically correct.  I've never used trace-cmd
> before and this all works fine on the cmd line and with this monitor command.
> 
> Is this messing up trace-cmd?

If you see an issue, would you be able to send me a trace.dat file that
includes the failed parsing?

That is:

 trace-cmd record -e <your-event>

Do something to trigger your event.

Then send me the produced trace.dat file that fails to parse from the
 trace-cmd report.

Thanks!

-- Steve
