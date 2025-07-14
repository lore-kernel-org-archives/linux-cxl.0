Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892182114;
	Mon, 14 Jul 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530547; cv=none; b=B7gnUQdZUNiSNTPE3Rv2QowqA4IQ28eXw0UTfGD3fQnw5Gp6oIIz3Y0DyJTyHvmb/Xescthp+Zg9OfeEGVVe2vpYE+Fmns+O71x7UCycjYfBWi+C38oU481se7+vLVm7izEGOwWkYzxHdOAt9YVz1sZgL+PrmL9OIrHYsgfSRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530547; c=relaxed/simple;
	bh=1lHZsb4r+okitv458h/5R2qI7+rSxffEGn1Sd8vECnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pf9oLNhQB5m7xekvd5xvWSoCTuwaUknGVGwmzQqLiCc9K0cLnwlKH0KQGk9Lnd8lVaFdwHBZRpWv+GWGOICbavZDpY5XhYgC7pnR+i5tvACr6JjEWOZQJ+RjOy1wRC5Yu6PdC6ep9REwtc5GRGuny2lV3nIZWaSPuhYZH8nn/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2w/9K3S; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2w/9K3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752530546; x=1784066546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1lHZsb4r+okitv458h/5R2qI7+rSxffEGn1Sd8vECnw=;
  b=E2w/9K3SQ6A3spOM4kdtr7WJ4OxTn48wL6E2OTFBak170EtTbHt0NCVQ
   Prta211pOh/Pj2DoootR7IwWKKuSCINvwjthIIr1/AFOLBDfjiV1op04z
   FrmZirFXR4upuew6hkbsUMqU7V1NAAIWDEZO6xOZmn86OIxGHHVA+iqsj
   KvJ5AFycDIuvzILzc/znIEz+ADwCFA/21iYW8vRp/nqtgzCcHvOb5/3tx
   HefP2MO4AzGtiobevETT6UFj+yXOb2DJ2lVOb3MD0EZSFWscNN1mUSxls
   D8CjwNrDcqj/aG3/TYvh8t9s63L8br0cZjS/U/4qlc1n7Dh8mnuu8OnLJ
   Q==;
X-CSE-ConnectionGUID: 0jPxq0BlRi242YDifGLbQA==
X-CSE-MsgGUID: JMQ6jWcRSlWeglsRyCi2Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58392905"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="58392905"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:02:25 -0700
X-CSE-ConnectionGUID: 4dsijGEBT8OhXiMcQvmgkw==
X-CSE-MsgGUID: RZNigl73RWu6Nfypl2d+RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157141299"
Received: from slindbla-desk.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.95])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:02:21 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject:
 Re: [PATCH v3 6/8] cxl/region: Move ready-to-probe state check to a helper
Date: Tue, 15 Jul 2025 00:02:17 +0200
Message-ID: <3315674.vFx2qVVIhK@fdefranc-mobl3>
In-Reply-To: <20250711234932.671292-7-dan.j.williams@intel.com>
References:
 <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-7-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, July 12, 2025 1:49:30=E2=80=AFAM Central European Summer Time =
Dan Williams wrote:
> Rather than unlocking the region rwsem in the middle of cxl_region_probe()
> create a helper for determining when the region is ready-to-probe.
>=20
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> ---
>  drivers/cxl/core/region.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3a77aec2c447..2a97fa9a394f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3572,9 +3572,8 @@ static void shutdown_notifiers(void *_cxlr)
>  	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);
>  }
> =20
> -static int cxl_region_probe(struct device *dev)
> +static int cxl_region_can_probe(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr =3D to_cxl_region(dev);
>  	struct cxl_region_params *p =3D &cxlr->params;
>  	int rc;
> =20
> @@ -3597,15 +3596,28 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
> =20
> -	/*
> -	 * From this point on any path that changes the region's state away from
> -	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> -	 */
>  out:
>  	up_read(&cxl_region_rwsem);
> =20
>  	if (rc)
>  		return rc;
> +	return 0;
> +}
> +
> +static int cxl_region_probe(struct device *dev)
> +{
> +	struct cxl_region *cxlr =3D to_cxl_region(dev);
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	int rc;
> +
> +	rc =3D cxl_region_can_probe(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * From this point on any path that changes the region's state away from
> +	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> +	 */
> =20
>  	cxlr->memory_notifier.notifier_call =3D cxl_region_perf_attrs_callback;
>  	cxlr->memory_notifier.priority =3D CXL_CALLBACK_PRI;
> --=20
> 2.50.0
>=20
>=20
>=20




