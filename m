Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530D238171;
	Mon, 14 Jul 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529768; cv=none; b=Jd/2WCVsogROZfPsgSUN2befO0/9+PNtIbCzi2WMK3ls/7yfAtx5iFjTz8S588RI1qlvmlHzcwMxeUnIweHll3X528TNyThHKg9SOMCRtl2mOqicKIIJPnN45Ua/pMUU9TlJjz1zhoupSrDIXL3pjPoHrycvJP2oNLM+wYQMnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529768; c=relaxed/simple;
	bh=tqqpQqkzdJlgwrVjzP3leMMwLjWGiwUiYUHXHdkAuPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8atdTWWKnOVG0Qzj1F9wxfF7qclYPPa/0MgleqE6aLvr+OT9IAJxWYN77beDUhoPt67HJTc9EMOj/5jcsESOpblsUhFKTPhESpsPIB8U1MvwVQ4uup3LSzqwnKsr81Dy17pUbKMZMja8fmq9Up8vCbfg0AtfXR2onpdXjAdgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PS1YadVg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PS1YadVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752529766; x=1784065766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqqpQqkzdJlgwrVjzP3leMMwLjWGiwUiYUHXHdkAuPE=;
  b=PS1YadVgfiZlLatRTsw3TvZzFe4l+7+mkzW7B5LEdwsiQH8h8x13AQjD
   /fEf4oFKhuRSnAXQXTdpojn4kJamxoxn+cjkySm4mZ+lUJcL2OfBCZoHK
   yb2qSCM5Yi/vwljRQQROmSS+fJvs3D7jZdvLUKip1kGkazckWPXNuljLT
   y1bzwuoPVdPUAxIyBXsvcjV7sD+BESiTVVxVcSp54KnXYZBlYyt5LlGn6
   ASEvZlQa62ygfXHeA4Iwo9RPQ+aKT09+Yga0lkFkkTZqpHmrOHqXH/PaN
   P7mxZ04d4aMGVAW7sZLLWDlke0haa2ol9MHZJA9lx9zynzARNGsQvG0TP
   Q==;
X-CSE-ConnectionGUID: y53E2G0kQIuFNotQ+zpZbg==
X-CSE-MsgGUID: Nxqn/QyHQzSCuh6AM4VKZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="80176887"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="80176887"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:49:25 -0700
X-CSE-ConnectionGUID: RlCsYAw8QQSB5kDMsu55Cg==
X-CSE-MsgGUID: pQ0GDPpTS9iFDgzGJJxS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157595572"
Received: from slindbla-desk.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.95])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:49:21 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject:
 Re: [PATCH v3 5/8] cxl/region: Split commit_store() into __commit() and
 queue_reset() helpers
Date: Mon, 14 Jul 2025 23:49:14 +0200
Message-ID: <3189798.9o76ZdvQCi@fdefranc-mobl3>
In-Reply-To: <20250711234932.671292-6-dan.j.williams@intel.com>
References:
 <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-6-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, July 12, 2025 1:49:29=E2=80=AFAM Central European Summer Time =
Dan Williams wrote:
> The complexity of dropping the lock is removed in favor of splitting comm=
it
> operations to a helper, and leaving all the complexities of "decommit" for
> commit_store() to coordinate the different locking contexts.
>=20
> The CPU cache-invalidation in the decommit path is solely handled now by
> cxl_region_decode_reset(). Previously the CPU caches were being needlessly
> flushed twice in the decommit path where the first flush had no guarantee
> that the memory would not be immediately re-dirtied.
>=20
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> ---
>  drivers/cxl/core/region.c | 99 +++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..3a77aec2c447 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -349,30 +349,42 @@ static int cxl_region_decode_commit(struct cxl_regi=
on *cxlr)
>  	return rc;
>  }
> =20
> -static ssize_t commit_store(struct device *dev, struct device_attribute =
*attr,
> -			    const char *buf, size_t len)
> +static int queue_reset(struct cxl_region *cxlr)
>  {
> -	struct cxl_region *cxlr =3D to_cxl_region(dev);
>  	struct cxl_region_params *p =3D &cxlr->params;
> -	bool commit;
> -	ssize_t rc;
> +	int rc;
> =20
> -	rc =3D kstrtobool(buf, &commit);
> +	rc =3D down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> =20
> +	/* Already in the requested state? */
> +	if (p->state < CXL_CONFIG_COMMIT)
> +		goto out;
> +
> +	p->state =3D CXL_CONFIG_RESET_PENDING;
> +
> +out:
> +	up_write(&cxl_region_rwsem);
> +
> +	return rc;
> +}
> +
> +static int __commit(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	int rc;
> +
>  	rc =3D down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> =20
>  	/* Already in the requested state? */
> -	if (commit && p->state >=3D CXL_CONFIG_COMMIT)
> -		goto out;
> -	if (!commit && p->state < CXL_CONFIG_COMMIT)
> +	if (p->state >=3D CXL_CONFIG_COMMIT)
>  		goto out;
> =20
>  	/* Not ready to commit? */
> -	if (commit && p->state < CXL_CONFIG_ACTIVE) {
> +	if (p->state < CXL_CONFIG_ACTIVE) {
>  		rc =3D -ENXIO;
>  		goto out;
>  	}
> @@ -385,31 +397,60 @@ static ssize_t commit_store(struct device *dev, str=
uct device_attribute *attr,
>  	if (rc)
>  		goto out;
> =20
> -	if (commit) {
> -		rc =3D cxl_region_decode_commit(cxlr);
> -		if (rc =3D=3D 0)
> -			p->state =3D CXL_CONFIG_COMMIT;
> -	} else {
> -		p->state =3D CXL_CONFIG_RESET_PENDING;
> -		up_write(&cxl_region_rwsem);
> -		device_release_driver(&cxlr->dev);
> -		down_write(&cxl_region_rwsem);
> -
> -		/*
> -		 * The lock was dropped, so need to revalidate that the reset is
> -		 * still pending.
> -		 */
> -		if (p->state =3D=3D CXL_CONFIG_RESET_PENDING) {
> -			cxl_region_decode_reset(cxlr, p->interleave_ways);
> -			p->state =3D CXL_CONFIG_ACTIVE;
> -		}
> -	}
> +	rc =3D cxl_region_decode_commit(cxlr);
> +	if (rc =3D=3D 0)
> +		p->state =3D CXL_CONFIG_COMMIT;
> =20
>  out:
>  	up_write(&cxl_region_rwsem);
> =20
> +	return rc;
> +}
> +
> +static ssize_t commit_store(struct device *dev, struct device_attribute =
*attr,
> +			    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr =3D to_cxl_region(dev);
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	bool commit;
> +	ssize_t rc;
> +
> +	rc =3D kstrtobool(buf, &commit);
>  	if (rc)
>  		return rc;
> +
> +	if (commit) {
> +		rc =3D __commit(cxlr);
> +		if (rc)
> +			return rc;
> +		return len;
> +	}
> +
> +	rc =3D queue_reset(cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Unmap the region and depend the reset-pending state to ensure
> +	 * it does not go active again until post reset
> +	 */
> +	device_release_driver(&cxlr->dev);
> +
> +	/*
> +	 * With the reset pending take cxl_region_rwsem unconditionally
> +	 * to ensure the reset gets handled before returning.
> +	 */
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +
> +	/*
> +	 * Revalidate that the reset is still pending in case another
> +	 * thread already handled this reset.
> +	 */
> +	if (p->state =3D=3D CXL_CONFIG_RESET_PENDING) {
> +		cxl_region_decode_reset(cxlr, p->interleave_ways);
> +		p->state =3D CXL_CONFIG_ACTIVE;
> +	}
> +
>  	return len;
>  }
> =20
> --=20
> 2.50.0
>=20
>=20
>=20




