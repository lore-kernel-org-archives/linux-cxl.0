Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27176C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 20:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjERUxU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjERUxT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 16:53:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C65E7D
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684443196; x=1715979196;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CS1cGAABWof7er9+v0MK7Y0MaiA0kfYu5Us8w/JUvUc=;
  b=RWZhh78WH3wJ9VWxthoBaPjLdUSFBbulTR3PzesqqhxvtwCIdYi1953C
   B8kmTCRD91QT6Fve26We9oXeDCLbp69fYBdh0xgsiwcBArHB1hG50XSHj
   +wPlG/3DD/daXjND1p2DC6eYL+t9WWPlzYCfBB6pHKaqlIkJ6+M9Qiu9F
   PCJvmjFVpPOxGU/4Ce8xBL93zfCSrYTMP7zeqS1Y0t0zQ5AjZik52uR7w
   ClRq6z1VYZUejmYcD2BVLfDneUIpoP+is3oXgORGFTHFS9L9ApQOI3WA7
   fDPR8RiYPSP/lamyZnBu0Nmu8FkTlYgNxCt3+2sBb7RtvUFNoan5iPd3y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349706640"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="349706640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 13:52:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="826526316"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="826526316"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.16.136]) ([10.212.16.136])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 13:52:19 -0700
Message-ID: <a732f860-65b2-7ea0-df17-0d3c33c60941@intel.com>
Date:   Thu, 18 May 2023 13:52:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] cxl: Wait Memory_Info_Valid before access memory
 related info
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com
References: <168443095459.2957452.1648087475761987955.stgit@djiang5-mobl3>
 <168443110267.2957452.10368382491569241133.stgit@djiang5-mobl3>
 <6466760139b73_114ccf294ca@iweiny-mobl.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6466760139b73_114ccf294ca@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/18/23 12:01 PM, Ira Weiny wrote:
> Dave Jiang wrote:
>> CXL rev3.0 8.1.3.8.2 Memory_Info_valid field
>>
>> The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
>> Low registers are valid. The bit must be set within 1 second of reset
>> deassertion to the device. Check valid bit before we check the
>> Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
>> the memory info is valid for consumption. Also ensures both DVSEC ranges
>> 1 and 2 are ready if DVSEC Capability indicates they are both supported.
>>
>> Fixes: 523e594d9cc0 ("cxl/pci: Implement wait for media active")
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v2:
>> - Check both ranges instead of just first offset. (Ira)
>> - Add to commit log. (Ira)
>> - Fix fixes tag. (Dan)
>>
> 
> [snip]
> 
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
>> -			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
>> +			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
> 
> I think this is still wrong.  I think this should be 'id' shouldn't it?

Yes. I was thinking of something else....

> ...
> 
>>   		if (rc)
>>   			return rc;
>>   
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
> 
> ... Based on this 'i'...
> 
> Ira
