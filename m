Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EE3815CF;
	Thu, 27 Aug 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871336; cv=none; b=DAjRZyfxMCa546Z22n9qpwxBVXYPBlOBsEU6DUrit0yryKqQhb34sYeeSzZ9N0l5KVFgc0W7Y4yCswF59cQjH8BI1q/QyDL5CA1s7/L9VM9AlyStXMV24weJ73q0AqDZY8JJZntv/+fSfApgw8Drnpv+QFV4knGZciRqqM8lgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871336; c=relaxed/simple;
	bh=eaddR6f96ggg4HHHojQOBTu+dM9cuubOZ3SSaV61S1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ln/3EmHVl7aH5zH7gsLQ2DyBMMWR4HYp+8Q6MktJtOekT2bY69gkiucSUlfMfblt6C0dQAYBqUCtPB96x4w7zmXL7UxbGj+zDN9/R5rRNjOGgeKi+8StgOfkzflheNrQK7EzBhr4zNCQOOqktocVxqTpQbMgeZRaoS37O61IpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzxaSfDE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzxaSfDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787871334; x=1819407334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eaddR6f96ggg4HHHojQOBTu+dM9cuubOZ3SSaV61S1g=;
  b=MzxaSfDEmu+kbP7Q0MN5k+p9xuZk3CL37haAvq0z+Y7FuoYiH4iNYaLA
   wJ5kD6dvLcfZZm8UZv10n2DkZXHouJpThp1g6QObmBlJnXP3iWFezQspd
   qjW8xnoPiSHsI21O+7Bj3mXwzTCNonHoJZ/TRDthVu/9WGqWdw89H4zhp
   NuEvQpsLWnpUxwQdoUDr0sOh+P8C/26H2Zqrvn+0hmKliN9D2ESXUo/+E
   loLOipMjFqovfXX32OZ6HZPVuzCHCbKFctM2cuWk+Kpe9MMfMm9MVIhhH
   9HGK22cJkhASOMDdLMYjr4oK5g+0mXt2BdbGDdEezDgYiWLSxW3o0NdV0
   g==;
X-CSE-ConnectionGUID: XfO31NL0QpWqAalQKGWJpQ==
X-CSE-MsgGUID: uNjWqmtCQmCm9YyCu+tNSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88586859"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88586859"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:55:33 -0700
X-CSE-ConnectionGUID: qT413krZSUSrGhIiIwJqDA==
X-CSE-MsgGUID: yhAyI4jFRvirvk5JFhfnDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="271813349"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.124]) ([10.125.109.124])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:55:31 -0700
Message-ID: <51c47dad-0517-43fa-80a1-da7d79fb90ea@intel.com>
Date: Thu, 27 Aug 2026 15:55:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] cxl/features: Reject feature offset that overflows
 16-bit field
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260826014508.9989-1-icheng@nvidia.com>
 <20260826014508.9989-2-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260826014508.9989-2-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/26 6:45 PM, Richard Cheng wrote:
> cxl_get_feature() and cxl_set_feature() build each mailbox command's
> offset from the starting offset plus the amount of data already
> transferred, then store it in a 16-bit field. A user-controlled fwctl
> offset and transfer size can exceed the feature extent, allowing a later
> offset to be truncated by cpu_to_le16() and target the wrong feature
> data.
> 
> Reject requests whose transfer size exceeds the remaining 16-bit feature
> range. Express the check as "size > U16_MAX - offset" so the validation
> itself cannot wrap on 32-bit systems.
> 
> Change cxl_get_feature() to return ssize_t so invalid input and mailbox
> failures are reported as negative errno rather than being conflated with
> a zero-byte result. Update the EDAC callers to handle negative results.
> Keep fwctl behavior unchanged by translating helper failures to the same
> header-only RPC response carrying the CXL mailbox return code.
> 
> Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
> Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/core.h     |  8 ++++----
>  drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
>  drivers/cxl/core/features.c | 28 ++++++++++++++++++----------
>  3 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..bb380ec6daeb 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -217,10 +217,10 @@ int cxl_port_get_possible_dports(struct cxl_port *port);
>  #ifdef CONFIG_CXL_FEATURES
>  struct cxl_feat_entry *
>  cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
> -size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> -		       enum cxl_get_feat_selection selection,
> -		       void *feat_out, size_t feat_out_size, u16 offset,
> -		       u16 *return_code);
> +ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> +			enum cxl_get_feat_selection selection,
> +			void *feat_out, size_t feat_out_size, u16 offset,
> +			u16 *return_code);
>  int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u8 feat_version, const void *feat_data,
>  		    size_t feat_data_size, u32 feat_flag, u16 offset,
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..f1df4b5cfe5b 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -78,7 +78,7 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
>  				    u16 *cycle, u8 *flags, u8 *min_cycle)
>  {
>  	size_t rd_data_size = sizeof(struct cxl_scrub_rd_attrbs);
> -	size_t data_size;
> +	ssize_t data_size;
>  	struct cxl_scrub_rd_attrbs *rd_attrbs __free(kfree) =
>  		kzalloc(rd_data_size, GFP_KERNEL);
>  	if (!rd_attrbs)
> @@ -87,6 +87,8 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
>  	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, NULL);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -551,7 +553,7 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_ecs_fru_rd_attrbs *fru_rd_attrbs;
>  	size_t rd_data_size;
> -	size_t data_size;
> +	ssize_t data_size;
>  
>  	rd_data_size = cxl_ecs_ctx->get_feat_size;
>  
> @@ -563,6 +565,8 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
>  	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, NULL);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -583,7 +587,7 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  	struct cxl_ecs_fru_wr_attrbs *fru_wr_attrbs;
>  	size_t rd_data_size, wr_data_size;
>  	u16 num_media_frus, count;
> -	size_t data_size;
> +	ssize_t data_size;
>  
>  	num_media_frus = cxl_ecs_ctx->num_media_frus;
>  	rd_data_size = cxl_ecs_ctx->get_feat_size;
> @@ -596,6 +600,8 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, NULL);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -1264,7 +1270,7 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	u16 restriction_flags;
> -	size_t data_size;
> +	ssize_t data_size;
>  	u16 return_code;
>  	struct cxl_memdev_sparing_rd_attrbs *rd_attrbs __free(kfree) =
>  		kzalloc(rd_data_size, GFP_KERNEL);
> @@ -1274,6 +1280,8 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  	data_size = cxl_get_feature(cxl_mbox, &cxl_sparing_ctx->repair_uuid,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, &return_code);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> @@ -1750,7 +1758,7 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
>  	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	u16 restriction_flags;
> -	size_t data_size;
> +	ssize_t data_size;
>  	u16 return_code;
>  
>  	struct cxl_memdev_ppr_rd_attrbs *rd_attrbs __free(kfree) =
> @@ -1761,6 +1769,8 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
>  	data_size = cxl_get_feature(cxl_mbox, &cxl_ppr_ctx->repair_uuid,
>  				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
>  				    rd_data_size, 0, &return_code);
> +	if (data_size < 0)
> +		return data_size;
>  	if (!data_size)
>  		return -EIO;
>  
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ba6d2a5acb74..8d44ce829497 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -220,10 +220,10 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
>  
> -size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> -		       enum cxl_get_feat_selection selection,
> -		       void *feat_out, size_t feat_out_size, u16 offset,
> -		       u16 *return_code)
> +ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> +			enum cxl_get_feat_selection selection,
> +			void *feat_out, size_t feat_out_size, u16 offset,
> +			u16 *return_code)
>  {
>  	size_t data_to_rd_size;
>  	struct cxl_mbox_get_feat_in pi;
> @@ -235,7 +235,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		*return_code = CXL_MBOX_CMD_RC_INPUT;
>  
>  	if (!feat_out || !feat_out_size)
> -		return 0;
> +		return -EINVAL;
> +
> +	if (feat_out_size > U16_MAX - offset)
> +		return -EINVAL;
>  
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection = selection;
> @@ -259,7 +262,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		if (rc < 0 || !mbox_cmd.size_out) {
>  			if (return_code)
>  				*return_code = mbox_cmd.return_code;
> -			return 0;
> +			return rc < 0 ? rc : -EIO;
>  		}
>  		data_rcvd_size += mbox_cmd.size_out;
>  	} while (data_rcvd_size < feat_out_size);
> @@ -288,6 +291,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	if (return_code)
>  		*return_code = CXL_MBOX_CMD_RC_INPUT;
>  
> +	if (feat_data_size > U16_MAX - offset)
> +		return -EINVAL;
> +
>  	struct cxl_mbox_set_feat_in *pi __free(kfree) =
>  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!pi)
> @@ -462,6 +468,7 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	const struct cxl_mbox_get_feat_in *feat_in;
>  	u16 offset, count, return_code;
>  	size_t out_size = *out_len;
> +	ssize_t data_size;
>  
>  	if (rpc_in->op_size != sizeof(*feat_in))
>  		return ERR_PTR(-EINVAL);
> @@ -482,16 +489,17 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	if (!rpc_out)
>  		return ERR_PTR(-ENOMEM);
>  
> -	out_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> -				   feat_in->selection, rpc_out->payload,
> -				   count, offset, &return_code);
> +	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> +				    feat_in->selection, rpc_out->payload,
> +				    count, offset, &return_code);
>  	*out_len = sizeof(struct fwctl_rpc_cxl_out);
> -	if (!out_size) {
> +	if (data_size <= 0) {
>  		rpc_out->size = 0;
>  		rpc_out->retval = return_code;
>  		return no_free_ptr(rpc_out);
>  	}
>  
> +	out_size = data_size;
>  	rpc_out->size = out_size;
>  	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>  	*out_len += out_size;

