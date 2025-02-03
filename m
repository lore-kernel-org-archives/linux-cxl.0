Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B501FBC83
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587791; cv=none; b=KoUR4ZFErfaZmZ3eWsdyeJxvqpZPNXDc/Z0MknYyeutXEtUV0+vkBw+c8iKkSO7IPvHIPkaYdRGthyJ2BvKjTO6sd92iRpBSK+BU/lNy5PX1O9rh8JsuV3o65EntsGzS4hnzxIk50PXIErRen+jPAWcWdkj7sqZ7bySaV6gnt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587791; c=relaxed/simple;
	bh=/NiX0TzbJ8T7vwVINxXg5fpcXLvGA/KtM0ZuZxpxBPo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmE8uf3S7VAMuI3tUT/LiMS1FRk3r+fIyXlUmgLWA7ZjrkByMPBsWuqDh1zxoxmWimap62KBsUQx5RzL4ID+XFFrRjB4P5t2Ow9im4lDoAOUpFrMFTWmxA5D7Wl6Y6uV5pvHL8VwubhQZCeW885fbFjTqvuqGMf6clAJsJIkHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymmnw0jSzz6M4VK;
	Mon,  3 Feb 2025 21:00:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C93B1140B73;
	Mon,  3 Feb 2025 21:03:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 14:03:04 +0100
Date: Mon, 3 Feb 2025 13:03:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 11/16] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250203130303.000017c5@huawei.com>
In-Reply-To: <20250201004459.466499-12-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
	<20250201004459.466499-12-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 17:42:04 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the feature reported by Get Supported Features call for the specific
> feature.
> 
> Only "get supported features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get supported features"
> will filter the features that are exclusive to the kernel and only
> report out features that are not kernel only.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Return -EINVAL for get_support_feature_info() instead of -ENOENT. (Dan)
> - Set set_feat_size to 0 for kernel exclusive features.
> - Just don't bother checking the valid (9) bit. (Dan)
> - Reject if the reserved bits are set. (Dan)

A few minor things inline.  Main ones are things that should
be in earlier patches to reduce noise in this one.

Jonathan


> diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
> index b7984c98645c..93c6174ded20 100644
> --- a/drivers/cxl/fwctl.c
> +++ b/drivers/cxl/fwctl.c
> @@ -35,11 +35,209 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  	return info;
>  }

> +
> +static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
> +					   const struct fwctl_rpc_cxl *rpc_in,
> +					   size_t *out_len)
> +{
> +	struct cxl_mbox_get_sup_feats_out *feat_out;
> +	struct cxl_mbox_get_sup_feats_in feat_in;
> +	struct cxl_feat_entry *pos;
> +	int requested, copied;
> +	size_t out_size;
> +	u32 count;
> +	u16 start;
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
> +	if (start >= cxlfs->num_user_features)
> +		return ERR_PTR(-EINVAL);
> +
> +	requested = min_t(int, requested, cxlfs->num_user_features - start);
> +
> +	out_size = sizeof(struct fwctl_rpc_cxl_out) + sizeof(*feat_out) +
> +		   requested * sizeof(*pos);
Pity we don't have a pointer to rpc_out until next line, otherwise
could do
	out_size = struct_size(rpc_out, payload,
			       struct_size(feat_out, ents, requested));

Maybe still worth
	out_size = sizeof(struct fwctl_rpc_cxl_out) +
		struct_size(feat_out, ents, requested);
Whilst pos is the right type, it isn't anything in particular in
some code paths so this just seems odd.
 
> +
> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> +		kvzalloc(out_size, GFP_KERNEL);
> +	if (!rpc_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rpc_out->size = sizeof(*feat_out) + requested * sizeof(*pos);

	struct_size for this one.

> +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
> +	if (requested == 0) {
> +		feat_out->num_entries = cpu_to_le16(requested);
> +		feat_out->supported_feats =
> +			cpu_to_le16(cxlfs->num_user_features);
> +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +		*out_len = out_size;
> +		return no_free_ptr(rpc_out);
> +	}
> +
> +	pos = &feat_out->ents[0];
> +
> +	copied = 0;
> +	for (int i = 0; i < cxlfs->num_features; i++, pos++) {
	for (int i = 0, copied = 0, pos = &feat_out->ents[0],
	     i < cxlfs->num_features; i++, pos++)

perhaps, or maybe keep copied outside given it's not adjusted
in the loops control.
 
> +		memcpy(pos, &cxlfs->entries[i], sizeof(*pos));
> +		/*
> +		 * If the feature is exclusive, set the set_feat_size to 0 to
> +		 * indicate that the feature is not changeable.
> +		 */
> +		if (is_cxl_feature_exclusive(pos))
> +			pos->set_feat_size = 0;
> +
> +		copied++;
Could move copied alongside pos++ in the loop definition and
this check to the start of the loop.

I don't mind on these changes.  That loop will get very
fiddly.


> +		if (copied == requested)
> +			break;
> +	}
> +
> +	feat_out->num_entries = cpu_to_le16(requested);
> +	feat_out->supported_feats = cpu_to_le16(cxlfs->num_features);
> +	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +	*out_len = out_size;
> +
> +	return no_free_ptr(rpc_out);
> +}


> +
>  static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> -			   void *rpc_in, size_t in_len, size_t *out_len)
> +			   void *in, size_t in_len, size_t *out_len)

Push renames back to where the stub was introduced.
Reduces noise as I doubt anyone minds them!

>  {
> -	/* Place holder */
> -	return ERR_PTR(-EOPNOTSUPP);
> +	struct fwctl_device *fwctl = uctx->fwctl;
> +	struct cxl_features_state *cxlfs = to_cxl_features_state(fwctl);
> +	const struct fwctl_rpc_cxl *rpc_in = in;
> +	u16 opcode;
> +
> +	opcode = cxl_get_feature_command_opcode(rpc_in->command_id);
> +	if (opcode == 0xffff)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
> +		return ERR_PTR(-EINVAL);
> +
> +	return cxlctl_handle_commands(cxlfs, rpc_in, out_len, opcode);
>  }
>  
>  static const struct fwctl_ops cxlctl_ops = {
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index eb13d7ee64f0..f43aa761a7ee 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -42,14 +42,6 @@
>  
>  struct cxl_mailbox;
>  
> -/* Index IDs for CXL mailbox Feature commands */
> -enum feature_cmds {
> -	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
> -	CXL_FEATURE_ID_GET_FEATURE,
> -	CXL_FEATURE_ID_SET_FEATURE,
> -	CXL_FEATURE_ID_MAX
> -};
> -
>  /* Feature commands capability supported by a device */
>  enum cxl_features_capability {
>  	CXL_FEATURES_NONE = 0,
> @@ -83,5 +75,6 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u8 feat_version, void *feat_data, size_t feat_data_size,
>  		    u32 feat_flag, u16 offset, u16 *return_code);
> +bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);

Why not put it here directly in patch 7?
Isn't it defined in two places after this patch?


>  
>  #endif


