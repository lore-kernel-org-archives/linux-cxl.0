Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B007202C4A
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624998; cv=none; b=gkWD0CEY57vp138GDZWtodORxeTGTQBEXyMPr17GTanfrfsZpapC4TAEVddoHrN771I538W7kqi+IYuCtdW8G99b6zbFocc4oKBvQ4vTdys1lSwvnaR+jCvZnq95to94fiPr+EcgmRZBvFEF8yM09MK+anOhjCzMF4zZzAcQiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624998; c=relaxed/simple;
	bh=t6IZR/5hDH4zVVW3LqhTDWa9YwL3e98J7XLDtF6uBLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U40fOBGQj2y4/Yrh+zkM1XwghovSPMA17i7pU4b2/+OP/IMPB0vC8+wPF2JCWFl/Qm8lwyDRaQ3+lSLcpRwBXwzDH34IQFK3+xQFf7ZjmmVWNudP370vQsTF/l6qpm6E7SOCjzVAoCdPA0KkZRE80qPtX5dXrsAlzTsYJxj42gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIXQopcp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIXQopcp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738624996; x=1770160996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t6IZR/5hDH4zVVW3LqhTDWa9YwL3e98J7XLDtF6uBLc=;
  b=OIXQopcp0BaUnI9eJVNv3//ajLZSA/AOQnbYL6z1rrMe/hCrcgGU5myS
   nR5Fd3pYogKbto0rRTBEqggdTDmkx40vP6mh+mrk4YrAsZqqO7J3z923C
   6vVxLTQMtBUPxr9NfCvIz0nQmHY5zyMklXQ0RaGsIEuJ41rK82uxnl8zc
   Wgw94Yr5mUrs+ZatEs9zLVBz/VdFESeKtljyw6/pvM+sbtq1fiTvfHBIj
   sj0jpjLJn4ZB1hCcl1S249VF62mOH3Q6Hk2cEz6eIKfJr/lZSzVRMUbsH
   SYqbLUyhJW6SrdJORNywBGseXLdjnhdm8KS/GlyGfKclmmrahtw6axN9f
   g==;
X-CSE-ConnectionGUID: kAUN6E50SeS3bHc06f2f0w==
X-CSE-MsgGUID: tdOqe9+9SaCmVCQlk2MLaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="26738962"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="26738962"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 15:23:15 -0800
X-CSE-ConnectionGUID: LWXk06mQTFKeVH8XQBNuSA==
X-CSE-MsgGUID: kN86Np1CRc68A1evDzdDKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114457226"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.215]) ([10.125.109.215])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 15:23:14 -0800
Message-ID: <1590e950-a4e3-49aa-b234-d9a776bce196@intel.com>
Date: Mon, 3 Feb 2025 16:23:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] cxl: Enumerate feature commands
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250201004459.466499-1-dave.jiang@intel.com>
 <20250201004459.466499-3-dave.jiang@intel.com>
 <20250203120607.0000606a@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250203120607.0000606a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/25 5:06 AM, Jonathan Cameron wrote:
> On Fri, 31 Jan 2025 17:41:55 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add feature commands enumeration code in order to detect and enumerate
>> the 3 feature related commands "get supported features", "get feature",
>> and "set feature". The enumeration will help determine whether the driver
>> can issue any of the 3 commands to the device.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Setup allocation of cxlfs and move enumeration of commands to
>>   the setup function.
>> - Introduce features_capability enum. (Dan)
>> - Name the setup function devm_cxl_add_features(). (Dan)
>> - Drop 'cxl_mem_command' support. (Dan)
>> - Move feature support to mem probe. (Dan)
>> - Remove comma at last entry of data structs. (Jonathan)
> Got carried away on this one.   Only drop them for termination
> entries.  So MAX or NULL or similar.
> 
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index bdb8f060f2c1..25fb7bd770b3 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -69,6 +69,29 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>>  };
>>  
>> +static u16 cxl_feature_commands[] = {
>> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>> +	CXL_MBOX_OP_GET_FEATURE,
>> +	CXL_MBOX_OP_SET_FEATURE
> 
> This one does want a trailing comma. Might be more feature commands in future.

ok

> 
>> +};
> 
>> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
>> new file mode 100644
>> index 000000000000..13b0b29ee102
>> --- /dev/null
>> +++ b/drivers/cxl/features.c
>> @@ -0,0 +1,55 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
>> +#include <linux/device.h>
>> +#include <cxl/mailbox.h>
>> +#include <cxl/features.h>
>> +#include "cxl.h"
>> +#include "cxlmem.h"
>> +#include "features.h"
>> +
>> +static void enumerate_feature_cmds(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>> +	struct cxl_features_state *cxlfs = cxlds->cxlmd->cxlfs;
> Going in circles?
> 	cxlmd->cxlfs;

yeah oops. should be cleaned up with the other changes going on in this patch

> 
> 
>> +	int fid;
>> +
>> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
>> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
>> +		return;
>> +
>> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_FEATURE);
>> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
>> +		return;
>> +
>> +	cxlfs->cap = CXL_FEATURES_RO;
>> +
>> +	fid = cxl_get_feature_command_id(CXL_MBOX_OP_SET_FEATURE);
>> +	if (!test_bit(fid, cxl_mbox->feature_cmds))
>> +		return;
>> +
>> +	cxlfs->cap = CXL_FEATURES_RW;
>> +}
>> +
>> +/**
>> + * devm_cxl_add_features() - Allocate and initialize features context
>> + * @cxlmd: CXL memory device
>> + *
>> + * Return 0 on success or -errno on failure.
>> + */
>> +int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_features_state *cxlfs;
>> +	struct device *dev = &cxlmd->dev;
>> +
>> +	cxlfs = devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);
>> +	if (!cxlfs)
>> +		return -ENOMEM;
>> +
>> +	cxlmd->cxlfs = cxlfs;
> 
> So I was curious about this one and why we leave the pointer
> hanging in the remove path + whether the two way pointer nest
> is needed.
> 
> That gets dealt with in patch 8.
> 
> I'd be tempted to drag the bones of dev_cxlfs_allocate() to this
> patch so that you can do that cleanup now and avoid some of the churn
> of the later patches.

ok I'll do that. 

> 
> As for the two way pointer nest. I'm not sure it is needed.
> Seems like most if not all places we use cxlmd->cxlfs have
> just gotten it in the caller from cxlfs->cxlmd.
> e.g. cxl_cxlfs_free() in patch 8. For here we could
> just pass it into enumerate_feature_cmds.
> 
> Maybe Shiju's set needs it. I haven't checked.

I think he does with calling of cxl_get_supported_feature_entry(). Need a way to go from cxlmd to cxlfs.
> 
> 
> 
> 
>> +	cxlfs->cxlmd = cxlmd;
>> +	enumerate_feature_cmds(cxlmd);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");
> 
>> diff --git a/include/cxl/features.h b/include/cxl/features.h
>> new file mode 100644
>> index 000000000000..eadf0d56553f
>> --- /dev/null
>> +++ b/include/cxl/features.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2024-2025 Intel Corporation. */
>> +#ifndef __CXL_FEATURES_H__
>> +#define __CXL_FEATURES_H__
>> +
>> +struct cxl_mailbox;
>> +
>> +/* Index IDs for CXL mailbox Feature commands */
>> +enum feature_cmds {
>> +	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
>> +	CXL_FEATURE_ID_GET_FEATURE,
>> +	CXL_FEATURE_ID_SET_FEATURE,
>> +	CXL_FEATURE_ID_MAX
>> +};
>> +
>> +/* Feature commands capability supported by a device */
>> +enum cxl_features_capability {
>> +	CXL_FEATURES_NONE = 0,
>> +	CXL_FEATURES_RO,
>> +	CXL_FEATURES_RW
> 
> Trivial but this one should have a trailing comma.  Maybe
> we'll have a write only one!  Anyhow, it's not a terminating
> entry so we shouldn't assume nothing comes after it.

ok

> 
>> +};
>> +
>> +/**
>> + * struct cxl_features_state - The Features state for the device
>> + * @cxlmd: Pointer to cxl mem device
>> + * @cap: Feature commands capability
>> + * @num_features: total Features supported by the device
>> + */
>> +struct cxl_features_state {
>> +	struct cxl_memdev *cxlmd;
>> +	enum cxl_features_capability cap;
>> +	int num_features;
>> +};
>> +
>> +#endif
> 

