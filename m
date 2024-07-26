Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F339FC6
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jul 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016217; cv=none; b=Ukpf7Gob+mA/ltu+VEoXJJTY0uW178ESilpuLsC2xV47cUF7fixosdSrmMx0fKLhFtaRKtuAv9n8wpkzk9+az3ZqP5/uhziVRye03Xog8Np+CU2WSGHh732pmiRtBSsktpdkw7Iaiz0INxU3k/Jm+CxsrAmKQpd1ylvbIU2fh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016217; c=relaxed/simple;
	bh=VXYna4Wz2bCUSeWDV1wwuoI8KrLvPcr7a9cs/9BtBrM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9p2H1fV/MHPP0HuF51vTB2AYoQy5HGU5nhvsvAW4skCQyFxW+IURD/aTo4s9LWKPylNs3hUqRN5ivhz1BfA2ueySiRKmyMTeIMXNf9M8ukwn1u2L4Je/lEWOmPsKJewmY5pTqDkeHYAEtogLixA4D9mtpoxnV2UXARAOKAYrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVwGM2Vlxz6K5rH;
	Sat, 27 Jul 2024 01:48:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ED42B1404FC;
	Sat, 27 Jul 2024 01:50:11 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 18:50:11 +0100
Date: Fri, 26 Jul 2024 18:50:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH 04/13] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <20240726185010.0000295c@Huawei.com>
In-Reply-To: <20240718213446.1750135-5-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240718213446.1750135-5-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jul 2024 14:32:22 -0700
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
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Already a fairly well reviewed implementation of this in 

https://lore.kernel.org/linux-cxl/20240726160556.2079-5-shiju.jose@huawei.com/

Though it wasn't focused on providing userspace access to it and doesn't handle
large feature lists which would be eventually needed.

I'd have preferred to see review on that rather than another version
of the same functionality.

Note the QEMU testing used for that set will be useable here too
and is now upstream.

A few comments inline.

Jonathan


> +int cxl_get_supported_features(struct cxl_mailbox *cxl_mbox)
> +{
> +	int remain_feats, max_size, max_feats, start, rc;
> +	int feat_size = sizeof(struct cxl_feat_entry);
> +	struct cxl_mbox_get_sup_feats_out *mbox_out;
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	int hdr_size = sizeof(*mbox_out);
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mem_command *cmd;
> +	void *ptr;
> +
> +	/* Get supported features is optional, need to check */
> +	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> +	if (!cmd)
> +		return -EOPNOTSUPP;
> +	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	rc = cxl_get_supported_features_count(cxl_mbox);
> +	if (rc)
> +		return rc;
> +
> +	struct cxl_feat_entry *entries __free(kvfree) =
> +		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
> +
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	cxl_mbox->entries = no_free_ptr(entries);

Hmm. Not srue I'd bother with __free(kvfree) for one line that doesn't
do the free.

> +	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
> +				      cxl_mbox->entries);
> +	if (rc)
> +		return rc;
> +
> +	max_size = cxl_mbox->payload_size - hdr_size;
> +	/* max feat entries that can fit in mailbox max payload size */
> +	max_feats = max_size / feat_size;
> +	ptr = &cxl_mbox->entries[0];
> +
> +	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
Freed?

> +	if (!mbox_out)
> +		return -ENOMEM;
> +
> +	start = 0;
> +	remain_feats = cxl_mbox->num_features;
> +	do {
> +		int retrieved, alloc_size, copy_feats;
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
> +		mbox_in.count = alloc_size;
> +		mbox_in.start_idx = start;
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
> +		if (retrieved % sizeof(struct cxl_feat_entry)) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		/*
> +		 * If the reported output entries * defined entry size !=
> +		 * retrieved output bytes, then the output package is incorrect.
> +		 */
> +		if (mbox_out->num_entries * feat_size != retrieved) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		memcpy(ptr, mbox_out->ents, retrieved);
> +		ptr += retrieved;
> +		/*
> +		 * If the number of output entries is less than expected, add the
> +		 * remaining entries to the next batch.
> +		 */
> +		remain_feats += copy_feats - mbox_out->num_entries;
> +		start += mbox_out->num_entries;
> +	} while (remain_feats);
> +
> +	return 0;
> +
> +err:
> +	cxl_mbox->num_features = 0;
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
>  /**
>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>   * @mds: The driver data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index efdf833f2c51..4d3690aa2f3b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

> +struct cxl_mbox_get_sup_feats_out {
> +	__le16 num_entries;
> +	__le16 supported_feats;
> +	__le32 reserved;
> +	struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));

I didn't know __counted_by worked with function calls. Interesting.

> +} __packed;
> +

>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7e26da706921..6a00238446f9 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -872,6 +872,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_get_supported_features(&cxlds->cxl_mbox);

I would separate no features from an error in trying to enumerate them.

> +	if (rc)
> +		dev_dbg(&pdev->dev, "No features enumerated.\n");
> +
>  	rc = cxl_set_timestamp(mds);
>  	if (rc)
>  		return rc;
> diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
> index 2380b22d7a12..570864239b8f 100644
> --- a/include/linux/cxl/mailbox.h
> +++ b/include/linux/cxl/mailbox.h
> @@ -53,6 +53,7 @@ struct cxl_mbox_cmd {
>   * @mbox_mutex: mutex protects device mailbox and firmware
>   * @mbox_wait: rcuwait for mailbox
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> + * @features: number of supported features

missing docs for entries.

>   */
>  struct cxl_mailbox {
>  	struct device *host;
> @@ -63,6 +64,8 @@ struct cxl_mailbox {
>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
> +	int num_features;
> +	struct cxl_feat_entry *entries;
>  };
>  
>  #endif
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c6c0fe27495d..bd2535962f70 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -50,6 +50,7 @@
>  	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
>  	___C(CLEAR_LOG, "Clear Log"),					  \
>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
> +	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

