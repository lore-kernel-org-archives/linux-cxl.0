Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704F5C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 14:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A2860EE9
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 14:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKAOfq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:35:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:10741 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232197AbhKAOfn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 10:35:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="230979324"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="230979324"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 07:33:09 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="448970193"
Received: from ahedgesx-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.133.93])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 07:33:09 -0700
Date:   Mon, 1 Nov 2021 07:33:07 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 05/28] cxl/core: Convert decoder range to resource
Message-ID: <20211101143307.iqe4gle7gbs3vwcv@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-6-ben.widawsky@intel.com>
 <CAPcyv4iiR_HT_9ExRvgLixWnQg8y-id1zpmRYurFSfw3OiVaYQ@mail.gmail.com>
 <20211029212654.cnge45a3tj3abj4s@intel.com>
 <CAPcyv4idbq0+VjHRLPVDjhDF6pH1GtqBJeNNTo-7USPLq+aUBw@mail.gmail.com>
 <20211029223751.qb7heeezdfqfhnt2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029223751.qb7heeezdfqfhnt2@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 15:37:51, Ben Widawsky wrote:
> On 21-10-29 15:22:19, Dan Williams wrote:
> > On Fri, Oct 29, 2021 at 2:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > [..]
> > > > Note, this is just how I had it roughly mapped out in my head, I defer
> > > > making it a hard recommendation until I get deeper into this set to
> > > > see if we diverge.
> > > >
> > >
> > > You're correct.
> > >
> > > I had changed this already for my v3. I ended up with this:
> > > +       union {
> > > +               struct resource cfmws_res;
> > 
> > "cfmws" is something that will only appear on ACPI based CXL systems,
> > so if it needs a prefix it should be something that does not preclude
> > CXL on other platform firmware architectures. So, "platform_" or
> > "root_"?
> 
> Sure. Platform_ is better.
> 

Coming back to this. While "CFMWS" is indeed defined as part of ACPI, I do think
it could also be a generic name for what it represents. In other words, I don't
see any issue with using CFMWS, but, I'll start using "platform" since it seems
it's your preference (and I prefer that to "root").

> > 
> > > +               struct resource *decoder_res;
> > 
> > So the region device is going to be doing the __request_region() from
> > @cfmws_res, not decoders, so why is this a resource and not a range?
> 
> Well, sort of. Most of v3 was to ultimately go with the decoders doing the
> __request_region, although thinking about this further that will not work since
> multiple decoders might want the same ranges of the parent resource.
> 
> So I guess it has to be region. I can go back to renaming it res in that case.
> You're correct that the region device should own doing the __request_region.
