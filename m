Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA6C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Jan 2022 16:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbiAFQ6S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Jan 2022 11:58:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:48309 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241426AbiAFQ6S (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 6 Jan 2022 11:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641488297; x=1673024297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bV+BRFbOeVG6rTQhpdczYqvbL/4I6EfhedlgG6scK/k=;
  b=nwc5u5ozGeQIfFGfDIYSJyANWvzoaU7aUn9u+x32S0IQMX2xUjCa+XXc
   7OS1KAMPojRK3liU2os3t9pteJCFo3jIWACWy7/yGmZUEMZyky19yiDvu
   7e5X68y0RQdjdPpFHK3uTMyBc8wV6kVPDsLVzmNUH9mVJ4FliMJLKB9Gk
   cA1v3YFarhPMvWvm2vXAEPkAggJWRR2IaUsS6K+8CJsmS3PjgrbHjEfrz
   Yqr/jpcAXzBRUWOuMD67IkON+Oue2f+4mA0eEm88Fv7TP92bUk0cR5YPd
   HlgKPQX3jEldMhwV0vuNK4N1kZIizcJukB92EjOtgFZedc+bUHycpARIG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222684702"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="222684702"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 08:58:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="689466993"
Received: from ftaylor1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.137.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 08:58:16 -0800
Date:   Thu, 6 Jan 2022 08:58:15 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 23/28] cxl/region: Implement XHB verification
Message-ID: <20220106165815.w22abd3f2ianrvco@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-24-ben.widawsky@intel.com>
 <20220106165547.000016bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106165547.000016bd@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-01-06 16:55:47, Jonathan Cameron wrote:
> On Fri, 22 Oct 2021 11:37:04 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Cross host bridge verification primarily determines if the requested
> > interleave ordering can be achieved by the root decoder, which isn't as
> > programmable as other decoders.
> > 
> > The algorithm implemented here is based on the CXL Type 3 Memory Device
> > Software Guide, chapter 2.13.14
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  .clang-format        |  1 +
> >  drivers/cxl/region.c | 81 +++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/trace.h  |  3 ++
> >  3 files changed, 84 insertions(+), 1 deletion(-)
> > 
> > diff --git a/.clang-format b/.clang-format
> > index cb7c46371465..55f628f21722 100644
> > --- a/.clang-format
> > +++ b/.clang-format
> > @@ -169,6 +169,7 @@ ForEachMacros:
> >    - 'for_each_cpu_and'
> >    - 'for_each_cpu_not'
> >    - 'for_each_cpu_wrap'
> > +  - 'for_each_cxl_decoder_target'
> >    - 'for_each_cxl_endpoint'
> >    - 'for_each_dapm_widgets'
> >    - 'for_each_dev_addr'
> > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > index d127c9c69eef..53442de33d11 100644
> > --- a/drivers/cxl/region.c
> > +++ b/drivers/cxl/region.c
> > @@ -30,6 +30,11 @@
> >  	for (idx = 0, ep = (region)->targets[idx]; idx < region_ways(region);  \
> >  	     idx++, ep = (region)->targets[idx])
> >  
> > +#define for_each_cxl_decoder_target(target, decoder, idx)                      \
> > +	for (idx = 0, target = (decoder)->target[idx];                         \
> > +	     idx < (decoder)->nr_targets;                                      \
> > +	     idx++, target = (decoder)->target[idx])
> > +
> target used for too many things in this macro.
> 
> I'm messing around with this to poke some of the Qemu stuff and noticed
> this in passing...
> 
> Jonathan

Thanks.

BTW, I have some rather large changes in flight. Might be good to check this
branch (I'm in force push mode):
https://gitlab.com/bwidawsk/linux/-/commits/cxl_region

Also, I have a minor QEMU change (HACK) to support multiple root ports.
https://gitlab.com/bwidawsk/qemu/-/commit/7c76849f9a4d2bc5fc9c355ed06ea926fc7ab494
