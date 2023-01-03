Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6796C3DA7D
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 21:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjACVcV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 16:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjACVcU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 16:32:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923861261B
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672781539; x=1704317539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CDEaJwEE9pGhTuvvkQh/hc43bteWNnavWF7gzw4BKrs=;
  b=Hu6Ye5wJDjeXboUoiC0gASLUmTj791xPNn9a0aBEgwr7u8C/afCz0QF1
   XXBsfZh5zr4uuF2yJUfPv+waDifups0B8uun80/DYx3IT9AJ+/Yt2jHok
   4TqCPfmZIml6QA6DSCZybUCHxx+JuFGyr0024pRpW5bo4qDvnH2gEGnva
   Ir3Xx7jkvXPmkotoWp/+TCRoaWolXCaRuJiLxQqhEcPpIsILpH59v+KIC
   9cX7m3kYedprVnTO814R2NbUvLiIEV+fFCywDfpREQWon+8mZIkMuQ8bq
   /ftRRs39XGX/l5vuUv1/c0I0AEEs+tt0CCzpgsaP/Akj2yKox7HCIQB1I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="305266766"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="305266766"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 13:32:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="900319948"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="900319948"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.96.127]) ([10.212.96.127])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 13:32:17 -0800
Message-ID: <0a126dca-fe40-5f3e-9c04-b6dae01c221a@intel.com>
Date:   Tue, 3 Jan 2023 14:32:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/8] cxl: break out range register decoding from
 cxl_hdm_decode_init()
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rrichter@amd.com, terry.bowman@amd.com
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
 <166984994091.2805382.15976080608757662866.stgit@djiang5-desk3.ch.intel.com>
 <20221219155918.000008db@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221219155918.000008db@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/19/22 8:59 AM, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:12:20 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> There are 2 scenarios that requires additional handling. 1. A device that
>> has active ranges in DVSEC range registers (RR) but no HDM decoder register
>> block. 2. A device that has both RR active and HDM, but the HDM decoders are
>> not programmed. The goal is to create emulated decoder software structs
>> based on the RR.
>>
>> Move the CXL DVSEC range register decoding code block from
>> cxl_hdm_decode_init() to its own function. Refactor code in preparation for
>> the HDM decoder emulation.  There is no functionality change to the code.
>> Name the new function to cxl_dvsec_rr_decode().
>>
>> The only change is to set range->start to CXL_RESOURCE_NONE if the range is
>> not programmed correctly or active.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Hi Dave,
> 
> I think this refactor, whilst fairly minimal reveals some places
> where with a slightly more invasive set of changes we can improve the resulting
> code.
> 
> Jonathan
> 
>> ---
> 
> 
>> -int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>> +
>> +static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
>> +			       struct cxl_endpoint_dvsec_info *info)
>>   {
> ...
> 
>>   	for (i = 0; i < hdm_count; i++) {
>>   		u64 base, size;
>> @@ -426,22 +417,44 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>>   
>>   		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>>   
>> -		info.dvsec_range[i] = (struct range) {
>> +		info->dvsec_range[i] = (struct range) {
>>   			.start = base,
>>   			.end = base + size - 1
>>   		};
>>   
>>   		if (size)
>>   			ranges++;
>> +		else
>> +			info->dvsec_range[i].start = CXL_RESOURCE_NONE;
> 
> The following might become irrelevant after later patches in series...
> 
> Seems a little odd to do it this way for the !size case and set it
> directly above for the case where size is non zero.  Also, is there any
> purpose to setting end?
> Perhaps just sent whole thing down here and set end to the magic flag?
> 
> 		if (size) {
> 			info->dvsec_range[i] = (struct range) {
> 				.start = base,
> 				.end = base + size - 1,
> 			};
> 			ranges++;
> 		} else {
> 			info->dvsec_range[i] = (struct range) {
> 				.start = CXL_RESOURCE_NONE,
> 				.end = CXL_RESOURCE_NONE,
> 			};
> 		}
> 
> or for a more major refactor short cut the !size case and don't bother
> reading the pci registers values that are going to be thrown away
> anyway.
> 
> 		if (!size) {
> 			info->dvsec_range[i] = (struct range) {
> 				.start = CXL_RESOURCE_NONE,
> 				.end = CXL_RESOURCE_NONE,
> 			};
> 			continue;
> 		}
> 
> 		rc = pci_read_config_dword(
> 			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
> 		if (rc)
> 			return rc;
> 
> 		...
> 
> 		info->dvsec_range[i] = (struct range) {
> 			.start = base,
> 			.end = base + size - 1,
> 		};
> 		ranges++;
> 	}

Ok I like this optimization. It makes sense not reading the other 
registers if the range is not enabled.

> 
>>   	}
>>   
>> -	info.ranges = ranges;
>> +	info->ranges = ranges;
> 
> Trivial but I would like a blank line here.

ok

> 
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
>> + * @cxlds: Device state
>> + * @cxlhdm: Mapped HDM decoder Capability
>> + *
>> + * Try to enable the endpoint's HDM Decoder Capability
>> + */
>> +int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct cxl_endpoint_dvsec_info info = { 0 };
>> +	int rc;
> 
> Trivial but probably want to reorder these to maintain the reverse xmas tree.

ok

> 
>> +	struct device *dev = &pdev->dev;
>> +	int d = cxlds->cxl_dvsec;
>> +
>> +	rc = cxl_dvsec_rr_decode(pdev, d, &info);
>> +	if (rc < 0)
>> +		return rc;
>>   
>>   	/*
>>   	 * If DVSEC ranges are being used instead of HDM decoder registers there
>>   	 * is no use in trying to manage those.
>>   	 */
>> -hdm_init:
>>   	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, &info)) {
>>   		dev_err(dev,
>>   			"Legacy range registers configuration prevents HDM operation.\n");
>>
>>
> 
