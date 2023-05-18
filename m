Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E3C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 15:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjERPVY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 11:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjERPVX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 11:21:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765BF11C
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684423282; x=1715959282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z8EXqJITftvoQcoBQpCWZmg/kjMbJp/qozusB/DUAm0=;
  b=TFQ43u66xNB+Tg1kpJSMLmrnmWUKS1c2unFqNfUYasCaMebXHNWNJL/M
   mEXsjTej+hqgEuNyBenDtlmm9247kdcBCgwzR4yAvctiV+NoklWQrOOpP
   xZkw3Hg/dCHhQpCd8DImvf0ZFHserEuKod5P83ysWuIqXnI8qndzfNOIV
   9VVMkjma/Q0XV5fZstvXXWJHnaYS71JyDADT6iVyY2S1V4xNtZ+naUMcv
   ZQfCKJSRI62PefFjZs2gCPTjlB+K0XoucL3uVgMtyqttqs9YiUsa2k8sX
   DCIEZ0cmH6NqAXg2OCowuXWZgrIYNzU0hkKpoHanH6vvXslcpCBfpQEuH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352114799"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="352114799"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="948731911"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="948731911"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.16.136]) ([10.212.16.136])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:21:21 -0700
Message-ID: <5c139aba-1b77-ccf2-a389-b21057b7f465@intel.com>
Date:   Thu, 18 May 2023 08:21:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] cxl: Wait Memory_Info_Valid before access memory
 related info
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428295907.2205351.12793990978386772732.stgit@djiang5-mobl3>
 <64659dfc73774_1098d429459@iweiny-mobl.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <64659dfc73774_1098d429459@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/17/23 8:39 PM, Ira Weiny wrote:
> Dave Jiang wrote:
>> CXL rev3.0 8.1.3.8.2 Memory_Info_valid field
>>
>> The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
>> Low registers are valid. The bit must be set within 1 second of reset
>> deassertion to the device. Check valid bit before we check the
>> Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
>> the memory info is valid for consumption.
> 
> FWIW this also ensures both DVSEC ranges 1 and 2 are ready if the DVSEC
> Capability indicates they are both supported.
> 
>>
>> Fixes: 2e4ba0ec9783 ("cxl/pci: Move cxl_await_media_ready() to the core")
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v2:
>> - Check both ranges. (Jonathan)
>> ---
>>   drivers/cxl/core/pci.c |   83 +++++++++++++++++++++++++++++++++++++++++++-----
>>   drivers/cxl/cxlpci.h   |    2 +
>>   2 files changed, 77 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 63f2f0b86fbc..484a8b0b96b9 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -101,21 +101,55 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
>>   
>> -/*
>> - * Wait up to @media_ready_timeout for the device to report memory
>> - * active.
>> - */
>> -int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>> +static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	int d = cxlds->cxl_dvsec;
>> +	bool valid = false;
>> +	int rc, i;
>> +	u32 temp;
>> +
>> +	if (id > CXL_DVSEC_RANGE_MAX)
>> +		return -EINVAL;
>> +
>> +	/* Check MEM INFO VALID bit first, give up after 1s */
>> +	i = 1;
>> +	do {
>> +		rc = pci_read_config_dword(pdev,
>> +					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
>> +					   &temp);
>> +		if (rc)
>> +			return rc;
>> +
>> +		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
>> +		if (valid)
>> +			break;
>> +		msleep(1000);
>> +	} while (i--);
>> +
>> +	if (!valid) {
>> +		dev_err(&pdev->dev,
>> +			"Timeout awaiting memory range %d valid after 1s.\n",
>> +			id);
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>   	int d = cxlds->cxl_dvsec;
>>   	bool active = false;
>> -	u64 md_status;
>>   	int rc, i;
>> +	u32 temp;
>>   
>> -	for (i = media_ready_timeout; i; i--) {
>> -		u32 temp;
>> +	if (id > CXL_DVSEC_RANGE_MAX)
>> +		return -EINVAL;
>>   
>> +	/* Check MEM ACTIVE bit, up to 60s timeout by default */
>> +	for (i = media_ready_timeout; i; i--) {
>>   		rc = pci_read_config_dword(
>>   			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
> 				  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> CXL_DVSEC_RANGE_SIZE_LOW(id)?

Yup. I missed that. Thanks.

> 
> Ira
> 
>>   		if (rc)
>> @@ -134,6 +168,39 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>>   		return -ETIMEDOUT;
>>   	}
>>   
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Wait up to @media_ready_timeout for the device to report memory
>> + * active.
>> + */
>> +int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	int d = cxlds->cxl_dvsec;
>> +	int rc, i, hdm_count;
>> +	u64 md_status;
>> +	u16 cap;
>> +
>> +	rc = pci_read_config_word(pdev,
>> +				  d + CXL_DVSEC_CAP_OFFSET, &cap);
>> +	if (rc)
>> +		return rc;
>> +
>> +	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
>> +	for (i = 0; i < hdm_count; i++) {
>> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>> +	for (i = 0; i < hdm_count; i++) {
>> +		rc = cxl_dvsec_mem_range_active(cxlds, i);
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>>   	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>>   	if (!CXLMDEV_READY(md_status))
>>   		return -EIO;
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 0465ef963cd6..7c02e55b8042 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -31,6 +31,8 @@
>>   #define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>>   #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>>   
>> +#define CXL_DVSEC_RANGE_MAX		2
>> +
>>   /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>>   #define CXL_DVSEC_FUNCTION_MAP					2
>>   
>>
>>
> 
> 
