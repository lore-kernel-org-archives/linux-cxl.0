Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8F25B676
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209862; cv=none; b=PWQhrtYYzNOUBA3ciXYsuGIC6Rm+kQU5fBXBMLyEEofw4eNX/CAaLYUqAUvTKYdatRVCK/OOgrWd27a2V9ciykV9R3Ym4NGDmlCOD1c6XmiMasM3/Pd2K4OkOsdu0cxgKa/Xvy1xNPAHC5CfpCnZ3VlABs+KfugcTkJzP1QhQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209862; c=relaxed/simple;
	bh=WdwetryGiwWUL5gYFvFIkRjj3GJ7ymbwu4v7hxmUILI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UByPZqXWurIL+2zSkwE8X6FuGklvWJp1JtoOnkQVStWUNjXtQ/DDbMCvPxAUcb7gbBytTT3s/F6tmqvPU+TGXf5HdyCI65Z53MrHdRJUChVGaPvXAF3XUFB0MJzwo1xG/PTg5QtjD4YARR0ry+YNMZAlNFSLpY1RD214348CutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjWeGyHQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjWeGyHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739209860; x=1770745860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WdwetryGiwWUL5gYFvFIkRjj3GJ7ymbwu4v7hxmUILI=;
  b=YjWeGyHQYv5thyfOgqPKO5xKyBBMv7MTuesU9kzx0p6kWOmRGEp3jlTH
   JNpE5/PKZeGH+SoZ8iEi0nUOL6QdW+YdRmksNJEXr5f4XXgpttTMSPFLg
   H5IWLI/nqvVJNtTiIb1OgKtXrp/c3Ma2SpUP8v/mXRXJsjkaIXkebgkMk
   QL3+08AnCzXpbGgUXi4sgRhQvoq+9x8T0wbHDZ7Lo6CXgBenhDAQk4NxV
   m+pcMEW0vpbh6KIYwAy9mxS8uHriQ0Api7m98o7baPi2HVoVgPksTNndw
   L3U4myQgCegCfevMvWS8Bysd6FJfPxK487YG+YJxnhnS5EdTLi5f2QdhS
   g==;
X-CSE-ConnectionGUID: tf47ynJeRw+ToJEcX7f5MQ==
X-CSE-MsgGUID: Ayydgr5RSHSqrgmQh1mWBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39951973"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39951973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:51:00 -0800
X-CSE-ConnectionGUID: 9/n0qTjgR62V/kBv9TEvIA==
X-CSE-MsgGUID: drQLc4a3R7KpKZXeYmZpCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113135496"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:50:58 -0800
Message-ID: <d991ca86-2e0b-46e5-80af-e922d38d20ab@intel.com>
Date: Mon, 10 Feb 2025 10:50:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] cxl: Setup exclusive CXL features that are
 reserved for the kernel
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-7-dave.jiang@intel.com>
 <7c6c904c-4045-4b5b-8c31-99e3fd971515@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7c6c904c-4045-4b5b-8c31-99e3fd971515@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/7/25 11:22 PM, Li Ming wrote:
> On 2/8/2025 7:37 AM, Dave Jiang wrote:
>> Certain features will be exclusively used by components such as in
>> kernel RAS driver. Setup an exclusion list that can be later filtered
>> out before exposing to user space.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/features.c | 26 ++++++++++++++++++++++++++
>>  include/cxl/features.h      | 34 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index d337224158fa..82f21f64452a 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -6,6 +6,28 @@
>>  #include "cxl.h"
>>  #include "cxlmem.h"
>>  
>> +/* All the features below are exclusive to the kernel */
>> +static const uuid_t cxl_exclusive_feats[] = {
>> +	CXL_FEAT_PATROL_SCRUB_UUID,
>> +	CXL_FEAT_ECS_UUID,
>> +	CXL_FEAT_SPPR_UUID,
>> +	CXL_FEAT_HPPR_UUID,
>> +	CXL_FEAT_CACHELINE_SPARING_UUID,
>> +	CXL_FEAT_ROW_SPARING_UUID,
>> +	CXL_FEAT_BANK_SPARING_UUID,
>> +	CXL_FEAT_RANK_SPARING_UUID,
>> +};
>> +
>> +static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
>> +{
>> +	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
>> +		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>>  {
>>  	return cxlds->cxlfs;
>> @@ -46,6 +68,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
>>  	struct cxl_mbox_get_sup_feats_in mbox_in;
>>  	struct cxl_feat_entry *entry;
>>  	struct cxl_mbox_cmd mbox_cmd;
>> +	int user_feats = 0;
>>  	int count;
>>  
>>  	count = cxl_get_supported_features_count(cxl_mbox);
>> @@ -120,6 +143,8 @@ get_supported_features(struct cxl_features_state *cxlfs)
>>  			return NULL;
>>  
>>  		memcpy(entry, mbox_out->ents, retrieved);

While you are pointing out the issue with copying multiple entries, I noticed that this needs to be fixed in patch2 as well. It should be:
memcpy(entry, mbox_out->ents + start, retrieved);

DJ

>> +		if (!is_cxl_feature_exclusive(entry))
>> +			user_feats++;
> 
> I guess that here should check all entries copied from mbox_out->ents, so it should be
> 
> 
> for (int i = 0; i < num_entries; i++)
> 
>     if (!is_cxl_feature_exclusive(entry + i))
> 
>         user_feats++;
> 
> 
> Other looks good to me.
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> 
>>  		entry += num_entries;
>>  		/*
>>  		 * If the number of output entries is less than expected, add the
>> @@ -130,6 +155,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
>>  	} while (remain_feats);
>>  
>>  	entries->num_features = count;
>> +	entries->num_user_features = user_feats;
>>  
>>  	return no_free_ptr(entries);
>>  }

