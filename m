Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A967FD
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jan 2025 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109649; cv=none; b=WzMoSggHisQgw2v2wGO0uFhcOnZ6RgQW4aEfELyIvxuPeYZ3kxtBHAll+3AHQLmemDtqgeIjqyAQBobdApiVzR/Mnl/TseNAvB9iLoUgwhywjylN7FARqBb4GeAj+TKhTuapbZ3a4yyJnvGmlaGGwhDAJmEJCzgPT1tc1rFL56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109649; c=relaxed/simple;
	bh=+e1jmvnDv4lOAeWaZu2D+ab1lMM7oY4X5FZMzj9xo1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMH7vVvU3eQyYxmhIGacjU3j2JEBBDEqSdQjC9pzA0Q+pwohnaBwrhwKH3UclLLECGguD5K6fDMHyaBTQVUOwvjR0qvUuKccfoIGdGoLqs6eIEPIb2pVPTxNwo7x3M4oXCpxB4uHNSR3aVP5oTaWE/ax/TMzcZI+QR6mvlr4O6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlZI6jul; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlZI6jul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738109648; x=1769645648;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+e1jmvnDv4lOAeWaZu2D+ab1lMM7oY4X5FZMzj9xo1I=;
  b=PlZI6julC4sItCBcKfHnGtV9Jj3Xhx3+YA4Nv825mFW10PbbLPbu5puC
   YRg4mhrCcgs1NXwfQDRRMKF1YiBKis+NIhTUFLosy5zyM+hw0pEISkBz9
   SauLXCVCRW9A6s//W2LbAIKQDc+GI90Spe/3SP5R1v3XHqbLzsZ+GSr4r
   je6Dw6l+B0qOnQNAN3h8Medr1TGeM5gHjPYQiStTeEpAnK+gIbld+kJac
   Vkdi67fcM7GBkDZ84yaJ5ddMXomIKUBdaN2vHh93wPhJJJN4UprRBXW0q
   CZS0n/tDbo4CHXAHJaUTWNpbP1mIyEoDI4RPwSsmDNSEQu/F6CjvUlSwR
   Q==;
X-CSE-ConnectionGUID: /zxZkgkmSgO1zZ93GboxDQ==
X-CSE-MsgGUID: QmH7N4c6TtikZmoSQ10WeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="41451698"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="41451698"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 16:14:07 -0800
X-CSE-ConnectionGUID: oAtfohGeTkOgZpiORT/48g==
X-CSE-MsgGUID: Wwl61OGvRRqH0w0dXZ0o0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="113884532"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.125.108.36]) ([10.125.108.36])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 16:14:06 -0800
Message-ID: <093de514-4b7a-4576-8a37-95ba7be59225@intel.com>
Date: Tue, 28 Jan 2025 17:14:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/19] cxl/mbox: Add GET_FEATURE mailbox command
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-8-dave.jiang@intel.com>
 <67941b1261dfc_20f329470@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <67941b1261dfc_20f329470@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/24/25 3:58 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for GET_FEATURE mailbox command.
>>
>> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
>> The settings of a feature can be retrieved using Get Feature command.
>> CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.
>>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v1:
>> - pass in cxl_mbox instead of cxlds (Dan)
>> - Move to the feature driver model. (Dan)
>> ---
>>  drivers/cxl/core/features.c | 74 +++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/features.c      |  6 +--
>>  include/cxl/features.h      | 27 ++++++++++++++
>>  3 files changed, 102 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index 66a4b82910e6..ab9386b53a95 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -4,6 +4,7 @@
>>  #include <cxl/mailbox.h>
>>  #include "cxl.h"
>>  #include "core.h"
>> +#include "cxlmem.h"
>>  
>>  #define CXL_FEATURE_MAX_DEVS 65536
>>  static DEFINE_IDA(cxl_features_ida);
>> @@ -97,3 +98,76 @@ cxl_get_supported_feature_entry(struct cxl_features *features,
>>  	return ERR_PTR(-ENOENT);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, "CXL");
>> +
>> +bool cxl_feature_enabled(struct cxl_features_state *cfs, u16 opcode)
>> +{
>> +	struct cxl_mailbox *cxl_mbox = cfs->features->cxl_mbox;
>> +	struct cxl_mem_command *cmd;
>> +
>> +	cmd = cxl_find_feature_command(opcode);
>> +	if (!cmd)
>> +		return false;
>> +
>> +	return test_bit(cmd->info.id, cxl_mbox->feature_cmds);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_feature_enabled, "CXL");
>> +
>> +size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
>> +		       enum cxl_get_feat_selection selection,
>> +		       void *feat_out, size_t feat_out_size, u16 offset,
> 
> Is @feat_out guaranteed to be a kernel pointer, or might it be an __user
> pointer?

@feat_out will be a kernel pointer. The way FWCTL is setup, the callback returns a kernel buffer that FWCTL core will copy out to user space and then free.

> 
> Shouldn't @feat_uuid be a 'uuid_t *' rather than a 'uuid_t'?

right. also code needs to use uuid_copy().

> 
>> +		       u16 *return_code)
>> +{
>> +	size_t data_to_rd_size, size_out;
>> +	struct cxl_features_state *cfs;
>> +	struct cxl_mbox_get_feat_in pi;
>> +	struct cxl_mailbox *cxl_mbox;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	size_t data_rcvd_size = 0;
>> +	int rc;
>> +
>> +	if (return_code)
>> +		*return_code = CXL_MBOX_CMD_RC_INPUT;
>> +
>> +	cfs = dev_get_drvdata(&features->dev);
>> +	if (!cfs)
>> +		return 0;
>> +
>> +	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_GET_FEATURE))
>> +		return 0;
> 
> Per previous feedback, just make the caller responsible for knowing this
> in advance, not checking every call. With that gone this function loses
> its dependency on 'struct cxl_features' and 'struct cxl_features_state'
> and can take 'struct cxl_mbox' directly.
> 
> If for some reason the caller did not know that Get Feature was missing
> the device will still fail it anyway, so that boilerplate is not serving
> any useful purpose.

ok

