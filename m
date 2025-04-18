Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1986250;
	Fri, 18 Apr 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993730; cv=none; b=Kwr7GKS/VfZ13YGzaw1XbRjG0xzYyiuyPwM99kBZmn4XQAjE2ZYSM5wr5eviysVtbtgSrIIBonqCoMxrCNiNLFwrGWY2UrQatfbVSCt9ATMQgssrQ4hKxmYwv9qkKmTS/UGLwDaSFbkd7tGbDKzzXZBDdbL+cTiQqGEsa/gibgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993730; c=relaxed/simple;
	bh=jM2jCqNrk/+awn4rQJCPLFiok9w2WoVJQHUX2vbK3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibziMoVpWqZaCNozF9kI4LtPnD9oxK2/rgVPSClJ5LzpSwxSeVTZBc025VI6FSV7ZsH7PYIvrw/TJN9j7r7bq+PNK6bXyTuxG0d/Ml6cuiy8GE1vV0H80NmQG3p9lyhFREwt4jwLVpb5n4//ZakP3z0jyK1d9tJf8Vpl+5KkQgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSotlHhr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSotlHhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744993728; x=1776529728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jM2jCqNrk/+awn4rQJCPLFiok9w2WoVJQHUX2vbK3do=;
  b=cSotlHhrS4RaBOaP2z2KrcmEjKd+pyJK6j0pIB7QlY9oeC7atcwFNxSC
   bOS4GTHRlV+omtiPxsE+H4o7UfwF8R9qM09DoZCi45OXIPuq3n5HPktqK
   mrzAP+xkG9PpK73QaL0Zv3EzvhQaIZ0O0qXT31kOo62TsZNPUr3bC60+N
   9tOtnwHRmnWKTtotkp2edP4SG0i5chC3MZi9ZJIJ31CNP8MEWnVi3qdw+
   vKFJLGpfO4p+RJUKlSvu6xRRFQQUYWc6IKvUoND4jHxVXTAwCZQ3GErQ6
   w6FQy863vPBLFpSKG0JHv+pr536kif0m5NmTTSGtZtvqGl8DLF+T14e7v
   A==;
X-CSE-ConnectionGUID: wA0Vx0A7SxyzvvdmqKTFOw==
X-CSE-MsgGUID: +SW2H5bdT+mAd7xxGFUd6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="57286889"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="asc'?scan'208";a="57286889"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:28:47 -0700
X-CSE-ConnectionGUID: hg6qTNsRRBmoWzU31FojWA==
X-CSE-MsgGUID: f4KMTDDURxiYJhW9LRwumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="asc'?scan'208";a="131098439"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.252])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 09:28:44 -0700
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
Subject: Re: [PATCH v4 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
Date: Fri, 18 Apr 2025 18:28:40 +0200
Message-ID: <5321893.0KrE1Onz32@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-3-rrichter@amd.com>
References:
 <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3307009.N2xkq1pzWS";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3307009.N2xkq1pzWS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Date: Fri, 18 Apr 2025 18:28:32 +0200
Message-ID: <5321893.0KrE1Onz32@fdefranc-mobl3>
In-Reply-To: <20250306164448.3354845-3-rrichter@amd.com>
MIME-Version: 1.0

On Thursday, March 6, 2025 5:44:36=E2=80=AFPM Central European Summer Time =
Robert Richter wrote:
> Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
> cxl_hdm_decode_init()") changed the code flow in this function. The
> root port is determined before a check to leave the function. Since
> the root port is not used by the check it can be moved to run the
> check first. This improves code readability and avoids unnesessary
> code execution.
>=20
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Tested-by: Gregory Price <gourry@gourry.net>
>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
>
> ---
>  drivers/cxl/core/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 33c3bdd35b24..6386e84e51a4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -419,14 +419,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,=
 struct cxl_hdm *cxlhdm,
>  	if (!hdm)
>  		return -ENODEV;
> =20
> -	root =3D to_cxl_port(port->dev.parent);
> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> -		root =3D to_cxl_port(root->dev.parent);
> -	if (!is_cxl_root(root)) {
> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> -		return -ENODEV;
> -	}
> -
>  	if (!info->mem_enabled) {
>  		rc =3D devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -435,6 +427,14 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds,=
 struct cxl_hdm *cxlhdm,
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  	}
> =20
> +	root =3D to_cxl_port(port->dev.parent);
> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> +		root =3D to_cxl_port(root->dev.parent);
> +	if (!is_cxl_root(root)) {
> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> +		return -ENODEV;
> +	}
> +
>  	for (i =3D 0, allowed =3D 0; i < info->ranges; i++) {
>  		struct device *cxld_dev;
> =20
>=20


--nextPart3307009.N2xkq1pzWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEPKnol7Erd70tN+Lb50DaXiQpiWEFAmgCfbAACgkQ50DaXiQp
iWHSngf/Yl+uC0WI+tOT/54ojH6pu6UvRd/tzd0NRl2/pw9LBmL/huF9Y/Tke+ev
84/MvS6Muipa9mDq5RFSIs3rCpIMTCj9uW/hLm0gcih0FnUWAIbNOHjWn91WoZLF
jvLluz2mbHhIceBlKh1C4T/FQJVoo3dWbuQ56DrpvQTO3R/djrf9eaEvAk+51Gbq
i4csZwNlYfvefN4TmMUoQSMymmyxNVeWksOid2gFpv4PCDWBYLnFhTENxE9ZO2EK
nWEoeeP+9Tenuwj7V4AdpMbyH1bCG1jDIicBbv5u9Ag4TY7SR1uwA9Cp+3csQlVW
CfATgNN1oO08U9doGb+M7aGCQbBvkw==
=Cj3P
-----END PGP SIGNATURE-----

--nextPart3307009.N2xkq1pzWS--



