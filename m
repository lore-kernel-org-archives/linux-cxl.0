Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F03BC4F8;
	Tue, 20 Jan 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929646; cv=none; b=lCHCpO7X1S2FJ1VZtL6f42UB4JDekpEUIY9p02oo4Mx9+aHBRPYBZoEjJcu4FPwmGaII3fTeZqzZalKbxX+WkxE88fTX8ma0IPuhRuM+Q6X9wwq1uQTj99vvIj9j0mZWWa/djKGYy+iFMVOmgWMxDDclXlxIzwRA3+npukwdUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929646; c=relaxed/simple;
	bh=nj0/HhcA/VSmWbOpBvMJYHwH+IhwwfM6ijmeK1HxtBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j05XZCaSPS3qfkm1wi+PHJ1U921mZbukT/zqBbsdiH0Df3AeHfWq7Gvab+vKifSzWCfYCWKmKiKt7Bl73zroP01BOHkrbhkM4jYPEWCSXNG03zGI2WNjLDZE2PQzE3S2cWHX5Mjizk1AnB99tu8mTYc+G2LbK7vwAqy934ZQBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvLQtFuP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvLQtFuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768929643; x=1800465643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nj0/HhcA/VSmWbOpBvMJYHwH+IhwwfM6ijmeK1HxtBc=;
  b=YvLQtFuPQkElgN3qS3TMJdhqR6GgYP0Pi8bHDi/GsKflTDxNy3nLhEYP
   XxLgUFhXFdDs+XE/DVRrTIkn9Mgyd45KTEIR3RUdYnR84MnWfentaUFl4
   cTd8Ywvyb4RdmZ2a3+3CizDjJLNywC6kcxv6RQ8+MNUj34SD7aINR13HW
   IphzkLHs/ut52i66/Q5CWGajoPgnnNxFenI/x2rv90XwLCHSzP7kj+/al
   5uzPyJAAURkgs/R5HOaxIu7UfgwZ4P+WR+UOYbB2y4NPZUpjvprSXrHhB
   mmYp5wIpBIYd6yBcLNYlpg/u9sAjpk3RfyYxLMa5aPYKJ3fuA5vFM4hf2
   A==;
X-CSE-ConnectionGUID: u7470HZARIWHURwTgZdI+g==
X-CSE-MsgGUID: HrDXqIbRQrWnsGIbbZdQyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81585442"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81585442"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:20:42 -0800
X-CSE-ConnectionGUID: 848XfcEQSXCzMLWvKw8bEw==
X-CSE-MsgGUID: XvdqvD6uQ3u1m0zA7p9S6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="210642028"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.91])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:20:39 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Subject:
 Re: [PATCH v2 2/3] cxl/core/region: move pmem region driver logic into
 pmem_region
Date: Tue, 20 Jan 2026 18:20:37 +0100
Message-ID: <2647763.vFx2qVVIhK@fdefranc-mobl3>
In-Reply-To: <20260113202138.3021093-2-gourry@gourry.net>
References:
 <20260113202138.3021093-1-gourry@gourry.net>
 <20260113202138.3021093-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, January 13, 2026 9:21:37=E2=80=AFPM Central European Standard T=
ime Gregory Price wrote:
> Move the pmem region driver logic from region.c into pmem_region.c.
>=20
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

>  drivers/cxl/core/Makefile      |   1 +
>  drivers/cxl/core/core.h        |   1 +
>  drivers/cxl/core/pmem_region.c | 191 +++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c      | 184 -------------------------------
>  4 files changed, 193 insertions(+), 184 deletions(-)
>  create mode 100644 drivers/cxl/core/pmem_region.c
>=20
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..23269c81fd44 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y +=3D cdat.o
>  cxl_core-y +=3D ras.o
>  cxl_core-$(CONFIG_TRACING) +=3D trace.o
>  cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
> +cxl_core-$(CONFIG_CXL_REGION) +=3D pmem_region.o
>  cxl_core-$(CONFIG_CXL_MCE) +=3D mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) +=3D features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) +=3D edac.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1fb66132b777..cd589e81f55e 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -42,6 +42,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64=
 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxl=
md,
>  		   u64 dpa);
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
> =20
>  #else
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> diff --git a/drivers/cxl/core/pmem_region.c b/drivers/cxl/core/pmem_regio=
n.c
> new file mode 100644
> index 000000000000..81b66e548bb5
> --- /dev/null
> +++ b/drivers/cxl/core/pmem_region.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_pmem_region_release(struct device *dev)
> +{
> +	struct cxl_pmem_region *cxlr_pmem =3D to_cxl_pmem_region(dev);
> +	int i;
> +
> +	for (i =3D 0; i < cxlr_pmem->nr_mappings; i++) {
> +		struct cxl_memdev *cxlmd =3D cxlr_pmem->mapping[i].cxlmd;
> +
> +		put_device(&cxlmd->dev);
> +	}
> +
> +	kfree(cxlr_pmem);
> +}
> +
> +static const struct attribute_group *cxl_pmem_region_attribute_groups[] =
=3D {
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
> +const struct device_type cxl_pmem_region_type =3D {
> +	.name =3D "cxl_pmem_region",
> +	.release =3D cxl_pmem_region_release,
> +	.groups =3D cxl_pmem_region_attribute_groups,
> +};
> +bool is_cxl_pmem_region(struct device *dev)
> +{
> +	return dev->type =3D=3D &cxl_pmem_region_type;
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
> +static struct lock_class_key cxl_pmem_region_key;
> +
> +static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int i;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state !=3D CXL_CONFIG_COMMIT)
> +		return -ENXIO;
> +
> +	struct cxl_pmem_region *cxlr_pmem __free(kfree) =3D
> +		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> +	if (!cxlr_pmem)
> +		return -ENOMEM;
> +
> +	cxlr_pmem->hpa_range.start =3D p->res->start;
> +	cxlr_pmem->hpa_range.end =3D p->res->end;
> +
> +	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> +	cxlr_pmem->nr_mappings =3D p->nr_targets;
> +	for (i =3D 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> +		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> +		struct cxl_pmem_region_mapping *m =3D &cxlr_pmem->mapping[i];
> +
> +		/*
> +		 * Regions never span CXL root devices, so by definition the
> +		 * bridge for one device is the same for all.
> +		 */
> +		if (i =3D=3D 0) {
> +			cxl_nvb =3D cxl_find_nvdimm_bridge(cxlmd->endpoint);
> +			if (!cxl_nvb)
> +				return -ENODEV;
> +			cxlr->cxl_nvb =3D cxl_nvb;
> +		}
> +		m->cxlmd =3D cxlmd;
> +		get_device(&cxlmd->dev);
> +		m->start =3D cxled->dpa_res->start;
> +		m->size =3D resource_size(cxled->dpa_res);
> +		m->position =3D i;
> +	}
> +
> +	dev =3D &cxlr_pmem->dev;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent =3D &cxlr->dev;
> +	dev->bus =3D &cxl_bus_type;
> +	dev->type =3D &cxl_pmem_region_type;
> +	cxlr_pmem->cxlr =3D cxlr;
> +	cxlr->cxlr_pmem =3D no_free_ptr(cxlr_pmem);
> +
> +	return 0;
> +}
> +
> +static void cxlr_pmem_unregister(void *_cxlr_pmem)
> +{
> +	struct cxl_pmem_region *cxlr_pmem =3D _cxlr_pmem;
> +	struct cxl_region *cxlr =3D cxlr_pmem->cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb =3D cxlr->cxl_nvb;
> +
> +	/*
> +	 * Either the bridge is in ->remove() context under the device_lock(),
> +	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> +	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> +	 * lock).
> +	 */
> +	device_lock_assert(&cxl_nvb->dev);
> +	cxlr->cxlr_pmem =3D NULL;
> +	cxlr_pmem->cxlr =3D NULL;
> +	device_unregister(&cxlr_pmem->dev);
> +}
> +
> +static void cxlr_release_nvdimm(void *_cxlr)
> +{
> +	struct cxl_region *cxlr =3D _cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb =3D cxlr->cxl_nvb;
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxlr->cxlr_pmem)
> +			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> +					cxlr->cxlr_pmem);
> +	}
> +	cxlr->cxl_nvb =3D NULL;
> +	put_device(&cxl_nvb->dev);
> +}
> +
> +/**
> + * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> + * @cxlr: parent CXL region for this pmem region bridge device
> + *
> + * Return: 0 on success negative error code on failure.
> + */
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int rc;
> +
> +	rc =3D cxl_pmem_region_alloc(cxlr);
> +	if (rc)
> +		return rc;
> +	cxlr_pmem =3D cxlr->cxlr_pmem;
> +	cxl_nvb =3D cxlr->cxl_nvb;
> +
> +	dev =3D &cxlr_pmem->dev;
> +	rc =3D dev_set_name(dev, "pmem_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc =3D device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +			dev_name(dev));
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxl_nvb->dev.driver)
> +			rc =3D devm_add_action_or_reset(&cxl_nvb->dev,
> +					cxlr_pmem_unregister,
> +					cxlr_pmem);
> +		else
> +			rc =3D -ENXIO;
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
> +	cxlr->cxl_nvb =3D NULL;
> +	return rc;
> +}
> +
> +
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f8262d2169ea..a61805542b56 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2808,46 +2808,6 @@ static ssize_t delete_region_store(struct device *=
dev,
>  }
>  DEVICE_ATTR_WO(delete_region);
> =20
> -static void cxl_pmem_region_release(struct device *dev)
> -{
> -	struct cxl_pmem_region *cxlr_pmem =3D to_cxl_pmem_region(dev);
> -	int i;
> -
> -	for (i =3D 0; i < cxlr_pmem->nr_mappings; i++) {
> -		struct cxl_memdev *cxlmd =3D cxlr_pmem->mapping[i].cxlmd;
> -
> -		put_device(&cxlmd->dev);
> -	}
> -
> -	kfree(cxlr_pmem);
> -}
> -
> -static const struct attribute_group *cxl_pmem_region_attribute_groups[] =
=3D {
> -	&cxl_base_attribute_group,
> -	NULL,
> -};
> -
> -const struct device_type cxl_pmem_region_type =3D {
> -	.name =3D "cxl_pmem_region",
> -	.release =3D cxl_pmem_region_release,
> -	.groups =3D cxl_pmem_region_attribute_groups,
> -};
> -
> -bool is_cxl_pmem_region(struct device *dev)
> -{
> -	return dev->type =3D=3D &cxl_pmem_region_type;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> -
> -struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> -{
> -	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> -			  "not a cxl_pmem_region device\n"))
> -		return NULL;
> -	return container_of(dev, struct cxl_pmem_region, dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
> -
>  struct cxl_poison_context {
>  	struct cxl_port *port;
>  	int part;
> @@ -3279,64 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl_=
region *cxlr, u64 offset,
>  	return -ENXIO;
>  }
> =20
> -static struct lock_class_key cxl_pmem_region_key;
> -
> -static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p =3D &cxlr->params;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int i;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state !=3D CXL_CONFIG_COMMIT)
> -		return -ENXIO;
> -
> -	struct cxl_pmem_region *cxlr_pmem __free(kfree) =3D
> -		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> -	if (!cxlr_pmem)
> -		return -ENOMEM;
> -
> -	cxlr_pmem->hpa_range.start =3D p->res->start;
> -	cxlr_pmem->hpa_range.end =3D p->res->end;
> -
> -	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> -	cxlr_pmem->nr_mappings =3D p->nr_targets;
> -	for (i =3D 0; i < p->nr_targets; i++) {
> -		struct cxl_endpoint_decoder *cxled =3D p->targets[i];
> -		struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
> -		struct cxl_pmem_region_mapping *m =3D &cxlr_pmem->mapping[i];
> -
> -		/*
> -		 * Regions never span CXL root devices, so by definition the
> -		 * bridge for one device is the same for all.
> -		 */
> -		if (i =3D=3D 0) {
> -			cxl_nvb =3D cxl_find_nvdimm_bridge(cxlmd->endpoint);
> -			if (!cxl_nvb)
> -				return -ENODEV;
> -			cxlr->cxl_nvb =3D cxl_nvb;
> -		}
> -		m->cxlmd =3D cxlmd;
> -		get_device(&cxlmd->dev);
> -		m->start =3D cxled->dpa_res->start;
> -		m->size =3D resource_size(cxled->dpa_res);
> -		m->position =3D i;
> -	}
> -
> -	dev =3D &cxlr_pmem->dev;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent =3D &cxlr->dev;
> -	dev->bus =3D &cxl_bus_type;
> -	dev->type =3D &cxl_pmem_region_type;
> -	cxlr_pmem->cxlr =3D cxlr;
> -	cxlr->cxlr_pmem =3D no_free_ptr(cxlr_pmem);
> -
> -	return 0;
> -}
> -
>  static void cxl_dax_region_release(struct device *dev)
>  {
>  	struct cxl_dax_region *cxlr_dax =3D to_cxl_dax_region(dev);
> @@ -3400,92 +3302,6 @@ static struct cxl_dax_region *cxl_dax_region_alloc=
(struct cxl_region *cxlr)
>  	return cxlr_dax;
>  }
> =20
> -static void cxlr_pmem_unregister(void *_cxlr_pmem)
> -{
> -	struct cxl_pmem_region *cxlr_pmem =3D _cxlr_pmem;
> -	struct cxl_region *cxlr =3D cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb =3D cxlr->cxl_nvb;
> -
> -	/*
> -	 * Either the bridge is in ->remove() context under the device_lock(),
> -	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> -	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> -	 * lock).
> -	 */
> -	device_lock_assert(&cxl_nvb->dev);
> -	cxlr->cxlr_pmem =3D NULL;
> -	cxlr_pmem->cxlr =3D NULL;
> -	device_unregister(&cxlr_pmem->dev);
> -}
> -
> -static void cxlr_release_nvdimm(void *_cxlr)
> -{
> -	struct cxl_region *cxlr =3D _cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb =3D cxlr->cxl_nvb;
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxlr->cxlr_pmem)
> -			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> -					    cxlr->cxlr_pmem);
> -	}
> -	cxlr->cxl_nvb =3D NULL;
> -	put_device(&cxl_nvb->dev);
> -}
> -
> -/**
> - * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> - * @cxlr: parent CXL region for this pmem region bridge device
> - *
> - * Return: 0 on success negative error code on failure.
> - */
> -static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> -{
> -	struct cxl_pmem_region *cxlr_pmem;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int rc;
> -
> -	rc =3D cxl_pmem_region_alloc(cxlr);
> -	if (rc)
> -		return rc;
> -	cxlr_pmem =3D cxlr->cxlr_pmem;
> -	cxl_nvb =3D cxlr->cxl_nvb;
> -
> -	dev =3D &cxlr_pmem->dev;
> -	rc =3D dev_set_name(dev, "pmem_region%d", cxlr->id);
> -	if (rc)
> -		goto err;
> -
> -	rc =3D device_add(dev);
> -	if (rc)
> -		goto err;
> -
> -	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> -		dev_name(dev));
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> -			rc =3D devm_add_action_or_reset(&cxl_nvb->dev,
> -						      cxlr_pmem_unregister,
> -						      cxlr_pmem);
> -		else
> -			rc =3D -ENXIO;
> -	}
> -
> -	if (rc)
> -		goto err_bridge;
> -
> -	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> -
> -err:
> -	put_device(dev);
> -err_bridge:
> -	put_device(&cxl_nvb->dev);
> -	cxlr->cxl_nvb =3D NULL;
> -	return rc;
> -}
> -
>  static void cxlr_dax_unregister(void *_cxlr_dax)
>  {
>  	struct cxl_dax_region *cxlr_dax =3D _cxlr_dax;
> --=20
> 2.52.0
>=20
>=20
>=20




