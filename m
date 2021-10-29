Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E99C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5060F61040
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJ2WkX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:40:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:64979 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhJ2WkX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 29 Oct 2021 18:40:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="316962436"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="316962436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:37:54 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="637021519"
Received: from applebex-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 15:37:54 -0700
Date:   Fri, 29 Oct 2021 15:37:51 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 05/28] cxl/core: Convert decoder range to resource
Message-ID: <20211029223751.qb7heeezdfqfhnt2@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-6-ben.widawsky@intel.com>
 <CAPcyv4iiR_HT_9ExRvgLixWnQg8y-id1zpmRYurFSfw3OiVaYQ@mail.gmail.com>
 <20211029212654.cnge45a3tj3abj4s@intel.com>
 <CAPcyv4idbq0+VjHRLPVDjhDF6pH1GtqBJeNNTo-7USPLq+aUBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4idbq0+VjHRLPVDjhDF6pH1GtqBJeNNTo-7USPLq+aUBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 15:22:19, Dan Williams wrote:
> On Fri, Oct 29, 2021 at 2:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> [..]
> > > Note, this is just how I had it roughly mapped out in my head, I defer
> > > making it a hard recommendation until I get deeper into this set to
> > > see if we diverge.
> > >
> >
> > You're correct.
> >
> > I had changed this already for my v3. I ended up with this:
> > +       union {
> > +               struct resource cfmws_res;
> 
> "cfmws" is something that will only appear on ACPI based CXL systems,
> so if it needs a prefix it should be something that does not preclude
> CXL on other platform firmware architectures. So, "platform_" or
> "root_"?

Sure. Platform_ is better.

> 
> > +               struct resource *decoder_res;
> 
> So the region device is going to be doing the __request_region() from
> @cfmws_res, not decoders, so why is this a resource and not a range?

Well, sort of. Most of v3 was to ultimately go with the decoders doing the
__request_region, although thinking about this further that will not work since
multiple decoders might want the same ranges of the parent resource.

So I guess it has to be region. I can go back to renaming it res in that case.
You're correct that the region device should own doing the __request_region.
