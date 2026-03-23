Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290DD248F57;
	Mon, 23 Mar 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278534; cv=none; b=S8lvm85tCZzhhka9WT3LN2uTfMf4NNAaI0DRLpzVBGs3P3ViMDZoZsq+YaUAnaqwd3wpGNoBPygAHTOzxqUy3e1OigRV2P+fVB6ZsBRpXV2l36lX8VUaKADuI4JJnZkRsgYb3kq6+GUBEIsyg3vD/ILkjRKX7PSYUu8MHbLSO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278534; c=relaxed/simple;
	bh=aBEIjPnGpQ1SLS7M302cQmKVjokOS5RvrjwRf7X0e7M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQFcHwpqWi+GwKDf4chm3Lvlf1G2h3PNgd1ilk8BeZ0lvii6hJnRG2P7Uik5sFkQv10VCr0EWZ+1xEkLy25oAL0/V8WLcPhCRogpj3yHvy6HPF2d7t1QMDDA8rCzUHJOyt0PbPZhi98vD+csjPt/LgkRKafF/+0oauHkOdgxE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffc4q5XZvzJ46Zw;
	Mon, 23 Mar 2026 23:08:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 303A04056B;
	Mon, 23 Mar 2026 23:08:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 15:08:48 +0000
Date: Mon, 23 Mar 2026 15:08:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <20260323150847.00002e6a@huawei.com>
In-Reply-To: <20260322131638.3636725-2-gourry@gourry.net>
References: <20260322131638.3636725-1-gourry@gourry.net>
	<20260322131638.3636725-2-gourry@gourry.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 22 Mar 2026 09:16:36 -0400
Gregory Price <gourry@gourry.net> wrote:

> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the pmem region driver logic from region.c into
> region_pmem.c make it clear that this code only applies to pmem regions.
> 
> No functional changes.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/Makefile      |   1 +
>  drivers/cxl/core/core.h        |   1 +
>  drivers/cxl/core/region.c      | 184 --------------------------------
>  drivers/cxl/core/region_pmem.c | 189 +++++++++++++++++++++++++++++++++
>  4 files changed, 191 insertions(+), 184 deletions(-)
>  create mode 100644 drivers/cxl/core/region_pmem.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index a639a9499972..d1484a0e5eb4 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -16,6 +16,7 @@ cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_REGION) += region_pmem.o

cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o

For me having them on one line makes it more obvious it's
either neither or both. Cost is a bit more churn if you
decide later to split the CONFIG_* up.

>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
Otherwise a couple of white space things. + a passing comment on the lifetime
management being more complex than I'd like.

Fix the white space and you can add
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
> new file mode 100644
> index 000000000000..138c373a5700
> --- /dev/null
> +++ b/drivers/cxl/core/region_pmem.c

> +const struct device_type cxl_pmem_region_type = {
> +	.name = "cxl_pmem_region",
> +	.release = cxl_pmem_region_release,
> +	.groups = cxl_pmem_region_attribute_groups,
> +};

Blank line here. There is one in the original and I can't see why
we'd want to get rid of it.

> +bool is_cxl_pmem_region(struct device *dev)
> +{
> +	return dev->type == &cxl_pmem_region_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> +
> +struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> +				"not a cxl_pmem_region device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_pmem_region, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");

Blank line here probably makes sense as the key has nothing to do
with the EXPORT_SYMBOL...


> +static struct lock_class_key cxl_pmem_region_key;
> +

> +
> +/**
> + * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> + * @cxlr: parent CXL region for this pmem region bridge device
> + *
> + * Return: 0 on success negative error code on failure.

FWIW the lifetime management in here feels way to complex to me.  Not
a problem for this patch and I'm not immediately sure what we can do about it.

> + */
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int rc;
> +
> +	rc = cxl_pmem_region_alloc(cxlr);
> +	if (rc)
> +		return rc;
> +	cxlr_pmem = cxlr->cxlr_pmem;
> +	cxl_nvb = cxlr->cxl_nvb;
> +
> +	dev = &cxlr_pmem->dev;
> +	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +			dev_name(dev));
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxl_nvb->dev.driver)
> +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> +					cxlr_pmem_unregister,
> +					cxlr_pmem);
> +		else
> +			rc = -ENXIO;
As an example. If we happen to take this path... Where is the device_add() undone?
> +	}
> +
> +	if (rc)
> +		goto err_bridge;
> +
> +	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> +
> +err:
> +	put_device(dev);
> +err_bridge:
> +	put_device(&cxl_nvb->dev);
> +	cxlr->cxl_nvb = NULL;
> +	return rc;
> +}

