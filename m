Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971B1C84AB;
	Mon, 21 Apr 2025 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257777; cv=none; b=A/09MNGqv4TvhnrTuzP8vekuv4UbP9hRBLJv7B2YbZhXBkZbb1qD6wKCaXW2eczofdjYxfT8pcnRO+/DNNwOO1O8ks+Mq44W43iwKBWdwnTd9N60CG3U/EJsrwK946eGWRoKI/NvsR2BH/9ZeIPGqYg57j3FNumJ+uTARgkJ4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257777; c=relaxed/simple;
	bh=ZSlHVkt9tZZj0NWeVHzHHJzzv4Ij0geBTQwO7I7vVHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iX/H6YOBE/aTrmJTteGKNT/KTD8pFQ6KM4oQfYNNGmcIOEh2nayILYBhtTrhGtSfFjLxXzFShJ9fcf83znWRR1Fe83tz1+d1VQmmrmWrCJDfyaf7u8Z3FDaLrWyayXxUvBaVW5YK/JHOdt4VmpMO93hjTrk45bjvwT71vcLKpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mqf7/ma3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mqf7/ma3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745257775; x=1776793775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSlHVkt9tZZj0NWeVHzHHJzzv4Ij0geBTQwO7I7vVHM=;
  b=Mqf7/ma309AhJfD/66esw+9DLIIE6mb4GQxlYv4EqcX+81jyY6wQVCHS
   WOcM9FVpCHWCnrANp7C6BtaENVvmwujNWNGWXd5LG8+X5wSBu2s9BSp+X
   ooXJKHSpM6tIUtblpPb2r5jq7e7UvlWmoh16YQ8d08CfaLfG3sLGF89Z7
   +wKjX+jpMfPr7XHSAcLQA7QWUDMEApx0m6qKpexETz6v9Gs1qUpFH/228
   s5FriVm1qoC/z/u7mta32GBtqqGknD+asrvWpwA25DDo4AnM6xW13VfDf
   I/vXgZ3OjX+ycPJZZALE3ERvCGbhVItrNFbIQF2rs0SRSVNOmo+EbMFe4
   w==;
X-CSE-ConnectionGUID: d4JfoaYOQ4qrAMfv4YndPw==
X-CSE-MsgGUID: 6Q6SPDa2S8ecu06s5EKydw==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46918678"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="46918678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 10:49:34 -0700
X-CSE-ConnectionGUID: 385rKdmmRyykdYZLHx0bfg==
X-CSE-MsgGUID: BuIr2BGcTlKA1oPIvvTpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="131633427"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.65])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 10:49:31 -0700
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
Subject: Re: [PATCH v4 04/14] cxl: Introduce parent_port_of() helper
Date: Mon, 21 Apr 2025 19:49:28 +0200
Message-ID: <17999655.87JKscXggJ@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-5-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:38=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Often a parent port must be determined. Introduce the parent_port_of()
> helper function for this.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>
I think that "often" doesn't provide any relevant information.
I would rephrase the commit message with something like that:

"Introduce the parent_port_of() helper function to avoid open
coding of determination of a parent port.".

Other than that:

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
>
>  drivers/cxl/core/port.c   | 15 +++++++++------
>  drivers/cxl/core/region.c | 11 ++---------
>  drivers/cxl/cxl.h         |  1 +
>  3 files changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6a44b6dad3c7..25eecb591496 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -602,17 +602,20 @@ struct cxl_port *to_cxl_port(const struct device *d=
ev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
> =20
> +struct cxl_port *parent_port_of(struct cxl_port *port)
> +{
> +	if (!port || !port->parent_dport)
> +		return NULL;
> +	return port->parent_dport->port;
> +}
> +EXPORT_SYMBOL_NS_GPL(parent_port_of, "CXL");
> +
>  static void unregister_port(void *_port)
>  {
>  	struct cxl_port *port =3D _port;
> -	struct cxl_port *parent;
> +	struct cxl_port *parent =3D parent_port_of(port);
>  	struct device *lock_dev;
> =20
> -	if (is_cxl_root(port))
> -		parent =3D NULL;
> -	else
> -		parent =3D to_cxl_port(port->dev.parent);
> -
>  	/*
>  	 * CXL root port's and the first level of ports are unregistered
>  	 * under the platform firmware device lock, all other ports are
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cbe762abf6b3..4f79cc17c9c8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1748,13 +1748,6 @@ static int cmp_interleave_pos(const void *a, const=
 void *b)
>  	return cxled_a->pos - cxled_b->pos;
>  }
> =20
> -static struct cxl_port *next_port(struct cxl_port *port)
> -{
> -	if (!port->parent_dport)
> -		return NULL;
> -	return port->parent_dport->port;
> -}
> -
>  static int match_switch_decoder_by_range(struct device *dev,
>  					 const void *data)
>  {
> @@ -1781,7 +1774,7 @@ static int find_pos_and_ways(struct cxl_port *port,=
 struct range *range,
>  	struct device *dev;
>  	int rc =3D -ENXIO;
> =20
> -	parent =3D next_port(port);
> +	parent =3D parent_port_of(port);
>  	if (!parent)
>  		return rc;
> =20
> @@ -1861,7 +1854,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpo=
int_decoder *cxled)
>  	 */
> =20
>  	/* Iterate from endpoint to root_port refining the position */
> -	for (iter =3D port; iter; iter =3D next_port(iter)) {
> +	for (iter =3D port; iter; iter =3D parent_port_of(iter)) {
>  		if (is_cxl_root(iter))
>  			break;
> =20
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index be8a7dc77719..24cec16d02a6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -724,6 +724,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  int cxl_num_decoders_committed(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);
>  struct cxl_port *to_cxl_port(const struct device *dev);
> +struct cxl_port *parent_port_of(struct cxl_port *port);
>  void cxl_port_commit_reap(struct cxl_decoder *cxld);
>  struct pci_bus;
>  int devm_cxl_register_pci_bus(struct device *host, struct device *uport_=
dev,
>=20




