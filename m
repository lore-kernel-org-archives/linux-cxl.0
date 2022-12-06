Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA33C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 16:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFQWL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiLFQVn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 11:21:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4FA2E690
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 08:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670343682; x=1701879682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iX19FGa2POMrqGY7TFecqWCYxE9y0jwi/7EcRWe4pUI=;
  b=ia+riEOKnZQfYliPejSKHBI6Y6U1LuoG7dYSau2tgLWZC59gUlR3FVke
   oiY6/iiasqSi9Yy/Y5ZbT2icwAIZJjUPG2Y+5ysbraA9TJQrYs7ueFTq+
   mfOPSLS5pAQXdMj46kHn0Pe3Fy7PVSg6rkpg+dNtKc1Uol7iwh0IbC1Ph
   srFL58fRvvyBj9BVYYAbJOtdBNcnpvCucL+xfJLVPLXQT3plO46IVGuku
   ZnqJp8SsIK+ELEn8uSdSartzd2E9H+f4f1+SKptx8x8y3vtBuxeKPwD3s
   Ojeg/Aa0ODr88IotfZ40RoL/Cm+rzmO8gzJ9tnms3hPWxorpNih+Fq7Qa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="314307679"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="314307679"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 08:21:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="891438980"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="891438980"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.100]) ([10.212.108.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 08:21:21 -0800
Message-ID: <df8849a7-fc73-210c-179d-2b9536711fd0@intel.com>
Date:   Tue, 6 Dec 2022 09:21:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] cxl/security: Fix Get Security State output payload
 endian handling
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, ira.weiny@intel.com
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
 <167030054822.4044561.4917796262037689553.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167030054822.4044561.4917796262037689553.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/5/2022 9:22 PM, Dan Williams wrote:
> Multi-byte integer values in CXL mailbox payloads are little endian. Add
> a definition of the Get Security State output payload and convert the
> value before testing flags.
> 
> Fixes: 328281155539 ("cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Looks like I missed the endian conversion. Thanks!

> ---
>   drivers/cxl/security.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 5484d4eecfd1..ebb78b8944f5 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -16,14 +16,18 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	unsigned long security_flags = 0;
> +	struct cxl_get_security_output {
> +		__le32 flags;
> +	} out;
>   	u32 sec_out;
>   	int rc;
>   
>   	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
> -			       &sec_out, sizeof(sec_out));
> +			       &out, sizeof(out));
>   	if (rc < 0)
>   		return 0;
>   
> +	sec_out = le32_to_cpu(out.flags);
>   	if (ptype == NVDIMM_MASTER) {
>   		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
>   			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
> 
