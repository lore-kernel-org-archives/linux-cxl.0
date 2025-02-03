Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E02063E4
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738585162; cv=none; b=ejvgCLWiV0MLWTP+FYtuOJjj6IGQ6um1qa+bE9L8zew3WY5+fN1wYex/Jloc5Gl7fP036ZdMI0TayFB9GnWqzk0TmuWDOYzwybj6n6i0/kwqtmg7Ygw5rseW1GsWEmIwetPr9m/zv/KlEly3KGdZNPkm360YwSDNhIBXtbwBP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738585162; c=relaxed/simple;
	bh=cAS5NQd7OqeLHQHyDdqTcn9d6vOqzdIjOdjoCrcBXjU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnc7sJD8lW26ym81TOwbANaSMXPlzOZ+qvpl6HeK3n/h8iCaNzXOAPqq2mEavaBQwLrHYccEgJOfzhTvh53pb2hih49V2ZiYCIsQq7S7kiWFI0ZFHnMP7BIj2B5reYoDdw/cW0hAdJTeIhSvF2p5YA1vXzwL0SGix2oPUh8fqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymlry4Zr6z6K8s3;
	Mon,  3 Feb 2025 20:18:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5391814011B;
	Mon,  3 Feb 2025 20:19:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 13:19:15 +0100
Date: Mon, 3 Feb 2025 12:19:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 03/16] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <20250203121914.00002b30@huawei.com>
In-Reply-To: <20250201004459.466499-4-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
	<20250201004459.466499-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 17:41:56 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

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
> v2:
> - Move to memdev driver and drop features driver support. (Dan)
> - Use features_capability to check what's supported. (Dan)
> - Drop cxl_get_supported_feature_entry() as no usage (Dan, Jonathan)
> - Drop Shiju sign off tags per requested. (Shiju)
> - Rename EXTEND bit(9) to VALID. (Jonathan)
I've read this code too many times :(

Anyhow some feedback on stuff I think belongs in patch 2 and
use of struct_size() to make the sizing calcs more obvious that
I'd missed until now.

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
> +		return 0;

Not sure this should return 0.  That will leave the cxlfs
in place.  + your outermost call in the mem driver prints
a message saying nothing found only if an error is returned.

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
> +	hdr_size = sizeof(*mbox_out);

May seem an odd request but can we make this 
struct_size(mbox_out, ents, 0)
as it seems odd to say how big is this thing we just allocated
and get a smaller size (though correct given the trailing [] array)

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
> +			alloc_size = sizeof(*mbox_out) + max_feats * feat_size;

alloc_size = struct_size(mbox_out, ents, max_feats); 

> +			remain_feats = remain_feats - max_feats;
> +			copy_feats = max_feats;
> +		} else {
> +			alloc_size = sizeof(*mbox_out) + remain_feats * feat_size;

alloc_size = struct_size(mbox_out, ents, remain_feats);

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
> +static void enumerate_feature_cmds(struct cxl_memdev *cxlmd,
> +				   struct cxl_features_state *cxlfs)
Good.  Suggested this in previous.
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> -	struct cxl_features_state *cxlfs = cxlds->cxlmd->cxlfs;

And you drop the circular line. Push this into patch 2.

>  	int fid;
>  
>  	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> @@ -31,6 +164,15 @@ static void enumerate_feature_cmds(struct cxl_memdev *cxlmd)
>  	cxlfs->cap = CXL_FEATURES_RW;
>  }
>  
> +static void cxl_cxlfs_free(struct cxl_features_state *cxlfs)
> +{
> +	struct device *dev = &cxlfs->cxlmd->dev;
> +
> +	devm_kfree(dev, cxlfs);

As below. Let's bring cleanup here if we have to unset cxlmd->cxlfs
later.

> +}
> +
> +DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(_T))
> +
>  /**
>   * devm_cxl_add_features() - Allocate and initialize features context
>   * @cxlmd: CXL memory device
> @@ -39,16 +181,21 @@ static void enumerate_feature_cmds(struct cxl_memdev *cxlmd)
>   */
>  int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_features_state *cxlfs;
>  	struct device *dev = &cxlmd->dev;
> +	int rc;
>  
> -	cxlfs = devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);
> +	struct cxl_features_state *cxlfs __free(free_cxlfs) =
> +		devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);

This line changes 3 times in the series.  Can we drag the
last one here (as per comment on patch 2) by introducing
the new allocate function at this point.

>  	if (!cxlfs)
>  		return -ENOMEM;
>  
> -	cxlmd->cxlfs = cxlfs;
>  	cxlfs->cxlmd = cxlmd;
> -	enumerate_feature_cmds(cxlmd);
> +	enumerate_feature_cmds(cxlmd, cxlfs);
> +	rc = get_supported_features(cxlmd, cxlfs);
> +	if (rc)
> +		return rc;
> +
> +	cxlmd->cxlfs = no_free_ptr(cxlfs);
>  
>  	return 0;
>  }

