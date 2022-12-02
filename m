Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05D1C4321E
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Dec 2022 13:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiLBNfC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Dec 2022 08:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiLBNe4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Dec 2022 08:34:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDDEC3598;
        Fri,  2 Dec 2022 05:34:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C4E6B82158;
        Fri,  2 Dec 2022 13:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85AAC433C1;
        Fri,  2 Dec 2022 13:34:49 +0000 (UTC)
Date:   Fri, 2 Dec 2022 08:34:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <20221202083448.4b3b3254@gandalf.local.home>
In-Reply-To: <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-4-ira.weiny@intel.com>
        <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 1 Dec 2022 18:29:20 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> >  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> >  				    enum cxl_event_log_type type)
> >  {
> > @@ -732,13 +769,22 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> >  		}
> >  
> >  		nr_rec = le16_to_cpu(payload->record_count);
> > -		if (trace_cxl_generic_event_enabled()) {
> > +		if (nr_rec > 0) {
> >  			int i;
> >  
> > -			for (i = 0; i < nr_rec; i++)
> > -				trace_cxl_generic_event(dev_name(cxlds->dev),
> > -							type,
> > -							&payload->records[i]);
> > +			if (trace_cxl_generic_event_enabled()) {  
> 
> Again, trace_cxl_generic_event_enabled() injects some awkward
> formatting here to micro-optimize looping. Any performance benefit this
> code might offer is likely offset by the extra human effort to read it.

This is commonly used throughout the kernel, and highly suggested for use to
encapsulate any work being done only for tracing, when tracing is disabled.
It uses static_braches/jump_labels which makes the loop into a 'nop' when
tracing is off. That is, there is zero overhead for the for loop below (and
there's not even a branch to skip it!)

But sure, if you really don't care as it's not a fast path, then keep it
out. I like people to keep the habit of doing this, because otherwise it
tends to creep into the fast paths.

-- Steve

> 
> > +				for (i = 0; i < nr_rec; i++)
> > +					trace_cxl_generic_event(dev_name(cxlds->dev),
> > +								type,
> > +								&payload->records[i]);
> > +			}
> > +
> > +			rc = cxl_clear_event_record(cxlds, type, payload, nr_rec);
> > +			if (rc) {
> > +				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
> > +					cxl_event_log_type_str(type), rc);
> > +				return;
> > +			}
> >  		}
> >  
