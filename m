Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4895C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 15:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346355AbiELPua (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345425AbiELPu3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 11:50:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3566F68BC
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652370628; x=1683906628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LtzNjIgaLmlN01m0X99eoeCvuTc9SqpMdkrdBj/FxSM=;
  b=AGfP7L2UM67FyZKXASZGGkGVhr/VgCLR4dMY5QfcPdIj/9/zru+2gw09
   QegJyb3hpsBpatJdoMtXpSMff28I4sfTYwYnwZVm4fweHuV87DBd+6y9j
   repy4zsTs4qdpvPbxDQjKiX/THDIq/rZs8ycBm+IHOYtNleTn6loFQj1L
   6QYpSl+yVNOxZketfZs4wK790jh3Fjh6W+RCzbxXQeQgBPVZseh1U1SIF
   5sAQht+mU0v087Hh4OjWyVCqrIvbyXYMjnNJjGRdmkJ5Do5y1J+FZ16/K
   NU07wHS6VWxmBq2fGprQDn/HeE2qGHGQGILIi6Rdig5JGYhPt7PXc4AjA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250561963"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="250561963"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:50:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="636891796"
Received: from wcogara-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.107])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:50:20 -0700
Date:   Thu, 12 May 2022 08:50:14 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [RFC PATCH 02/15] cxl/core/hdm: Bail on endpoint init fail
Message-ID: <20220512155014.bbyqvxqbqnm3pk2p@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
 <20220413183720.2444089-3-ben.widawsky@intel.com>
 <CAPcyv4hKGEy_0dMQWfJAVVsGu364NjfNeup7URb7ORUYLSZncw@mail.gmail.com>
 <CGME20220418163713uscas1p17b3b1b45c7d27e54e3ecb62eb8af2469@uscas1p1.samsung.com>
 <20220418163702.GA85141@bgt-140510-bm01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418163702.GA85141@bgt-140510-bm01>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-04-18 16:37:12, Adam Manzanares wrote:
> On Wed, Apr 13, 2022 at 02:31:42PM -0700, Dan Williams wrote:
> > On Wed, Apr 13, 2022 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Endpoint decoder enumeration is the only way in which we can determine
> > > Device Physical Address (DPA) -> Host Physical Address (HPA) mappings.
> > > Information is obtained only when the register state can be read
> > > sequentially. If when enumerating the decoders a failure occurs, all
> > > other decoders must also fail since the decoders can no longer be
> > > accurately managed (unless it's the last decoder in which case it can
> > > still work).
> > 
> > I think this should be expanded to fail if any decoder fails to
> > allocate anywhere in the topology otherwise it leaves a mess for
> > future address translation code to work through cases where decoder
> > information is missing.
> > 
> > The current approach is based around the current expectation that
> > nothing is enumerating pre-existing regions, and nothing is performing
> > address translation.
> 
> Does the qemu support currently allow testing of this patch? If so, it would 
> be good to reference qemu configurations. Any other alternatives would be 
> welcome as well. 
> 
> +Luis on cc.
> 

No. This type of error injection would be cool to have, but I'm not sure of a
good way to support that in a scalable way. Maybe Jonathan has some ideas?

> > 
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/core/hdm.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index bfc8ee876278..c3c021b54079 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -255,6 +255,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
> > >                                       cxlhdm->regs.hdm_decoder, i);
> > >                 if (rc) {
> > >                         put_device(&cxld->dev);
> > > +                       if (is_endpoint_decoder(&cxld->dev))
> > > +                               return rc;
> > >                         failed++;
> > >                         continue;
> > >                 }
> > > --
> > > 2.35.1
> > >
> > 
