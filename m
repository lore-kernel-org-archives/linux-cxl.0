Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4753E8330
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813624; cv=none; b=VwYhOHUqtpGdbypJmG5CHrHGv5oQ9xPYu0GseR1GLO6mFbWt7NVCQYH5/Ro9Gwxcka768TdCXNpgMZpKfEvvGMH2Sbus8CKcuTE3Dzip7Ssvvw+ZOuQJPPAFA/eeRjNe8BnFxtvNaWTC/1kSp4B+RwCQUGkIN7BefdDojDjNg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813624; c=relaxed/simple;
	bh=zPpqw8TV8hqSpWs+Uy5BfoDtF03VcBK/7fIdZrIGDd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q8QKIhmQuSTTBW0YUrwDE8a7BzTNBqeb/n/g3JtPyR1Vf4GXaLE8OP/u9Hz1fWHBiFgXFOZ4o8Z4DqNxTKKUdTCvgIw/4iMXKGqNtJ0NBpzJNB1af1LQce7CPHP964nxvx8JoPEhtTzTJwgQwSIoTrsAA18UwHojJNxgAPb6k/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Lo1Afe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Lo1Afe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A621A1F000E9;
	Tue, 30 Jun 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813623;
	bh=7ceXvbju1iBuf5xy4FoBhaXwRTIvFCDT3zwGhGtVcxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A3Lo1AfeDDWEQ5bkN6cciIWaLyZU08h7IDh6gzlPxI1F5P21qd3TOG/ejyeCAQIH3
	 xFlqDyF1bwfhQfPdx4asNboCFLfEyNvyJJ82du2SPQgmXu3TQUkc4SwH/gX9oLV1tI
	 UjndtzX1+3knO0occ8jOvIqYxOZA4rmNfLWdQ7zh3jsCKV1JTOhIMa1LVCf6+pPtYM
	 ZOQrfNWWu4OO3bXSCcOvEYwahmS2f2bTocyrcOwUM49o4TgHnkxSgm+Ijm8h3T0V2p
	 FB+oJvf2wyZx7MK19qqZehrTTr1jcvpDIM6jBBdg9vBDv3EiO1BZ5wl1lghRAM911v
	 /t1COHazwAyhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] cxl/region: Don't leak tolerated RAM -EFAULT from
 unmapped poison scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260630074657.43077-4-icheng@nvidia.com>
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:00:22 +0000
Message-Id: <20260630100022.A621A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_get_poison_by_memdev() overwrites the return code on each loop=
 iteration, silently dropping errors from earlier partitions.
- [High] cxl_get_poison_unmapped() ignores ctx->offset, causing the DPA ran=
ge of uncommitted decoders to be entirely omitted from poison scans.
--

commit a901f2fb80d97b0599597ec96f439ad59dcd1987
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. If the tolerated RAM fault was the last poison query before the
loop ended, the function returned a spurious -EFAULT and the poison-list
read failed even though enumeration succeeded. Reset rc to 0 when
tolerating the fault, matching poison_by_decoder().

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index be246fb09c999..52ba8e9e42885 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2933,8 +2933,10 @@ static int cxl_get_poison_unmapped(struct cxl_memd=
ev *cxlmd,
>  		if (!length)
>  			continue;
>  		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
> +		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM) {
> +			rc =3D 0;
>  			continue;
> +		}
>  		if (rc)
>  			break;
>  	}

[Severity: High]
This is a pre-existing issue, but does cxl_get_poison_unmapped() ignore
ctx->offset in the loop containing these lines?

Looking at the start of this loop, just above the changed lines:

	for (int i =3D ctx->part; i < cxlds->nr_partitions; i++) {
		res =3D &cxlds->part[i].res;
		for (p =3D res->child, last =3D NULL; p; p =3D p->sibling)
			last =3D p;
		if (last)
			offset =3D last->end + 1;
		else
			offset =3D res->start;

It calculates the unmapped start offset using the resource tree's
last->end + 1 rather than the ctx->offset boundary.

In poison_by_decoder(), ctx->offset is explicitly set to indicate where the
unmapped scan should begin:

	/* Iterate until commit_end is reached */
	if (cxled->cxld.id =3D=3D ctx->port->commit_end) {
		ctx->offset =3D cxled->dpa_res->end + 1;
		ctx->part =3D cxled->part;
		return 1;
	}

Because ctx->offset is bypassed, and the resource tree includes uncommitted
decoders, could this cause the DPA range of uncommitted decoders (and any
unmapped space before them) to be omitted from the poison scans?

[Severity: High]
This is a pre-existing issue, but I also noticed a similar error-handling
pattern in cxl_get_poison_by_memdev() in drivers/cxl/core/memdev.c:

	for (int i =3D 0; i < cxlds->nr_partitions; i++) {
		const struct resource *res =3D &cxlds->part[i].res;

		offset =3D res->start;
		length =3D resource_size(res);
		rc =3D cxl_mem_get_poison(cxlmd, offset, length, NULL);
		/*
		 * Invalid Physical Address is not an error for
		 * volatile addresses. Device support is optional.
		 */
		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
			rc =3D 0;
	}
	return rc;

Does this loop continuously overwrite rc without checking for failure from
previous iterations?

If querying the poison list for the first partition (e.g., PMEM) fails,
the loop seems to continue to the next partition. If the next partition
succeeds, rc is overwritten with 0, which would silently swallow hardware
errors and potentially lead to machine check exceptions when unscanned memo=
ry
is accessed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630074657.4307=
7-1-icheng@nvidia.com?part=3D3
