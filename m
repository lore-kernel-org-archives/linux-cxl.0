Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EFB1E0E14
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515763; cv=none; b=OAaNW7nimVFh+14LdwRhExw1HDao27wrCH27fDOCvFxZU2R+Q/FQvRKQ86dRaFsqJ16na5q6Rxya+yvfKzNiKnVzLFwCH9l0n4oNSA3TSo+uMXds+ZDMYrPjojutPEUKwWjQv5b+vggtKTfNm+YrcMJGBYa1oCIqLzUvhBoKuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515763; c=relaxed/simple;
	bh=MUF/Y7XsEaAmgkJAlp7HWdbegVvfjNn8lP60I5s6Jpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j7HfLcJ80gelwzl6WLQwZ7gmr3OoIlZCk2UeKj0z/hkf9Sl2aG8mdbI5IkAoyn1sWukIhKEW/nDVBxgx85d+ktJs1yRof/jPoXnPcNIh1314BpfBZl9ZZiszV8gNCF+a0f8Fz4wGWat3uBF9D4qezvOpV1OhN4k6xhTAn40ND/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehlc20Ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehlc20Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570631F000E9;
	Wed, 12 Aug 2026 06:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786515761;
	bh=/fORVSfq2FmWLuCwkiW6/zgAcB9Q7MFZtwS1U2apSTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ehlc20Ol+e9Tvrp823RmC2xDntekHNJBX8Qg7gA9odQo1W3umGtaJNUjBEfAGKoP9
	 3HBHe5KwMWHNNpacnNcw7GfjTNqfw4+1ttuvwiLKGNfdvN0qUAPRIBxYdDRAacfYjy
	 6UGMBjgxBe6wHDk0uVxRrIrMqenJrPcH+7XSPENNHzfxRYsYgSbf8qsnbsj3CG7WDf
	 xWtnU5Q4GFT7afimzZqe5sl4CiLnrKQYplhLjDF9BaY9taSAKhutg1gvQKSFewQWTL
	 +J/u1DV65m/imcre+sWhBsGKV1yc1D+juK118hBDBRdmp9noiWT63hDsXFODnrj2BB
	 1qpjeGH/9CWgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint
 bandwidth gathering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812060912.54932-1-kanie@linux.alibaba.com>
References: <20260812060912.54932-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:22:40 +0000
Message-Id: <20260812062241.570631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack memory use in cxl_switch_gather_bandwidth() du=
ring access coordinate combination.
- [High] Uninitialized stack memory leak into QoS class calculation for Res=
tricted CXL Devices (RCDs).
- [Medium] Pointer aliasing in `cxl_coordinates_combine()` causes bandwidth=
 calculations to incorrectly ignore zero bandwidths from downstream hops.
--

--- Patch [1]: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint=
 bandwidth gathering ---
commit 1627473a040a741d578311d820959582436220a3
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering

cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
the stack - pci_coord, sw_coord and ep_coord - without initializing them,
and relies on its helpers to fill every member. None of them does.

Link: https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linu=
x.alibaba.com/

> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f072625135..3c6a1537f89b8 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_r=
egion *cxlr,
>  	struct cxl_port *endpoint =3D to_cxl_port(cxled->cxld.dev.parent);
>  	struct cxl_port *parent_port =3D to_cxl_port(endpoint->dev.parent);
>  	struct cxl_port *gp_port =3D to_cxl_port(parent_port->dev.parent);
> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] =3D { };
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] =3D { };
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] =3D { };
>  	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);

[Severity: High]
This is a pre-existing issue, but cxl_switch_gather_bandwidth() has a simil=
ar
uninitialized stack array:

drivers/cxl/core/cdat.c:cxl_switch_gather_bandwidth() {
    ...
    struct access_coordinate coords[ACCESS_COORDINATE_MAX];
    ...
    rc =3D cxl_pci_get_bandwidth(pdev, coords);
    ...
    cxl_coordinates_combine(coords, coords, ctx->coord);
    ...
}

cxl_pci_get_bandwidth() leaves latency members uninitialized, and then
cxl_coordinates_combine() unconditionally sums them.

Should coords be zero-initialized here as well to prevent reading
uninitialized memory?

[Severity: High]
This is a pre-existing issue, but uninitialized stack memory can leak into =
QoS
calculations for Restricted CXL Devices (RCDs):

drivers/cxl/core/cdat.c:cxl_port_perf_data_calculate() {
    struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
    ...
    rc =3D cxl_endpoint_get_perf_coordinates(port, ep_c);
    ...
    cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
    ...
}

For RCDs, cxl_endpoint_get_perf_coordinates() returns 0 early without
modifying the array:

drivers/cxl/core/port.c:cxl_endpoint_get_perf_coordinates() {
    ...
    if (cxlmd->cxlds->rcd)
        return 0;
    ...
}

This causes cxl_coordinates_combine() to merge uninitialized stack data into
the region's coordinates, which is later passed to QoS class calculation and
exported to userspace sysfs.

Should ep_c also be zero-initialized?

[Severity: Medium]
This is a pre-existing issue, but does pointer aliasing in
cxl_coordinates_combine() cause bandwidth calculations to ignore zero
bandwidths from downstream hops?

drivers/cxl/core/cdat.c:__cxl_coordinates_combine() {
    if (c1->write_bandwidth && c2->write_bandwidth)
        out->write_bandwidth =3D min(c1->write_bandwidth,
                                   c2->write_bandwidth);
}

When called with aliased pointers in cxl_endpoint_gather_bandwidth() and
cxl_switch_gather_bandwidth():

    cxl_coordinates_combine(ep_coord, ep_coord, sw_coord);

If sw_coord has 0 bandwidth, the operation is skipped, and ep_coord retains
its previous non-zero bandwidth instead of being updated to 0.

Should the bandwidth be updated when one of the inputs has 0 bandwidth, or =
is
retaining the previous value intended?

>  	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>  	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812060912.5493=
2-1-kanie@linux.alibaba.com?part=3D1
