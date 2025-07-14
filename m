Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5A22127C;
	Mon, 14 Jul 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530998; cv=none; b=doANMaNlGX8XLtuCjJODoSV318IeTg5oF4xyStoqbeQEOUy55V+rgMMF11qnDTgDu5DOsgMBinXHc5aJbOSHdb5vkRPQf2KLujPJu/lAfM+kF9oUS492uoUqON2w490GDw/yNXP8PUDDfvTCW3W6x8zDJoJYYeoBDKjVZRncuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530998; c=relaxed/simple;
	bh=yR43T4+mWK2Yn+n75FT9j9VbpxdhyZ/UEzg5n/QH1WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKD+GcT9v4C200WkPmVB956LgVaSU9wqG5Vo29uBDxdNzTg4o3+kBDzcDIV3xgUFb9ISoyrwgVHU4I+6dV7Fvdw2ntEg7qqPVlj24vGREGn8Yw0P8MqMzDHVDiPacWwwMEVwAayIm8bd/iS5REx0NMwqtdrfDG9jZ5159bYhQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Af7K4TWn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Af7K4TWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752530996; x=1784066996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yR43T4+mWK2Yn+n75FT9j9VbpxdhyZ/UEzg5n/QH1WQ=;
  b=Af7K4TWn1VXaU6nSdFGF+NSLEJGBL+iC6yRzzIjGxO2julCxEvCYBoZt
   Gh4BrNoI8STba4IEARfSR33NInVHvDErHCz12J+H1PqZEiBpBaUziGBMR
   c0IHR7Cv/DpxmwRmrTRHQKg5vL/rUQDmhopWCgamarwnkDIrRiqCIRoVZ
   o2zva5/ux/ntQ/H4oWEMNQ2rQeh5f5SSqKEsMf6al9ZB0JvNxIO6msPdP
   jizvQdiMsqWUtYThbYAYUvTZUeIw+rCXosWOzeKH/VIyOb2vRSu0B84H8
   /oAl7OHkM2bnTMsw5FfQ/OdJEuuZArW4MXYH/QI9qlV0xE+O5UnCCtbvy
   Q==;
X-CSE-ConnectionGUID: icIaw49KSBee2UuZGBiQfg==
X-CSE-MsgGUID: 0nXfR3g7Sh+JK8DYC1M/+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77273984"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="77273984"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:09:55 -0700
X-CSE-ConnectionGUID: wy+jXHKZR325i2nltRAVeQ==
X-CSE-MsgGUID: Xcp/R4WpS+SPxyBNiIl6eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="162592515"
Received: from slindbla-desk.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.95])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:09:51 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject:
 Re: [PATCH v3 7/8] cxl/region: Consolidate cxl_decoder_kill_region() and
 cxl_region_detach()
Date: Tue, 15 Jul 2025 00:09:48 +0200
Message-ID: <3563734.XAFRqVoOGU@fdefranc-mobl3>
In-Reply-To: <20250711234932.671292-8-dan.j.williams@intel.com>
References:
 <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-8-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, July 12, 2025 1:49:31=E2=80=AFAM Central European Summer Time =
Dan Williams wrote:
> Both detach_target() and cxld_unregister() want to tear down a cxl_region
> when an endpoint decoder is either detached or destroyed.
>=20
> When a region is to be destroyed cxl_region_detach() releases
> cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
>=20
> This "reverse" locking pattern is difficult to reason about, not amenable
> to scope-based cleanup, and the minor differences in the calling context =
of
> detach_target() and cxld_unregister() currently results in the
> cxl_decoder_kill_region() wrapper.
>=20
> Introduce cxl_decoder_detach() to wrap a core __cxl_decoder_detach() that
> serves both cases. I.e. either detaching a known position in a region
> (interruptible), or detaching an endpoint decoder if it is found to be a
> member of a region (uninterruptible).
>=20
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> ---
>  drivers/cxl/core/core.h   |  15 +++++-
>  drivers/cxl/core/port.c   |   9 ++--
>  drivers/cxl/core/region.c | 103 ++++++++++++++++++++++----------------
>  3 files changed, 75 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..2be37084409f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -12,6 +12,11 @@ extern const struct device_type cxl_pmu_type;
> =20
>  extern struct attribute_group cxl_base_attribute_group;
> =20
> +enum cxl_detach_mode {
> +	DETACH_ONLY,
> +	DETACH_INVALIDATE,
> +};
> +
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> @@ -20,7 +25,11 @@ extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
>  extern const struct device_type cxl_dax_region_type;
>  extern const struct device_type cxl_region_type;
> -void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
> +
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode);
> +
>  #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
>  #define CXL_REGION_TYPE(x) (&cxl_region_type)
>  #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
> @@ -48,7 +57,9 @@ static inline int cxl_get_poison_by_endpoint(struct cxl=
_port *port)
>  {
>  	return 0;
>  }
> -static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *=
cxled)
> +static inline int cxl_decoder_detach(struct cxl_region *cxlr,
> +				     struct cxl_endpoint_decoder *cxled,
> +				     int pos, enum cxl_detach_mode mode)
>  {
>  }
>  static inline int cxl_region_init(void)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eb46c6764d20..087a20a9ee1c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2001,12 +2001,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
> =20
>  static void cxld_unregister(void *dev)
>  {
> -	struct cxl_endpoint_decoder *cxled;
> -
> -	if (is_endpoint_decoder(dev)) {
> -		cxled =3D to_cxl_endpoint_decoder(dev);
> -		cxl_decoder_kill_region(cxled);
> -	}
> +	if (is_endpoint_decoder(dev))
> +		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
> +				   DETACH_INVALIDATE);
> =20
>  	device_unregister(dev);
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2a97fa9a394f..4314aaed8ad8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2135,27 +2135,43 @@ static int cxl_region_attach(struct cxl_region *c=
xlr,
>  	return 0;
>  }
> =20
> -static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> +static struct cxl_region *
> +__cxl_decoder_detach(struct cxl_region *cxlr,
> +		     struct cxl_endpoint_decoder *cxled, int pos,
> +		     enum cxl_detach_mode mode)
>  {
> -	struct cxl_port *iter, *ep_port =3D cxled_to_port(cxled);
> -	struct cxl_region *cxlr =3D cxled->cxld.region;
>  	struct cxl_region_params *p;
> -	int rc =3D 0;
> =20
>  	lockdep_assert_held_write(&cxl_region_rwsem);
> =20
> -	if (!cxlr)
> -		return 0;
> +	if (!cxled) {
> +		p =3D &cxlr->params;
> =20
> -	p =3D &cxlr->params;
> -	get_device(&cxlr->dev);
> +		if (pos >=3D p->interleave_ways) {
> +			dev_dbg(&cxlr->dev, "position %d out of range %d\n",
> +				pos, p->interleave_ways);
> +			return ERR_PTR(-ENXIO);
> +		}
> +
> +		if (!p->targets[pos])
> +			return NULL;
> +		cxled =3D p->targets[pos];
> +	} else {
> +		cxlr =3D cxled->cxld.region;
> +		if (!cxlr)
> +			return NULL;
> +		p =3D &cxlr->params;
> +	}
> +
> +	if (mode =3D=3D DETACH_INVALIDATE)
> +		cxled->part =3D -1;
> =20
>  	if (p->state > CXL_CONFIG_ACTIVE) {
>  		cxl_region_decode_reset(cxlr, p->interleave_ways);
>  		p->state =3D CXL_CONFIG_ACTIVE;
>  	}
> =20
> -	for (iter =3D ep_port; !is_cxl_root(iter);
> +	for (struct cxl_port *iter =3D cxled_to_port(cxled); !is_cxl_root(iter);
>  	     iter =3D to_cxl_port(iter->dev.parent))
>  		cxl_port_detach_region(iter, cxlr, cxled);
> =20
> @@ -2166,7 +2182,7 @@ static int cxl_region_detach(struct cxl_endpoint_de=
coder *cxled)
>  		dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
>  			      dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			      cxled->pos);
> -		goto out;
> +		return NULL;
>  	}
> =20
>  	if (p->state =3D=3D CXL_CONFIG_ACTIVE) {
> @@ -2180,21 +2196,42 @@ static int cxl_region_detach(struct cxl_endpoint_=
decoder *cxled)
>  		.end =3D -1,
>  	};
> =20
> -	/* notify the region driver that one of its targets has departed */
> -	up_write(&cxl_region_rwsem);
> -	device_release_driver(&cxlr->dev);
> -	down_write(&cxl_region_rwsem);
> -out:
> -	put_device(&cxlr->dev);
> -	return rc;
> +	get_device(&cxlr->dev);
> +	return cxlr;
>  }
> =20
> -void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> +/*
> + * Cleanup a decoder's interest in a region. There are 2 cases to
> + * handle, removing an unknown @cxled from a known position in a region
> + * (detach_target()) or removing a known @cxled from an unknown @cxlr
> + * (cxld_unregister())
> + *
> + * When the detachment finds a region release the region driver.
> + */
> +int cxl_decoder_detach(struct cxl_region *cxlr,
> +		       struct cxl_endpoint_decoder *cxled, int pos,
> +		       enum cxl_detach_mode mode)
>  {
> -	down_write(&cxl_region_rwsem);
> -	cxled->part =3D -1;
> -	cxl_region_detach(cxled);
> +	struct cxl_region *detach;
> +
> +	/* when the decoder is being destroyed lock unconditionally */
> +	if (mode =3D=3D DETACH_INVALIDATE)
> +		down_write(&cxl_region_rwsem);
> +	else {
> +		int rc =3D down_write_killable(&cxl_region_rwsem);
> +
> +		if (rc)
> +			return rc;
> +	}
> +
> +	detach =3D __cxl_decoder_detach(cxlr, cxled, pos, mode);
>  	up_write(&cxl_region_rwsem);
> +
> +	if (detach) {
> +		device_release_driver(&detach->dev);
> +		put_device(&detach->dev);
> +	}
> +	return 0;
>  }
> =20
>  static int attach_target(struct cxl_region *cxlr,
> @@ -2225,29 +2262,7 @@ static int attach_target(struct cxl_region *cxlr,
> =20
>  static int detach_target(struct cxl_region *cxlr, int pos)
>  {
> -	struct cxl_region_params *p =3D &cxlr->params;
> -	int rc;
> -
> -	rc =3D down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
> -	if (pos >=3D p->interleave_ways) {
> -		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
> -			p->interleave_ways);
> -		rc =3D -ENXIO;
> -		goto out;
> -	}
> -
> -	if (!p->targets[pos]) {
> -		rc =3D 0;
> -		goto out;
> -	}
> -
> -	rc =3D cxl_region_detach(p->targets[pos]);
> -out:
> -	up_write(&cxl_region_rwsem);
> -	return rc;
> +	return cxl_decoder_detach(cxlr, NULL, pos, DETACH_ONLY);
>  }
> =20
>  static size_t store_targetN(struct cxl_region *cxlr, const char *buf, in=
t pos,
> --=20
> 2.50.0
>=20
>=20
>=20




