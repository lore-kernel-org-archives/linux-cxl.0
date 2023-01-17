Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BDC54E76
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Jan 2023 18:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjAQSqf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 Jan 2023 13:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjAQSdj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 Jan 2023 13:33:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404B25E1E
        for <linux-cxl@vger.kernel.org>; Tue, 17 Jan 2023 10:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673978736; x=1705514736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v1MEGk9Wc1dux3fnva1QpPy0CqgaEb7seMTRk486rw0=;
  b=mpk+STa1DDLzC34HI+/9MYZzVLG+8WpyBhpmQ4H9b/wf+D360jJJ41kh
   WC7Km4t0QoGf4iX0Cs3S3Y3GTFJWSwovCeGM3quhJL225xkJlIFMT2l4C
   L68rGa0r9KWkn3HJZyXDvF9/mkR3EdZcOewWjmVltpsnRi4a4TWTJ/rR+
   EpvJXoFYRFVkglRTDo8KLaLh4yM0xaBnYWZUF/rW5vNNSAlua5UB21ypI
   kSlWIa+VpFgC0uL4mhfVTUoTz0F61PAOHv0v85DBkD8XR7Qv3wfz/cvKR
   avqFtQvF/gCqwRkKghrROnZJoQCftNhLEheMvUodbmeQXOxNPsgY2FmDv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="308335335"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308335335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:05:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="689869647"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="689869647"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.41.87]) ([10.212.41.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:05:34 -0800
Message-ID: <db285965-1bf4-7e46-df94-d4ce349baf8f@intel.com>
Date:   Tue, 17 Jan 2023 11:05:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/2] cxl: RAS: Multiple header recording support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     linuxarm@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
 <20230113154058.16227-2-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230113154058.16227-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/13/23 8:40 AM, Jonathan Cameron wrote:
> Similar to PCIe, CXL devices may support logging multiple headers
> corresponding to multiple errors as reported via the CXL RAS capability.
> 
> Unlike PCIe, in CXL there is no Multiple Header Recording Enable bit
> and the CXL r3.0 specification is sparse on details. As such, the
> kernel should allow for any reasonable interpretation including
> endpoints for which the capability bit is set that behave as per
> the PCIe equivalent definitions (with assumption that the missing
> 'enable bit' is set). Note that behaving as if Multiple Headers
> are being logged is also valid behavior when they are not so this
> approach should be safe with all sensible specification interpretations.
> 
> By repeatedly attempting to clear a single bit corresponding to the reported
> First Error (may need multiple goes if multiple records of same type
> are tracked by the hardware) the additional header logs may be obtained.
> 
> Note that each trace record only records the FE in the status.
> We could record them all as done without Multi header recording
> capability but that seemed less intuitive to me.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks reasonable

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/pci.c | 17 ++++++++++++-----
>   drivers/cxl/cxl.h      |  1 +
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 184ead6a2796..6fd311e313c6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -673,10 +673,13 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   	void __iomem *addr;
>   	u32 status;
>   	u32 fe;
> +	bool mh;
>   
>   	if (!cxlds->regs.ras)
>   		return false;
>   
> +next_record:
> +	mh = false;
>   	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
>   	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
> @@ -684,11 +687,13 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   
>   	/* If multiple errors, log header points to first error from ctrl reg */
>   	if (hweight32(status) > 1) {
> -		void __iomem *rcc_addr =
> -			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> -
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   readl(rcc_addr)));
> +		u32 capctrl = readl(cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET);
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, capctrl));
> +		if (FIELD_GET(CXL_RAS_CAP_CONTROL_MH_REC_CAP, capctrl)) {
> +			mh = true;
> +			/* Report and clear only first error */
> +			status = fe;
> +		}
>   	} else {
>   		fe = status;
>   	}
> @@ -696,6 +701,8 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   	header_log_copy(cxlds, hl);
>   	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
> +	if (mh)
> +		goto next_record;
>   
>   	return true;
>   }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index aa3af3bb73b2..ee31a99073c2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -138,6 +138,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   #define   CXL_RAS_CORRECTABLE_MASK_MASK GENMASK(6, 0)
>   #define CXL_RAS_CAP_CONTROL_OFFSET 0x14
>   #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
> +#define CXL_RAS_CAP_CONTROL_MH_REC_CAP BIT(9)
>   #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>   #define CXL_RAS_CAPABILITY_LENGTH 0x58
>   #define CXL_HEADERLOG_SIZE SZ_512
