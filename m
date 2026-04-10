Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7629E114;
	Fri, 10 Apr 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775846407; cv=none; b=Z69vGASK0x6Zed3W5GVAnfrHkUUN9qacGtezNhJUIVBCpbFTkIo4HowKW2voJLlgxQo6Hoc146eKlErihM8xA3NCe6g5Q/0NzesYC8/t8alRWcAlhfsBPYtB77wx+XclB2hLs6w/xKASttEMIwJLgVMH9sant6ZMNM4j31Aiqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775846407; c=relaxed/simple;
	bh=IPAEykwHumLpDK4fAcq5dq9jCusv1jSWptU/5kPS/8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHjoHLmbBhrH2muBY+kr8YbAUnZtnY2bMRVUBohPQuKvLFR4rNZJhSPGXa9cprHW2pf3Gp+ulSYWh4RJIlW6pwUbin39fOyG4XuVbO7m3UEYgCY1a6YAdNyPlrMJCPbWauyQt/mo9rdF07SmasFgE0PqNYW/FvJIRUkWZ1V90TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jduk0vTY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jduk0vTY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775846405; x=1807382405;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IPAEykwHumLpDK4fAcq5dq9jCusv1jSWptU/5kPS/8I=;
  b=jduk0vTYnYfNjo6CEUhxoL3iAT5D1oalaF9XL+ul/KJmBK7uYF1sqoxw
   4R2ZbbkMq3p3dSN3VZxy7jbIOXQxDGd/Reznr8rw+e3jEflfayfny2uaq
   iv7XP/H7QnqfqpYxzVVaToIUU5zOX6mlo62E6Lt2ZyFbdUTO61yqglGEC
   kosTDprnqMrFPFBi6tsk6B25dl0XlecmHzG2o96y3IME6q4yP9skhpUBz
   E/Y2nV1ssgKHa+JyG8r6R46v3J7TSSGU+F0e1sohDkCkfg1ACqMTd9ZGl
   IVd+9UBxeTOf+YjKwaVk3uDXyZYR09xvT0Lsa5gaK1TYQxh85xgfTWjdw
   g==;
X-CSE-ConnectionGUID: lLWsoCgkRNyl3JCgYMR+Wg==
X-CSE-MsgGUID: 6+zJ5iCsS7C+Yfxm0fXSQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76892036"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="76892036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:39:58 -0700
X-CSE-ConnectionGUID: OTfFsWGJSPaDAM11wjs0kQ==
X-CSE-MsgGUID: 1b1/pyGBS7q7sfSoeIwhrA==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.54]) ([10.125.109.54])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:39:57 -0700
Message-ID: <bc25b27f-ef27-492d-bd7a-7d27156bfa02@intel.com>
Date: Fri, 10 Apr 2026 11:39:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/hdm: Add support for 32 switch decoders
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260321061459.1910205-1-ming.li@zohomail.com>
 <d9c29dea-0359-4257-9f8e-0e7a7e68654b@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <d9c29dea-0359-4257-9f8e-0e7a7e68654b@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/10/26 1:17 AM, Li Ming wrote:
> kindly ping.
> 
> Is this patch missing in cxl/next?

Sorry I missed it. Applied to cxl/next
3624a22783b7


> 
> 
> Ming
> 
> 在 2026/3/21 14:14, Li Ming 写道:
>> Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
>> support 32 HDM decoders. Current implementation misses some decoders on
>> CXL host bridge and switch in the case that the value of Decoder Count
>> field in CXL HDM decoder Capability Register is greater than or equal to
>> 9.
>>
>> Update calculation implementation to ensure the decoder count calculation
>> is correct for CXL host bridge/switch ports.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> Changes from v1:
>> - Return -ENXIO if the value violates SPEC. (Dave & Alison)
>> ---
>>   drivers/cxl/core/hdm.c |  2 +-
>>   drivers/cxl/cxl.h      | 11 ++++++++++-
>>   drivers/cxl/cxlmem.h   |  2 +-
>>   3 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index c222e98ae736..3930e130d6b6 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -177,7 +177,7 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>       }
>>         parse_hdm_decoder_caps(cxlhdm);
>> -    if (cxlhdm->decoder_count == 0) {
>> +    if (cxlhdm->decoder_count < 0) {
>>           dev_err(dev, "Spec violation. Caps invalid\n");
>>           return ERR_PTR(-ENXIO);
>>       }
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 9b947286eb9b..0a5301049cf3 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -77,7 +77,16 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>>   {
>>       int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>>   -    return val ? val * 2 : 1;
>> +    switch (val) {
>> +    case 0:
>> +        return 1;
>> +    case 1 ... 8:
>> +        return val * 2;
>> +    case 9 ... 12:
>> +        return (val - 4) * 4;
>> +    default:
>> +        return -ENXIO;
>> +    }
>>   }
>>     /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index e21d744d639b..399b150b404c 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -923,7 +923,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>>    */
>>   struct cxl_hdm {
>>       struct cxl_component_regs regs;
>> -    unsigned int decoder_count;
>> +    int decoder_count;
>>       unsigned int target_count;
>>       unsigned int interleave_mask;
>>       unsigned long iw_cap_mask;

