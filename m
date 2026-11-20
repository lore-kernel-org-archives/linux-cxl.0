Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199951;
	b=Tu7f8OQVBTPk/g8FZ98TWYmWN2eDhBeQssbZW7M+4r5UJ+Rx5xlhtQhSMZ1819JhIjPy
	 CBhUGSZA3v+0b/p/7wNbMvc6HSzAQjS51IxY+cb3YhknjcVfgX4wst//O+GKrh2hqVHrL
	 wGzzTbtVhng9e8LkvjNC7vj3TmcfvJ0UxF80RRXynweIShaeneNq/SebGtQ2x2uVSHuDF
	 7VNTwh5VQpDxobw21UqhFUn9rLs/mVZ9LHT010GlyIWVbY2DQNizkhzBX+xfdhi47Eqdf
	 lGpyJUuUC0mDW+sD9MrLNRNO2wyj3SKNygULnf2ut849WPnMxpvZudwII3/kCIGVNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p2uVglodQcPTVuerI8t3kdkOXadbTUcG3DFRBpSmXTQ=;
	b=u8Cr6rrz2JuVWg9SJUYnkIdHQ/D567Wzx1vphiYS1GyHebCC28AcHUAoI1y86oOsbRfW
	 ieGq6bw858s5HQ/rMCpln/kY52U7M0l/54q1wiGSEfjznQ12nuqKBzUYRKYeEa60J1nnO
	 r2+qMXj+2AnsnUr9AP9ul9JksLK83m+sCsvzVncgRUTSouYPexsHQZFd33RlWASAA/8XS
	 XBaK9dkJH8J2Fckg0B4TZO/MdRTpwDtHMhRqXrWP7YXhpPEUSkXXK6nMfoDKVUEM3nKJg
	 q0/5TvgYd3UM0/ENNgy62i2nV9zqe/oRbRMX8dNliUI26+DL5/qniHRlMufep3y90BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxo0HJpZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175D606A33E
	for <linux-cxl@vger.kernel.org>; Fri, 20 Nov 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxo0HJpZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663B41F000D1;
	Fri, 20 Nov 2026 18:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199950;
	bh=p2uVglodQcPTVuerI8t3kdkOXadbTUcG3DFRBpSmXTQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mxo0HJpZy9emT6Cw9c5n6h0Kmti9BUZ4NiBfKmquWTOSGCl922uDggXML6mVs5M7Q
	 6fLnPLQmOI7uDzbVd4qLJejwedp1XMeKdh5dQ+fB+OBj5mbRI5fg0EPfZTQR3/BtN7
	 ZORSA+c6ghdkulSvs5pUBMgoe53uKynrmtccm9HL0Vf16DFvOIRt66v5UvzAijAF4A
	 0RC1mWyg2tpGpUu9EFRbmaAFHK84eVjmy4emWw9noJwZ6WmAXs2wvVaukmUxRPgHfV
	 nq8P0qRp/kRwOWxWnctnEa3O8ZjY2cKqpSScWiex7KN3FMjoJ0qcNrdl9sXHpu7c+n
	 OFfv+y/Mf7eVg==
Message-ID: <sashiko-outbox-225857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/region: Keep a decoder staged when its auto attach
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
In-Reply-To: <20261120181228.1466310-1-dave.jiang@intel.com>
References: <20261120181228.1466310-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:39:10 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] cxl/region: duplicate target attach corrupts region refs in
  cxl_region_attach() [1]
--

commit bb73ffca81dd406b180098a77a7d18645c37f8a1
Author: Dave Jiang <dave.jiang@intel.com>

cxl/region: Keep a decoder staged when its auto attach fails

This commit restores an endpoint decoder's state to
CXL_DECODER_STATE_AUTO_STAGED if cxl_region_attach_position() fails and
unwinds its region attachment.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb6..f1083976592f9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1830,6 +1830,14 @@ static int cxl_region_attach_position(struct cxl_r=
egion *cxlr,
>  	for (iter =3D cxled_to_port(cxled); !is_cxl_root(iter);
>  	     iter =3D to_cxl_port(iter->dev.parent))
>  		cxl_port_detach_region(iter, cxlr, cxled);
> +
> +	/*
> +	 * Attaching at the endpoint port moved a staged decoder to AUTO, and
> +	 * the unwind above cleared its region again. It is still listed as a
> +	 * target, so keep it staged for cxl_cancel_auto_attach() to find.
> +	 */
> +	if (cxled->state =3D=3D CXL_DECODER_STATE_AUTO && !cxled->cxld.region)
> +		cxled->state =3D CXL_DECODER_STATE_AUTO_STAGED;
>  	return rc;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can a duplicate write to
a targetN sysfs attribute cause this unwind loop to detach an already
attached target [1]?

In cxl_region_validate_position(), if p->targets[pos] =3D=3D cxled, it retu=
rns
0:

drivers/cxl/core/region.c:cxl_region_validate_position() {
    ...
	if (p->targets[pos] =3D=3D cxled)
		return 0;
    ...
}

cxl_region_attach() treats that 0 return as success and calls
cxl_region_attach_position() a second time for the same decoder instead of
returning early.  When configuring a manual region with interleave_ways >=
=3D 2,
attaching succeeds again at the endpoint port (incrementing nr_eps to 2)
and then fails at the parent port (for example with -EBUSY in
cxl_rr_ep_add() because cxled is already in cxl_rr->endpoints).

The err unwind in cxl_region_attach_position() then detaches cxled across
all ports up to the root and frees the ancestor ports' cxl_region_ref while
p->targets[pos] remains set.  Once the remaining targets are attached,
cxl_port_setup_targets() gets NULL from cxl_rr_load() on the ancestor port
and dereferences cxl_rr->decoder.

[1] https://sashiko.dev/#/bug/linux-bc3dac83-96b6-4b99-8e2f-b2f4ad93b98b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120181228.1466=
310-1-dave.jiang@intel.com?part=3D1
