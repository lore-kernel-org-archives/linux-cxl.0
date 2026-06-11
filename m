Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C43349AF6
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200891; cv=none; b=YUIHePlJliSKm7t1hoZZuzzO/k0U6TwPIdnZOADIDLVDbCp+uYnB/nXZ7SHkyX1aTb3uo0JDcYf9h61NjQizhjDLx6EepzVox6VwX1O++mXPfGpoWHrImqbfbA/oCqup4vJItLu/ueDYpQMq1k81GYXZ1HCA7TQLNLF6fKMjxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200891; c=relaxed/simple;
	bh=VCCOppYv+iox1XnweHrH7NuilRaa4YeJcCogN1mAoKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BlsS5YkwOjfyUA+83u7/YDQ/u2tov8Lfu6yJ0KnIMNk7TPoUz23rM4HtW8TYJ0dQCt3iQmXD4MGov9lOFMrevOrVJaWMtvmN2glfSVMe0lUwivfyR24NWe/0DJPdhj2du62gQEap5DXJaP7M/AjucCUUtqc1EdiJNOSv2JwFnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqZf4g2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqZf4g2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1016D1F00893;
	Thu, 11 Jun 2026 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200890;
	bh=sMx7R1KJKDuoZEr+z7A+EMd/5nMgFhO/WGiAeWQmKMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqZf4g2gw3S8CsklQKzuVP1k1PAA0kKBW6C6BUPSHyOm2gxXJDILW5CYYHSkVTECF
	 3QJOKDU/SiU2PQPFL1tdoiugHYQ1vgfAt9xhcm2v16swUEamR3OqEBvbZyLeOYjbXs
	 i/UR6vXBWdWqSSlT9HTVMFevUWHTwlVzQIwe+aJP1rwUlBvSoIDzgFezGgJXDBSK8l
	 FSBjMpyvQ/B3Potkde/C4D/uAFxrGAC3Opy69wZ8NoB294aeMIDJdVP9kXHkePeTvi
	 xV2Wxt8LaQh1EjcvU6WYZQJjA570qNnwfCbdvkZtgF8UV3d3v6ad96Dntb+JyBb2cx
	 zPbKafWFsma4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] cxl/region: Account for mixed-granularity in
 position calculations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
References: <94ec26d420e0e40a2a991c1a4205e9e93cab44de.1781199122.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:01:29 +0000
Message-Id: <20260611180130.1016D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect uniform `pos_distance` assumption in mixed-granularity r=
egions leads to a kernel panic in `check_last_peer()`.
- [High] Flawed arithmetic in `cxl_calc_interleave_pos()` breaks auto-disco=
very for topologies with multiple interleave passes or interleaved downstre=
am switches.
--

commit 9cd5598bf3a699e6fbc48008f0af90a4640e7218
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Account for mixed-granularity in position calculations

Mixed-granularity regions place the root decoder at outer HPA bits. A root
target then owns root_gran / region_gran inner positions before advancing.
This patch accounts for that stride in endpoint placement, position
calculations, and peer-distance checks.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d5d19ed621713..9fff538a9ce16 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

[ ... ]

> @@ -1490,10 +1512,11 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  				cxlrd->cxlsd.cxld.interleave_granularity);
> =20
>  	/* Track distances used in passthrough granularity and peer checks */
> -	parent_distance =3D cxlrd->cxlsd.cxld.interleave_ways;
> -	if (!is_power_of_2(parent_distance))
> -		parent_distance /=3D 3;
> -	distance =3D cxlrd->cxlsd.cxld.interleave_ways;
> +	stride =3D root_pos_stride(cxlr);
> +	sel_distance =3D cxlrd->cxlsd.cxld.interleave_ways;
> +	if (!is_power_of_2(sel_distance))
> +		sel_distance /=3D 3;
> +	pos_distance =3D stride > 1 ? 1 : cxlrd->cxlsd.cxld.interleave_ways;
> =20
>  	for (iter =3D parent_port; !is_cxl_root(iter);
>  	     iter =3D to_cxl_port(iter->dev.parent)) {

[ ... ]

> @@ -1540,7 +1563,7 @@ static int cxl_port_setup_targets(struct cxl_port *=
port,
>  		for (int i =3D 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport =3D=3D cxlsd->target[i]) {
>  				rc =3D check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> +						     pos_distance);

[Severity: High]
If stride > 1, pos_distance is initially 1 and then scaled by intermediate
target counts. Does this uniform distance correctly account for the
non-uniform gap between positions routed to the same downstream port in
mixed-granularity topologies?

In check_last_peer(), it subtracts this distance to locate a peer endpoint:

drivers/cxl/core/region.c:check_last_peer() {
	...
	cxled_peer =3D p->targets[pos - distance];
	cxlmd_peer =3D cxled_to_memdev(cxled_peer);
	ep_peer =3D cxl_ep_load(port, cxlmd_peer);
	if (ep->dport !=3D ep_peer->dport) {
	...
}

If the calculated distance is flawed, could this inspect a position
belonging to a completely different root target's block? If so,
cxl_ep_load() might return NULL since the peer endpoint isn't a
descendant of the current intermediate switch port. This would lead
to a NULL pointer dereference when accessing ep_peer->dport.

>  				if (rc)
>  					return rc;
>  				goto out_target_set;

[ ... ]

> @@ -2010,6 +2042,11 @@ static int cxl_calc_interleave_pos(struct cxl_endp=
oint_decoder *cxled,
>  		if (rc)
>  			return rc;
> =20
> +		if (stride > 1 && is_cxl_root(parent_port_of(iter))) {
> +			pos =3D pos + stride * parent_pos;
> +			break;
> +		}
> +
>  		pos =3D pos * parent_ways + parent_pos;
>  	}

[Severity: High]
Does this position calculation properly handle interleave wrap-around and
higher-order switch interleaving?

By using pos =3D pos + stride * parent_pos, it appears to assume that the r=
oot
target always provides the highest-order bits of the region position. In
topologies where a root target owns more endpoints than the stride, or where
downstream switches decode bits higher than the root decoder, could this
result in local position collisions?

For example, if the 5th endpoint on a host bridge has a local pos of 4 and
a stride of 4, this would calculate 4 + 4 * 0 =3D 4 instead of the correct
region position 8. Would this cause cxl_region_attach_position() to reject
otherwise valid auto-discovered CXL topologies?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781199122.gi=
t.alison.schofield@intel.com?part=3D3
