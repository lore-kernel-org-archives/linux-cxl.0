Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C392C6A3
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738998581; cv=pass; b=GNADXnmHTo2yjd5uR/aWlb3wHY/JOm6NkE4lhgUAjpHa4syMvt8pq/rU60FZ/P5u8SuW4uTJ8cmWByEjrS/c+hE1FQqbWLaG4oTRRx5uBhoSgEk/FBxn1jkrcuzaTt5rispCIAnrxm9CkUsSzVt+AlYe3CbYgz2v7iZYSOJN848=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738998581; c=relaxed/simple;
	bh=G5oIc2j69h6PH57Hq8Qw9OpE3YfT30naHwPq1mPnSh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myK12xTcUHIZHG2VDtzWOpi4Gml3OMXvnaluB3BFm8VC2MaaK0qzKNheW+BELw4gALxySre/hCwVvmXhT436aEzyZVS/BRF/2FtfR21aMds36nmXAUFEga84zB8FdtjM1Dx4XTSo7AxNZVQDIN3oT8HAIBiBLRosshQiVCOWv8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=GmLtgkGN; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="GmLtgkGN"
ARC-Seal: i=1; a=rsa-sha256; t=1738998563; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WX05mc6oa2TwxneKYHRuNfzZChkafTSLIV2yiiQzkV6jryXPxnZ+wskMzc9wfywz6KEcKHcKfnxjNl/kdVm7s1QJwSR+hDrd1f1JleO5pzMMLZ41a17s4rGffx4EO56uHYtF/IT16FAmsS533X2oW/d8ljlynRkUoQeCXsVNGrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738998563; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t2LOxt4YJh51o2dZ1c5SbP7+GhVKBJTmKRG27GaalYw=; 
	b=OyiFf1OosCvw352RGl1HeGPm867G3hsqQtqfZ6B3CPWHFVuOCEw8Uh5MbsFBXAb4rBDLIZ0nwgDrnJg6VtUxzDS+ebtd/nFDD0bcKcUYvl1GYOuJwxIacviaHI+Q9gz/53QS3PE20/9TDhNx26GxKj7Wqc2/IKq9/3iiu5B7yUU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738998563;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=t2LOxt4YJh51o2dZ1c5SbP7+GhVKBJTmKRG27GaalYw=;
	b=GmLtgkGN+VYeZxqRSJMJqm8Ws0cMAczlHxGwq5zUxXyiFxpoD6gYvFROz/5SxEpy
	CV/e53RXjIi77vGP3xYion+u64samRoEzRffphIP9hicqehSThPOtAe7SGlbugUeWC0
	eiqNdQbrE7huQVaOiEzi6/8WJ8wkx7kaShETqyVE=
Received: by mx.zohomail.com with SMTPS id 173899856100244.84974161308992;
	Fri, 7 Feb 2025 23:09:21 -0800 (PST)
Message-ID: <cfe2a637-d00d-4388-b075-a57806603ca1@zohomail.com>
Date: Sat, 8 Feb 2025 15:09:19 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] cxl: Add support for fwctl RPC command to enable
 CXL feature commands
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-11-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250207233914.2375110-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122790151feec93295bcd8df897e0000098a0f86ca8de473fda9458300e86e9b66b14fc258d3fc5285:zu08011227275e9fcb557bba673e3545f20000df309093ddd6aa624c95e05773777f608f77cf363f2cc21d40:rf0801122d828d79b3540588bbc00e2b2a00000a4c492a6b6c94a198824fe7f319c636391aff252622edc2d1a0ab0ab5c48a:ZohoMail
X-ZohoMailClient: External

On 2/8/2025 7:37 AM, Dave Jiang wrote:
> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> Feature commands: Get Supported Features, Get Feature, and Set Feature.
>
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the Feature reported by Get Supported Features call for the specific
> Feature.
>
> Only "Get Supported Features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get Supported Features"
> will filter the Features that are exclusive to the kernel. The flag
> field of the Feature details will be cleared of the "Changeable"
> field and the "set feat size" will be set to 0 to indicate that
> the feature is not changeable.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Use opcode directly instead of command ids. (Dan)
> - Add check for no immediate effects and no reset effects. (Dan, Jonathan)
> - Add check for Set Features to have CXL_FEATURES_RW cap.
> - Add clearing of the "Changeable" bit in the flags for exclusive features.
> ---
>  drivers/cxl/core/features.c | 221 +++++++++++++++++++++++++++++++++++-
>  include/uapi/cxl/features.h |   1 +
>  include/uapi/fwctl/cxl.h    |  37 ++++++
>  3 files changed, 257 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index b2836b951360..2682067dd2d7 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -365,11 +365,228 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  	return info;
>  }
>  
> +static struct cxl_feat_entry *
> +get_support_feature_info(struct cxl_features_state *cxlfs,
> +			 const struct fwctl_rpc_cxl *rpc_in)
> +{
> +	struct cxl_feat_entry *feat;
> +	uuid_t uuid;
> +
> +	if (rpc_in->op_size < sizeof(uuid))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
> +			   sizeof(uuid)))
> +		return ERR_PTR(-EFAULT);
> +
> +	for (int i = 0; i < cxlfs->entries->num_features; i++) {
> +		feat = &cxlfs->entries->ent[i];
> +		if (uuid_equal(&uuid, &feat->uuid))
> +			return feat;
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
> +					   const struct fwctl_rpc_cxl *rpc_in,
> +					   size_t *out_len)
> +{
> +	struct cxl_mbox_get_sup_feats_out *feat_out;
> +	struct cxl_mbox_get_sup_feats_in feat_in;
> +	struct cxl_feat_entry *pos;
> +	size_t out_size;
> +	int requested;
> +	u32 count;
> +	u16 start;
> +	int i;
> +
> +	if (rpc_in->op_size != sizeof(feat_in))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
> +			   rpc_in->op_size))
> +		return ERR_PTR(-EFAULT);
> +
> +	count = le32_to_cpu(feat_in.count);
> +	start = le16_to_cpu(feat_in.start_idx);
> +	requested = count / sizeof(*pos);
> +
> +	/*
> +	 * Make sure that the total requested number of entries is not greater
> +	 * than the total number of supported features allowed for userspace.
> +	 */
> +	if (start >= cxlfs->entries->num_features)
> +		return ERR_PTR(-EINVAL);
> +
> +	requested = min_t(int, requested, cxlfs->entries->num_features - start);
> +
> +	out_size = sizeof(struct fwctl_rpc_cxl_out) +
> +		struct_size(feat_out, ents, requested);
> +
> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> +		kvzalloc(out_size, GFP_KERNEL);
> +	if (!rpc_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rpc_out->size = struct_size(feat_out, ents, requested);
> +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
> +	if (requested == 0) {
> +		feat_out->num_entries = cpu_to_le16(requested);
> +		feat_out->supported_feats =
> +			cpu_to_le16(cxlfs->entries->num_features);
> +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +		*out_len = out_size;
> +		return no_free_ptr(rpc_out);
> +	}
> +
> +	for (i = 0, pos = &feat_out->ents[0];
> +	     i < cxlfs->entries->num_features; i++, pos++) {

My understanding is that 'i' should start from the value of the 'start' got from 'feat_in.start_idx'.

Please correct me if I'm wrong.


Ming

> +		if (i == requested)
> +			break;
> +
> +		memcpy(pos, &cxlfs->entries->ent[i], sizeof(*pos));
> +		/*
> +		 * If the feature is exclusive, set the set_feat_size to 0 to
> +		 * indicate that the feature is not changeable.
> +		 */
> +		if (is_cxl_feature_exclusive(pos)) {
> +			u32 flags;
> +
> +			pos->set_feat_size = 0;
> +			flags = le32_to_cpu(pos->flags);
> +			flags &= ~CXL_FEATURE_F_CHANGEABLE;
> +			pos->flags = cpu_to_le32(flags);
> +		}
> +	}
> +
> +	feat_out->num_entries = cpu_to_le16(requested);
> +	feat_out->supported_feats = cpu_to_le16(cxlfs->entries->num_features);
> +	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +	*out_len = out_size;
> +
> +	return no_free_ptr(rpc_out);
> +}
> +
[...]
