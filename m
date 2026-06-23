Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89635F5E3
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207460; cv=none; b=i3twuXKMERk5F3A6eZQawnh8AoR/PQ5tuXLWfqXTX03orVkgJloHqRkjREIz9jUBzFdUx+hg7zytoS+2jKHUg8O5aPSXrOjXX/AsJbz6z6vbNd5zL9oOhA7h5IDURsOPmOjoq93caLSA8AlG2+A+NoXJx+gHbHlnXC25ML22l0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207460; c=relaxed/simple;
	bh=uroWcFp8ewfMIkRYlE/RLybplKYBfN1v5Qzm0+xJUbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R3K5PyizpOynIJ3Hmo4sTBz3W22IDAvVFInQjGSYCLzbDUNunwXjSqfkKv6dVPqJ1u7OxzTYtTKlpyPXjXCFY88K7CBCww++7+nOyth14Pik5hr/EaRLMP8aXlh8RyYIOP03FzP5ci935bVfdiNE1sCc+Flu9f+ZXAtiBTlR3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYJv1cpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYJv1cpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2C11F000E9;
	Tue, 23 Jun 2026 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207458;
	bh=HrLrourLon+70CVcQAJbM8mdsmjW/YJwSYGbT7VvZEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYJv1cpAT40bP7odGnchOF/0FuFI1wdyp2kl0HrSoMyHLxbRr0Q5duU3r/KZYTfoj
	 +Jh+c7FO6fDXBDcEYxLYYn5H04PxnZAEvIq8Vz5cYjZzIl/P5aezq39tcqQuHyx8cu
	 ElA/V5q64BBZqEleYFL3dkTfUTplQW3K1ZtUDM+F3IO2xdb6kr2tff5SzQvFLljsVv
	 Y8tSNzZJAGen6KEwPr33bAfIYqhIHQUjDF+mpNp23nUMBvxiqNzwA2swHbR2ONI2gx
	 BNsKC79In7na8fe3ijdPvT2tDP7CBC0HTJP0/o0FtX05zgw49oC42MkKPlTR7ELqaR
	 b6HGSMGD/8s6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] cxl/hdm: Allow zero sized HDM decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260623091019.33417-2-icheng@nvidia.com>
References: <20260623091019.33417-1-icheng@nvidia.com>
 <20260623091019.33417-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:37:38 +0000
Message-Id: <20260623093738.6B2C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] cxl_dpa_free() incorrectly bypasses teardown for zero-sized decode=
rs, permanently locking hdm_end and breaking the LIFO DPA teardown sequence.

Pre-existing issues:
- [High] Pre-existing bug in cxl_get_poison_unmapped: prematurely breaking =
out of the partition loop skips poison scanning for unmapped partitions.
--

commit 66fbe5db5d8f3f27534b45af8c4ef71b88ab7f3e
Author: Richard Cheng <icheng@nvidia.com>

cxl/hdm: Allow zero sized HDM decoders

Treat empty decoders as first class instead of special casing them, back
them with a kmalloc'd resource, since the resource tree can't represent
an empty range, and keep the skip and hdm_end accounting intact. Guard
the paths an empty decoder can't serve, e.g. region attach, DPA free, and
poison queries.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..ccbab2e21f060 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	struct device *dev =3D &cxled->cxld.dev;
> =20
>  	guard(rwsem_write)(&cxl_rwsem.dpa);
> -	if (!cxled->dpa_res)
> +	if (cxled_empty(cxled))
>  		return 0;

[Severity: High]
Does this early return prevent decrementing port->hdm_end for zero-sized
decoders?

If an unlocked zero-sized decoder is freed by userspace (for example, by
writing 0 to dpa_size in sysfs), cxled_empty() returns true because
resource_size(dpa_res) is 0. The function then returns 0 early, skipping
devm_cxl_dpa_release().

Because hdm_end is decremented only inside __cxl_dpa_release(), bypassing it
leaves port->hdm_end permanently elevated. Would subsequent attempts to free
lower-indexed decoders fail the cxled->cxld.id !=3D port->hdm_end check with
-EBUSY, preventing further dynamic DPA reconfiguration?

>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder assigned to: %s\n",
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e82..eeecb588821a4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
[ ... ]
> @@ -2953,9 +2960,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *po=
rt)
>  	};
> =20
>  	rc =3D device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> -	if (rc =3D=3D 1)
> +	if (rc =3D=3D 1) {
> +		/*
> +		 * No decoder with a sized DPA reservation was walked
> +		 * (every committed decoder is zero-size): scan all
> +		 * partitions in full.
> +		 */
> +		if (ctx.part < 0)
> +			ctx.part =3D 0;
>  		rc =3D cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);

[Severity: High]
This is a pre-existing issue, but does cxl_get_poison_unmapped() prematurely
break out of its partition loop when encountering a fully mapped partition?

Looking at cxl_get_poison_unmapped() in drivers/cxl/core/region.c:

for (int i =3D ctx->part; i < cxlds->nr_partitions; i++) {
        ...
        length =3D res->end - offset + 1;
        if (!length)
                break;
        rc =3D cxl_mem_get_poison(...);

If it processes a partition that is fully mapped, length becomes 0, and the
break statement completely terminates the outer loop over the remaining
partitions instead of moving to the next one. Should this be a continue
instead of a break so that poison in subsequent unmapped partitions isn't
silently ignored?

> +	}
> =20
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623091019.3341=
7-1-icheng@nvidia.com?part=3D1
