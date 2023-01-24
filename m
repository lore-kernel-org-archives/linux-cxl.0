Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0596C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 16:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjAXQQq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjAXQQo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 11:16:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE547434
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674577003; x=1706113003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gWnDhAysaEfifDlqZQ+awh+3OnMzrV8NIvzx49gIFVI=;
  b=W4KXd81XGu4DBhocyCmrsTbD09OKrYlK6mS1aC6JDkDXiphoTF4uAWkp
   uS26pSzHwgmN0HQ1bTvRkDIa0RWyBLINwnnerfvF3vxQVahENTd64yxEH
   xb+45UqZGApmf3xdfyZK5zkIaB0Ig2prj5CRAMSTkLyzKR05UltYVjE+C
   H3e/GF7E175MOYk4h1xewScO13miDOcFP85lOvx6kfzEplvhuW2C1fcKW
   eAWCqSCE9mO+8Aned8nhnrXpEMQYGDpwx5N5OWZCNPWY4S4aG9Gj6b4jh
   uSSDe463YCcx9BD+5qwTb3l7MmetsFvONG5N12RsEJDqg5OXs8TW5Ll8R
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="314233358"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="314233358"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:16:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="750873810"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="750873810"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.182.87]) ([10.213.182.87])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:16:42 -0800
Message-ID: <025041d2-2e18-fb5f-b8be-cbb49109a13d@intel.com>
Date:   Tue, 24 Jan 2023 09:16:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2] cxl/trace: Add an HPA to cxl_poison trace events
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <20230118201805.485232-1-alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230118201805.485232-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/18/23 1:18 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a cxl_poison trace event is reported by region, the poisoned
> Device Physical Address (DPA) can be translated to a Host Physical
> Address (HPA) for consumption by user space.
> 
> Translate and add the resulting HPA to the cxl_poison trace event.
> Follow the device decode logic as defined in the CXL Spec 3.0 Section
> 8.2.4.19.13.
> 
> When the poison request is by memdev, no HPA translation is performed
> and ULLONG_MAX is assigned to the cxl_poison hpa trace field.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> Built on cxl/next plus Patchset: CXL Poison List Retrieval & Tracing [1]
> 
> Changes in v2:
> - Rebased to cxl/next
> 
> Link to v1: https://lore.kernel.org/linux-cxl/20230104210401.195808-1-alison.schofield@intel.com/
> 
> [1] https://lore.kernel.org/linux-cxl/de11785ff05844299b40b100f8e0f56c7eef7f08.1674070170.git.alison.schofield@intel.com/
> 
> 
>   drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/core/trace.h |  9 +++-
>   2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index 29ae7ce81dc5..d0403dc3c8ab 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -1,5 +1,99 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>   
> +#include <cxl.h>
> +#include "core.h"
> +
>   #define CREATE_TRACE_POINTS
>   #include "trace.h"
> +
> +static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int gran = p->interleave_granularity;
> +	int ways = p->interleave_ways;
> +	u64 offset;
> +
> +	/* Is the hpa within this region at all */
> +	if (hpa < p->res->start || hpa > p->res->end) {
> +		dev_dbg(&cxlr->dev,
> +			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> +		return false;
> +	}
> +
> +	/* Is the hpa in an expected chunk for its pos(-ition) */
> +	offset = hpa - p->res->start;
> +	offset = do_div(offset, gran * ways);
> +	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
> +		return true;
> +
> +	dev_dbg(&cxlr->dev,
> +		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
> +
> +	return false;
> +}
> +
> +static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> +			  struct cxl_endpoint_decoder *cxled)
> +{
> +	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> +	struct cxl_region_params *p = &cxlr->params;
> +	int pos = cxled->pos;
> +	u16 eig = 0;
> +	u8 eiw = 0;
> +
> +	ways_to_eiw(p->interleave_ways, &eiw);
> +	granularity_to_eig(p->interleave_granularity, &eig);
> +
> +	/*
> +	 * The device position in the region interleave set was removed
> +	 * from the offset at HPA->DPA translation. To reconstruct the
> +	 * HPA, place the 'pos' in the offset.
> +	 *
> +	 * The placement of 'pos' in the HPA is determined by interleave
> +	 * ways and granularity and is defined in the CXL Spec 3.0 Section
> +	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
> +	 */
> +
> +	/* Remove the dpa base */
> +	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +
> +	mask_upper = GENMASK_ULL(51, eig + 8);
> +
> +	if (eiw < 8) {
> +		hpa_offset = (dpa_offset & mask_upper) << eiw;
> +		hpa_offset |= pos << (eig + 8);
> +	} else {
> +		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> +		bits_upper = bits_upper * 3;
> +		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> +	}
> +
> +	/* The lower bits remain unchanged */
> +	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> +
> +	/* Apply the hpa_offset to the region base address */
> +	hpa = hpa_offset + p->res->start;
> +
> +	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> +		return ULLONG_MAX;
> +
> +	return hpa;
> +}
> +
> +u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *cxlmd,
> +		  u64 dpa)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled = NULL;
> +
> +	for (int i = 0; i <  p->nr_targets; i++) {
> +		cxled = p->targets[i];
> +		if (cxlmd == cxled_to_memdev(cxled))
> +			break;
> +	}
> +	if (!cxled || cxlmd != cxled_to_memdev(cxled))
> +		return ULLONG_MAX;
> +
> +	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
> +}
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index c7958311ce5f..521b80f92e96 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -136,6 +136,8 @@ TRACE_EVENT(cxl_aer_correctable_error,
>   #define cxl_poison_overflow(flags, time)				\
>   	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
>   
> +u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
> +
>   TRACE_EVENT(cxl_poison,
>   
>   	    TP_PROTO(struct cxl_memdev *memdev, const struct pci_dev *pcidev,
> @@ -150,6 +152,7 @@ TRACE_EVENT(cxl_poison,
>   		__string(pcidev, dev_name(&pcidev->dev))
>   		__string(region, region)
>   		__field(u64, overflow_t)
> +		__field(u64, hpa)
>   		__field(u64, dpa)
>   		__field(u32, length)
>   		__array(char, uuid, 16)
> @@ -168,17 +171,21 @@ TRACE_EVENT(cxl_poison,
>   		if (region) {
>   			__assign_str(region, dev_name(&region->dev));
>   			memcpy(__entry->uuid, &region->params.uuid, 16);
> +			__entry->hpa = cxl_trace_hpa(region, memdev,
> +						     __entry->dpa);
>   		} else {
>   			__assign_str(region, "");
>   			memset(__entry->uuid, 0, 16);
> +			__entry->hpa = ULLONG_MAX;
>   		}
>   	    ),
>   
> -	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> +	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU hpa=0x%llx dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
>   		__get_str(memdev),
>   		__get_str(pcidev),
>   		__get_str(region),
>   		__entry->uuid,
> +		__entry->hpa,
>   		__entry->dpa,
>   		__entry->length,
>   		show_poison_source(__entry->source),
