Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BBF1B6CE1
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987882; cv=none; b=et6YPGUkBAQnTB0Q+gtTK3dQG7qIyW6ddSF9nTlekeqaRJkAVtJEzte8Czqb6h9LNac4LaZ9qnw/P7dTRHReOHUwvI3FQYjcVG5bP8r7HGLXF7AUMl3BGELWxJYn6uDENGDqCYhybwc7Z5Q+JADnmLqvWlj70mg9GSMJzEB9OVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987882; c=relaxed/simple;
	bh=t2WEAV9Trc5dCMKRys7loaUiijDU4rwh8zdrYuThJdg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tV2ZZRvS4GePCpE4hllVjwgl5I8XBDVV0lA7LJErmkNIksH6+giqa77y8eN/dWIj5Owi7AYyY0R2Ix8p/Z1BI1jgMaitgWERJl7r4tF6lh/sue8XTZnX8HhcMHC+P2/uFZ9Q3QCBktnxaG2vLi0/qlWmPVawe6lvTr2iDzKFkvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YykYQ0Sjwz67P7J;
	Thu, 20 Feb 2025 01:54:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 342A8140382;
	Thu, 20 Feb 2025 01:57:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 19 Feb
 2025 18:57:56 +0100
Date: Wed, 19 Feb 2025 17:57:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>, <saeed@kernel.org>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v6 10/14] cxl: Add support to handle user feature
 commands for get feature
Message-ID: <20250219175755.00003953@huawei.com>
In-Reply-To: <20250218225721.2682235-11-dave.jiang@intel.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
	<20250218225721.2682235-11-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 15:54:39 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_get_feature() call.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v6:
> - adjust for embedded input payload
> - move get_feature bits here from previous patch

One of those flexible arrays gets used here I see..  If
this is first place it is needed maybe drag the definition into
here?


> ---
>  drivers/cxl/core/features.c | 44 +++++++++++++++++++++++++++++++++++++
>  include/uapi/fwctl/cxl.h    |  3 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 106ea9e25c82..ec0e3ace1803 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -427,6 +427,47 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>  	return no_free_ptr(rpc_out);
>  }
>  
> +static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> +				const struct fwctl_rpc_cxl *rpc_in,
> +				size_t *out_len)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
> +	const struct cxl_mbox_get_feat_in *feat_in;
> +	u16 offset, count, return_code;
> +	size_t out_size = *out_len;
> +
> +	if (rpc_in->op_size != sizeof(*feat_in))
> +		return ERR_PTR(-EINVAL);
> +
> +	feat_in = &rpc_in->get_feat_in;
> +	offset = le16_to_cpu(feat_in->offset);
> +	count = le16_to_cpu(feat_in->count);
> +
> +	if (!count)
> +		return ERR_PTR(-EINVAL);
> +
> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> +		kvzalloc(out_size, GFP_KERNEL);
> +	if (!rpc_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	out_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> +				   feat_in->selection, rpc_out->payload,

Ah. You are using the flexible array here to provide a void *
That's fine but maybe drag defining it into this patch.

> +				   count, offset, &return_code);
> +	*out_len = sizeof(struct fwctl_rpc_cxl_out);
> +	if (!out_size) {
> +		rpc_out->size = 0;
> +		rpc_out->retval = return_code;
> +		return no_free_ptr(rpc_out);
> +	}
> +
> +	rpc_out->size = out_size;
> +	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +	*out_len += out_size;
> +
> +	return no_free_ptr(rpc_out);
> +}
> +
>  static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
>  				       const struct fwctl_rpc_cxl *rpc_in,
>  				       enum fwctl_rpc_scope scope,
> @@ -436,6 +477,7 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
>  
>  	switch (opcode) {
>  	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +	case CXL_MBOX_OP_GET_FEATURE:
>  		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
>  			return false;
>  		if (scope >= FWCTL_RPC_CONFIGURATION)
> @@ -453,6 +495,8 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
>  	switch (opcode) {
>  	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
>  		return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
> +	case CXL_MBOX_OP_GET_FEATURE:
> +		return cxlctl_get_feature(cxlfs, rpc_in, out_len);
>  	default:
>  		return ERR_PTR(-EOPNOTSUPP);
>  	}
> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> index 39996ec56816..07b7e5bab461 100644
> --- a/include/uapi/fwctl/cxl.h
> +++ b/include/uapi/fwctl/cxl.h
> @@ -13,6 +13,7 @@
>  
>  struct cxl_mbox_get_sup_feats_in;
>  struct cxl_mbox_get_sup_feats_out;
> +struct cxl_mbox_get_feat_in;
>  
>  /**
>   * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
> @@ -21,6 +22,7 @@ struct cxl_mbox_get_sup_feats_out;
>   * @op_size: Size of input payload.
>   * @reserved1: Reserved. Must be 0s.
>   * @get_sup_feats_in: Get Supported Features input
> + * @get_feat_in: Get Feature input
>   * @op: hardware operation input byte array
>   */
>  struct fwctl_rpc_cxl {
> @@ -32,6 +34,7 @@ struct fwctl_rpc_cxl {
>  	);
>  	union {
>  		struct cxl_mbox_get_sup_feats_in get_sup_feats_in;
> +		struct cxl_mbox_get_feat_in get_feat_in;
>  		__DECLARE_FLEX_ARRAY(__u8, op);
>  	};
>  };

