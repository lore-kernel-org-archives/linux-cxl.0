Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD9C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Jan 2022 18:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiAFSeE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Jan 2022 13:34:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:59995 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242731AbiAFSeD (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 6 Jan 2022 13:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641494043; x=1673030043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptELDCxRGxUmx9EWhhgEzlpunp1OLnmBivGUVWooKJg=;
  b=Sh/OOSMbtC3THaq9SNz+pwOhZtRIKaKPb4ZriDlJu5Z7RReFEgCV31q1
   lC8Xfg1g/WegI3GNU4j4slpjeIBWgSbBatA/y6ij+nobopul31cRm/y+b
   yzqE4BIyQ73uzpBEIN7lkqNIA9+79/HfVFvm3wZITdkFZtiD7E/dHT4hp
   H/afiJ2KmgsIK8uozfl0U3Xgbjrj0WA7KFGQvwfqE0gCXM1ZV6K0o4dKD
   byYvpuyY5bUQm0y41XPffRw/UTxaLbTBFm2me5WlF+bV+5ciWGPmyiSB+
   2CcouA0xJ3zvV+15OvI6hQYviyOPgrm4s8Wevy595YECwL4auqSwOU13V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="306063178"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="306063178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 10:34:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="527073703"
Received: from ftaylor1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.137.52])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 10:34:03 -0800
Date:   Thu, 6 Jan 2022 10:34:02 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 23/28] cxl/region: Implement XHB verification
Message-ID: <20220106183402.i76juwkmahzenj6n@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-24-ben.widawsky@intel.com>
 <20220106165547.000016bd@huawei.com>
 <20220106165815.w22abd3f2ianrvco@intel.com>
 <20220106173346.00002171@huawei.com>
 <20220106181033.00000f4c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106181033.00000f4c@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-01-06 18:10:33, Jonathan Cameron wrote:
> On Thu, 6 Jan 2022 17:33:46 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Thu, 6 Jan 2022 08:58:15 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > 
> > > On 22-01-06 16:55:47, Jonathan Cameron wrote:  
> > > > On Fri, 22 Oct 2021 11:37:04 -0700
> > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >     
> > > > > Cross host bridge verification primarily determines if the requested
> > > > > interleave ordering can be achieved by the root decoder, which isn't as
> > > > > programmable as other decoders.
> > > > > 
> > > > > The algorithm implemented here is based on the CXL Type 3 Memory Device
> > > > > Software Guide, chapter 2.13.14
> > > > > 
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > ---
> > > > >  .clang-format        |  1 +
> > > > >  drivers/cxl/region.c | 81 +++++++++++++++++++++++++++++++++++++++++++-
> > > > >  drivers/cxl/trace.h  |  3 ++
> > > > >  3 files changed, 84 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/.clang-format b/.clang-format
> > > > > index cb7c46371465..55f628f21722 100644
> > > > > --- a/.clang-format
> > > > > +++ b/.clang-format
> > > > > @@ -169,6 +169,7 @@ ForEachMacros:
> > > > >    - 'for_each_cpu_and'
> > > > >    - 'for_each_cpu_not'
> > > > >    - 'for_each_cpu_wrap'
> > > > > +  - 'for_each_cxl_decoder_target'
> > > > >    - 'for_each_cxl_endpoint'
> > > > >    - 'for_each_dapm_widgets'
> > > > >    - 'for_each_dev_addr'
> > > > > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > > > > index d127c9c69eef..53442de33d11 100644
> > > > > --- a/drivers/cxl/region.c
> > > > > +++ b/drivers/cxl/region.c
> > > > > @@ -30,6 +30,11 @@
> > > > >  	for (idx = 0, ep = (region)->targets[idx]; idx < region_ways(region);  \
> > > > >  	     idx++, ep = (region)->targets[idx])
> > > > >  
> > > > > +#define for_each_cxl_decoder_target(target, decoder, idx)                      \
> > > > > +	for (idx = 0, target = (decoder)->target[idx];                         \
> > > > > +	     idx < (decoder)->nr_targets;                                      \
> > > > > +	     idx++, target = (decoder)->target[idx])
> > > > > +    
> > > > target used for too many things in this macro.
> > > > 
> > > > I'm messing around with this to poke some of the Qemu stuff and noticed
> > > > this in passing...
> > > > 
> > > > Jonathan    
> > > 
> > > Thanks.
> > > 
> > > BTW, I have some rather large changes in flight. Might be good to check this
> > > branch (I'm in force push mode):
> > > https://gitlab.com/bwidawsk/linux/-/commits/cxl_region
> > > 
> > > Also, I have a minor QEMU change (HACK) to support multiple root ports.
> > > https://gitlab.com/bwidawsk/qemu/-/commit/7c76849f9a4d2bc5fc9c355ed06ea926fc7ab494  
> 
> If we were feeling lazy that could (I think) just be set to the maximum allowed and
> be 'correct' in all cases.
> 

Yeah. For validation standpoint, having it be a prop is nice, but I think
default as max rather than 1 is smart.

> > Thanks. Will take a look at both.
> > 
> > Mostly I'm interested in the QEMU side of things and trying to get a cleaner
> > command line working but good to have a way to poke it an check the
> > CFMWS is correct etc.
> 
> FYI. I'll leave feedback for where I'm hitting bugs on your gitlab branches.
> My test setup that I'm trying to build regions on is
> 2 host bridge, 2 ports on each, 1 device directly connected to both.
> The qemu code will unfortunately take a bit of extracting from company internals
> so I want to get a bit further with it before going the effort of doing that
> and I have a few other things on my todo list.

Okay, thanks.

> 
> Jonathan
> 
> > 
> > Jonathan
> > 
> > 
> 
