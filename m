Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150992046A2
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586560; cv=none; b=KuamCG3xJyluzeqQ31twA2maovXcB8rBAQdEP4fn1AZQnBgntqiqnRv7Z7L3Fskjou+s4eul6g8i0SQMSammHVZZ9cuGZ0Alxue6BfNCLplMDwk3qISC1AlQJewndZLWSsU2MXqxtd00YkOXC/2ygTOA28QNmpp0nYOsMfFy0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586560; c=relaxed/simple;
	bh=BEGdbRzadtYnit8mde7G5WyiJdou5s+cXTHYtRI0Oac=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jipqmuz9LCGwjTbUMjcoW2dd0Yj0T1qldrq+c07I12nhsXinmARUgRiIPIKr/q/JRX600Zc8tzvlMC6JHjeXH7O0nA4iEXpLQvyYZX3YnHk2OM/o0ApJfiwWtf5s/t+EKdaZEtsz8yGvRaAKDrOZiyfHQq5+46aItNmBqVRKA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmmMr51PVz6K9CX;
	Mon,  3 Feb 2025 20:41:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 69D011400CA;
	Mon,  3 Feb 2025 20:42:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 13:42:33 +0100
Date: Mon, 3 Feb 2025 12:42:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v2 08/16] cxl: Add FWCTL support to the CXL memdev
 driver
Message-ID: <20250203124232.00003dd2@huawei.com>
In-Reply-To: <20250201004459.466499-9-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
	<20250201004459.466499-9-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 17:42:01 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Associate FWCTL with the 'cxl_memdev' through the memdev driver. (Dan)
> - I'm leaving Jonathan's tag off to get this looked at again.
Wise move ;)  Comments inline.  Mind you I'm rereading the lot
as been off a few days and this is all gone from my head!



> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index 82598a409acc..2dcfefdfa6b3 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c

>  
> +/* The __weak symbol gets replaced by FWCTL allocation function in fwctl.c */
> +struct cxl_features_state * __weak devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct cxl_features_state *cxlfs =
> +		devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);
> +
> +	if (!cxlfs)
> +		return ERR_PTR(-ENOMEM);
This is returning an error pointer, but the DEFINE FREE assumes
NULL I think for the failed to allocate case. Or just return NULL
and don't modify that.

> +
> +	cxlfs->cxlmd = cxlmd;
> +
> +	return cxlfs;
> +}
> +
> +/* The __weak symbol gets replaced by FWCTL free function in fwctl.c */
> +void __weak devm_cxlfs_free(struct cxl_memdev *cxlmd)
> +{
> +	devm_kfree(&cxlmd->dev, cxlmd->cxlfs);
> +	cxlmd->cxlfs = NULL;

This missing clear of hanging pointer I mentioned back in earlier patch.

> +}
> +
>  static void cxl_cxlfs_free(struct cxl_features_state *cxlfs)
>  {
> -	struct device *dev = &cxlfs->cxlmd->dev;
> -
> -	devm_kfree(dev, cxlfs);
> +	devm_cxlfs_free(cxlfs->cxlmd);
>  }
>  
>  DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(_T))
> @@ -185,15 +208,13 @@ DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(_T))

As above, needs to be if (!IS_ERR_OR_NULL(_T)) I think.

>   */
>  int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>  {
> -	struct device *dev = &cxlmd->dev;
>  	int rc;
>  
>  	struct cxl_features_state *cxlfs __free(free_cxlfs) =
> -		devm_kzalloc(dev, sizeof(*cxlfs), GFP_KERNEL);
> +		devm_cxlfs_allocate(cxlmd);

As per early comments. I'd drag this much earlier in the series
though make only add the __weak markings and comments in this
patch.  That will reduce churn.

>  	if (!cxlfs)
>  		return -ENOMEM;
>  
> -	cxlfs->cxlmd = cxlmd;
>  	enumerate_feature_cmds(cxlmd, cxlfs);
>  	rc = get_supported_features(cxlmd, cxlfs);
>  	if (rc)
> @@ -204,3 +225,5 @@ int devm_cxl_add_features(struct cxl_memdev *cxlmd)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");
> +
> +MODULE_IMPORT_NS("CXL");

> diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
> new file mode 100644
> index 000000000000..d8fd68ac8982
> --- /dev/null
> +++ b/drivers/cxl/fwctl.c
> @@ -0,0 +1,88 @@

> +static void remove_cxlfs(void *_cxlfs)
> +{
> +	struct cxl_features_state *cxlfs = _cxlfs;
> +	struct cxl_memdev *cxlmd = cxlfs->cxlmd;
> +	struct fwctl_device *fwctl = &cxlfs->fwctl;
> +
> +	cxlmd->cxlfs = NULL;

This is a little nasty.  Originally set in enumerate commands, so not
obvious it should be unwound down in here. Perhaps a comment is
enough.

> +	fwctl_unregister(fwctl);
> +	fwctl_put(fwctl);
> +}
> +
> +DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) fwctl_put(&_T->fwctl))
> +
> +static struct cxl_features_state *
> +__devm_cxl_cfs_allocate(struct cxl_memdev *cxlmd, const struct fwctl_ops *ops)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	int rc;
> +
> +	struct cxl_features_state *cxlfs __free(free_cxlfs) =
> +		fwctl_alloc_device(dev, ops, struct cxl_features_state, fwctl);
> +	if (!cxlfs)
> +		return ERR_PTR(-ENOMEM);

As above, the caller of this is used with __free that is assuming NULL
for failed.

> +
> +	cxlfs->cxlmd = cxlmd;
> +	rc = fwctl_register(&cxlfs->fwctl);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = devm_add_action_or_reset(dev, remove_cxlfs, cxlfs);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return no_free_ptr(cxlfs);
> +}

This use of weak functions is a bit too clever for me to be entirely happy but it
seems right so fair enough.

> +
> +struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
> +{
> +	return __devm_cxl_cfs_allocate(cxlmd, &cxlctl_ops);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxlfs_allocate, "CXL");
> +
> +void devm_cxlfs_free(struct cxl_memdev *cxlmd)
> +{
> +	devm_release_action(&cxlmd->dev, remove_cxlfs, cxlmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxlfs_free, "CXL");
> +
> +MODULE_IMPORT_NS("FWCTL");

