Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921363E8C79;
	Tue, 20 Jan 2026 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929988; cv=none; b=NPNbQVAHOQaIUFmdbDzs1jQmdpMubwLO/pDbCzEEk0awpJXJaaRkZ1jetCXaWh09v4raDY6pyMm6kKVj7qK10aE6a+OALZrG65GqZFz5Dhh2YiM61944EvI+0DniqHe1nLPYS0Ng6huaHfaNfsktTjTleVAm3vZGBymGasj6+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929988; c=relaxed/simple;
	bh=Bkle8sgHnlGV4/xSI4KkvSNbsx7jNBk8Zg7cc30oLMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKbABk5nUVjp3WIrAjSOByhvyRRzyLg17L0XyC6p2o930Fg6GLNsPLj6IPPuOh77nnWeFYoDLyzpsQfWd+0iRpt3p9DRxIGD5heyuhnP6YuaxhASdw84kEu/tTU5Gl3VqqWi9Aa+IlwOim4uGncrwyzLRaSLWn6qHU/ikV7LzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiHsQHpW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiHsQHpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768929986; x=1800465986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bkle8sgHnlGV4/xSI4KkvSNbsx7jNBk8Zg7cc30oLMg=;
  b=RiHsQHpWcu4XP05Syxr18lZ5shI6OdPkARVA9548hhCgMnTRIXpjR4U6
   Qsmlew+7KVUJLIsgOLn5XPg9/x5OOsUZB93pV/xL+diuaNQLtbP/ud//Y
   62VUeNA1W2qUwlyO1Em3WZ15aD7KRAYCuym4GE65wlzn6tV6YXjmgCsQv
   y0NyjQ1YdpeSzxJNuazraNHLjxqHSgWIWRe0BQU3in12w1xRI88+f9LKa
   QYPJRQiGGAbWIisBfQ83dtQPMUaYA9x1UnoIQ7WULijMigFTj6jjjnMkh
   k+SyTQV1Cxjd0luDv1r2Cn8RyS/RcF+dhrwHd36sC+pPghz/8Yk5HDQ43
   Q==;
X-CSE-ConnectionGUID: gFeDpH/VSAif6Fb/RePuQg==
X-CSE-MsgGUID: Ta/Fcrk3TkePJ0uhseu6SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57707624"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="57707624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:26:25 -0800
X-CSE-ConnectionGUID: TsqM40W2SqCUen/cNaLSzg==
X-CSE-MsgGUID: soKBC/x6TACUUKmmitBm8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="206096085"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 09:26:23 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Subject:
 Re: [PATCH v2 3/3] cxl/core/region: move dax region driver logic into
 dax_region
Date: Tue, 20 Jan 2026 18:26:21 +0100
Message-ID: <3087236.lGaqSPkdTl@fdefranc-mobl3>
In-Reply-To: <20260113202138.3021093-3-gourry@gourry.net>
References:
 <20260113202138.3021093-1-gourry@gourry.net>
 <20260113202138.3021093-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, January 13, 2026 9:21:38=E2=80=AFPM Central European Standard T=
ime Gregory Price wrote:
> Move the dax region driver logic from region.c into dax_region.c
>=20
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

>  drivers/cxl/core/Makefile     |   1 +
>  drivers/cxl/core/core.h       |   1 +
>  drivers/cxl/core/dax_region.c | 106 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c     |  99 -------------------------------
>  4 files changed, 108 insertions(+), 99 deletions(-)
>  create mode 100644 drivers/cxl/core/dax_region.c
>=20
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 23269c81fd44..36f284d7c500 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y +=3D cdat.o
>  cxl_core-y +=3D ras.o
>  cxl_core-$(CONFIG_TRACING) +=3D trace.o
>  cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
> +cxl_core-$(CONFIG_CXL_REGION) +=3D dax_region.o
>  cxl_core-$(CONFIG_CXL_REGION) +=3D pmem_region.o
>  cxl_core-$(CONFIG_CXL_MCE) +=3D mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) +=3D features.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index cd589e81f55e..3ea850408814 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -42,6 +42,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64=
 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxl=
md,
>  		   u64 dpa);
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr);
>  int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
> =20
>  #else
> diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
> new file mode 100644
> index 000000000000..d7c38447f816
> --- /dev/null
> +++ b/drivers/cxl/core/dax_region.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_dax_region_release(struct device *dev)
> +{
> +	struct cxl_dax_region *cxlr_dax =3D to_cxl_dax_region(dev);
> +
> +	kfree(cxlr_dax);
> +}
> +
> +static const struct attribute_group *cxl_dax_region_attribute_groups[] =
=3D {
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
> +const struct device_type cxl_dax_region_type =3D {
> +	.name =3D "cxl_dax_region",
> +	.release =3D cxl_dax_region_release,
> +	.groups =3D cxl_dax_region_attribute_groups,
> +};
> +
> +static bool is_cxl_dax_region(struct device *dev)
> +{
> +	return dev->type =3D=3D &cxl_dax_region_type;
> +}
> +
> +struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
> +			  "not a cxl_dax_region device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_dax_region, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
> +
> +static struct lock_class_key cxl_dax_region_key;
> +
> +static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cx=
lr)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state !=3D CXL_CONFIG_COMMIT)
> +		return ERR_PTR(-ENXIO);
> +
> +	cxlr_dax =3D kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
> +	if (!cxlr_dax)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlr_dax->hpa_range.start =3D p->res->start;
> +	cxlr_dax->hpa_range.end =3D p->res->end;
> +
> +	dev =3D &cxlr_dax->dev;
> +	cxlr_dax->cxlr =3D cxlr;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent =3D &cxlr->dev;
> +	dev->bus =3D &cxl_bus_type;
> +	dev->type =3D &cxl_dax_region_type;
> +
> +	return cxlr_dax;
> +}
> +
> +static void cxlr_dax_unregister(void *_cxlr_dax)
> +{
> +	struct cxl_dax_region *cxlr_dax =3D _cxlr_dax;
> +
> +	device_unregister(&cxlr_dax->dev);
> +}
> +
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +	int rc;
> +
> +	cxlr_dax =3D cxl_dax_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_dax))
> +		return PTR_ERR(cxlr_dax);
> +
> +	dev =3D &cxlr_dax->dev;
> +	rc =3D dev_set_name(dev, "dax_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc =3D device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +		dev_name(dev));
> +
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> +					cxlr_dax);
> +err:
> +	put_device(dev);
> +	return rc;
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a61805542b56..1ca5f5b02b22 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3239,105 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl=
_region *cxlr, u64 offset,
>  	return -ENXIO;
>  }
> =20
> -static void cxl_dax_region_release(struct device *dev)
> -{
> -	struct cxl_dax_region *cxlr_dax =3D to_cxl_dax_region(dev);
> -
> -	kfree(cxlr_dax);
> -}
> -
> -static const struct attribute_group *cxl_dax_region_attribute_groups[] =
=3D {
> -	&cxl_base_attribute_group,
> -	NULL,
> -};
> -
> -const struct device_type cxl_dax_region_type =3D {
> -	.name =3D "cxl_dax_region",
> -	.release =3D cxl_dax_region_release,
> -	.groups =3D cxl_dax_region_attribute_groups,
> -};
> -
> -static bool is_cxl_dax_region(struct device *dev)
> -{
> -	return dev->type =3D=3D &cxl_dax_region_type;
> -}
> -
> -struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
> -{
> -	if (dev_WARN_ONCE(dev, !is_cxl_dax_region(dev),
> -			  "not a cxl_dax_region device\n"))
> -		return NULL;
> -	return container_of(dev, struct cxl_dax_region, dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
> -
> -static struct lock_class_key cxl_dax_region_key;
> -
> -static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cx=
lr)
> -{
> -	struct cxl_region_params *p =3D &cxlr->params;
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state !=3D CXL_CONFIG_COMMIT)
> -		return ERR_PTR(-ENXIO);
> -
> -	cxlr_dax =3D kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
> -	if (!cxlr_dax)
> -		return ERR_PTR(-ENOMEM);
> -
> -	cxlr_dax->hpa_range.start =3D p->res->start;
> -	cxlr_dax->hpa_range.end =3D p->res->end;
> -
> -	dev =3D &cxlr_dax->dev;
> -	cxlr_dax->cxlr =3D cxlr;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent =3D &cxlr->dev;
> -	dev->bus =3D &cxl_bus_type;
> -	dev->type =3D &cxl_dax_region_type;
> -
> -	return cxlr_dax;
> -}
> -
> -static void cxlr_dax_unregister(void *_cxlr_dax)
> -{
> -	struct cxl_dax_region *cxlr_dax =3D _cxlr_dax;
> -
> -	device_unregister(&cxlr_dax->dev);
> -}
> -
> -static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> -{
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> -	int rc;
> -
> -	cxlr_dax =3D cxl_dax_region_alloc(cxlr);
> -	if (IS_ERR(cxlr_dax))
> -		return PTR_ERR(cxlr_dax);
> -
> -	dev =3D &cxlr_dax->dev;
> -	rc =3D dev_set_name(dev, "dax_region%d", cxlr->id);
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
> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> -					cxlr_dax);
> -err:
> -	put_device(dev);
> -	return rc;
> -}
> -
>  static int match_decoder_by_range(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 =3D data;
> --=20
> 2.52.0
>=20
>=20
>=20




