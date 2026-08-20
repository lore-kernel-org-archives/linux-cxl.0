Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E92E92BA
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269391; cv=none; b=OBzY9g3R1vsZaOlxr1S0hlqy7UW5RS5eWLdPmuYYBKUUnsQFLXc/UVfM4xz95J4gCtsc1uFUxQF6kdp8GJR0vIvEkcW0IUEcSoILKq3A2JVB4217AGqxN9r5pcAOcXttpgeCrJMbLeCQB0zFD9LYsTlTmD54RJDRa+8uxgDgzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269391; c=relaxed/simple;
	bh=nW49dkt/ZaBWGM71MoD4+UmOR3mR1JHJG9pFbyDru/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Reeulo92jfsmzShSXQQ3D/4X3NBFrvFIIiZGXDXHCWG/ThSWb5UC8fHeLwbbVgPoMtPkEwHkioQdKyMeuIVlhmEubrQI5ulhRblUNeTTaS5XXr+cEMQo4QOUAaF5gG0joTkg5I8VcTCVfF87yU1HxQO3jQA7fkQr54750G39oxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd4bE4Me; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd4bE4Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6507D1F000E9;
	Thu, 20 Aug 2026 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787269389;
	bh=121gIWoIAnw5Zk9+AF1hFrSX6Cm4f2iSnEcxGEiiXmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nd4bE4MeGFHn64IqjPC6gqfJMZI5POjJmNAIOmRHhcyHmlixY84JLlqYXh/dpHTok
	 1qYTgPXe7uNTzKeIB0TQNqESYBmY9FYwrP3Qfxko+cz23IEObo9rBQvgKS4EXXzbfS
	 fl5g3BokruPn/DPZQ2aQVEm6ywMPYKxiDLYuqRXV6xeihjir2NF/QngL7Ufnb8VZcW
	 nVyY1jLo0tJeYTUY0m06VqR4vkNK9f0MKoVf2FbQCmfLBkqae0atQawuaou0eilW8S
	 uxMewPP0AMBrk/Gan4BtiM/1J66IQFwKVEKZ/NCs2G16x7/iv9wn276U99T3AU0Ii6
	 fqjj80DGyyeMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 23:43:08 +0000
Message-Id: <20260820234309.6507D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free read of device structure in find_pos_and_gran error=
 path.
--

--- Patch [2]: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapp=
ing ---
commit 74f53df9f58a0339cb5f29038f2e514904e34cf5
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Generalize endpoint position mapping

This commit alters the endpoint position calculation to support
mixed-granularity regions. It weights each decoder's contribution by its
relative granularity instead of assuming a uniform granularity across the
interleave hierarchy.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3b640c9ba5a08..4f367feaf6c84 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -1929,9 +1934,10 @@ static int find_pos_and_ways(struct cxl_port *port=
, struct range *range,
>  		return rc;
>  	}
>  	cxlsd =3D to_cxl_switch_decoder(dev);
> -	*ways =3D cxlsd->cxld.interleave_ways;
> +	ways =3D cxlsd->cxld.interleave_ways;
> +	*gran =3D cxlsd->cxld.interleave_granularity;
> =20
> -	for (int i =3D 0; i < *ways; i++) {
> +	for (int i =3D 0; i < ways; i++) {
>  		if (cxlsd->target[i] =3D=3D port->parent_dport) {
>  			*pos =3D i;
>  			rc =3D 0;

[Severity: High]
This is a pre-existing issue, but could the error handling path just after
this loop trigger a use-after-free?

Looking at find_pos_and_gran(), if the loop completes without finding a
match, rc remains -ENXIO. Immediately after the loop, put_device(dev) is
called, and then dev_err() formats an error message using cxlsd:

	put_device(dev);

	if (rc)
		dev_err(port->uport_dev,
			"failed to find %s:%s in target list of %s\n",
			dev_name(&port->dev),
			dev_name(port->parent_dport->dport_dev),
			dev_name(&cxlsd->cxld.dev));

Since cxlsd is derived from dev, does calling put_device() before dev_err()
release the structure prematurely and cause a read of freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787255388.gi=
t.alison.schofield@intel.com?part=3D2
