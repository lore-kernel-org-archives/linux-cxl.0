Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071D372
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973032; cv=none; b=EXGApvKdXqxQX+ruJ2aqgB7Q7v2NNFvJ+eaomZZUGfcI0n65LYuL8JxpJAvDj6629ZN7wBR0lS7DK0MEpqKS59x1CuWCIkQrLbqoXh0gXqZ34vo6EF9WalY0h6DFyHqPeEjR80r/3VH6kIdD7Ojf/vo4t3JwbJ0j00QbW/Tvzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973032; c=relaxed/simple;
	bh=8y0mh5C0clRXY6IsnBI51ubkEG/b/iJdzrDLUMyvdn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF1fi+D9E2QfqrnSiOz2gzHWdByO2+G8RXmizmEgQGxet66nHV9NxmhKgf9nxmnp4O9WSTsuU0+NHXCc/OBZb5lo23Cvh32liRshx+n9JHgK3CxJRkAr54EIYd8egmwnlmtF2J2wsYws10XXj1dwqpjTkpC23p/IlOjC4eqaGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFepMyBX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFepMyBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738973031; x=1770509031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8y0mh5C0clRXY6IsnBI51ubkEG/b/iJdzrDLUMyvdn4=;
  b=FFepMyBXNEgQQmKPv45GXi0LvPO7/GCfmN6CvPJZ99WhwkCZdy64IMw6
   IICgS7Qu6sO0V6KSGi4rDNfUiKw6vVGcSXdxwr3aEpahn7ZcOp5L3j+/w
   ft6kcHlMtlG/Ql930P5xxy0CLqvRxMQwfDge3IbECca5lVGswDuSE/V4H
   okQ6CrvmWDdFfxVlxFwU8ytFCPvRjpuWsA0HPh4NNosC4QWxmxsOVLUT9
   GVHTOY+ZTMCsSCMuKvm16OHCFbXhxsg6jBSl34BcAtxYPgAGWA/+qmpqf
   aJK1DJRFTgo8iobdhuDSwNiAzVfvl13wxI8pA1lEFiuWOlBk0TcJR/esI
   g==;
X-CSE-ConnectionGUID: xvCAKyjbQh2g1JeCY+ZmLw==
X-CSE-MsgGUID: hqRblRa0Q5uxBdDjVYaeuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42468301"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42468301"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:03:50 -0800
X-CSE-ConnectionGUID: SNJXb3ipTkeJaLJh7MydYw==
X-CSE-MsgGUID: h9gPYymoTy6RcaSmMkAuBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134899719"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:03:49 -0800
Message-ID: <aba6711d-5b11-49a2-b22b-99ef51b4c60a@intel.com>
Date: Fri, 7 Feb 2025 17:03:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/16] cxl: Add Get Supported Features command for
 kernel usage
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-4-dave.jiang@intel.com>
 <94a52a5d-5b71-43b2-ae1f-49745bfa3416@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <94a52a5d-5b71-43b2-ae1f-49745bfa3416@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 10:42 PM, Li Ming wrote:
> On 2/5/2025 6:03 AM, Dave Jiang wrote:
>> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
>> The command retrieve the list of supported device-specific features
>> (identified by UUID) and general information about each Feature.
>>
>> The driver will retrieve the feature entries in order to make checks and
>> provide information for the Get Feature and Set Feature command. One of
>> the main piece of information retrieved are the effects a Set Feature
>> command would have for a particular feature.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Use struct_size() instead of open coding the calculation. (Jonathan)
>> ---
>>  drivers/cxl/features.c | 138 +++++++++++++++++++++++++++++++++++++++++
>>  include/cxl/features.h |  57 +++++++++++++++++
>>  2 files changed, 195 insertions(+)
>>
>> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
>> index 958e4828a58d..4d8c603121f0 100644
>> --- a/drivers/cxl/features.c
>> +++ b/drivers/cxl/features.c
>> @@ -7,6 +7,139 @@
> [...]
>> +static int get_supported_features(struct cxl_memdev *cxlmd,
>> +				  struct cxl_features_state *cxlfs)
>> +{
>> +	int remain_feats, max_size, max_feats, start, rc, hdr_size;
>> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>> +	int feat_size = sizeof(struct cxl_feat_entry);
>> +	struct cxl_mbox_get_sup_feats_in mbox_in;
>> +	struct cxl_feat_entry *entry;
>> +	struct cxl_mbox_cmd mbox_cmd;
>> +	int count;
>> +
>> +	if (cxlfs->cap < CXL_FEATURES_RO)
>> +		return -EOPNOTSUPP;
>> +
>> +	count = cxl_get_supported_features_count(cxl_mbox);
>> +	if (count == 0)
>> +		return -ENOENT;
>> +	if (count < 0)
>> +		return -ENXIO;
>> +
>> +	struct cxl_feat_entry *entries __free(kvfree) =
>> +		kvmalloc(count * sizeof(*entries), GFP_KERNEL);
>> +	if (!entries)
>> +		return -ENOMEM;
>> +
>> +	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
>> +		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>> +	if (!mbox_out)
>> +		return -ENOMEM;
>> +
>> +	hdr_size = struct_size(mbox_out, ents, 0);
>> +	max_size = cxl_mbox->payload_size - hdr_size;
>> +	/* max feat entries that can fit in mailbox max payload size */
>> +	max_feats = max_size / feat_size;
>> +	entry = entries;
>> +
>> +	start = 0;
>> +	remain_feats = count;
>> +	do {
>> +		int retrieved, alloc_size, copy_feats;
>> +		int num_entries;
>> +
>> +		if (remain_feats > max_feats) {
>> +			alloc_size = struct_size(mbox_out, ents, max_feats);
>> +			remain_feats = remain_feats - max_feats;
>> +			copy_feats = max_feats;
>> +		} else {
>> +			alloc_size = struct_size(mbox_out, ents, remain_feats);
>> +			copy_feats = remain_feats;
>> +			remain_feats = 0;
>> +		}
>> +
>> +		memset(&mbox_in, 0, sizeof(mbox_in));
>> +		mbox_in.count = cpu_to_le32(alloc_size);
>> +		mbox_in.start_idx = cpu_to_le16(start);
>> +		memset(mbox_out, 0, alloc_size);
>> +		mbox_cmd = (struct cxl_mbox_cmd) {
>> +			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>> +			.size_in = sizeof(mbox_in),
>> +			.payload_in = &mbox_in,
>> +			.size_out = alloc_size,
>> +			.payload_out = mbox_out,
>> +			.min_out = hdr_size,
>> +		};
>> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		if (mbox_cmd.size_out <= hdr_size)
>> +			return -ENXIO;
>> +
>> +		/*
>> +		 * Make sure retrieved out buffer is multiple of feature
>> +		 * entries.
>> +		 */
>> +		retrieved = mbox_cmd.size_out - hdr_size;
>> +		if (retrieved % feat_size)
>> +			return -ENXIO;
>> +
>> +		num_entries = le16_to_cpu(mbox_out->num_entries);
>> +		/*
>> +		 * If the reported output entries * defined entry size !=
>> +		 * retrieved output bytes, then the output package is incorrect.
>> +		 */
>> +		if (num_entries * feat_size != retrieved)
>> +			return -ENXIO;
>> +
>> +		memcpy(entry, mbox_out->ents, retrieved);
>> +		entry++;
> 
> This memcpy() copies multiple entries from mbox_out->ents to entry, this ''entry++" should be "entry += num_entries"?

Thanks for finding this Ming. Appreciate the review. Fixed in v4.

DJ

> 
> 
> Ming
> 
>> +		/*
>> +		 * If the number of output entries is less than expected, add the
>> +		 * remaining entries to the next batch.
>> +		 */
>> +		remain_feats += copy_feats - num_entries;
>> +		start += num_entries;
>> +	} while (remain_feats);
>> +
>> +	cxlfs->num_features = count;
>> +	cxlfs->entries = no_free_ptr(entries);
>> +	return devm_add_action_or_reset(&cxlmd->dev, cxl_free_feature_entries,
>> +					cxlfs->entries);
>> +}
>> +
> 

