Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C142500BA
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209263; cv=none; b=RITyMUYAzZGsGwVhw0ChXum90pYblip9qnT6HDlAb032ccK6BxITR3FwJFIhNqpfxAPKGm2u03I9aeMHbLOhno89wqsD9CyWU1hJcIDQ3LxghZGq5t2RtD8FYWwWMMI9Hd16F6o1RU0u+GYaZ1ryi44KF+f/BTQ99J8JC0c7bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209263; c=relaxed/simple;
	bh=X9GPSv4uWfq9tjTMX40JYp455H7jI5YDbzkZbPGlJlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNQGkkr6hTdyGwbIDVOrS6DDS6iBqVqEPq6LNWYObv61jJEOdLySyulA59iuJ1Rs6FjAEoQ+u2L392bbIvsE4oZv9IWKkJo9XJP7+IKo//AWlqcRLSlMbnQ3dx7TiPJVpm9beugRAKZR0JC3p8MdDHAClITPomxNi15bXHJrkwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhX4VDjd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhX4VDjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739209262; x=1770745262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X9GPSv4uWfq9tjTMX40JYp455H7jI5YDbzkZbPGlJlw=;
  b=RhX4VDjdkzexSLOKCmw/w8HVxcXNqdPPq88DA1TLRZPpcUGxq/Q6G6FV
   yHW2lnJDOUVU6UytFupnV75hacwfurplJg/ON+AI/heeYfLvOBrkkDaW2
   zjjtdsEpDh1YbPx8BAP0o5/hjVSg3Mw1/Nx7om3UzKxAyYLUi4ZP3DHtL
   Raprg0Kvl1AZaQLGAb+LZqXS7xzJYqnAMNIVO+DsxDT/F3KnOfNcL2wiz
   /d73H0hBxsRW1aPMeLZeCooZud1SF1iUNpy8hp0vMijG7AJLpJtJebQgT
   gbdQPs7eTj6Ioj+X1iASpa4uc8yQo+m7F2fsnirNqLkM92X14YXvQ6ftY
   Q==;
X-CSE-ConnectionGUID: W0ULl5PDQfG5GBpC/rns8Q==
X-CSE-MsgGUID: 2F/G1DBsTPa0i7v7QMOqwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="62276987"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="62276987"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:41:01 -0800
X-CSE-ConnectionGUID: Cwcx7ue7T4CTIQwT2/tS+Q==
X-CSE-MsgGUID: leGL293kTQGB/nWrEYHv2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="117332343"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:41:00 -0800
Message-ID: <9e38ddd1-b4ff-4c20-a1e9-76bc94f35e48@intel.com>
Date: Mon, 10 Feb 2025 10:40:58 -0700
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

Yes I'll fix. The copying multiple entries really threw everything off. Thanks for the catch.

DJ

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

