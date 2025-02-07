Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87213CFA6
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 05:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738906964; cv=pass; b=GuIzkVzOmjfzACwy4eslddBg7j4PEBoDAbHK/ZZbHQaE4nQyGV1fk13O14Z6b5rCdF804eAZoqvn6GVlnfe+5DUDeJp+xN5UX0vcPndN6/yeCdnNi5+w5iByDVWl9ElG9ivGeUSNb5ficwtl/nz08M5KlRFKiWBwH0lTTMCocYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738906964; c=relaxed/simple;
	bh=Z5YUHlulJH6qmUmOn5fmazFytlhETvRXPDAzVNHGIzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnDCx9lCqbtiSBEXd0lB4Uq1jJFil4o7xOYvDhz+9X46f/FEe9AG2T0xt0DSqWEo75mnYIPUHgCK8UnYayR9OossJ4laqbn8SBuvKjDmfg7LRg/SKK9jligBu+rd0HElSNSPjZPEz8A6eJFEO9VtUTxCs/EWTi4ZbUVip+E52YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=SecPS2V0; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="SecPS2V0"
ARC-Seal: i=1; a=rsa-sha256; t=1738906948; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eRS6ONFzug5gSlELVGCmhPexVc52zS25DXcex/6ocTQSPtLgPWuP+Dbi4Ca3ci+psUUXRIWViP0aacWQ9qilCfqYScZlM8cNg/7+eUYAcCRodLrAG15f8YtGk2BceYd7YB5FkgJYXScfDjAOcsqOUWi0e9DM/XriTIjemrFa7j8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738906948; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0AYmGfspRwdMazYRJ6Eo34F7Nh7a4MwKsSJSNttRQoU=; 
	b=Mqn1nh2mt+aHFJ9nEuBk2jH7HwYNTVG0CupyA4G5cR+hzfRVeOCJa5ibohxGWUtc4unbTjztbKdk9AGhwMC375mVjHfZRiX8KCg1fM3ZaoAth0GL6thoYd8Uctlck0aTQ47C0R4ZqQ0/zDeCjWGfM2XO+ItGE82hG6vS1ktnQiU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738906948;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=0AYmGfspRwdMazYRJ6Eo34F7Nh7a4MwKsSJSNttRQoU=;
	b=SecPS2V08BRz2pH1NhmQ2QpYEvwjvVSHyAU3XbOFBhNLx+ITm8PeRH7MDRm6zgc0
	oJ5hatL/a4gtxboh5y5opgZEx7I2DTWCz/HKYACx4IS41NDwxnM0rg2B4ksg9m05s4B
	YZIR4CcsGcrdU0eGSuGkaLlobZ97yP4yUqEg7aMM=
Received: by mx.zohomail.com with SMTPS id 1738906944248848.4669400985111;
	Thu, 6 Feb 2025 21:42:24 -0800 (PST)
Message-ID: <94a52a5d-5b71-43b2-ae1f-49745bfa3416@zohomail.com>
Date: Fri, 7 Feb 2025 13:42:22 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/16] cxl: Add Get Supported Features command for
 kernel usage
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-4-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250204220430.4146187-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227e474b56577e1ea372e7849f600009b1d04b450bc08823cd4480f5a30544d26e0f3f1b6092403d6:zu080112278318e0f88acb89ab381c9cab0000687f4cdad0881fe9f8fa07191a9d4e763b9ad30ef856ff3c0e:rf0801122d928427e1bddc02d3c8fbba980000753d8232fa288618cd4e005a3ee63ee621d530f2758ed75a12166fe73b4ebb:ZohoMail
X-ZohoMailClient: External

On 2/5/2025 6:03 AM, Dave Jiang wrote:
> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
>
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Use struct_size() instead of open coding the calculation. (Jonathan)
> ---
>  drivers/cxl/features.c | 138 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h |  57 +++++++++++++++++
>  2 files changed, 195 insertions(+)
>
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 958e4828a58d..4d8c603121f0 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
> @@ -7,6 +7,139 @@
[...]
> +static int get_supported_features(struct cxl_memdev *cxlmd,
> +				  struct cxl_features_state *cxlfs)
> +{
> +	int remain_feats, max_size, max_feats, start, rc, hdr_size;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	int feat_size = sizeof(struct cxl_feat_entry);
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	struct cxl_feat_entry *entry;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int count;
> +
> +	if (cxlfs->cap < CXL_FEATURES_RO)
> +		return -EOPNOTSUPP;
> +
> +	count = cxl_get_supported_features_count(cxl_mbox);
> +	if (count == 0)
> +		return -ENOENT;
> +	if (count < 0)
> +		return -ENXIO;
> +
> +	struct cxl_feat_entry *entries __free(kvfree) =
> +		kvmalloc(count * sizeof(*entries), GFP_KERNEL);
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
> +		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!mbox_out)
> +		return -ENOMEM;
> +
> +	hdr_size = struct_size(mbox_out, ents, 0);
> +	max_size = cxl_mbox->payload_size - hdr_size;
> +	/* max feat entries that can fit in mailbox max payload size */
> +	max_feats = max_size / feat_size;
> +	entry = entries;
> +
> +	start = 0;
> +	remain_feats = count;
> +	do {
> +		int retrieved, alloc_size, copy_feats;
> +		int num_entries;
> +
> +		if (remain_feats > max_feats) {
> +			alloc_size = struct_size(mbox_out, ents, max_feats);
> +			remain_feats = remain_feats - max_feats;
> +			copy_feats = max_feats;
> +		} else {
> +			alloc_size = struct_size(mbox_out, ents, remain_feats);
> +			copy_feats = remain_feats;
> +			remain_feats = 0;
> +		}
> +
> +		memset(&mbox_in, 0, sizeof(mbox_in));
> +		mbox_in.count = cpu_to_le32(alloc_size);
> +		mbox_in.start_idx = cpu_to_le16(start);
> +		memset(mbox_out, 0, alloc_size);
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +			.size_in = sizeof(mbox_in),
> +			.payload_in = &mbox_in,
> +			.size_out = alloc_size,
> +			.payload_out = mbox_out,
> +			.min_out = hdr_size,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (mbox_cmd.size_out <= hdr_size)
> +			return -ENXIO;
> +
> +		/*
> +		 * Make sure retrieved out buffer is multiple of feature
> +		 * entries.
> +		 */
> +		retrieved = mbox_cmd.size_out - hdr_size;
> +		if (retrieved % feat_size)
> +			return -ENXIO;
> +
> +		num_entries = le16_to_cpu(mbox_out->num_entries);
> +		/*
> +		 * If the reported output entries * defined entry size !=
> +		 * retrieved output bytes, then the output package is incorrect.
> +		 */
> +		if (num_entries * feat_size != retrieved)
> +			return -ENXIO;
> +
> +		memcpy(entry, mbox_out->ents, retrieved);
> +		entry++;

This memcpy() copies multiple entries from mbox_out->ents to entry, this ''entry++" should be "entry += num_entries"?


Ming

> +		/*
> +		 * If the number of output entries is less than expected, add the
> +		 * remaining entries to the next batch.
> +		 */
> +		remain_feats += copy_feats - num_entries;
> +		start += num_entries;
> +	} while (remain_feats);
> +
> +	cxlfs->num_features = count;
> +	cxlfs->entries = no_free_ptr(entries);
> +	return devm_add_action_or_reset(&cxlmd->dev, cxl_free_feature_entries,
> +					cxlfs->entries);
> +}
> +
