Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA925A333
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381714; cv=none; b=KyMMRzgTEvURhJgzLgkIDbggLC/u96ZVJtKx2EX7oAceVKhH8+31RQ6/m+hqVrA5MPPoAw5lhIgm/6wQC85VaMDjR+vVHOQm3vuSeHzyZUIxXrV9UnirzWlv0xoO+pq04fdnuKXRQnSEtw3ABfXCcl5WEeTBOmjMZfVjLGyIRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381714; c=relaxed/simple;
	bh=SmVMw578XIsFDJNhogPC5ywj6yCw3yi9oDwVECyd1d0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLw3PXtDOKXrIsgCE+/mPEWyZENRj51GdhQVtUsiJzxoJY2jxnCEnenSXibyhFVoT0JZt1+PhVmTmvnyoN/IeOugBEKXeDzah9E4dT4ER/9F51gPuuR4oLcK18sIjaSeJXaAUAGYmYPcE097qyJhVDYa+v6lFYqKamNzMmBTbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtQPP5wBjz6H8D5;
	Thu, 13 Feb 2025 01:32:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 61E70140A90;
	Thu, 13 Feb 2025 01:35:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 18:35:06 +0100
Date: Wed, 12 Feb 2025 17:35:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v5 05/15] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <20250212173505.00006457@huawei.com>
In-Reply-To: <20250211182909.1650096-6-dave.jiang@intel.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
	<20250211182909.1650096-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 11:27:59 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for SET_FEATURE mailbox command.
> 
> CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> The settings of a feature can be optionally modified using Set Feature
> command.
> CXL spec r3.2 section 8.2.9.6.3 describes Set Feature command.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

Taking one last look. Totally trivial comment inline.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 3fc6f8415f19..e6d5465b0af1 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -223,3 +223,86 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  
>  	return data_rcvd_size;
>  }
> +
> +/*
> + * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
> + * available in the mailbox for storing the actual feature data so that
> + * the feature data transfer would work as expected.
> + */
> +#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
> +int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> +		    const uuid_t *feat_uuid, u8 feat_version,
> +		    void *feat_data, size_t feat_data_size,
> +		    u32 feat_flag, u16 offset, u16 *return_code)
> +{
> +	struct cxl_memdev_set_feat_pi {
> +		struct cxl_mbox_set_feat_hdr hdr;
> +		u8 feat_data[];
> +	}  __packed;
> +	size_t data_in_size, data_sent_size = 0;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t hdr_size;
> +	int rc = 0;

Only used in the loop below and there it is always set.
Maybe move into that scope and not set?


> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +
> +	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
> +			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!pi)
> +		return -ENOMEM;
> +
> +	uuid_copy(&pi->hdr.uuid, feat_uuid);
> +	pi->hdr.version = feat_version;
> +	feat_flag &= ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;
> +	feat_flag |= CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET;
> +	hdr_size = sizeof(pi->hdr);
> +	/*
> +	 * Check minimum mbox payload size is available for
> +	 * the feature data transfer.
> +	 */
> +	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > cxl_mbox->payload_size)
> +		return -ENOMEM;
> +
> +	if (hdr_size + feat_data_size <= cxl_mbox->payload_size) {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
> +		data_in_size = feat_data_size;
> +	} else {
> +		pi->hdr.flags = cpu_to_le32(feat_flag |
> +				       CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
> +		data_in_size = cxl_mbox->payload_size - hdr_size;
> +	}
> +
> +	do {
> +		pi->hdr.offset = cpu_to_le16(offset + data_sent_size);
> +		memcpy(pi->feat_data, feat_data + data_sent_size, data_in_size);
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_SET_FEATURE,
> +			.size_in = hdr_size + data_in_size,
> +			.payload_in = pi,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);

As above. This is only place rc shows up.

> +		if (rc < 0) {
> +			if (return_code)
> +				*return_code = mbox_cmd.return_code;
> +			return rc;
> +		}
> +
> +		data_sent_size += data_in_size;
> +		if (data_sent_size >= feat_data_size) {
> +			if (return_code)
> +				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> +			return 0;
> +		}
> +
> +		if ((feat_data_size - data_sent_size) <= (cxl_mbox->payload_size - hdr_size)) {
> +			data_in_size = feat_data_size - data_sent_size;
> +			pi->hdr.flags = cpu_to_le32(feat_flag |
> +					       CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
> +		} else {
> +			pi->hdr.flags = cpu_to_le32(feat_flag |
> +					       CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
> +		}
> +	} while (true);
> +}

