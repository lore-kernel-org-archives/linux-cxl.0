Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4548C7EE23
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 16:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjELQpa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbjELQpa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 12:45:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC74C1F
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 09:45:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHvkC6YXRz67cDZ;
        Sat, 13 May 2023 00:44:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 17:45:24 +0100
Date:   Fri, 12 May 2023 17:45:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC 3/3] ACPI: NUMA: Apply SRAT proximity domain to entire
 CFMWS window
Message-ID: <20230512174523.00001cf1@Huawei.com>
In-Reply-To: <645d85d378a85_2ec5d294d2@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1683742429.git.alison.schofield@intel.com>
        <79a10b7101a8fab56f9ff3f9a4de73bee3156b40.1683742429.git.alison.schofield@intel.com>
        <645d7765a218a_1e6f2944c@dwillia2-xfh.jf.intel.com.notmuch>
        <ZF2Bz9Kw9rNOyOdZ@aschofie-mobl2>
        <645d85d378a85_2ec5d294d2@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023 17:18:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Alison Schofield wrote:
> > On Thu, May 11, 2023 at 04:16:53PM -0700, Dan Williams wrote:  
> > > alison.schofield@ wrote:  
> > 
> > snip...
> >   
> > > > +	/*
> > > > +	 * The SRAT may have already described the NUMA details for
> > > > +	 * this CFMWS HPA range, yet it may not have created memblks
> > > > +	 * for the entire range. Look for a node with a memblk covering
> > > > +	 * any part of the HPA range. Don't bother figuring out if it
> > > > +	 * is partially or wholly described. Replace any memblks in the
> > > > +	 * range with one single memblk that covers the entire range.
> > > > +	 *
> > > > +	 * This preserves the SRAT defined node and Proximity Domain.
> > > > +	 */
> > > > +
> > > > +	found_node = numa_find_node(start, end);
> > > > +	if (found_node != NUMA_NO_NODE) {
> > > > +		numa_remove_memblks(found_node, start, end);
> > > > +		if (numa_add_memblk(found_node, start, end) < 0) {  
> > > 
> > > I worry that this blows away information in the case where the BIOS for
> > > some reason decides to describe multiple proximity domains per CXL
> > > window.
> > > 
> > > I think this wants to be an algorithm like
> > > 
> > > numa_fill_memblks(start, end)
> > > 
> > > ...where that walks the range and for any gaps in that range extend the
> > > last memblk to the end of the gap.
> > > 
> > > For example if the CFWMS to SRAT mapping is this:
> > > 
> > >  ┌──────────────────────────────────────────────────┐
> > >  │                  WINDOW0                         │
> > >  ├──────────┬────────────┬────────────┬─────────────┤
> > >  │PXM0      │ GAP        │ PXM1       │ GAP         │
> > >  └──────────┴────────────┴────────────┴─────────────┘
> > > 
> > > 
> > >  ┌──────────────────────────────────────────────────┐
> > >  │                  WINDOW0                         │
> > >  ├───────────────────────┬──────────────────────────┤
> > >  │PXM0                   │ PXM1                     │
> > >  └───────────────────────┴──────────────────────────┘
> > > 
> > > ...and if that finds nothing to fill, *then* create the next proximity
> > > domain for the window.  
> > 
> > Thanks for the feedback Dan.
> > 
> > Is there any guarantee that the first PXM begins at cfmws.start?
> > ie...that gaps always 'follow'
> > 
> > This one's easy:	gap-pxm0 	becomes all pxm0
> > This one's easy too:	gap-pxm0-gap 	becomes all pxm0
> > 
> > This one's not so obvious: gap-pxm0-gap-pxm1   
> 
> Good point.
> 
> I would say that pxm0 consuming both gaps is ok. pxm1 grabbing the
> second gap is also ok, whatever makes the code simpler.

Agreed - it's best effort on a heuristic.  My guess is we'll end up
revisiting this when hotplug means we see similar patterns to those
that led a bios to do the above, but this is fine for now.

> 
> > Imagine those are quarters. Is the end result 50/50 or 75/25?  
> 
> The window is all one QoS class anyway as far as CXL is concerned. So
> the end distribution is not much of a concern. I.e. I would not worry if
> you end up with 75/25 even if 50/50 was possible.

I don't like tying QoS class to a narrow range of access characteristics
but that's a problem for another day.

> 
> > I'm wondering if there is any policy in existence or this is new,
> > and we are setting the policy now?  
> 
> We are trailblazing on our own. The reason why I think we have the
> freedom to make an arbitrary decision here is that it is unlikely that the
> BIOS describes multiple proximity domains per window, but on the off
> chance they do lets not throw away information.

Agree with not throwing it away, fairly sure you'll see this :)
If nothing else it's handy for a system that doesn't do interleaving
across devices for some reason where the OS is then going to use NUMA Interleave.

So it can be useful to have multiple proximity domains even for identical
memory if the access paths are different.

Ha! I see an excuse to reuse old work:
https://github.com/hisilicon/acpi-numa-whitepaper/releases/tag/v0.93
See 5.1

I should bring that back one day when things are quieter (so likely never).
Was targeted as an ACPI WP and out for review when something happened (check
the date and who I work for if curious ;)

Jonathan





