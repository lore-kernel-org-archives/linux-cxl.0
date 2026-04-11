Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C512171CD
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 00:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865725; cv=none; b=FnezyY2b0uzA0ckiccXY60vgQJh6pDQFIp0VGxrMMzfPG+lbrNFYH8XJR+XnQsGAhLI2Lp9im9oJoDSUaEwpqcLJbog426/5GYKHjtZC14HMyTeHT6e+OoQC+I9EWX6Y5A2DmVQuMCy8bB2ZLkzl59Ixl+m8eBMtwNO9xhtyOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865725; c=relaxed/simple;
	bh=sUUDowhwfmXiYs0dQWxc+LB6/jO3xW4YYkDxcaVMc7I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNOb8VEjVyekubjvR0wPCOR50f+n4nBklg3eXQQaFEfs5AbgpW77+JwEU5BgYvm7ySHANwZsqNhqR8qhIQeSMTmBFa2FtB8Dn2pW6iSWGtetRektLADUe7NUSuKAqhY1Jleo5o6mZQJuFfXDzVTzQkcdG5zuIlIL6e0utlaIzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh0AhNNx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh0AhNNx"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso26190807b3.0
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775865723; x=1776470523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=houtKEASg9Aq9lkLj9uhLhMfcl+G341VvfzWXy9t+5A=;
        b=Gh0AhNNxlrcWde5Yj2jD0GaGWNU2/YF/igEcflPF0Q8JGw1vRSGuHQYaANmYHdgf3d
         Zzwjd6seOWuYyqjtmIjv0T2Ky1aQ/dTykt2mCkzH6NN1TobVQMv9NaUAQptLpoug0b2a
         w8ybbWKnZgvvVPc5FlEfCS1zOuScIykPZYBXWFUg80V5qTCLksjqMT+w8xtCajxU8Jzo
         eD0F0N+JvENqOyvit2i702FhUajaMHmAd1Tl6s7uqOpn5JA6ZpyDLME2xwEAmyZ2VRfL
         vHtLhHmY7iezJZTOvgt/EILkGNDFGAg24//4MF0QkvA7ZwwhKOEB+I4/wBv6ca/I5Be6
         HjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865723; x=1776470523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=houtKEASg9Aq9lkLj9uhLhMfcl+G341VvfzWXy9t+5A=;
        b=ZKOm7uTJNUlvarqWhBW6WE76XrD8IRS2gQ+Cf24tcSOoqFBHVh0ps0LR6G7EgMTF/w
         OyI+5x5skeiaae+q6TpwfiGcUQohN2hm3DmYTzRY50fWl2+Zmu3AKQZCve+S/fQ9EYGT
         yw2sXVec2C3LHKvcKE4JSh+fSK462ZOq+ZAr51sUhyEvdGnoCIndF01LcneeS8VAhSWP
         ra3CcxqmNkQkW4c0mkvR19hlOr0D+KIE2pWQfF1gntuOWhcaivllQWcnauSrIU+vKUIk
         19jcJiNWpXByEGAHkk6ovyx5rM4v6ea4A5LGZEou9/9en5KTWWwqUIB7twDfNvPC9NRl
         BAwA==
X-Gm-Message-State: AOJu0YzGmUWgtdC42MtZS4t6HEXJUM4mBYKU+0QWM/aN/uyODGvM+pm+
	tm742N+YoFCS3+3FLoVGgRkRYcjhoRbva+ol5ejOdAMkkR1X6C9rjY/1
X-Gm-Gg: AeBDievwir1pour1vHZY+YlShI5NKJ93fmcVFSZ4CJ8MrUUC1MUm9cmKSlSLEP7sHym
	MGDzj2qCXwagyG6nvPNFxPs0zDnaz/5/iYoSVAFgoTbGLKBkZKz7cKSQyDwYJWv0LTAUX2G5Atd
	hdQq0oVlJDIpwHR4VxbqhF6i6dtVxqHg6kPvRw2/MSuXTGGDHRSvF8aBs6IObCtExLMZTp42iCy
	KxfnbiN1zJxIg1BmOQJKYw4U42AxlW93mpwmbMXRanRu8yYzEDaFdCq8i7pKIpGipYw76iHAaJR
	WMsMjdSuY0WvbunZluBsgSjW8JOhp7kVAwmMoTVWrRk5FoqMpHqDzSgrvyC1Id9vwBWvuojfIta
	9q3vYHhKZg3oBxkMqmFTETEAPeF3y3O/aA8mjWfhFvELaVGKYH+5ggQaN+zMoZRh8F1vVojj6vE
	xz55nsFzABJ6XzLEBVYNCqWY19kTYtbc7L01K6AO8ItQ==
X-Received: by 2002:a05:690c:8d05:b0:799:198d:8c78 with SMTP id 00721157ae682-7af71e4792cmr47719237b3.46.1775865723199;
        Fri, 10 Apr 2026 17:02:03 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fff584bsm22762737b3.43.2026.04.10.17.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:02:02 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 10 Apr 2026 17:02:00 -0700
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH v5 2/3] cxl/core/region: move dax region device logic
 into region_dax.c
Message-ID: <admPeJv7mjDZPhJv@4470NRD-ASU.ssi.samsung.com>
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-3-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327020203.876122-3-gourry@gourry.net>

On Thu, Mar 26, 2026 at 10:02:02PM -0400, Gregory Price wrote:
> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the CXL DAX region device infrastructure from
> region.c into a new region_dax.c file.
> 
> This will also allow us to add additional dax-driver integration paths
> that don't further dirty the core region.c logic.
> 
> No functional changes.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/Makefile     |   2 +-
>  drivers/cxl/core/core.h       |   1 +
>  drivers/cxl/core/region.c     |  99 ------------------------------
>  drivers/cxl/core/region_dax.c | 109 ++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/Kbuild      |   2 +-
>  5 files changed, 112 insertions(+), 101 deletions(-)
>  create mode 100644 drivers/cxl/core/region_dax.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index f73776fe323b..ce7213818d3c 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,7 +15,7 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
> -cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o
> +cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index ef03966eeabd..82ca3a476708 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -50,6 +50,7 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr);
>  int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>  
>  #else
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 72aee1408efb..6a2ef3475764 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3436,105 +3436,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	return -ENXIO;
>  }
>  
> -static void cxl_dax_region_release(struct device *dev)
> -{
> -	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> -
> -	kfree(cxlr_dax);
> -}
> -
> -static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
> -	&cxl_base_attribute_group,
> -	NULL,
> -};
> -
> -const struct device_type cxl_dax_region_type = {
> -	.name = "cxl_dax_region",
> -	.release = cxl_dax_region_release,
> -	.groups = cxl_dax_region_attribute_groups,
> -};
> -
> -static bool is_cxl_dax_region(struct device *dev)
> -{
> -	return dev->type == &cxl_dax_region_type;
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
> -static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state != CXL_CONFIG_COMMIT)
> -		return ERR_PTR(-ENXIO);
> -
> -	cxlr_dax = kzalloc_obj(*cxlr_dax);
> -	if (!cxlr_dax)
> -		return ERR_PTR(-ENOMEM);
> -
> -	cxlr_dax->hpa_range.start = p->res->start;
> -	cxlr_dax->hpa_range.end = p->res->end;
> -
> -	dev = &cxlr_dax->dev;
> -	cxlr_dax->cxlr = cxlr;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent = &cxlr->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->type = &cxl_dax_region_type;
> -
> -	return cxlr_dax;
> -}
> -
> -static void cxlr_dax_unregister(void *_cxlr_dax)
> -{
> -	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
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
> -	cxlr_dax = cxl_dax_region_alloc(cxlr);
> -	if (IS_ERR(cxlr_dax))
> -		return PTR_ERR(cxlr_dax);
> -
> -	dev = &cxlr_dax->dev;
> -	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> -	if (rc)
> -		goto err;
> -
> -	rc = device_add(dev);
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
>  static int match_root_decoder(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 = data;
> diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> new file mode 100644
> index 000000000000..fe367759ac69
> --- /dev/null
> +++ b/drivers/cxl/core/region_dax.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright(c) 2022 Intel Corporation. All rights reserved.
> + * Copyright(c) 2026 Meta Technologies Inc. All rights reserved.
> + */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_dax_region_release(struct device *dev)
> +{
> +	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> +
> +	kfree(cxlr_dax);
> +}
> +
> +static const struct attribute_group *cxl_dax_region_attribute_groups[] = {
> +	&cxl_base_attribute_group,
> +	NULL
> +};
> +
> +const struct device_type cxl_dax_region_type = {
> +	.name = "cxl_dax_region",
> +	.release = cxl_dax_region_release,
> +	.groups = cxl_dax_region_attribute_groups,
> +};
> +
> +static bool is_cxl_dax_region(struct device *dev)
> +{
> +	return dev->type == &cxl_dax_region_type;
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
> +static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return ERR_PTR(-ENXIO);
> +
> +	cxlr_dax = kzalloc_obj(*cxlr_dax);
> +	if (!cxlr_dax)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlr_dax->hpa_range.start = p->res->start;
> +	cxlr_dax->hpa_range.end = p->res->end;
> +
> +	dev = &cxlr_dax->dev;
> +	cxlr_dax->cxlr = cxlr;
	cxlr->cxlr_dax = cxlr_dax;

Running into segfaults without this ^
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_dax_region_type;
> +
> +	return cxlr_dax;
> +}
> +
> +static void cxlr_dax_unregister(void *_cxlr_dax)
> +{
> +	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
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
> +	cxlr_dax = cxl_dax_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_dax))
> +		return PTR_ERR(cxlr_dax);
> +
> +	dev = &cxlr_dax->dev;
> +	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
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
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index f53d79a05661..d2b291e5f842 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -59,7 +59,7 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
>  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> -cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o
> +cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o $(CXL_CORE_SRC)/region_dax.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
> -- 
> 2.53.0
> 
