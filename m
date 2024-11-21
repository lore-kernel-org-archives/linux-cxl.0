Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF51A01CD
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210981; cv=none; b=ldEuaeHq4YVqd7Rmlxbf7ny6VLO3t/NRxTpLuOZRbeKboaVjYLipO7+8iMvPcgPQKlo10KT+VcaS1hgDxeKOl6vysiZARDAuWVLzAovE+LOi1ulh9lQ6yz9EjLjf3PnrFjvOxcGOKxUHVh6AbCdJdgGyuaolkMRFCxx1hk7Tmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210981; c=relaxed/simple;
	bh=Rn/Md70nZZdxs+qjfcVPQtGVCLIoHkg4dK6GEpNhw20=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlGbGX5o4+vqSNy85PJ5w01yD1xtZHP1ZWmn8xpCElkeFrJtCNaZOp4In+sOpffuKNYORNHtTrcTI3uhmZWCeYKKqwm6dm1+u2tN17DViB+FnRXRT9sEPogXQBnSMm08QBfxTA4gXaeN5hZEFIf2uFX83FOTCc9TkAdqHzPVfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvQTP0k19z6K6XP;
	Fri, 22 Nov 2024 01:39:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 494A3140A70;
	Fri, 22 Nov 2024 01:42:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 18:42:55 +0100
Date: Thu, 21 Nov 2024 17:42:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 02/20] cxl: Add Get Supported Features command
 for kernel usage
Message-ID: <20241121174254.000047bc@huawei.com>
In-Reply-To: <20241115212745.869552-3-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
> 
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

A few things inline.

> ---
> 
> v2:
> - fix feature entry pointer math.
> - free mbox_out in cxl_get_supported_features(). (Shiju, Jonathan)
> - replace sizeof(struct) with feat_size. (Shiju)
> - replace reserved in feature structs with u8 type. (Shiju)
> - change cxl_feat_entry->effects to set_effects. (Shiju)
> - rearrange assigment of cxl_mbox->entries. (Jonathan)
> - Separate no features from actual error. (Jonathan)
> - Fix missing kdoc for entries. (Jonathan)
> ---
>  drivers/cxl/core/mbox.c      | 178 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         |  31 ++++++
>  drivers/cxl/pci.c            |   4 +
>  include/cxl/mailbox.h        |   4 +
>  include/uapi/linux/cxl_mem.h |   1 +
>  5 files changed, 218 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 880ac1dba3cc..4ba56f3d5a65 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c

> +int cxl_get_supported_features(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) = NULL;

If there is a reason this isn't inline, definitely needs a comment.

Otherwise move it inline as per the comments in cleanup.h


> +	int remain_feats, max_size, max_feats, start, rc;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	int feat_size = sizeof(struct cxl_feat_entry);
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	int hdr_size = sizeof(*mbox_out);
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mem_command *cmd;
> +	struct cxl_feat_entry *entry;
> +
> +	/* Get supported features is optional, need to check */
> +	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> +	if (!cmd)
> +		return -EOPNOTSUPP;
> +	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	rc = cxl_get_supported_features_count(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	if (!cxl_mbox->num_features) {
> +		dev_dbg(cxl_mbox->host, "No CXL features enumerated.\n");
> +		return 0;
> +	}
> +
> +	struct cxl_feat_entry *entries __free(kvfree) =
> +		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
> +
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	max_size = cxl_mbox->payload_size - hdr_size;
> +	/* max feat entries that can fit in mailbox max payload size */
> +	max_feats = max_size / feat_size;
> +	entry = &entries[0];
> +
> +	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!mbox_out)
> +		return -ENOMEM;
> +
> +	start = 0;
> +	remain_feats = cxl_mbox->num_features;
> +	do {
> +		int retrieved, alloc_size, copy_feats;
> +		int num_entries;
> +
> +		if (remain_feats > max_feats) {
> +			alloc_size = sizeof(*mbox_out) + max_feats * feat_size;
> +			remain_feats = remain_feats - max_feats;
> +			copy_feats = max_feats;
> +		} else {
> +			alloc_size = sizeof(*mbox_out) + remain_feats * feat_size;
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
> +		if (mbox_cmd.size_out <= hdr_size) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		/*
> +		 * Make sure retrieved out buffer is multiple of feature
> +		 * entries.
> +		 */
> +		retrieved = mbox_cmd.size_out - hdr_size;
> +		if (retrieved % feat_size) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		num_entries = le16_to_cpu(mbox_out->num_entries);
> +		/*
> +		 * If the reported output entries * defined entry size !=
> +		 * retrieved output bytes, then the output package is incorrect.
> +		 */
> +		if (num_entries * feat_size != retrieved) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		memcpy(entry, mbox_out->ents, retrieved);
> +		entry++;
> +		/*
> +		 * If the number of output entries is less than expected, add the
> +		 * remaining entries to the next batch.
> +		 */
> +		remain_feats += copy_feats - num_entries;
> +		start += num_entries;
> +	} while (remain_feats);
> +
> +	cxl_mbox->entries = no_free_ptr(entries);
> +	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
> +				      cxl_mbox->entries);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +
> +err:
> +	cxl_mbox->num_features = 0;
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a0a49809cd76..6685dd76985a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

...

> +struct cxl_mbox_get_sup_feats_out {
> +	__le16 num_entries;
> +	__le16 supported_feats;
> +	u8 reserved[4];
> +	struct cxl_feat_entry ents[] __counted_by_le(supported_feats);
Wrong counted_by. That one is the total number of supported_feats.
num_entries is the one for the number in the output payload.

Might well have been me getting this wrong in earlier review ;(

Jonathan


> +} __packed;
