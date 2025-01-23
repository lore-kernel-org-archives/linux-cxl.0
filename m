Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591754A1D
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656734; cv=none; b=Zucx3Y+yAW9KcpiSLcceTzAj1wLXKjgD/D93VJ5TYWjSIztBiqNZ+0SQtUtAoBKL8EJtsXY2DLvF8p2ObUPwHiOhbt9SWzZHWM6Ph7yI+Kc63fAvYXhBRBhU2l0Ke/mQDS2pmcOa67ZDWygnQ/zToQPKYnT7IgTKRjr9k0wZor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656734; c=relaxed/simple;
	bh=XH1CT0KMrU8ufsT+yu/Vf+MItpfmZjkVJ4kMpKQOlpc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKf9YNsFJ1na4IeSQ3mTMSF7sPjdGnLuOxHV9kTESZiaNZPzU7GuMVGXqrsg4s5O7NvkQxTM1uRr/B9P0smAg+LeAIuH8+C0R51NqgJlOCS2koXJ1+7KqhiMUymAJMMIcinSZDcbabM/gDgrXa95JeyJoeCtWc5xIAPnlu9MkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf8TJ6x10z6L56h;
	Fri, 24 Jan 2025 02:23:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 87D571400C8;
	Fri, 24 Jan 2025 02:25:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:25:29 +0100
Date: Thu, 23 Jan 2025 18:25:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 15/19] cxl: Add support to handle user feature
 commands for get feature
Message-ID: <20250123182527.000018e8@huawei.com>
In-Reply-To: <20250122235159.2716036-16-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-16-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_get_feature() call.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/features.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index e65fc8479d21..7c726f1512d0 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c
> @@ -146,6 +146,51 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cfs,
>  	return no_free_ptr(rpc_out);
>  }
>  
> +static void *cxlctl_get_feature(struct cxl_features_state *cfs,
> +				const struct fwctl_rpc_cxl *rpc_in,
> +				size_t *out_len)
> +{
> +	struct cxl_mbox_get_feat_in feat_in;
> +	u16 offset, count, return_code;
> +	size_t out_size = *out_len;
> +	void *feat_out;
> +
> +	if (rpc_in->op_size != sizeof(feat_in))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
> +			   rpc_in->op_size))
> +		return ERR_PTR(-EFAULT);
> +
> +	offset = le16_to_cpu(feat_in.offset);
> +	count = le16_to_cpu(feat_in.count);
> +
> +	if (!count)
> +		return ERR_PTR(-EINVAL);
> +
> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> +		kvzalloc(out_size, GFP_KERNEL);
> +	if (!rpc_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	feat_out = (void *)rpc_out->payload;

Fairly sure no need for the cast.  Should be fine given it's a void *
that you are assigning it to from another pointer type.
As such, maybe just use it inline in next call?

> +	out_size = cxl_get_feature(cfs->features, feat_in.uuid,
> +				   feat_in.selection, feat_out,
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


