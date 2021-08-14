Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C8C4338F
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9F06103A
	for <linux-cxl@archiver.kernel.org>; Sat, 14 Aug 2021 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbhHNHfl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:35:41 -0400
Received: from verein.lst.de ([213.95.11.211]:49482 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNHfg (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 14 Aug 2021 03:35:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 645AA67373; Sat, 14 Aug 2021 09:35:06 +0200 (CEST)
Date:   Sat, 14 Aug 2021 09:35:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-cxl@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 10/23] libnvdimm/labels: Add uuid helpers
Message-ID: <20210814073506.GA21463@lst.de>
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com> <162854812073.1980150.8157116233571368158.stgit@dwillia2-desk3.amr.corp.intel.com> <YROE48iCZNFaDcSo@smile.fi.intel.com> <YRQB9Yvh3tmT9An4@smile.fi.intel.com> <CAPcyv4jOEfi=RJTeOFTbvkBB+Khfzi5QirrhPxeM4J2bQXRYiQ@mail.gmail.com> <YRQik5OnRyYQAm4o@smile.fi.intel.com> <CAPcyv4hY9YL7MhkeSu4GYBNo6hbeMRgqnKf8YuLuQ3khSbhn9A@mail.gmail.com> <YRZGInO3vguWR4IA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRZGInO3vguWR4IA@smile.fi.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 13, 2021 at 01:14:58PM +0300, Andy Shevchenko wrote:
> > Andy, does this incremental diff restore your reviewed-by? The awkward
> > piece of this for me is that it introduces a handful of unnecessary
> > memory copies. See some of the new nsl_get_uuid() additions and the
> > extra copy in nsl_uuid_equal()
> 
> It does, thanks! As for the deeper discussion I think you need to talk to
> Christoph. It was his idea to move uuid_t from UAPI to internal kernel type.
> And I think it made and still makes sense to be that way.
> 
> But if we have already users of uuid_t like you are doing here (without this
> patch) then it will be fine I guess. Not my area to advise or decide.

I'm missing a lot of context here.  But that whole uuid/guid thing is
a little complex:

 - for userspace APIs and on-disk formats a uuid is nothing but a blob
 - userspace historically has its own library to deal with this (libuuid),
   which defines a uuid_t itself.

So instead of trying to build abstractions that somehow word in diferent
software ecosystems I think just treating it as the blob that it is for
exchange makes life easіer for everyone.  It also really makes definitions
of on-disk structures more clear when using the raw bytes instead of a
semi-opaque typedef.
