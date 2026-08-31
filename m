Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E86257435
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169519; cv=none; b=S20R6mPDRvvNVwpEYoKFePYKlPRyIvqcrzQjjhSWaDdNw9msUp30eT0HkzzWm9grurAJg8PFTJ3+bGCAEcJeKFoN1bgckOFy9N5njPPneth/D0tXC4FXMuYvQ8G42KP7/aqODmyFurvo29RXq7hVRTMYdWJqiKrJC5nAGln+BBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169519; c=relaxed/simple;
	bh=tAQ2UT9qGXFuY/qVSyLrEZjVglxK8F4D1fjkyqon4J4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R6TD2z4Tipfy+fVIut7WhCDVnVDY+Wyc+WU6jo+MtM/4PPymw4lsDUmrt/y2H2tp6ItoGm2LYm0Djq47apRUQEwYYTxZI79I06aTZeDzynJomi1JTjLELJ8fAdqfMA+vLGMdvGmgwydqnJs23uTROnUBR+8opoVU5/caFn0qMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfFwEy+3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfFwEy+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7D91F000E9;
	Mon, 31 Aug 2026 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169518;
	bh=PMgTVYYfv979ItXjW1/B2bHdUa8HlXnvrIHmf5yCb0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfFwEy+3JHKesHWPOkbNZ0KzbChb8CUD+ZQCcmbGNw4rLBo16WkWODHOyWK+MLmNq
	 ivHeG/wagfo1cLSt0owXMdD/IFB8kfQiDxZuh1mzgFj0vylKT1meDN/vwcdB9c27J0
	 Lqat1mLuHZUcnUCOzP7AG9n/rjgXJW3s4Oyb+t+ZMY1LKTJzXW8gVK/Y8UNcn3FkkI
	 kl8afmd985GUfl5Wvc9FWWC9Frky3nWoSijeU4i6js/Emyc36/QeaB3ZgM28X7ywxD
	 pNEc4GXCoTY7g+xzC+OVT70CJXrlxoOOPvoIwVAIamZy74xYcow2y8dBPx4V8ZbSln
	 hffv++IsgPnpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] cxl/cdat: Fix uninitialized stack use in
 bandwidth gathering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260831092216.540644-2-kanie@linux.alibaba.com>
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
 <20260831092216.540644-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:45:17 +0000
Message-Id: <20260831094517.EB7D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inconsistent handling of 0 (unreported) bandwidth in __cxl_coordin=
ates_combine due to pointer aliasing causes mathematically incorrect bandwi=
dth calculations.
--

commit 4a06d73ff1f865478d3669ce819144aacd32799a
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/cdat: Fix uninitialized stack use in bandwidth gathering
   =20
The commit zeroes out access_coordinate arrays on the stack in
cxl_endpoint_gather_bandwidth() and cxl_switch_gather_bandwidth(). This
prevents uninitialized stack residues from being summed into the latency
members and stored in sysfs when the endpoint CDAT reports no bandwidth.

> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f072625135..df9261ba84e5a 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
[ ... ]
> @@ -757,7 +757,7 @@ static struct xarray *cxl_switch_gather_bandwidth(str=
uct cxl_region *cxlr,
>  {
>  	struct xarray *res_xa __free(free_perf_xa) =3D
>  		kzalloc_obj(*res_xa);
> -	struct access_coordinate coords[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate coords[ACCESS_COORDINATE_MAX] =3D { };
>  	struct cxl_perf_ctx *ctx, *us_ctx;
>  	unsigned long index, us_index;
>  	int dev_count =3D 0;

[Severity: High]
This is a pre-existing issue, but does pointer aliasing in
cxl_coordinates_combine() cause incorrect bandwidth calculations when an
endpoint reports 0 (unknown) bandwidth?

Looking at cxl_switch_gather_bandwidth(), if ctx->coord has 0 bandwidth,
does coords incorrectly retain the PCI link bandwidth instead of 0?

drivers/cxl/core/cdat.c:__cxl_coordinates_combine() {
    ...
		if (c1->write_bandwidth && c2->write_bandwidth)
			out->write_bandwidth =3D min(c1->write_bandwidth,
						   c2->write_bandwidth);
    ...
}

When called later in cxl_switch_gather_bandwidth(), coords aliases both
out and c1:

    /* Retrieve the upstream link bandwidth */
    rc =3D cxl_pci_get_bandwidth(to_pci_dev(dev), coords);
    ...
    cxl_coordinates_combine(coords, coords, ctx->coord);

Because coords is populated by cxl_pci_get_bandwidth(), it is non-zero.
If ctx->coord (c2) has 0 bandwidth, the condition fails and coords (out)
is left unmodified.

Will this cause the endpoint's bandwidth to be incorrectly aggregated up
the tree as the full PCI link bandwidth instead of 0 when CDAT data is
missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831092216.5406=
44-1-kanie@linux.alibaba.com?part=3D1
