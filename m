Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0B1CAA66
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989748; cv=none; b=oyD7JHAItqudB2od7J5rc7+BAU+pSZhpqGQ5wQGrewlRDpBrYcdgfEAgkJvNcfMYxF3bwMntEs5GKAMzJ0uuSlGXutYNAljU39qOBDHCNZXZjsYUKzwr+QJTlOkTAydHMRUgWPBUejxB/4CB/1nlDMAwM7+Uu/zB6/DUg7+esOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989748; c=relaxed/simple;
	bh=Z/Qd+BSFcKIrMoRKLM4TTkCyJI8bVBANgmjMbbrCgiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0A4L0DrPnPYdayx3G2xr3TemRpJM3PA6dtEFyDBqopjt3h1kpJl+gkkFR+ENMwXhFQ4GuvS92MoicN83YtiVLorclYIQO1gYGq49LIIXJtF49lDo/sfKZvZvh5am9xbi4y3ohf6k2xa6gPrHnE3sXFbOl7EXr2XY4FcYQmOcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JErWFQqK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JErWFQqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989746; x=1771525746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z/Qd+BSFcKIrMoRKLM4TTkCyJI8bVBANgmjMbbrCgiY=;
  b=JErWFQqKZR63HPAdhJ274pEMKV46Zlw4EDzUaZTUX2PehjodRzGUF0mh
   PjY/olClO8zg/iIS3OtXzT1gjcjyKrwxOG7eaH1QnpcnQGsd7212E2C2w
   xfgQfzIB2MT00TRip8fHkKMp2p00EQSsR9TqGVAFpgIOIN+qd9EMfR8zR
   opiBECWHFa+zNiYtvuixTF3GSWsmHcNRCdsRafGmSGddF3FrCNyNk/p9K
   1eXshR5Dpsnk7FRfNgXcCcZtLLFx5vjOkMMXq2DDBpfSPp1iVBYvRyU8B
   5zildnfAnksIjr/ONfZLKE6i03fjq5tK+eGebocpda3VvPcMQrdUhDrC6
   w==;
X-CSE-ConnectionGUID: W47Fb7FCRAW9kTxLEvCoDg==
X-CSE-MsgGUID: VfoFLa7HSLO63LxLTyD9sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40865556"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40865556"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:29:06 -0800
X-CSE-ConnectionGUID: CgY5cLgyReuyrsZo2VWVLg==
X-CSE-MsgGUID: ryfcPS+oSQGg3hF/pBqWCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114736795"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:29:06 -0800
Message-ID: <a56e2a95-fa06-4815-9ef7-5f29462aec45@intel.com>
Date: Wed, 19 Feb 2025 11:29:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] cxl: Add support for fwctl RPC command to enable
 CXL feature commands
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, saeed@kernel.org
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-10-dave.jiang@intel.com>
 <20250219175312.000070ec@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219175312.000070ec@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/25 10:53 AM, Jonathan Cameron wrote:
> On Tue, 18 Feb 2025 15:54:38 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
>> to a device. The cxl fwctl driver will start by supporting the CXL
>> Feature commands: Get Supported Features, Get Feature, and Set Feature.
>>
>> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
>> it indicates the security scope of the call. The Get Supported Features
>> and Get Feature calls can be executed with the scope of
>> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
>> of the Feature reported by Get Supported Features call for the specific
>> Feature.
>>
>> Only "Get Supported Features" is supported in this patch. Additional
>> commands will be added in follow on patches. "Get Supported Features"
>> will filter the Features that are exclusive to the kernel. The flag
>> field of the Feature details will be cleared of the "Changeable"
>> field and the "set feat size" will be set to 0 to indicate that
>> the feature is not changeable.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Hi Dave,
> 
> I'm probably missing something but I don't understand the need for
> __DECLARE_FLEXIBLE_ARRAY() in the unions.  We always seem to use one of
> the structs (some of which have trailing flexible arrays).

There are some usages. I probably should move the addition of that to the said patch. For example, feature data output is a byte stream. 

> 
> 
>> ---
>> v6:
>> - Embed hw op in 'fwctl_rpc_cxl'. (Saeed, Jason)
>> - Move set_features bits to set_features enabling patch. (Saeed)
>> - Fix copyright years. (Jason)
>> ---
>>  drivers/cxl/core/features.c | 121 +++++++++++++++++++++++++++++++++++-
>>  include/uapi/cxl/features.h |   1 +
>>  include/uapi/fwctl/cxl.h    |  57 +++++++++++++++++
>>  3 files changed, 177 insertions(+), 2 deletions(-)
>>  create mode 100644 include/uapi/fwctl/cxl.h
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index 846de3294a5e..106ea9e25c82 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/device.h>
>>  #include <cxl/mailbox.h>
>>  #include <cxl/features.h>
>> +#include <uapi/fwctl/cxl.h>
>>  #include "cxl.h"
>>  #include "core.h"
>>  #include "cxlmem.h"
>> @@ -349,11 +350,127 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
>>  {
>>  }
>>  
>> +static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>> +					   const struct fwctl_rpc_cxl *rpc_in,
>> +					   size_t *out_len)
>> +{
>> +	const struct cxl_mbox_get_sup_feats_in *feat_in;
>> +	struct cxl_mbox_get_sup_feats_out *feat_out;
>> +	struct cxl_feat_entry *pos;
>> +	size_t out_size;
>> +	int requested;
>> +	u32 count;
>> +	u16 start;
>> +	int i;
>> +
>> +	if (rpc_in->op_size != sizeof(*feat_in))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	feat_in = &rpc_in->get_sup_feats_in;
>> +	count = le32_to_cpu(feat_in->count);
>> +	start = le16_to_cpu(feat_in->start_idx);
>> +	requested = count / sizeof(*pos);
>> +
>> +	/*
>> +	 * Make sure that the total requested number of entries is not greater
>> +	 * than the total number of supported features allowed for userspace.
>> +	 */
>> +	if (start >= cxlfs->entries->num_features)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	requested = min_t(int, requested, cxlfs->entries->num_features - start);
>> +
>> +	out_size = sizeof(struct fwctl_rpc_cxl_out) +
>> +		struct_size(feat_out, ents, requested);
>> +
>> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>> +		kvzalloc(out_size, GFP_KERNEL);
>> +	if (!rpc_out)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rpc_out->size = struct_size(feat_out, ents, requested);
>> +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
> 
> Why not, 
> 
> 	feat_out = rpc_out->get_sup_feats_out;
> ?

I missed that one during refactoring.

> 
> 
>> +	if (requested == 0) {
>> +		feat_out->num_entries = cpu_to_le16(requested);
>> +		feat_out->supported_feats =
>> +			cpu_to_le16(cxlfs->entries->num_features);
>> +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>> +		*out_len = out_size;
>> +		return no_free_ptr(rpc_out);
>> +	}
>> +
>> +	for (i = start, pos = &feat_out->ents[0];
>> +	     i < cxlfs->entries->num_features; i++, pos++) {
>> +		if (i - start == requested)
>> +			break;
>> +
>> +		memcpy(pos, &cxlfs->entries->ent[i], sizeof(*pos));
>> +		/*
>> +		 * If the feature is exclusive, set the set_feat_size to 0 to
>> +		 * indicate that the feature is not changeable.
>> +		 */
>> +		if (is_cxl_feature_exclusive(pos)) {
>> +			u32 flags;
>> +
>> +			pos->set_feat_size = 0;
>> +			flags = le32_to_cpu(pos->flags);
>> +			flags &= ~CXL_FEATURE_F_CHANGEABLE;
>> +			pos->flags = cpu_to_le32(flags);
>> +		}
>> +	}
>> +
>> +	feat_out->num_entries = cpu_to_le16(requested);
>> +	feat_out->supported_feats = cpu_to_le16(cxlfs->entries->num_features);
>> +	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>> +	*out_len = out_size;
>> +
>> +	return no_free_ptr(rpc_out);
>> +}
> 
>> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
>> new file mode 100644
>> index 000000000000..39996ec56816
>> --- /dev/null
>> +++ b/include/uapi/fwctl/cxl.h
>> @@ -0,0 +1,57 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) 2024-2025 Intel Corporation
>> + *
>> + * These are definitions for the mailbox command interface of CXL subsystem.
>> + */
>> +#ifndef _UAPI_FWCTL_CXL_H_
>> +#define _UAPI_FWCTL_CXL_H_
>> +
>> +#include <linux/types.h>
>> +#include <linux/stddef.h>
>> +#include <cxl/features.h>
>> +
>> +struct cxl_mbox_get_sup_feats_in;
>> +struct cxl_mbox_get_sup_feats_out;
> 
> These are defined now in uapi/cxl/features.h anyway so why is forwards
> def needed?

I'll drop those.

> 
>> +
>> +/**
>> + * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
>> + * @opcode: CXL mailbox command opcode
>> + * @flags: Flags for the command (input).
>> + * @op_size: Size of input payload.
>> + * @reserved1: Reserved. Must be 0s.
>> + * @get_sup_feats_in: Get Supported Features input
>> + * @op: hardware operation input byte array
>> + */
>> +struct fwctl_rpc_cxl {
>> +	__struct_group(fwctl_rpc_cxl_hdr, hdr, /* no attrs */,
>> +		__u32 opcode;
>> +		__u32 flags;
>> +		__u32 op_size;
>> +		__u32 reserved1;
>> +	);
>> +	union {
>> +		struct cxl_mbox_get_sup_feats_in get_sup_feats_in;
>> +		__DECLARE_FLEX_ARRAY(__u8, op);
> 
> Similar to below. op isn't used in this patch that I can see.
> Is it just here so it's obvious what op_size refers to?

Yes. and also I cast it to the feature uuid field as the common header. But I can move this addition to the get_feature enabling.

> 
>> +	};
>> +};
>> +
>> +/**
>> + * struct fwctl_rpc_cxl_out - ioctl(FWCTL_RPC) output for CXL
>> + * @size: Size of the output payload
>> + * @retval: Return value from device
>> + * @get_sup_feats_out: Get Supported Features output
>> + * @payload: Return data from device
>> + */
>> +struct fwctl_rpc_cxl_out {
>> +	__struct_group(fwctl_rpc_cxl_out_hdr, hdr, /* no attrs */,
>> +		__u32 size;
>> +		__u32 retval;
>> +	);
>> +	union {
>> +		struct cxl_mbox_get_sup_feats_out get_sup_feats_out;
>> +		__DECLARE_FLEX_ARRAY(__u8, payload);
> 
> I this patch I don't see a particular use for payload other
> than where I've noted I think you can use get_sup_feats_out
> directly.

The get_feature has a byte stream for feature data as output. It's also convenient for the user app to access the feature data.  

> 
>> +	};
>> +};
>> +
>> +#endif
> 

