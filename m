Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A944D6A0;
	Tue, 20 Jan 2026 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934372; cv=none; b=owp88+w2kr1uZWa6QhOcXf6Z7bMXS8MnP+rw0LRRfd01rUxHp3vaX9bffu2XQbcDsehBxIEbONsg8PeiB6W2nkkNI3bwqkS0LyeL2xt9DOOLjUfQ5uIolGzxcxTlXZsTgDX/a8AH4QI7tWaW9TYIGmDMCMCil/uNCLrkV2i4WDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934372; c=relaxed/simple;
	bh=ahi/OXMp0rG1OWeApKeopMtvcSrWBWIs+/Mje+RIBvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M96BamWI3X9++x5j94dikXR5Bhbv7pjwUcmOKme/aXOwg41DfjKxrzYNhdET/qZSN6qwjTmBE9/AQIxA8WkBYwm/CQwFs0jSRJQersZbfshgn9aSdtIb9W8OV3OcLcvexvvLkLWjAARbZyIVqM2zO40Xncpj2T/ldvj4J9nfPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jmb3pALk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jmb3pALk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768934370; x=1800470370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahi/OXMp0rG1OWeApKeopMtvcSrWBWIs+/Mje+RIBvg=;
  b=Jmb3pALkzNqf3XHTIKt0Kry6o/AhuyhgU8840SWeUhQkqaZUrtAHrIk6
   mmXynVJpY6hky0/iP4a1I1jsDE3qWuftndtJG1CX1WhFkI7wA9iPaFrr9
   YeTB87Rafnk+EkErLWqBEykIrwawQXv4ITDlHuPIrol50UgZStOQIM20f
   AVeyNi6AInUgYw0CBi7ABCSIlIAJ+oMx+hvfv/jzmUmZWOlnxNOxbA27N
   1rXsKlSaKGrKAdezSK3ae8zHgIS5ddNGHJ4UWfllLw9RGG6xR5+PT+cWm
   SalJUpVDv13Fhu+DpPpdO0G3GJy4KxAtpS0HqqwJ17pg1rwIuh/pFFPSg
   Q==;
X-CSE-ConnectionGUID: uw82fa7rR3ODZJXHzn1BsA==
X-CSE-MsgGUID: +7f33IYZT5qVVupyYbdhIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70244886"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70244886"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 10:39:28 -0800
X-CSE-ConnectionGUID: 75WArlsdSLmI9kt1amZdbg==
X-CSE-MsgGUID: 4Eg+0fv1RiO9lMIlbiYzOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="243774173"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 10:39:25 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
Subject:
 Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field for
 cxl_region
Date: Tue, 20 Jan 2026 19:39:22 +0100
Message-ID: <3985672.dWV9SEqChM@fdefranc-mobl3>
In-Reply-To: <20260113202138.3021093-1-gourry@gourry.net>
References: <20260113202138.3021093-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, January 13, 2026 9:21:36=E2=80=AFPM Central European Standard T=
ime Gregory Price wrote:
> The CXL driver presently has 3 modes of managing a cxl_region:
>   - no specific driver (bios-onlined SystemRAM)
>   - dax_region (all other RAM regions, for now)
>   - pmem_region (all PMEM regions)
>=20
> Formalize these into specific "region drivers".
>=20
> enum cxl_region_driver {
> 	CXL_REGION_DRIVER_NONE,
> 	CXL_REGION_DRIVER_DAX,
> 	CXL_REGION_DRIVER_PMEM
> };
>=20
> $cat regionN/region_driver
> [none,dax,pmem]
>=20
> The intent is to clarify how to to add additional drivers (sysram,
> dynamic_capacity, etc) in the future, and to allow switching the
> driver selection via a sysfs entry `regionN/region_driver`.
>=20
> All RAM regions will be defaulted to CXL_CONTROL_DAX.
>=20
> Auto-regions will either be static sysram (BIOS-onlined) and has no
> region controller associated with it - or if the SP bit was set a
> DAX device will be created.  This will be discovered at probe time.
>=20
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

>  drivers/cxl/core/region.c | 113 ++++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |   8 +++
>  2 files changed, 98 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..f8262d2169ea 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -626,6 +626,57 @@ static ssize_t mode_show(struct device *dev, struct =
device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(mode);
> =20
> +static ssize_t region_driver_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct cxl_region *cxlr =3D to_cxl_region(dev);
> +	const char *desc;
> +
> +	switch (cxlr->driver) {
> +	case CXL_REGION_DRIVER_NONE:
> +		desc =3D "none";
> +		break;
> +	case CXL_REGION_DRIVER_DAX:
> +		desc =3D "dax";
> +		break;
> +	case CXL_REGION_DRIVER_PMEM:
> +		desc =3D "pmem";
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", desc);
> +}
> +
> +static ssize_t region_driver_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr =3D to_cxl_region(dev);
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc =3D ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	if (p->state >=3D CXL_CONFIG_COMMIT)
> +		return -EBUSY;
> +
> +	/* PMEM drivers cannot be changed */
> +	if (cxlr->mode =3D=3D CXL_PARTMODE_PMEM)
> +		return -EBUSY;
> +
> +	/* NONE type is not a valid selection for manually probed regions */
> +	if (sysfs_streq(buf, "dax"))
> +		cxlr->driver =3D CXL_REGION_DRIVER_DAX;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(region_driver);
> +
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
>  	struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(cxlr->dev.parent=
);
> @@ -772,6 +823,7 @@ static struct attribute *cxl_region_attrs[] =3D {
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_extended_linear_cache_size.attr,
> +	&dev_attr_region_driver.attr,
>  	NULL,
>  };
> =20
> @@ -2599,6 +2651,16 @@ static struct cxl_region *devm_cxl_add_region(stru=
ct cxl_root_decoder *cxlrd,
>  	cxlr->mode =3D mode;
>  	cxlr->type =3D type;
> =20
> +	/*
> +	 * PMEM regions only have 1 driver: pmem_region
> +	 * RAM regions default to DAX, but if the memory is already onlined by
> +	 * BIOS as 'System-RAM', the DAX driver will be dropped during probe.
> +	 */
> +	if (mode =3D=3D CXL_PARTMODE_PMEM)
> +		cxlr->driver =3D CXL_REGION_DRIVER_PMEM;
> +	else
> +		cxlr->driver =3D CXL_REGION_DRIVER_DAX;
> +
>  	dev =3D &cxlr->dev;
>  	rc =3D dev_set_name(dev, "region%d", id);
>  	if (rc)
> @@ -3951,33 +4013,38 @@ static int cxl_region_probe(struct device *dev)
>  			return rc;
>  	}
> =20
> -	switch (cxlr->mode) {
> -	case CXL_PARTMODE_PMEM:
> -		rc =3D devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=3D%d failed\=
n",
> -				cxlr->id);
> +	if (cxlr->mode > CXL_PARTMODE_PMEM) {
> +		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> +			cxlr->mode);
> +		return -ENXIO;
> +	}
> =20
> -		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_PARTMODE_RAM:
> -		rc =3D devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=3D%d failed\=
n",
> -				cxlr->id);
> +	/*
> +	 * The region can not be managed by CXL if any portion of
> +	 * it is already online as 'System RAM'.
> +	 */
> +	if (walk_iomem_res_desc(IORES_DESC_NONE,
> +				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				p->res->start, p->res->end, cxlr,
> +					is_system_ram) > 0) {
> +		cxlr->driver =3D CXL_REGION_DRIVER_NONE;
> +		return 0;
> +	}
> =20
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> -			return 0;
> +	rc =3D devm_cxl_region_edac_register(cxlr);
> +	dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=3D%d %s\n",
> +			cxlr->id, rc ? "failed" : "succeeded");
> +
> +	switch (cxlr->driver) {
> +	case CXL_REGION_DRIVER_NONE:
> +		return 0;
> +	case CXL_REGION_DRIVER_DAX:
>  		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_REGION_DRIVER_PMEM:
> +		return devm_cxl_add_pmem_region(cxlr);
>  	default:
> -		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> -			cxlr->mode);
> +		dev_dbg(&cxlr->dev, "unsupported region driver: %d\n",
> +			cxlr->driver);
>  		return -ENXIO;
>  	}
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..e8256099de29 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -502,6 +502,13 @@ enum cxl_partition_mode {
>  	CXL_PARTMODE_PMEM,
>  };
> =20
> +
> +enum cxl_region_driver {
> +	CXL_REGION_DRIVER_NONE,
> +	CXL_REGION_DRIVER_DAX,
> +	CXL_REGION_DRIVER_PMEM,
> +};
> +
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> @@ -543,6 +550,7 @@ struct cxl_region {
>  	struct device dev;
>  	int id;
>  	enum cxl_partition_mode mode;
> +	enum cxl_region_driver driver;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> --=20
> 2.52.0
>=20
>=20
>=20




