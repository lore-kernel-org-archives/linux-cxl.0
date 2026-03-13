Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2F363C72;
	Fri, 13 Mar 2026 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420983; cv=none; b=Zuev/G5DnPgSSscUo6ffBDy/6sn6d428S2ZLLAp80oPFktVK+nYp7oeYo+zMqI5Zyya/HVAafvZaG7Ljl0+kw9RM2/xYTn+6BUSR+IeD6mQdvK8TDTQwa34YkHnTjfLw+KelTjsc85pwR53k+t9E/8sjjT0QzXfzWcBPa10F/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420983; c=relaxed/simple;
	bh=0uqgpIANlqfUrdaeadAKjdf+nK8dcNapPkhTFncGu6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1eSsVD9Nu+f1rc2LCWzcRxx26VUiskPXHlZrIxCT4KLsL562pExUS0B9UUfRTz8Cm2tbzjci4U0a03Bx1MpBL5N8WG1/wfdwn8GibkCK/M2clzCpAFsHkZTNnmZJnULBkjtJ6qNQRK2wpEto3YXAwChltwff8WDi3R5cS681wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZweAU1l+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZweAU1l+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773420975; x=1804956975;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0uqgpIANlqfUrdaeadAKjdf+nK8dcNapPkhTFncGu6o=;
  b=ZweAU1l+hkLSY07BrSTEoFv+0kM7hPCR5FztoYv8u6zNz6nPqAOpLbYh
   PEg35dssZhEBFInBos5w5Q7t0bjQaLyukGr8ZG+OukmcJ1LL5Q2cW4+Rt
   mXB6GzJTiGKp17IeKYgG7mL6rLO863puBHizxv3N6oINapRx8b4UWWtpT
   Zpnlx4Ewp9RVCmcqDYC3Pres+Tm4Tz6r8CHtBNpkZsRIAjB8A9DGd21UR
   hnC+gW4RgCtA4ZSeKX/CxLr27IQj0jz495Qjh2Cwqa0EpKkpiFELx0tLw
   qssXX0e5ClJ4lgjVfTP9YxxojyoCRrA5976b/6KoKcn6R4Fon/N+abLHM
   g==;
X-CSE-ConnectionGUID: jcITCmhrSxC9Mw5qXNZuUQ==
X-CSE-MsgGUID: 29fGa5AjQtGpNLRZAq0YxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85618717"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85618717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 09:56:13 -0700
X-CSE-ConnectionGUID: kG43qGn4SPK9kgxWUJXIEw==
X-CSE-MsgGUID: NMOq9FYXT8CWksTfb+ifJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225328810"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 09:56:11 -0700
Message-ID: <fd232cc5-f2ab-463f-9238-44e2514d4ad1@intel.com>
Date: Fri, 13 Mar 2026 09:56:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] cxl: Move CXL spec defines to public header
To: Jonathan Cameron <jonathan.cameron@huawei.com>, mhonap@nvidia.com
Cc: aniketa@nvidia.com, ankita@nvidia.com, alwilliamson@nvidia.com,
 vsethi@nvidia.com, jgg@nvidia.com, mochs@nvidia.com,
 skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, yishaih@nvidia.com,
 kevin.tian@intel.com, cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com,
 kjaju@nvidia.com, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-4-mhonap@nvidia.com>
 <20260313121805.0000611e@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260313121805.0000611e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/26 5:18 AM, Jonathan Cameron wrote:
> On Thu, 12 Mar 2026 02:04:23 +0530
> mhonap@nvidia.com wrote:
> 
>> From: Manish Honap <mhonap@nvidia.com>
>>
>> HDM decoder capability structure and component reg block size
>> needs to be used by VFIO subsystem. Move the macros from private
>> CXL header to public one.
>>
>> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> 
> Not really related to this patch, but...
> 
> Maybe this is the time to think about doing a PCI like
> uapi/linux/cxl_regs.h header?

Sounds reasonable. Maybe makes sense to be in uapi/cxl/? There's already a features.h header in there.

> 
> So far we have these duplicated in at least a couple of code
> bases and that is less than ideal!
> 
> Move seems fine to me otherwise.
> 
>> ---
>>  drivers/cxl/cxl.h | 30 ------------------------------
>>  include/cxl/cxl.h | 30 ++++++++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 10ddab3949ee..7146059e0dae 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -24,9 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>>   */
>>  
>> -/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
>> -#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
>> -
>>  /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
>>  #define CXL_CM_OFFSET 0x1000
>>  #define CXL_CM_CAP_HDR_OFFSET 0x0
>> @@ -39,33 +36,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>>  #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>>  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>>  
>> -/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>> -#define CXL_HDM_DECODER_CAP_OFFSET 0x0
>> -#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>> -#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>> -#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>> -#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>> -#define   CXL_HDM_DECODER_ENABLE BIT(1)
>> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
>> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
>> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
>> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
>> -#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
>> -#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
>> -#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
>> -#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
>> -#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>> -#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>> -#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>> -#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>> -#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>> -#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>> -#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>> -#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>> -
>>  /* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
>>  #define CXL_DECODER_MIN_GRANULARITY 256
>>  #define CXL_DECODER_MAX_ENCODED_IG 6
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 610711e861d4..27c006fa53c3 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -75,6 +75,36 @@ struct cxl_regs {
>>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>>  
>> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
>> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
>> +
>> +/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>> +#define CXL_HDM_DECODER_CAP_OFFSET 0x0
>> +#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>> +#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
>> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
>> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
>> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
>> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
>> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
>> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
>> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
>> +#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
>> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>> +#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>> +#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>> +#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>> +
>>  struct cxl_reg_map {
>>  	bool valid;
>>  	int id;
> 
> 

