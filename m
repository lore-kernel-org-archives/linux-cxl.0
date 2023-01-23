Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB966C25B50
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 23:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjAWXbj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWXbi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 18:31:38 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A052D17174
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 15:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674516697; x=1706052697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e111471OgtA1Ou2f8/h3pg96FqY8/kNhf0K4zlFsSS0=;
  b=RQen4OfH3E6o2668HbwnJAfelo+wdF7eDnj25Ytgf0NafedEBQY6Akyw
   j+Hmi6ng1LdyPSvHxL3yqYzQvWD3N1KuKO1yP8soDE4ixEnYWlJ9edjGg
   3Iji+9FxxvsxUOUmJmbMLhXFQ2OpLVJt3GFeL9L469V6lYV9IQaXv4GGW
   /jfWEqep9iCPai2nOwQ3hLDohXABcJSLk5xF1ZCuiRaehlSjwu+zzH2oH
   NKd+uCq8QcBICQqekI+Z9ihyFAnych5bh0RMQTdf8ow2uR+fPbAX2vpSl
   U5IvpbfYa0szDxy2ghV8osS/oXdfnH2ifXXqDv0qMUiM4XOYy2TxfAiHt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323879681"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="323879681"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 15:31:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="692412104"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="692412104"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.2.84])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 15:31:36 -0800
Date:   Mon, 23 Jan 2023 15:31:35 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/trace: Add an HPA to cxl_poison trace events
Message-ID: <Y88Y11hUGfsQD0ki@aschofie-mobl2>
References: <20230118201805.485232-1-alison.schofield@intel.com>
 <20230123145848.00007b5f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123145848.00007b5f@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 02:58:48PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 12:18:05 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a cxl_poison trace event is reported by region, the poisoned
> > Device Physical Address (DPA) can be translated to a Host Physical
> > Address (HPA) for consumption by user space.
> > 
> > Translate and add the resulting HPA to the cxl_poison trace event.
> > Follow the device decode logic as defined in the CXL Spec 3.0 Section
> > 8.2.4.19.13.
> > 
> > When the poison request is by memdev, no HPA translation is performed
> > and ULLONG_MAX is assigned to the cxl_poison hpa trace field.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> The offset stuff for non power of 2 gives me a headache, but I 'think'
> you have it right... We don't yet have support in QEMU for those
> modes, so I can't easily brute force test it.  With all that in mind.
> 
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Trivial style comment inline.
> 
Thanks for the review Jonathan. I noted the comment hpa->HPA, and will
pick it up if/when I rev this.

Thanks for sharing the headache with me ;)  I posted a test program to
that mimics these calculations and cranks thru every (perhaps some
illegal) permuation of EIG, EIW, POS, and applies them to a dpa_offset
to make an hpa_offset.

https://github.com/AlisonSchofield/cxl-addrtest

Ideally, I would be able to compare the outputs I'm getting, rather
than just validate using my own, possibly flawed again, calculations.

Ideas to further that testing are welcome!

Alison


> > ---
> > 
> > Built on cxl/next plus Patchset: CXL Poison List Retrieval & Tracing [1]
> > 
> > Changes in v2:
> > - Rebased to cxl/next
> > 
> > Link to v1: https://lore.kernel.org/linux-cxl/20230104210401.195808-1-alison.schofield@intel.com/
> > 
> > [1] https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com/
> > 
> > 
> >  drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/trace.h |  9 +++-
> >  2 files changed, 102 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> > index 29ae7ce81dc5..d0403dc3c8ab 100644
> > --- a/drivers/cxl/core/trace.c
> > +++ b/drivers/cxl/core/trace.c
> > @@ -1,5 +1,99 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> >  
> > +#include <cxl.h>
> > +#include "core.h"
> > +
> >  #define CREATE_TRACE_POINTS
> >  #include "trace.h"
> > +
> > +static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int gran = p->interleave_granularity;
> > +	int ways = p->interleave_ways;
> > +	u64 offset;
> > +
> > +	/* Is the hpa within this region at all */
> 
> For comments we could go with HPA... Doesn't really matter though.
> 
>  
> > +	if (hpa < p->res->start || hpa > p->res->end) {
> > +		dev_dbg(&cxlr->dev,
> > +			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> > +		return false;
> > +	}
> > +
> > +	/* Is the hpa in an expected chunk for its pos(-ition) */
> > +	offset = hpa - p->res->start;
> > +	offset = do_div(offset, gran * ways);
> > +	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
> > +		return true;
> > +
> > +	dev_dbg(&cxlr->dev,
> > +		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
> > +
> > +	return false;
> > +}
> > +
> > +static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> > +			  struct cxl_endpoint_decoder *cxled)
> > +{
> > +	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int pos = cxled->pos;
> > +	u16 eig = 0;
> > +	u8 eiw = 0;
> > +
> > +	ways_to_eiw(p->interleave_ways, &eiw);
> > +	granularity_to_eig(p->interleave_granularity, &eig);
> > +
> > +	/*
> > +	 * The device position in the region interleave set was removed
> > +	 * from the offset at HPA->DPA translation. To reconstruct the
> > +	 * HPA, place the 'pos' in the offset.
> > +	 *
> > +	 * The placement of 'pos' in the HPA is determined by interleave
> > +	 * ways and granularity and is defined in the CXL Spec 3.0 Section
> > +	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
> > +	 */
> > +
> > +	/* Remove the dpa base */
> > +	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> > +
> > +	mask_upper = GENMASK_ULL(51, eig + 8);
> > +
> > +	if (eiw < 8) {
> > +		hpa_offset = (dpa_offset & mask_upper) << eiw;
> > +		hpa_offset |= pos << (eig + 8);
> > +	} else {
> > +		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> > +		bits_upper = bits_upper * 3;
> > +		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> > +	}
> > +
> > +	/* The lower bits remain unchanged */
> > +	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> > +
> > +	/* Apply the hpa_offset to the region base address */
> > +	hpa = hpa_offset + p->res->start;
> > +
> > +	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> > +		return ULLONG_MAX;
> > +
> > +	return hpa;
> > +}
> > +
> 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index c7958311ce5f..521b80f92e96 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -136,6 +136,8 @@ TRACE_EVENT(cxl_aer_correctable_error,
> >  #define cxl_poison_overflow(flags, time)				\
> >  	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
> >  
> > +u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
> > +
> >  TRACE_EVENT(cxl_poison,
> >  
> >  	    TP_PROTO(struct cxl_memdev *memdev, const struct pci_dev *pcidev,
> > @@ -150,6 +152,7 @@ TRACE_EVENT(cxl_poison,
> >  		__string(pcidev, dev_name(&pcidev->dev))
> >  		__string(region, region)
> >  		__field(u64, overflow_t)
> > +		__field(u64, hpa)
> >  		__field(u64, dpa)
> >  		__field(u32, length)
> >  		__array(char, uuid, 16)
> > @@ -168,17 +171,21 @@ TRACE_EVENT(cxl_poison,
> >  		if (region) {
> >  			__assign_str(region, dev_name(&region->dev));
> >  			memcpy(__entry->uuid, &region->params.uuid, 16);
> > +			__entry->hpa = cxl_trace_hpa(region, memdev,
> > +						     __entry->dpa);
> >  		} else {
> >  			__assign_str(region, "");
> >  			memset(__entry->uuid, 0, 16);
> > +			__entry->hpa = ULLONG_MAX;
> >  		}
> >  	    ),
> >  
> > -	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> > +	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU hpa=0x%llx dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> >  		__get_str(memdev),
> >  		__get_str(pcidev),
> >  		__get_str(region),
> >  		__entry->uuid,
> > +		__entry->hpa,
> >  		__entry->dpa,
> >  		__entry->length,
> >  		show_poison_source(__entry->source),
> 
