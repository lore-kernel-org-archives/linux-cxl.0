Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57237EEC3;
	Mon,  5 May 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467724; cv=none; b=lLy7b2eRvVYWXe/SOATkbthbFh3Rm0IO8TG/vmem4t7gzbyNtPLNtVQ/cSe6Xp5W8AIU7hl3rOK6BT5Rh+EFbexznT1HugBUJVsW4nQKFm3K+zgIDmflyngL/pMEmYuw2m5Zypqa+hGlZoT1jxYJxnWVRsHSXkum3dmGWytnH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467724; c=relaxed/simple;
	bh=AJV9SWBkkofgsLLmLFvkjd7VkJ+uBk28zKmrUgYUJ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9kppZWzoSpbd42gdqK4ZCD/yAWZUKQcYxYKUwJ0hCwmFKbS1BaciQHm1vu+wQV9n4CC1HPSODfGgKWoVO49A3mOzAjiPwpXbGFwcHRxpvsuXDYHQ4ksndwwkAl4BbvphjEOeUQGzWFUR276uUMbH/OWucqFgrXv+eQHcUbvXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwcIlonh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwcIlonh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746467722; x=1778003722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AJV9SWBkkofgsLLmLFvkjd7VkJ+uBk28zKmrUgYUJ7I=;
  b=gwcIlonhkM/OSkRHlow0am03buz/hVte+HlEF/nFJ+oA5APE0FbI03FZ
   BKbT7UvAvPxNloUdJwFO+/XtbtML99C6s5jZOwmpV3bBtiYxjBpB6+g/J
   WdK4N0iLhqkLl9skUpDC+zCocjReEubxPw07Rkcg7DaWDzXVPFG1GlsLo
   zWs7piyU+wTxrsYBSkQ8yMfmQw0mLz2OwsH3vG8bFnZ1EX/xBSIPb/bMU
   5Id318+iqpoXOuDezXMSQLrps3ldd706y3NPUjt9ieNcv3kvrSzLe+1+g
   EFeEi1Y3waP9gfhvH/Oh5MvvPF/B0uXffN0xCUAfGuUrXsgoE/tPZcetC
   g==;
X-CSE-ConnectionGUID: WVsivdpSSOOz88YAqAth0Q==
X-CSE-MsgGUID: rqq37WSnRxqhD2kXdqdqdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="65501809"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="65501809"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:55:21 -0700
X-CSE-ConnectionGUID: IsSejwSVQm63kp4GldYRSQ==
X-CSE-MsgGUID: Cvmm7A5bQOeZAfj37N1eFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="166247736"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.37])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 10:55:16 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>
Subject:
 Re: [PATCH v5 08/14] cxl/port: Replace put_cxl_root() by a cleanup helper
Date: Mon, 05 May 2025 19:55:12 +0200
Message-ID: <2303863.vFx2qVVIhK@fdefranc-mobl3>
In-Reply-To: <20250428214318.1682212-9-rrichter@amd.com>
References:
 <20250428214318.1682212-1-rrichter@amd.com>
 <20250428214318.1682212-9-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, April 28, 2025 11:43:11=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Function put_cxl_root() is only used by its cleanup helper. Remove the
> function entirely and only use the helper.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> ---
>  drivers/cxl/core/port.c | 9 ---------
>  drivers/cxl/cxl.h       | 4 ++--
>  2 files changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c9087515d743..e325f08aaf32 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1037,15 +1037,6 @@ struct cxl_root *find_cxl_root(struct cxl_port *po=
rt)
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, "CXL");
> =20
> -void put_cxl_root(struct cxl_root *cxl_root)
> -{
> -	if (!cxl_root)
> -		return;
> -
> -	put_device(&cxl_root->port.dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
> -
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 960efcc60476..ea06850ecaea 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -737,10 +737,10 @@ struct cxl_port *devm_cxl_add_port(struct device *h=
ost,
>  struct cxl_root *devm_cxl_add_root(struct device *host,
>  				   const struct cxl_root_ops *ops);
>  struct cxl_root *find_cxl_root(struct cxl_port *port);
> -void put_cxl_root(struct cxl_root *cxl_root);
> -DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
> =20
> +DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->por=
t.dev))
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) pu=
t_device(&_T->dev))
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
>=20




