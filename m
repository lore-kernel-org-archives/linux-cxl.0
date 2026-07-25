Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D429D264
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942799; cv=none; b=UcnmTYshNklNIAtCQxcxN8sQDLs682uY77DyVKopxBB93xQk/OF5Z/+1NixCiRTC9s+VzhDbZJe5TeoDZPI0SJ+boYHNc0pydtMvU57xJwiI+EKY6T315jPu4h4HzcD/rAdN2D+8PM72jb+ZEcNMWx6+f2QpRoabDaV8fLnvuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942799; c=relaxed/simple;
	bh=37j6SoLNCBoXfP3caznksKBP3NQVdfyQzZxL1eSADw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ig2jVpisbrboRoU36Q9jIaQpjxyLESwn7nRQcpPbWIWKo+CJRcGpBMCo4sTUVYDE1oVk88xE4KjdFqK9lF/y9Z0KNwbqiBywEIfCqoME7gHQyb0p/STBkj2jVX093riFivgiSWlU6j30f7CUoKCXnBpcOCS2RtUaW9k3b16lVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z43k1WXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z43k1WXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34231F00AC4;
	Sat, 25 Jul 2026 01:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784942798;
	bh=UH95vcON60l63C2TTJlT+5cBuIBRCdD2S52G4DVjZpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z43k1WXjqZ1ew9Ab8i/VJiJ5y7MgDdE4v/0W+bY38WRNDYEtPOKXSGxej1QLyNkQw
	 hv1P8hneOmVELTgQb/p51NzI7pIsZdlDxPd9KZdHvcuaw13K0J5XujUfH5lRVmsred
	 DNKUWAUO8MKu9AVFUETCjNbnm6m7ZB5kRd02aTHQ05mcsy2EAdUN2OqpnVLog7vg8E
	 UIV567uyk2ZTt5l3mCpeZRLMrCFbMQmTFCo1j2gzV6xuqgjPyrPN838clyglexBAZZ
	 OsdowvSqAnWog5LVQ7NNzlPGZ93NCHl2SB2oUKgeWlxfWaudRItrUxkZ7i90LCOM8r
	 uecMcDhNwck9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <5b1f9970140ad1ea5924de06b7e6879e3b9deea1.1784940306.git.alison.schofield@intel.com>
References: <cover.1784940306.git.alison.schofield@intel.com>
 <5b1f9970140ad1ea5924de06b7e6879e3b9deea1.1784940306.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 01:26:37 +0000
Message-Id: <20260725012637.F34231F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] During region auto-discovery, a passthrough decoder's interleave g=
ranularity is not updated to its correct topological value, causing valid i=
nterleaving descendants to fail auto-discovery.
--

--- Patch [1]: [PATCH v3 1/2] cxl/region: Allow passthrough decoders with >=
16K granularity ---
commit d213bad3e4cb8647e64aafb5eacaa82258aa533b
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Allow passthrough decoders with >16K granularity

This commit allows passthrough decoders to have computed granularities larg=
er
than 16K by treating the interleave granularity as a don't-care value for
non-interleaving decoders. It updates the region configuration to skip
validation and hardware encodability checks for these granularities, while
keeping the computed value to seed descendant decoder setup.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
[ ... ]
> +	ig =3D parent_ig * parent_iw;
> =20
> -	rc =3D eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +	/*
> +	 * Keep the computed granularity for descendant setup. Only
> +	 * interleaving decoders require an encodable granularity.
> +	 */
> +	if (iw > 1) {
> +		rc =3D granularity_to_eig(ig, &eig);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: invalid granularity calculation (%d * %d)\n",
> +				dev_name(&parent_port->dev), parent_ig,
> +				parent_iw);
> +			return rc;
> +		}
>  	}
> =20
>  	if (iw > 8 || iw > cxlsd->nr_targets) {

[Severity: High]
When auto-discovering a region with a passthrough decoder (iw =3D=3D 1), do=
es this
skip updating the decoder's interleave granularity to the computed 'ig'?

Looking at cxl_port_setup_targets(), the auto-discovery path handles
non-interleaving decoders by bypassing the granularity mismatch check:

    if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
            if (cxld->interleave_ways !=3D iw ||
                (iw > 1 && cxld->interleave_granularity !=3D ig) || ...

However, because cxld->interleave_granularity is never updated to 'ig' for
auto-discovered passthrough decoders, won't it retain its stale hardware
value (which could be a don't-care value like 0)?

If so, when descendant decoders load their parent's interleave granularity
earlier in cxl_port_setup_targets():

    parent_rr =3D cxl_rr_load(parent_port, cxlr);
    parent_cxld =3D parent_rr->decoder;
    parent_ig =3D parent_cxld->interleave_granularity;

won't they inherit this stale hardware don't-care value? This appears to
cause their own expected 'ig' calculation to fail validation during
auto-discovery, resulting in the region being rejected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784940306.gi=
t.alison.schofield@intel.com?part=3D1
