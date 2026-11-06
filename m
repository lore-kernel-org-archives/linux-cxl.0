Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003758;
	b=ZWU/t8xUtKpi7zrevleJssMCF+Q7jFHGvnKfrB2cfjcx8mJ3Q5K8LNzl3E9VJrM6j/FK
	 AiISgblXCadU8BUmP13AfpWTQ65n9Am2oBOl84KLdV+Pt++xwUTzFrQuMpXcixrXU33c+
	 8kHm0+BJFwnrHv80CI3/Y6B1b3naA24+zw5oPiWhm+Q+zJnxtYZbKpssftYVvi2mDNXAY
	 CKKPVyl+GY/qSzpNJjHLiuv/AjVRLqfHTQuOyiqyCdnLB2ACEIlhYOyAqVnt/meDC4psn
	 94vizLS4+EQZg2yztq9DE+iF4cNNe14pdFU4gdM3vQpsvc34duMDRTFEXZOX6HY/pkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003758;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tWCsU6H3CjztQNT0AJxZxWnMLbC9Rif4oAlccU6FPCA=;
	b=nwJIH0LMuf68aaYldZnmEjT3n44NYJpSn2tfdlE3b31hAgQVC9CpTlUDZqw5fSlB/NKo
	 d1WaPPtQBmxwwZferk918Rc29krdLRvKYZfcF5JNHx+00B88fkTxKxiBP/GKqZppYL3+C
	 0UKH3E71gKhDyfbsdiSlPF2t+JgaLLAzLazWM+AVIHqyNuMXjkbauKJbR4kjQ2wTx1520
	 ohXQczdzrgm1o18NNI2GzE13WGnHBjLTEkGhEWy/XrF5FAK6/09ZUhnKDsSE261yhUYVU
	 pnGPDUIdCN6sDxM78ovffsT9+A4neesec3DTF9SCJCwEAeFknjlZe0+YuHvQa5rxV8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJA+xZUm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A804606A32C
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJA+xZUm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4A71F008A1;
	Fri,  6 Nov 2026 22:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794003758;
	bh=tWCsU6H3CjztQNT0AJxZxWnMLbC9Rif4oAlccU6FPCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJA+xZUmCKnRNaQDHIaO4uPDoXWDpkGtBaFi2M64HJqaqGrkjLqfKSndhxZoBVVmq
	 rftkfKJxnWuLBQ87E0EHEqvc+7uCahcvBu7tb67Z0799fih+m7uvuBlFAM+ojgGY1h
	 R0oXGNzKPYP7OrWPB3v1kJO0EQCz1ro2MJr237a+f5+FlpgXysWbcqCS0zx/IlPdfg
	 5ly+2w+AzJIJA81ZSMtXpuhjHpHCMHynzqKIH6M/yPxja0HbseLCyBIyUj1mx+SCqV
	 66cLBEIRIMOj4YBdCPLiKq/OdrhGu8W/7B6vIWGKI7bTQG/viN5krPvQgD5QFb5W0i
	 sR/KXTwdHMlCw==
Message-ID: <sashiko-outbox-202327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] cxl/region: Support auto region granularity
 finer than the root
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <15338cf5f174c87f414e4518b24edb3c1f8371bd.1794000806.git.alison.schofield@intel.com>
References: <cover.1794000806.git.alison.schofield@intel.com>
 <15338cf5f174c87f414e4518b24edb3c1f8371bd.1794000806.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 22:22:37 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] cxl/region: passthrough parent granularity used in
  cxl_port_calc_interleave()
- [Medium] cxl/region: unvalidated endpoint positions in
  cxl_region_sort_targets()
--

commit d69ce1cc3e00f111d2894f426382e5b9afaa5815
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Support auto region granularity finer than the root

This commit adds support for assembling auto-discovered CXL regions whose
interleave granularity is finer than the interleaving root decoder, and
updates unaligned region offset-to-DPA translation to use the region
granularity and ways.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 1594bec3930bf..0a39e634b4b0a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -1449,6 +1495,14 @@ static int cxl_port_peer_distance(struct cxl_port =
*port, struct cxl_region *cxlr
>  	struct cxl_port *iter =3D port;
>  	int distance =3D 1;
> =20
> +	/*
> +	 * A finer-than-root region refines toward the endpoints, so peer
> +	 * targets at the finest interleaving level occupy consecutive region
> +	 * positions.
> +	 */
> +	if (cxl_region_is_finer_than_root(cxlr))
> +		return 1;
> +
>  	do {
>  		cxl_rr_iter =3D cxl_rr_load(iter, cxlr);
>  		distance *=3D cxl_rr_iter->nr_targets;

[Severity: Medium]
Can check_last_peer() index out of bounds or dereference NULL in
p->targets[] when cxl_port_peer_distance() returns 1?

During auto-region assembly in cxl_region_attach(),
cxl_region_sort_targets() runs before cxl_region_setup_targets() validates
intermediate decoder granularities.  cxl_port_interleave_pos() scales pos
by gran / region_gran using the unvalidated decoder granularity, and
cxl_region_sort_targets() only checks cxled->pos < 0 without verifying
that the sorted positions match 0 .. p->nr_targets - 1:

drivers/cxl/core/region.c:cxl_region_sort_targets() {
	for (i =3D 0; i < p->nr_targets; i++) {
		struct cxl_endpoint_decoder *cxled =3D p->targets[i];

		cxled->pos =3D cxl_calc_interleave_pos(cxled, cxlr);
		...
		if (cxled->pos < 0)
			rc =3D -ENXIO;
	}
	/* Keep the cxlr target list in interleave position order */
	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
	     cmp_interleave_pos, NULL);
}

If firmware programs a bogus granularity on an intermediate decoder,
cxled->pos can exceed p->nr_targets or CXL_DECODER_MAX_INTERLEAVE (or
produce duplicate positions).  When cxl_region_setup_targets() then calls
check_last_peer() with distance =3D=3D 1 at an upper port, pos < distance o=
nly
rejects pos < 1 before indexing p->targets[pos - 1] and dereferencing
cxled_peer.  Because cxl_region_attach_position() attaches endpoints using
the loop index i while cxled->pos !=3D i, later teardown in
__cxl_decoder_detach() also hits dev_WARN_ONCE() and fails to detach the
endpoint.

Validating that p->targets[i]->pos =3D=3D i for all targets after sort() in
cxl_region_sort_targets() would catch both out-of-range and duplicate
positions before attachment and target setup proceed.

> @@ -1476,15 +1530,17 @@ static int cxl_port_parent_interleave(struct cxl_=
port *port,
>  	int parent_iw, parent_ig;
> =20
>  	if (is_cxl_root(parent_port)) {
> -		/*
> -		 * Root decoder IG is always set to value in CFMWS which
> -		 * may be different than this region's IG.  We can use the
> -		 * region's IG here since interleave_granularity_store()
> -		 * does not allow interleaved host-bridges with
> -		 * root IG !=3D region IG.
> -		 */
> -		parent_ig =3D p->interleave_granularity;
>  		parent_iw =3D cxlrd->cxlsd.cxld.interleave_ways;
> +		if (parent_iw > 1) {
> +			parent_ig =3D cxlrd->cxlsd.cxld.interleave_granularity;
> +		} else {
> +			/*
> +			 * A single-way root does not interleave, so its
> +			 * granularity does not constrain the region interleave.
> +			 * Use the region granularity instead.
> +			 */
> +			parent_ig =3D p->interleave_granularity;
> +		}
>  		if (!is_power_of_2(parent_iw))
>  			parent_iw /=3D 3;
>  	} else {
> @@ -1521,7 +1577,7 @@ static int cxl_port_calc_interleave(struct cxl_port=
 *port, struct cxl_region *cx
>  				    struct cxl_region_ref *cxl_rr, int *out_iw,
>  				    int *out_ig)
>  {
> -	struct cxl_port *parent_port =3D to_cxl_port(port->dev.parent);
> +	struct cxl_region_params *p =3D &cxlr->params;
>  	struct cxl_decoder *cxld =3D cxl_rr->decoder;
>  	int parent_iw, parent_ig, iw, ig, rc;
>  	struct cxl_switch_decoder *cxlsd;
> @@ -1537,16 +1593,24 @@ static int cxl_port_calc_interleave(struct cxl_po=
rt *port, struct cxl_region *cx
>  		return -EINVAL;
>  	}
> =20
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	ig =3D parent_ig * parent_iw;
> +	/* Finer-than-root regions refine granularity toward the endpoints */
> +	if (cxl_region_is_finer_than_root(cxlr)) {
> +		ig =3D parent_ig / iw;
> +
> +		if (ig < p->interleave_granularity) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s: granularity %d is finer than region granularity %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				ig, p->interleave_granularity);
> +			return -ENXIO;
> +		}
> +	} else {
> +		ig =3D parent_ig * parent_iw;
> +	}
> =20
>  	if (!granularity_valid(ig)) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid granularity: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), ig);
>  		return -EINVAL;
>  	}

[Severity: High]
Does cxl_port_calc_interleave() use an unvalidated passthrough decoder
granularity when an interleaving switch sits below a 1-way host bridge or
parent switch?

In cxl_port_setup_decoder(), an auto-region passthrough decoder (iw =3D=3D =
1)
is exempted from matching ig and its cxld->interleave_granularity is left
at whatever raw value firmware programmed in the hardware register (such
as 256B):

drivers/cxl/core/region.c:cxl_port_setup_decoder() {
	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
		if (cxld->interleave_ways !=3D iw ||
		    (iw > 1 && cxld->interleave_granularity !=3D ig) ||
		    !spa_maps_hpa(p, &cxld->hpa_range) ||
		    ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)) {
			...
			return -ENXIO;
		}
	}
}

When cxl_region_setup_targets() then descends to a downstream interleaving
switch port (for example, a 3-way root at 2 * IGB -> 1-way host bridge ->
2-way switch at IGB), the non-root branch of cxl_port_parent_interleave()
reads parent_ig =3D parent_cxld->interleave_granularity directly from that
passthrough host bridge decoder.  cxl_port_calc_interleave() then divides
that raw passthrough granularity by iw instead of using the granularity
from the nearest upstream interleaving decoder, causing auto-region
assembly to fail with -ENXIO.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794000806.gi=
t.alison.schofield@intel.com?part=3D3
