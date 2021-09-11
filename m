Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84092C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 17:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E42E611F0
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 17:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhIKRcQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:32:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:22570 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233438AbhIKRcN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 11 Sep 2021 13:32:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="208431745"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="208431745"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 10:31:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="432710892"
Received: from vksouw-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 10:30:59 -0700
Date:   Sat, 11 Sep 2021 10:30:58 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 03/13] cxl/core: Ignore interleave when adding decoders
Message-ID: <20210911173058.suoj6sqhmjhd2oul@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-4-ben.widawsky@intel.com>
 <20210903152517.00005399@Huawei.com>
 <CAPcyv4ijcEMLEn4QDxDd=ML65PKG4YMnwrMBCUdSHGWKYfJhQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ijcEMLEn4QDxDd=ML65PKG4YMnwrMBCUdSHGWKYfJhQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-09-10 12:00:29, Dan Williams wrote:
> On Fri, Sep 3, 2021 at 7:25 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 2 Sep 2021 12:50:07 -0700
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > Decoders will be added to the bus either already active (committed in
> > > spec parlance), or inactive. From the driver perspective, the set of
> > > devices comprising the former are those which are brought up by system
> > > firmware; decoders that implement: volatile regions, persistent regions,
> > > or platform specific (ie. CFMWS) constraints. Such devices have a given
> > > interleave programming already in place. Inactive decoders on the other
> > > hand, do not have any interleave programming in place. The set of
> > > devices comprising that are hostbridges, switches, and endpoint devices.
> > >
> > > Allow adding inactive decoders by removing this check.
> 
> I thought I agreed with this initially, but the spec initializes the
> default value of IW to 0 (== x1 interleave). It is impossible for a
> decoder to ever have less than one interleave-way defined. Instead
> "Decoder Size == 0" is a disabled decoder.

Well I later add state as to whether or not the decoder is active too. I don't
disagree with your logic, though I find this more awkward than what my patch
does. For the sake of moving things forward smoothly, I will drop this patch and
simply set iw = 1 for new, inactive decoders being enumerated.
