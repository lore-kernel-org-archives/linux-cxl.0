Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF032D6613
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775646; cv=none; b=ehwY5TMyKzT88peqD7HiA0HkFbENC0GmPVx7FTE/v9hegml9pbVaj34h8Gi1cngZGYhFeICuJZ+uGLQgaU8W4NPpVv5tvixOwTXwZ94fqwACjd1XFzSYe/HDKQCUjpGOzFxRqmRVlH9oIrDs5Nlecn2eXOnDs4B8vQZiC9og3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775646; c=relaxed/simple;
	bh=rpJ6wVgVFjXw6bDedCEzW7td+YI32467ismyKLwo/IE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mg9fyKuRHwiJPBlYZVtVE6pxEn+6fqnkMdTmjM/wy1tqXqRKaKJNTSI7FWx8w564jt0NQbCsw5Wl/INpSuKtZJNDUZiNH33R8rJFozozeHoXp9938cLPpByWcP0fhXuXFD94RkwZwRNM7pQbpghecoZMk/n5kh9tK+B4IFMWjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRS4Y430Hz6J67L;
	Tue, 24 Jun 2025 22:29:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 25A231402C3;
	Tue, 24 Jun 2025 22:34:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Jun
 2025 16:34:00 +0200
Date: Tue, 24 Jun 2025 15:33:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: Add inject and clear poison by HPA
Message-ID: <20250624153359.00006dbe@huawei.com>
In-Reply-To: <50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
References: <cover.1750725512.git.alison.schofield@intel.com>
	<50bd42e0db1ed5979a00e6f5a43147320a1d5b9b.1750725512.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 23 Jun 2025 17:53:36 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add CXL region debugfs attributes to inject and clear poison based
> on Host Physical Addresses (HPA). These new interfaces allow users
> to operate on poison at the region level without needing to resolve
> Device Physical Addresses (DPA) or target individual memdevs.
> 
> The implementation leverages an internal HPA-to-DPA helper, which
> applies decoder interleave logic, including XOR-based address decoding
> when applicable. Note that XOR decodes rely on driver internal xormaps
> which are not exposed to userspace. So, this support is not only a
> simplification of poison operations that could be done using existing
> per memdev operations, but also it enables the functionality for XOR
> interleaved regions for the first time.
> 
> The new debugfs attributes are added under /sys/kernel/debug/regionX/:
> inject_poison and clear_poison. These are only exposed if all memdevs
> participating in the region support both inject and clear commands,
> ensuring consistent and reliable behavior across multi-device regions.
> 
> If tracing is enabled, these operations are logged as cxl_poison
> events in /sys/kernel/tracing/trace.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

A few things inline.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b38141761f47..7616e68fa79e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -200,6 +200,17 @@ static ssize_t security_erase_store(struct device *dev,
>  static struct device_attribute dev_attr_security_erase =
>  	__ATTR(erase, 0200, NULL, security_erase_store);
>  
> +bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
> +			       enum poison_cmd_enabled_bits cmd)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (test_bit(cmd, mds->poison.enabled_cmds))
> +		return true;
> +
> +	return false;

	return test_bit(cmd, ...);

> +}
> +
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d2d904c4b427..e9ed5ac7309e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2,6 +2,7 @@


> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
> +			 cxl_region_debugfs_poison_inject, "%llx\n");
> +
> +static int cxl_region_debugfs_poison_clear(void *data, u64 hpa)
> +{
> +	struct cxl_region *cxlr = data;
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_dpa_result result;
> +	int rc;
> +
> +	rc = down_read_interruptible(&cxl_region_rwsem);

This can use the new shiny ACQUIRE() tool letting us do
early returns and generally making it more readable.

> +	if (rc)
> +		return rc;
> +
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;
> +	}
> +
> +	if (hpa < p->res->start || hpa > p->res->end) {
> +		dev_err_once(&cxlr->dev, "HPA 0x%llx not in region %pr\n", hpa,
> +			     p->res);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	result = cxl_hpa_to_dpa(cxlr, hpa);
> +	if (!result.cxlmd || result.dpa == ULLONG_MAX) {
> +		dev_err(&cxlr->dev, "Failed to resolve DPA from HPA 0x%llx\n",
> +			hpa);
> +
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	rc = __clear_poison_locked(result.cxlmd, result.dpa);
> +out:
> +	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
> +
> +	return rc;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
> +			 cxl_region_debugfs_poison_clear, "%llx\n");
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> +	bool poison_supported = true;
>  	int rc;
>  
>  	rc = down_read_interruptible(&cxl_region_rwsem);
> @@ -3663,6 +3754,31 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/* Create poison attributes if all memdevs support the capabilities */
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
> +		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR)) {
> +			poison_supported = false;
You could drop i out of the loop and simply use the early break to detect
that a match occurred.

	if (i < p->nr_targets) {
		struct dentry *dentry;

but maybe that's a bit too subtle.  I don't mind having a variable for this.
	}
> +			break;
> +		}
> +	}
> +
> +	if (poison_supported) {
> +		struct dentry *dentry;
> +
> +		dentry = cxl_debugfs_create_dir(dev_name(dev));
> +		debugfs_create_file("inject_poison", 0200, dentry, cxlr,
> +				    &cxl_poison_inject_fops);
> +		debugfs_create_file("clear_poison", 0200, dentry, cxlr,
> +				    &cxl_poison_clear_fops);
> +		rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	switch (cxlr->mode) {
>  	case CXL_PARTMODE_PMEM:
>  		rc = devm_cxl_region_edac_register(cxlr);

