Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC62E92BA
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269401; cv=none; b=tlDWDr6So3/r3/D0I8iHFX7MyfyAiKOQm/ahKI/328d7Oaq5Sy1DW1yRHg6M7wnGQS+dqJDGTo6NIK6IjEaPDVF4q4ihG9nGPTG8LTJvG704q8rDoYySW28rVNGimiMmfgTWfP+NxDpN/+QfYWjwpcScZlakleneLCz5EdIEAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269401; c=relaxed/simple;
	bh=u4hC2+QqwWeOnD82o55IGPAcY1aw6rgeYdvkPdyxNrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RAJHW944Dw4QIq2hXea3JJHDlykk8j7I1ciMcRZSCFyAr0+KeQO/q/UbI6fMmc2EecAmwPJtkEcckJd/9NMz0l6Mi4dJXsL5/o+oNTt/RR9cYyTUg0EAJhU3qGNYVuWSU82hUIvn0iuKLIHZ5lf3INWDUW9xH5ZgmyRkNCRfe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZxQQd2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZxQQd2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C561F000E9;
	Thu, 20 Aug 2026 23:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787269400;
	bh=p6gw9+Sduxi1QGcJz4scw9QrgcnJuJktU6/O9iNg1X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZxQQd2Di6vNqVpkNvVn/Iv4TNvYkgZo5yQ/hJtHBJisJDas1IJMakZxLdnI7mar9
	 /T9/DbdIffbfRYGOQecIsiUnUK4G3UmUXNcXpLo4e3JQlC2MuR46C6CqCHH25uDldg
	 T4akxcpQAtJrqqrjvOqXyW6mv9ROBTnY2qgZ0TjTpMkQVVaCGuOqjsVjZagc/xaC12
	 +SkR7qzCTmoatBbN7S32Xdcl9FyD1EQ9mBYgV2Y0j6e8GdPXgJchsPFsgZpA4CQ9wZ
	 KfYoqBPE8MQAtwoSp4m7+60dXiglX8vSj/MqWxO6++Cs0lurE6OJbuniuNBTH42QJ+
	 j31ZlWrUePGww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] cxl/region: Support mixed-granularity auto
 regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <465a9a3e68144a41af45ca1cdfa642e7af553c4e.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
 <465a9a3e68144a41af45ca1cdfa642e7af553c4e.1787255388.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 23:43:19 +0000
Message-Id: <20260820234320.18C561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect distance calculation for non-mixed-granularity regions w=
ith non-power-of-2 root interleaves causes a NULL pointer dereference.
--

--- Patch [3]: [PATCH v4 3/6] cxl/region: Support mixed-granularity auto re=
gions ---
commit 13bc48fe2efef1744b5bbf29c756bd07f400ebe3
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Support mixed-granularity auto regions

The CXL driver currently assumes the interleaving root has the same
granularity as the region, with each successive interleaving level
becoming coarser toward the endpoints. This patch allows the CXL driver
to assemble an auto region where the root granularity is coarser than
the region granularity.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4f367feaf6c84..637d1b60a570b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -1463,26 +1472,21 @@ static int cxl_port_setup_targets(struct cxl_port=
 *port,
>  	}
> =20
>  	cxlsd =3D to_cxl_switch_decoder(&cxld->dev);
> +	iw =3D cxl_rr->nr_targets;
> +
>  	if (cxl_rr->nr_targets_set) {
> -		int i, distance =3D 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> +		int i, distance;
> =20
>  		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch =3D=3D distance.
> +		 * @distance is the spacing between region positions sharing
> +		 * this dport. Mixed-granularity regions place those positions
> +		 * contiguously.
>  		 */
> -		do {
> -			cxl_rr_iter =3D cxl_rr_load(iter, cxlr);
> -			distance *=3D cxl_rr_iter->nr_targets;
> -			iter =3D to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *=3D cxlrd->cxlsd.cxld.interleave_ways;
> +		if (cxl_region_is_mixed_gran(cxlr))
> +			distance =3D 1;
> +		else
> +			distance =3D cxld->interleave_granularity * iw /
> +				   p->interleave_granularity;

[Severity: High]
Does this mathematical distance calculation correctly handle non-power-of-2
root interleaves?

When configuring a CXL region with a non-power-of-2 root interleave (like
3-way or 6-way) and multiple endpoints sharing a downstream port, this
formula seems to calculate a distance 3 times smaller than the true
topological stride. This appears to happen because parent_iw is divided
by 3 for address routing, which scales down cxld->interleave_granularity.

If the distance is undersized, check_last_peer() will check an endpoint on
a completely different host bridge:

drivers/cxl/core/region.c:check_last_peer() {
        ...
        cxled_peer =3D p->targets[pos - distance];
        cxlmd_peer =3D cxled_to_memdev(cxled_peer);
        ep_peer =3D cxl_ep_load(port, cxlmd_peer);
        if (ep->dport !=3D ep_peer->dport) {
        ...
}

Since cxl_ep_load() returns NULL when selecting a peer on a different host
bridge, will ep_peer->dport trigger a NULL pointer dereference here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787255388.gi=
t.alison.schofield@intel.com?part=3D3
