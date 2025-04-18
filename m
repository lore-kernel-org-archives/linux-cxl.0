Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9E1C57B2;
	Fri, 18 Apr 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994059; cv=none; b=GHOSYPoDEVhB9QkMgKotYC83L+Xe40F3HyGDpZPEunUfrO852DZLajq4mCFwBaIa8wOKnpdRUsE+8Q8LlTw0oA3/1u73q94KmJiMukNwfIBkAsucLxaXpTJF7wPtv5wGvmjxmpn2/CgowpaHL24cgd2amuESpeEkptMGSVLaXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994059; c=relaxed/simple;
	bh=pjfHQJAcshL8dMOtbsmbjYJjoBDacDf3BLU0sbW01bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLEsTv+og4G/hWc1UshcpVS9yumI3K3dfbfBShRMtuV0DgfqHXakKJZKBykaWG+/eW6oHKC7ENW3S3JHMW451EVfTeLTmUNE6Lw2W/TqwjIFDW/a/HCyNyIbpQvXfvW8EJSn5Huz22XGCuaXrD6CIqepHMXNxiIaPcbPtI4ywj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDuhtAZb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDuhtAZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744994058; x=1776530058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pjfHQJAcshL8dMOtbsmbjYJjoBDacDf3BLU0sbW01bQ=;
  b=PDuhtAZbbuAzbjnCIXLbP+zjvjiMxZ2akJp0+Xb0nOjfQ4bU0aSXbv2i
   QsW3Xheo2Z9lAshpwt8nSwJMNdnR1GnlDlhoqwpNr9T7XV7fuOVcPRoH+
   UpwV5B31P9P6wKMKkOlJIXOIGghXf6w1qPV6FtLqCB7Rxob9gyfd0ipkf
   b89WiF5pRykrZeof7ddLG7njfB9bXWn71HLY88g800zDI92ht1EqgMCoz
   2Nw8AU9WVbjrWzFtxn49cs+2H/P2c1A1QUQBWYWainSjFy2ATPMS4FE4i
   sVrSR+lWkh7HTpdgLY1OC1hLAsPAdlnrXHPrjT2Pu7GC03cCMMdKDSfO9
   w==;
X-CSE-ConnectionGUID: dqDcJainSS+VIeEtzGIWYQ==
X-CSE-MsgGUID: estLbzrKT1uygnmyRSo3XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50287925"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="50287925"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:34:16 -0700
X-CSE-ConnectionGUID: OkCttVwzSAiHYtle5PQoTA==
X-CSE-MsgGUID: WlzfQ5qKRymFFIH2uSakRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="154332391"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.252])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:34:13 -0700
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
Subject: Re: [PATCH v4 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Date: Fri, 18 Apr 2025 18:34:09 +0200
Message-ID: <4257228.aVYbkx8dNR@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-4-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, March 6, 2025 5:44:37=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> There are various configuration cases of HDM decoder registers causing
> different code paths. Add comments to cxl_hdm_decode_init() to better
> explain them.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Tested-by: Gregory Price <gourry@gourry.net>
>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
>
> ---
>  drivers/cxl/core/pci.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6386e84e51a4..ef4b08abe424 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -416,9 +416,21 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,=
 struct cxl_hdm *cxlhdm,
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
> =20
> +	/*
> +	 * If the HDM Decoder Capability does not exist and DVSEC was
> +	 * not setup, the DVSEC based emulation cannot be used.
> +	 */
>  	if (!hdm)
>  		return -ENODEV;
> =20
> +	/*
> +	 * The HDM Decoder Capability exists but is globally disabled.
> +	 */
> +
> +	/*
> +	 * If the DVSEC CXL Range registers are not enabled, just
> +	 * enable and use the HDM Decoder Capability registers.
> +	 */
>  	if (!info->mem_enabled) {
>  		rc =3D devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -427,6 +439,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,=
 struct cxl_hdm *cxlhdm,
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
> =20
> +	/*
> +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> +	 * [High,Low] when HDM operation is enabled the range register values
> +	 * are ignored by the device, but the spec also recommends matching the
> +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> +	 * are expected even though Linux does not require or maintain that
> +	 * match. Check if at least one DVSEC range is enabled and allowed by
> +	 * the platform. That is, the DVSEC range must be covered by a locked
> +	 * platform window (CFMWS). Fail otherwise as the endpoint's decoders
> +	 * cannot be used.
> +	 */
> +
>  	root =3D to_cxl_port(port->dev.parent);
>  	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
>  		root =3D to_cxl_port(root->dev.parent);
> @@ -454,15 +478,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,=
 struct cxl_hdm *cxlhdm,
>  		return -ENXIO;
>  	}
> =20
> -	/*
> -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> -	 * [High,Low] when HDM operation is enabled the range register values
> -	 * are ignored by the device, but the spec also recommends matching the
> -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> -	 * are expected even though Linux does not require or maintain that
> -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> -	 * Decoder Capability Enable.
> -	 */
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
>=20




