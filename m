Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F12FFDF8
	for <linux-cxl@vger.kernel.org>; Sat, 11 Jul 2026 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783800915; cv=none; b=S3BX25NcXzKr3ypI0AwURA3f28pFvWbnTwJggjTZHCoNQMFnUjAxcE1WR54/qNBzdmOgU7tj+rWqERGvCHUNMZdn+pFJtXgrTBBTKnBSU+TBZ+byL22oPwlBeDcGtntebTUDPswYPZL6h+9AOJ3STi+Kpr/cPF5kVL0MZFwlL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783800915; c=relaxed/simple;
	bh=fgqFMWL0M2qi2AiNYAvx7PYjU+EWABu5MaaMzb6almQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCXdpDdvxrdGwwVPF7krmXQF0bXXA72gdVv3sRObDYOpgPVJ4+k8Gqs8OWvE+Tdy+Q8K4ayhkiw/P8gIGis6+K3tjB7lF+NsofMzRk9jRXfSNFxWeWtsuNiaAmCGW6a3UlA2fJzgDREJSw08TGu/lbo8jv/iV4QtxCtP+jXr89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekpc1Cqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekpc1Cqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082531F000E9;
	Sat, 11 Jul 2026 20:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783800908;
	bh=0Wx0i11mCsNq5dKnAjcgavgIXrfSVoiPwuRiL4wkthI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ekpc1CqmH2AemKdJYc3z3JAdYBWhnJ2pMCSWV15gMyegpHjcrDHSWCDtcEarLmaVD
	 PmtK+879VuoE21S/veo1qpDOtukaqbL+lEFYx/IU97i/c8k8UxLZupsyukdTkdlJJC
	 7QxddeZXAlK6lVcvnLQV7KO0wPk+afpPz2uxPae11LHowcPwWx/NX7djJWML8jdjAr
	 AKhZUPMFomgyWVfECHA7afqyZnl9py84A3Nd4hthfj9KUFo4llGTVv5gVOS5TLE/qx
	 mcCA5Fy/rnZrS6xJh/G9yqUX9/wuC9UdNubtzjyiP4dh8ezX6nOGL2d75QUVz1JYmx
	 qDQZLybafbLMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
References: <cover.1783795720.git.alison.schofield@intel.com>
 <9a798f6b445ca8f2b16743d3e16fa289efadd86a.1783795720.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 20:15:07 +0000
Message-Id: <20260711201508.082531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] During auto-discovery (CXL_REGION_F_AUTO), passthrough decoders fa=
il to update their `interleave_granularity` software state to the computed =
value, causing downstream decoders to inherit incorrect granularity and fai=
l validation upon reboot.
--

--- Patch [1]: [PATCH v2 1/2] cxl/region: Allow passthrough decoders with >=
16K granularity ---
commit 9e2526342188a97e338bfc63d454c253f1e2b3ef
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Allow passthrough decoders with >16K granularity

This commit allows passthrough decoders beneath wide parent interleaves
to have a granularity exceeding 16K by programming a don't-care value
in hardware for non-interleaving decoders.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..d164662668c19 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -691,9 +691,16 @@ static void cxld_set_interleave(struct cxl_decoder *=
cxld, u32 *ctrl)
>  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
>  		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> -		      "invalid interleave_granularity: %d\n",
> -		      cxld->interleave_granularity))
> +
> +	/*
> +	 * A non-interleaving decoder ignores the IG field. Encode a
> +	 * don't-care value instead of validating the stored granularity.
> +	 */
> +	if (cxld->interleave_ways =3D=3D 1)
> +		eig =3D 0;
> +	else if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &ei=
g),
> +			   "invalid interleave_granularity: %d\n",
> +			   cxld->interleave_granularity))
>  		return;
> =20
>  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);

[ ... ]

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1e211542b6b64..5a443551288c4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	rc =3D granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
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
Does this code break region auto-discovery on reboot for topologies
containing a passthrough decoder?

When cxld_set_interleave() configures a passthrough decoder, it now sets
eig =3D 0 (a don't-care value) in the hardware.

Upon reboot, reading this hardware state will initialize the decoder's
software interleave_granularity to a stale value.

During auto-discovery in cxl_port_setup_targets(), the CXL_REGION_F_AUTO
path skips validating the granularity for passthrough decoders (iw =3D=3D 1=
),
but it appears to be missing an update to correct the software state:

	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
		if (cxld->interleave_ways !=3D iw ||
		    (iw > 1 && cxld->interleave_granularity !=3D ig) ||
		    !spa_maps_hpa(p, &cxld->hpa_range) ||
		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
			...
			return -ENXIO;
		}
		/* missing update: cxld->interleave_granularity =3D ig; */
	}

If cxld->interleave_granularity is not updated to the computed ig here, won=
't
any interleaving descendants read the stale parent_ig, compute a mismatched
expected granularity, and fail validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783795720.gi=
t.alison.schofield@intel.com?part=3D1
