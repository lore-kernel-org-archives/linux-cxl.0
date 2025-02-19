Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1B214A6E
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989904; cv=none; b=PDFleP8fs9XjiI2Kdzet7gBLsvLMMobpBUv39fLSunTAWD9jsfP5NtaBX1fJVhTzAUICwrsEjgqba6yoiVklhzayljbwrlnPrfFP0POplY72hOaeF/XwWTkBneXsRpc7grBIUQ1SSM8ZIJnB83fjNL8HJyaDDV7yZq4xZC+gxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989904; c=relaxed/simple;
	bh=16X3AS33GxOnhNDsphjBiATi7YIlDXzRIAonQoWj5xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l75wLvtqaBZ5ZG/GkEFEZhZTSSyJfnQwMLT4iR+Q3NnaDsLgSJ68qvtlAumSIrvsUyyN9MGplvGRbuTYM6/QRv/+BjruB73xOhKWxlerHlkKths1xRSf/lHGWCfhZV5622yBnw0hR90E8/0DUJGSLe3xKWqBAIwHfDfacVG6XFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq3P13lf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq3P13lf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989902; x=1771525902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=16X3AS33GxOnhNDsphjBiATi7YIlDXzRIAonQoWj5xQ=;
  b=Bq3P13lfiKZah2hwXN8HdQOH7p/N9aKdlqZig052qDCKSoh7nIIVlwK/
   kpYn5KS4LrEb1naDiWcaYh/1YOO/NW1ISXW5V7kDUM7p9RJm1t6PHxZmG
   QikzyrTyUmiBFFeSzpcc7+yPItB9veKwIr5PfaKnOVVfu0tDSrtkiNfv1
   OnMSBSqHwqCnH3sDDRGhT7mcHsA7aHg1jsTaug++c/XIVAWW2jxn4i1eK
   knYYejfpGnzimY+QHAOOeIEB0djgMSA5QdMdNxIFsUN7GCHJmNE9iACPR
   VCAF417gcGKcr+wSd+mCahNcEyYMrzgR+baWzZWRYmCTX5kECuV8Ye7Ie
   g==;
X-CSE-ConnectionGUID: YEZPfydiQNuEF0iU/S6c8g==
X-CSE-MsgGUID: GPQtAR39SSyXPXpicudPUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40865942"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40865942"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:31:39 -0800
X-CSE-ConnectionGUID: sy7ZXgv9RLm0dDiJhdV7Vw==
X-CSE-MsgGUID: PjBFaouiSYiKpg01FgTOUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114737910"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:31:39 -0800
Message-ID: <4383f662-750d-402f-ab7b-1fba68525cf6@intel.com>
Date: Wed, 19 Feb 2025 11:31:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/14] cxl: Add support to handle user feature commands
 for set feature
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, saeed@kernel.org,
 Li Ming <ming.li@zohomail.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-12-dave.jiang@intel.com>
 <20250219181202.00003ed3@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219181202.00003ed3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/25 11:12 AM, Jonathan Cameron wrote:
> On Tue, 18 Feb 2025 15:54:40 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add helper function to parse the user data from fwctl RPC ioctl and
>> send the parsed input parameters to cxl_set_feature() call.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v6:
>> - Add set features bits checking bits from two patches ago. (Saeed)
>> - Adjust for embedded input payload
> 
> Follow on from earlier.  Now I see where op is used.
> I think we can do better however.
> 
>>  
>> +static struct cxl_feat_entry *
>> +get_support_feature_info(struct cxl_features_state *cxlfs,
>> +			 const struct fwctl_rpc_cxl *rpc_in)
>> +{
>> +	struct cxl_feat_entry *feat;
>> +	uuid_t *uuid;
>> +
>> +	if (rpc_in->op_size < sizeof(uuid))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	uuid = (uuid_t *)rpc_in->op;
> 
> hmm. So here you use the op, but we know this a set features, so
> much like in previous patch we could use
> 
> rpc_in->set_feat_in->uuid
> 
> That is relying on the fact we know this is being called on a
> set feature which the name doesn't imply. So maybe rename?
> 
> Or.. check rpc_in->opcode and grab it from rpc_in->get_feat_in->uuid or
> rpc_in->set_feat_in->uuid as appropriate.
> and error out on anything else as we don't 'know' for sure there
> is a uuid at that location.

Yes that makes sense. I'll drop the flex array in the input data struct. 

> 
>> +
>> +	for (int i = 0; i < cxlfs->entries->num_features; i++) {
>> +		feat = &cxlfs->entries->ent[i];
>> +		if (uuid_equal(uuid, &feat->uuid))
>> +			return feat;
>> +	}
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
> 
> 
> 

