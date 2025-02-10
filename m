Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F12512EA
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226672; cv=none; b=cmbfQPLZy4upTSkdnWyfN/CfCUxHFI+1FwYzbXuLl/qL/pARy5lkcJprpKE1E38h2tsQmASltfh0wEWUAORwdGjURKK7PZNjhBMzsmurK4yq4rknXf7TGNjKBD6D+3i7n8lcWq9bpRMWIes+26fJnnPV/xIxoQNpAbHat6+To60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226672; c=relaxed/simple;
	bh=36xFV2QzKUVvaBJFOxIw6pcIlI3Z+EmNUNuIKL+Xsbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5iiTqzvNYH0B1R9ms1ywq1U0XSLnp8kA5UmuHcZTdRYOZNyeUyweIb/yzZielFrnuX8bPLdwVdLZaY+Rmm4R3Rudtly0MLSYIO8lKRQ2Iw4c4yjYRuRhOEzV7zIr+O4r4qmYGM39uqTtSbSVGOctvwMlPH3STAO7m168XMasK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVPtqJCf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVPtqJCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739226670; x=1770762670;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=36xFV2QzKUVvaBJFOxIw6pcIlI3Z+EmNUNuIKL+Xsbs=;
  b=XVPtqJCfRYw5JVuqKMHBti/gANNAccUZPY4moxM55D+g6ybF65ulAsKB
   /Pb6fcn/fJq4dOi8vxpm6Qk0UAUpZaJ97IOBwZb5p3XjQ+b5tQIN9J/Gi
   7F3II5U6yKoeDBj+gKjBPMX+Z419cEx/UWyMAuRRHDQiWzfceJ+xT/57R
   EhQEMRH14SjW/jUj1lsy9qf5m35VMNeuMbneXJ+O0Fd8C9wRnnWyANKYp
   u6xhG3yQn5KD6ncpReXegEqIS7c3wKTJXSvysDAH2lzT1Ke4n4yWPKngl
   1LnLMNGOZ6J+lMHuGw4MErhrRzxFl831PjnBY7nl1xw/8JggZEUwjcd3k
   A==;
X-CSE-ConnectionGUID: FmHGqyhtRjucVINJvtC91A==
X-CSE-MsgGUID: TVm35fmHSUC6uHqaXAXCAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39745520"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39745520"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 14:31:09 -0800
X-CSE-ConnectionGUID: bE4NRFEnSLmwXdoiqJTk9Q==
X-CSE-MsgGUID: oqlpLjY7R56iGvljrRcjmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="143181885"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 14:31:09 -0800
Message-ID: <f6cbd618-5638-433e-bc71-8a23d9387055@intel.com>
Date: Mon, 10 Feb 2025 15:31:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] cxl: Add support for fwctl RPC command to enable
 CXL feature commands
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-11-dave.jiang@intel.com>
 <cfe2a637-d00d-4388-b075-a57806603ca1@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <cfe2a637-d00d-4388-b075-a57806603ca1@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/25 12:09 AM, Li Ming wrote:
> On 2/8/2025 7:37 AM, Dave Jiang wrote:
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
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - Use opcode directly instead of command ids. (Dan)
>> - Add check for no immediate effects and no reset effects. (Dan, Jonathan)
>> - Add check for Set Features to have CXL_FEATURES_RW cap.
>> - Add clearing of the "Changeable" bit in the flags for exclusive features.
>> ---
>>  drivers/cxl/core/features.c | 221 +++++++++++++++++++++++++++++++++++-
>>  include/uapi/cxl/features.h |   1 +
>>  include/uapi/fwctl/cxl.h    |  37 ++++++
>>  3 files changed, 257 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index b2836b951360..2682067dd2d7 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -365,11 +365,228 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>>  	return info;
>>  }
>>  
>> +static struct cxl_feat_entry *
>> +get_support_feature_info(struct cxl_features_state *cxlfs,
>> +			 const struct fwctl_rpc_cxl *rpc_in)
>> +{
>> +	struct cxl_feat_entry *feat;
>> +	uuid_t uuid;
>> +
>> +	if (rpc_in->op_size < sizeof(uuid))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
>> +			   sizeof(uuid)))
>> +		return ERR_PTR(-EFAULT);
>> +
>> +	for (int i = 0; i < cxlfs->entries->num_features; i++) {
>> +		feat = &cxlfs->entries->ent[i];
>> +		if (uuid_equal(&uuid, &feat->uuid))
>> +			return feat;
>> +	}
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>> +static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>> +					   const struct fwctl_rpc_cxl *rpc_in,
>> +					   size_t *out_len)
>> +{
>> +	struct cxl_mbox_get_sup_feats_out *feat_out;
>> +	struct cxl_mbox_get_sup_feats_in feat_in;
>> +	struct cxl_feat_entry *pos;
>> +	size_t out_size;
>> +	int requested;
>> +	u32 count;
>> +	u16 start;
>> +	int i;
>> +
>> +	if (rpc_in->op_size != sizeof(feat_in))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
>> +			   rpc_in->op_size))
>> +		return ERR_PTR(-EFAULT);
>> +
>> +	count = le32_to_cpu(feat_in.count);
>> +	start = le16_to_cpu(feat_in.start_idx);
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
>> +	if (requested == 0) {
>> +		feat_out->num_entries = cpu_to_le16(requested);
>> +		feat_out->supported_feats =
>> +			cpu_to_le16(cxlfs->entries->num_features);
>> +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>> +		*out_len = out_size;
>> +		return no_free_ptr(rpc_out);
>> +	}
>> +
>> +	for (i = 0, pos = &feat_out->ents[0];
>> +	     i < cxlfs->entries->num_features; i++, pos++) {
> 
> My understanding is that 'i' should start from the value of the 'start' got from 'feat_in.start_idx'.
> 
> Please correct me if I'm wrong.

You are correct. It needs to be
for (i = start, pos = &feat_out->ents[0];
     i < cxlfs->entries->num_features; i++; pos++) {
	if (i - start == requested)
		break;
	...
}

Thanks for catching that.

DJ


> 
> 
> Ming
> 
>> +		if (i == requested)
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
>> +
> [...]

