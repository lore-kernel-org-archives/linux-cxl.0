Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD75C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 21:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFFD604AC
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhKBVtw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:49:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:12102 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhKBVtw (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 2 Nov 2021 17:49:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="218283631"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="218283631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 14:47:16 -0700
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="449820012"
Received: from jpsavari-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.136.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 14:47:16 -0700
Date:   Tue, 2 Nov 2021 14:47:15 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 09/28] cxl/acpi: Map single port host bridge
 component registers
Message-ID: <20211102214715.wtba7z6sk6ctsvhd@intel.com>
References: <20211101170750.sajcmjxdv5rajffe@intel.com>
 <CAPcyv4i-8oRjOPywtNwBef3irb8b44PzwBrEUdQ0Bxrzrju5+w@mail.gmail.com>
 <20211102163121.hyfj7yceainmppmk@intel.com>
 <CAPcyv4iQzHeF8cth4VGGMpAT-3d6T=6knCq5fnt+Yt1ucxbW8Q@mail.gmail.com>
 <20211102175737.k7l4yymx75kdvgwv@intel.com>
 <CAPcyv4iNaTmJJ-vgPRMtUO9_xbB0TTTVcrm4gm8m1wMzbfK4NQ@mail.gmail.com>
 <20211102182715.p5odqlr2z7z3n6go@intel.com>
 <CAPcyv4j0yi7utGR2UcG99_i0TH4j23QyryiYxOvZ6BosP=WEhQ@mail.gmail.com>
 <20211102211556.ingfag535md3z37y@intel.com>
 <CAPcyv4iTXJ=Ck2hR=KDBNwHtV+FF7RUFyq0YD+YuwtnhTF55yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iTXJ=Ck2hR=KDBNwHtV+FF7RUFyq0YD+YuwtnhTF55yQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-02 14:34:19, Dan Williams wrote:
> On Tue, Nov 2, 2021 at 2:16 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-11-02 11:49:14, Dan Williams wrote:
> > > On Tue, Nov 2, 2021 at 11:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > On 21-11-02 11:10:05, Dan Williams wrote:
> > > > > On Tue, Nov 2, 2021 at 10:57 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > >
> > > > > > On 21-11-02 10:46:41, Dan Williams wrote:
> > > > > > > On Tue, Nov 2, 2021 at 9:31 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > > > [..]
> > > > > > > > It seemed like a very simple thing to support given the port driver's existence
> > > > > > > > so it was added to remove a TODO. However, I will drop it as you request.
> > > > > > >
> > > > > > > I'm honestly asking the question why this is needed and more
> > > > > > > specifically why this is needed in this location?
> > > > > > >
> > > > > > > In other words, how is this case different than typical component
> > > > > > > register probing that is done in the port driver itself? I would
> > > > > > > expect the TODO just gets deleted by the port driver addition.
> > > > > >
> > > > > > Without this code, a decoder is added for the full address range regardless if
> > > > > > there is an existing programmed HDM decoder. With this code when the port driver
> > > > > > probes this host bridge HDM component registers, everything will be enumerated
> > > > > > by the normal flow.
> > > > > >
> > > > > > This seemed easier than trying to have the port driver determine what cxl_acpi
> > > > > > driver did and unwind that if there is a programmed decoder.
> > > > >
> > > > > I think this is more an argument to unify all decoder creation in the
> > > > > port driver. When the port driver sees a single dport with no HDM
> > > > > decoder registers it can create the passthrough decoder, if it sees
> > > > > single dport with HDM decoder registers then it can create a
> > > > > programmable decoder.
> > > >
> > > > That too, though I'm not sure how useful that will be for us.
> > >
> > > ?
> > >
> > > This is about the proper place to enumerate decoders. The proposal in
> > > this patch is to do some part of the enumeration in cxl_acpi and some
> > > part in cxl_port, I'm saying push it all to cxl_port. I.e. it was a
> > > layering violation in retrospect to create a default passthrough
> > > decoder from cxl_acpi.
> >
> > I think it makes sense to have cxl_decoder_add() not called from anything but
> > the port driver. So long as there's a way to determine it's a CXL 2.0 Root Port,
> > which, it seems we'll have, it should be straight forward.
> 
> Does it need to be root port aware? I expect any single ported switch
> is treated the same, not that I expect single-ported switches to be a
> real thing, but I don't expect our port driver would care.

You're correct... I thought switch ports required HDM decoder registers even if
single port, but I just checked and they are the same as the host bridge. So
indeed the enumeration should only be special cased for the endpoint.
