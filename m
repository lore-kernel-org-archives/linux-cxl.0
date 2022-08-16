Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170BFC25B0E
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 16:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiHPQlY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiHPQlX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 12:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4EF80B51;
        Tue, 16 Aug 2022 09:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 077646123A;
        Tue, 16 Aug 2022 16:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A08EC433D6;
        Tue, 16 Aug 2022 16:41:21 +0000 (UTC)
Date:   Tue, 16 Aug 2022 12:41:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <20220816124128.618948e9@gandalf.local.home>
In-Reply-To: <20220816123958.2b49674a@gandalf.local.home>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-2-ira.weiny@intel.com>
        <20220816123958.2b49674a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 16 Aug 2022 12:39:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +		record_count = le16_to_cpu(payload.record_count);
> > +		if (record_count > 0)
> > +			trace_cxl_event(dev_name(cxlds->dev), type,
> > +					&payload.record);
> > +
> > +		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > +			trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> > +						 &payload);  
> 
> If you want to avoid the compare operations when the tracepoints are not
> enabled, you can add:
> 
> 		if (trace_cxl_event_enabled()) {
> 			if (record_count > 0)
> 				trace_cxl_event(dev_name(cxlds->dev), type,
> 						&payload.record);
> 		}
> 
> 		if (trace_cxl_event_overflow_enabled()) {
> 			if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> 				trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> 							 &payload);
> 		}
> 
> Those "<tracepoint>_enabled()" functions are static branches. Which means
> when not enabled it's a nop that skips this code, and when either is
> enabled, it turns into a jump to the contents of the if block.

Ignore this suggestion. I see in the second patch you add more logic to the
if condition. Only use this suggestion if the logic is only for when the
tracepoint is enabled.

-- Steve
