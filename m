Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBB44C7C
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485024; cv=none; b=sYjDLuCrIAN16npXTNNoMatbLF/T4jLoEjHAi4Yp8A4yQtvXU+sIEdU14mWavR5nd77FaBDZdJC/Kjf6ae8Gl9wBoxRd4ytPH3WD5Fk5Rt0z/7Y58zZKO1HaLLAyhttuISk52RhS1bocg8rJmF1ycI/GnIBdb+hi8RbvNHh0TUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485024; c=relaxed/simple;
	bh=L78G/UCaY4rLDRTCxws4T5GGoClIRxTHTYVJ0aiQa6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ8Rbji5ldAYNJE4i+YpLJhD3pzhRwnsOCqL7Adwq6fxCD4ez3sxmxk80dTMGjZdSCy+xOuFrq633eUYsls/PVKRX3mTQQ3WHW22RnFnTnKHwEN+IEufbISiMuLdccCtBEumm9QkJq+9HeUjKI7tiR68rIpC+wPUXhl/ayEd5dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAqEZvpt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAqEZvpt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739485022; x=1771021022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L78G/UCaY4rLDRTCxws4T5GGoClIRxTHTYVJ0aiQa6A=;
  b=VAqEZvptEpjT4KqhhgzpbGjUsDVG2DtUstCrlo41h0PdFhRNURN1azG8
   kl7NC0cUjYC4pTkqulbjoHUcllOCib2i8ElYZSBy7AJs+y5p97M6n9Ftl
   SZsbGyUqhx3tPsgq1Y7QA8Haknw/Ji5HbIHvzjp6Elcl5uIyD4Zi/dXOl
   HzoiBhYrM2j9xdjRlYli9oXzEQauPOoYjvhW+JtJ8vrB82MnZy9iXNtQK
   FZl0Gex4/rt/r9xU7ixfrgA9+sxDhg5f1AWfAmFTEWe4BOfMf9uIfCRAJ
   kURdj+AmDbP/U0K21G3rKSDTT1NyThKaysqYiD1U6DAtG1mfkPkYY+eEq
   w==;
X-CSE-ConnectionGUID: yj9KPHffR7uIaRyfqncJww==
X-CSE-MsgGUID: L4L+CyPYQ462K9bZXBdR1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40330654"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40330654"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:17:02 -0800
X-CSE-ConnectionGUID: kYsg1f4RTrmqwXaVGtoR0g==
X-CSE-MsgGUID: NSoIjMrDQEOi+N9J4HMekg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144215713"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:17:01 -0800
Message-ID: <e2024921-f221-4c87-8e8b-606ab0ca6c92@intel.com>
Date: Thu, 13 Feb 2025 15:16:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] cxl: Add support for fwctl RPC command to enable
 CXL feature commands
To: Saeed Mahameed <saeed@kernel.org>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, jgg@nvidia.com,
 shiju.jose@huawei.com
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-11-dave.jiang@intel.com> <Z61dsxVDH1yZAfEY@x130>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z61dsxVDH1yZAfEY@x130>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/12/25 7:49 PM, Saeed Mahameed wrote:
> On 11 Feb 11:28, Dave Jiang wrote:
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
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>> v5:
>> - drop unused feature_cmds. (Dan)
>> - Fix index of for loop. (Ming)
>> ---
>> drivers/cxl/core/features.c | 218 +++++++++++++++++++++++++++++++++++-
>> include/uapi/cxl/features.h |   1 +
>> include/uapi/fwctl/cxl.h    |  29 +++++
>> 3 files changed, 246 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index 923c054599ad..a43be03ada43 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -365,11 +365,225 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>>     return info;
>> }
>>
>> +static struct cxl_feat_entry *
>> +get_support_feature_info(struct cxl_features_state *cxlfs,
>> +             const struct fwctl_rpc_cxl *rpc_in)
>> +{
>> +    struct cxl_feat_entry *feat;
>> +    uuid_t uuid;
>> +
>> +    if (rpc_in->op_size < sizeof(uuid))
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
>> +               sizeof(uuid)))
>> +        return ERR_PTR(-EFAULT);
>> +
>> +    for (int i = 0; i < cxlfs->entries->num_features; i++) {
>> +        feat = &cxlfs->entries->ent[i];
>> +        if (uuid_equal(&uuid, &feat->uuid))
>> +            return feat;
>> +    }
>> +
>> +    return ERR_PTR(-EINVAL);
>> +}
>> +
>> +static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>> +                       const struct fwctl_rpc_cxl *rpc_in,
>> +                       size_t *out_len)
>> +{
>> +    struct cxl_mbox_get_sup_feats_out *feat_out;
>> +    struct cxl_mbox_get_sup_feats_in feat_in;
>> +    struct cxl_feat_entry *pos;
>> +    size_t out_size;
>> +    int requested;
>> +    u32 count;
>> +    u16 start;
>> +    int i;
>> +
>> +    if (rpc_in->op_size != sizeof(feat_in))
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
>> +               rpc_in->op_size))
>> +        return ERR_PTR(-EFAULT);
>> +
>> +    count = le32_to_cpu(feat_in.count);
>> +    start = le16_to_cpu(feat_in.start_idx);
>> +    requested = count / sizeof(*pos);
>> +
>> +    /*
>> +     * Make sure that the total requested number of entries is not greater
>> +     * than the total number of supported features allowed for userspace.
>> +     */
>> +    if (start >= cxlfs->entries->num_features)
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    requested = min_t(int, requested, cxlfs->entries->num_features - start);
>> +
>> +    out_size = sizeof(struct fwctl_rpc_cxl_out) +
>> +        struct_size(feat_out, ents, requested);
>> +
>> +    struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
>> +        kvzalloc(out_size, GFP_KERNEL);
>> +    if (!rpc_out)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    rpc_out->size = struct_size(feat_out, ents, requested);
>> +    feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
>> +    if (requested == 0) {
>> +        feat_out->num_entries = cpu_to_le16(requested);
>> +        feat_out->supported_feats =
>> +            cpu_to_le16(cxlfs->entries->num_features);
>> +        rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>> +        *out_len = out_size;
>> +        return no_free_ptr(rpc_out);
>> +    }
>> +
>> +    for (i = start, pos = &feat_out->ents[0];
>> +         i < cxlfs->entries->num_features; i++, pos++) {
>> +        if (i - start == requested)
>> +            break;
>> +
>> +        memcpy(pos, &cxlfs->entries->ent[i], sizeof(*pos));
>> +        /*
>> +         * If the feature is exclusive, set the set_feat_size to 0 to
>> +         * indicate that the feature is not changeable.
>> +         */
>> +        if (is_cxl_feature_exclusive(pos)) {
>> +            u32 flags;
>> +
>> +            pos->set_feat_size = 0;
>> +            flags = le32_to_cpu(pos->flags);
>> +            flags &= ~CXL_FEATURE_F_CHANGEABLE;
>> +            pos->flags = cpu_to_le32(flags);
>> +        }
>> +    }
>> +
>> +    feat_out->num_entries = cpu_to_le16(requested);
>> +    feat_out->supported_feats = cpu_to_le16(cxlfs->entries->num_features);
>> +    rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>> +    *out_len = out_size;
>> +
>> +    return no_free_ptr(rpc_out);
>> +}
>> +
>> +static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
>> +                     const struct fwctl_rpc_cxl *rpc_in,
>> +                     enum fwctl_rpc_scope scope)
>> +{
>> +    u16 effects, imm_mask, reset_mask;
>> +    struct cxl_feat_entry *feat;
>> +    u32 flags;
>> +
>> +    feat = get_support_feature_info(cxlfs, rpc_in);
>> +    if (IS_ERR(feat))
>> +        return false;
>> +
>> +    /* Ensure that the attribute is changeable */
>> +    flags = le32_to_cpu(feat->flags);
>> +    if (!(flags & CXL_FEATURE_F_CHANGEABLE))
>> +        return false;
>> +
>> +    effects = le16_to_cpu(feat->effects);
>> +
>> +    /*
>> +     * Reserved bits are set, rejecting since the effects is not
>> +     * comprehended by the driver.
>> +     */
>> +    if (effects & CXL_CMD_EFFECTS_RESERVED) {
>> +        dev_warn_once(cxlfs->cxlds->dev,
>> +                  "Reserved bits set in the Feature effects field!\n");
>> +        return false;
>> +    }
>> +
>> +    /* Currently no user background command support */
>> +    if (effects & CXL_CMD_BACKGROUND)
>> +        return false;
>> +
>> +    /* Effects cause immediate change, highest security scope is needed */
>> +    imm_mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
>> +           CXL_CMD_DATA_CHANGE_IMMEDIATE |
>> +           CXL_CMD_POLICY_CHANGE_IMMEDIATE |
>> +           CXL_CMD_LOG_CHANGE_IMMEDIATE;
>> +
>> +    reset_mask = CXL_CMD_CONFIG_CHANGE_COLD_RESET |
>> +             CXL_CMD_CONFIG_CHANGE_CONV_RESET |
>> +             CXL_CMD_CONFIG_CHANGE_CXL_RESET;
>> +
>> +    /* If no immediate or reset effect set, The hardware has a bug */
>> +    if (!(effects & imm_mask) && !(effects & reset_mask))
>> +        return false;
>> +
>> +    /*
>> +     * If the Feature setting causes immediate configuration change
>> +     * then we need the full write permission policy.
>> +     */
>> +    if (effects & imm_mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
>> +        return true;
> 
> I am not sure the security policy here is coherent with the documentation
>  * @FWCTL_RPC_DEBUG_WRITE_FULL: Write access to all debug information
> 
> From the documentation these features settings in CXL should only be for
> debug purposes, a bit confusing, same for below.
>> +
>> +    /*
>> +     * If the Feature setting only causes configuration change
>> +     * after a reset, then the lesser level of write permission
>> +     * policy is ok.
>> +     */
>> +    if (!(effects & imm_mask) && scope >= FWCTL_RPC_DEBUG_WRITE)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>> +static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
>> +                       const struct fwctl_rpc_cxl *rpc_in,
>> +                       enum fwctl_rpc_scope scope,
>> +                       u16 opcode)
>> +{
>> +    struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
>> +
>> +    switch (opcode) {
>> +    case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
>> +    case CXL_MBOX_OP_GET_FEATURE:
>> +        if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
>> +            return false;
>> +        if (scope >= FWCTL_RPC_CONFIGURATION)
>> +            return true;
>> +        return false;
>> +    case CXL_MBOX_OP_SET_FEATURE:
>> +        if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
>> +            return false;
>> +        return cxlctl_validate_set_features(cxlfs, rpc_in, scope);
> 
> You don't support set_features in this patch, maybe move this functionality
> to the patch that introduces the SET_FEATURES support?

Yes I'll move the relevant bits back.

> 
>> +    default:
>> +        return false;
>> +    }
>> +}
>> +
>> +static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
>> +                    const struct fwctl_rpc_cxl *rpc_in,
>> +                    size_t *out_len, u16 opcode)
>> +{
>> +    switch (opcode) {
>> +    case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
>> +        return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
>> +    case CXL_MBOX_OP_GET_FEATURE:
>> +    case CXL_MBOX_OP_SET_FEATURE:
>> +    default:
>> +        return ERR_PTR(-EOPNOTSUPP);
>> +    }
>> +}
>> +
>> static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>>                void *in, size_t in_len, size_t *out_len)
>> {
>> -    /* Place holder */
>> -    return ERR_PTR(-EOPNOTSUPP);
>> +    struct fwctl_device *fwctl_dev = uctx->fwctl;
>> +    struct cxl_memdev *cxlmd = fwctl_to_memdev(fwctl_dev);
>> +    struct cxl_features_state *cxlfs = to_cxlfs(cxlmd->cxlds);
>> +    const struct fwctl_rpc_cxl *rpc_in = in;
>> +    u16 opcode = rpc_in->opcode;
>> +
>> +    if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
>> +        return ERR_PTR(-EINVAL);
>> +
>> +    return cxlctl_handle_commands(cxlfs, rpc_in, out_len, opcode);
>> }
>>
>> static const struct fwctl_ops cxlctl_ops = {
>> diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
>> index 2e98efb9abf1..05c8a06a5dff 100644
>> --- a/include/uapi/cxl/features.h
>> +++ b/include/uapi/cxl/features.h
>> @@ -33,6 +33,7 @@ struct cxl_mbox_get_sup_feats_in {
>> #define CXL_CMD_EFFECTS_VALID            BIT(9)
>> #define CXL_CMD_CONFIG_CHANGE_CONV_RESET    BIT(10)
>> #define CXL_CMD_CONFIG_CHANGE_CXL_RESET        BIT(11)
>> +#define CXL_CMD_EFFECTS_RESERVED        GENMASK(15, 12)
>>
>> /*
>>  * CXL spec r3.2 Table 8-109
>> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
>> index d21fd6b80c20..e4cf6375a683 100644
>> --- a/include/uapi/fwctl/cxl.h
>> +++ b/include/uapi/fwctl/cxl.h
>> @@ -16,4 +16,33 @@
>> struct fwctl_info_cxl {
>>     __u32 reserved;
>> };
>> +
>> +/**
>> + * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
>> + * @opcode: CXL mailbox command opcode
>> + * @flags: Flags for the command (input).
>> + * @op_size: Size of input payload.
>> + * @reserved1: Reserved. Must be 0s.
>> + * @in_payload: User address of the hardware op input structure
>> + */
>> +struct fwctl_rpc_cxl {
>> +    __u32 opcode;
>> +    __u32 flags;
>> +    __u32 op_size;
>> +    __u32 reserved1;
>> +    __aligned_u64 in_payload;
> 
> I think this would be an unnecessary indirection.
> fwctl subsystem already copies the user buffer for you.
> 1. You could embed the FW input structure at the end of fwct_rpc_cxl
> 2. Have a fixed size header in fwctl_rpc struct to be used by device
> drivers? Can also be useful for other drivers if they need to communicate meta
> data to the driver in the future.

I'll have it embedded.

DJ

> 
> 
>> +};
>> +
>> +/**
>> + * struct fwctl_rpc_cxl_out - ioctl(FWCTL_RPC) output for CXL
>> + * @size: Size of the output payload
>> + * @retval: Return value from device
>> + * @payload: Return data from device
>> + */
>> +struct fwctl_rpc_cxl_out {
>> +    __u32 size;
>> +    __u32 retval;
>> +    __u8 payload[] __counted_by(size);
>> +};
>> +
>> #endif
>> -- 
>> 2.48.1
>>
>>
> 

