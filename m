Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F6C48BE4
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 23:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiHKXUG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbiHKXTu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 19:19:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434FA1A5D
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660259954; x=1691795954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mKzB4P4VFeeV0waEOaLLGez7hTm6UBl5kfBznsS24Jo=;
  b=fs/qOmM75hAjstrvcmNOPTT48hjxcL4R8fXuM5POxrVNdOlu7EmG5+tM
   RWPJJd6newxNq7TjuyY51h3mgn46tiBicvlYmhptbFjPSoyg3hWCZ0r7F
   Wrj91cal8+0iigaiv36kjF4ZCGcN7tM/rQFVgb5CmeMUAGUIhcdtI7mKy
   kvnuBhqCxlQAUUvIcTUj/M5TDUe0OBqfKBdA4QRWd7/JlMIUQulPeRFvx
   WOPdxtuetXY5YVL4HuqZcWwY97nMrBXKIKeXHZ2LuJMNdYMv3fxwluuAk
   m2urUp92lV/UJ7+610zfDn0My8eAmYH/m40kH2jHQ0ant2YZnjyQ121RP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271256409"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271256409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:19:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="933510452"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.81.242]) ([10.212.81.242])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:19:13 -0700
Message-ID: <638867f4-214b-eba3-6bf3-9aa4fb85fa53@intel.com>
Date:   Thu, 11 Aug 2022 16:19:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] cxl: Add CXL spec v3.0 interleave support
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999282258.493131.2782730417677035484.stgit@djiang5-desk4.jf.intel.com>
 <62f2895635e69_1f18b29456@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <62f2895635e69_1f18b29456@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/9/2022 9:20 AM, Dan Williams wrote:
> Dave Jiang wrote:
>> CXL spec v3.0 added 2 CAP bits to the CXL HDM Decoder Capability Register.
>> CXL spec v3.0 8.2.4.19.1. Bit 11 indicates that 3, 6, and 12 way interleave
>> is capable. Bit 12 indicates that 16 way interleave is capable.
>>
>> Add code to parse_hdm_decoder_caps() to cache those new bits. Add check in
>> cxl_interleave_verify() call to make sure those CAP bits matches the passed
>> in interleave value.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/hdm.c |    4 ++++
>>   drivers/cxl/cxl.h      |    2 ++
>>   drivers/cxl/cxlmem.h   |   29 +++++++++++++++++++++++++++++
>>   3 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 8143e2615957..50ff7387e425 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -80,6 +80,10 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>>   		cxlhdm->interleave_mask |= GENMASK(11, 8);
>>   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>>   		cxlhdm->interleave_mask |= GENMASK(14, 12);
>> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
>> +		cxlhdm->interleave_3_6_12 = true;
>> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
>> +		cxlhdm->interleave_16 = true;
>>   }
>>   
>>   static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 275979fbd15a..db9631d09dd0 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -42,6 +42,8 @@
>>   #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>>   #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>>   #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>>   #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>>   #define   CXL_HDM_DECODER_ENABLE BIT(1)
>>   #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index d5f872ca62f9..9b4b23b3b78a 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -398,9 +398,35 @@ struct cxl_hdm {
>>   	unsigned int decoder_count;
>>   	unsigned int target_count;
>>   	unsigned int interleave_mask;
>> +	bool interleave_3_6_12;
>> +	bool interleave_16;
>>   	struct cxl_port *port;
>>   };
>>   
>> +static inline bool valid_interleave(struct cxl_hdm *cxlhdm, u8 iw)
>> +{
>> +	switch (iw) {
>> +	case CXL_INTERLEAVE_1_WAY:
>> +	case CXL_INTERLEAVE_2_WAY:
>> +	case CXL_INTERLEAVE_4_WAY:
>> +	case CXL_INTERLEAVE_8_WAY:
>> +		return true;
>> +	case CXL_INTERLEAVE_16_WAY:
>> +		if (!cxlhdm->interleave_16)
>> +			return false;
>> +		return true;
>> +	case CXL_INTERLEAVE_3_WAY:
>> +	case CXL_INTERLEAVE_6_WAY:
>> +	case CXL_INTERLEAVE_12_WAY:
>> +		if (!cxlhdm->interleave_3_6_12)
>> +			return false;
>> +		return true;
>> +	default:
>> +	};
>> +
>> +	return false;
> I'd prefer something more compact like
>
>      test_bit(iw, &port->interleave_cap)
>
> ...where interleave_cap is just a mask with bits 1,2,3,4,6,8,12,16
> optionally set.

ok

