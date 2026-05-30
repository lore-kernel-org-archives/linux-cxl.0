Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CE320CAD
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163871; cv=none; b=gMPaKf+x9INGtYJYqs87aMb6eVeJyyn8LBoWKGqsfu6gK0r07MRsgAJ9/CY9CobPQUQFZQ8kKJ+UazKfFCSD2dB5nCgLKu7saJ3LwxIg0EWgfTAH68hmruDqN7Lci0OCA7XT0C9/7OpWQNs/XUKWQnRQgzZM238B3+O3AYJ1tYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163871; c=relaxed/simple;
	bh=F5lgVkxDWk7LP4/nniQL18ZDRuUUBN3hs0KY8q0s3rg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WT1tY7HD5Y1ZeMq6R9rPLK1LwGxawRWvzD0F45tGRwoOonjyZijeEODIhadZC0CjZuwGAZVtkXGslLzRtNXIaj+rxYyvjWp238zwehA6jZtusixLb27hfxehwRazk0xHpfDdaDpYxQ/YTArc1pyE0z/QKzSR4fnPv43Q+KPSJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDoP5NH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDoP5NH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22751F00898;
	Sat, 30 May 2026 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780163870;
	bh=Wqv8mWVH0ccLqb/VrFnKodaXXxSjKfnNjJQzd99KLXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fDoP5NH+5tLqLS8Fi6zqncMcTO34wWkm2uzVJlqJIf/X4wWpZJEwLSfe8KyDO47Ci
	 vgjwrFE2KcUySENDo6TObqab9Run30joatjyFWErFjPgMSAVoO9ge5cXXyPaa0Fj+K
	 Cu11j5bNTpPSITBm3lfEajZgQdCcizzIKSYHf2Pn9AeMnSFLjgNyGgK0mxzTTSdDih
	 uzziSjVVe80s5Rmb6giEsrC1OVc1HTJdJ6xWqjFsYq4OIwtnTB2v79EM5zNXNWEIYd
	 uUauxO9p+wMS+alJsUkoS9oXYWYymq+lXKiwlhVSUcMpiIp7hH++0JYRnXBIbEielT
	 gH0HwR4Tf0nNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 6/9] dax/fsdev: fail probe on invalid pgmap offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019e79cbfeba-7b2cf549-f869-4572-bc78-b32ebf16eb7c-000000@email.amazonses.com>
References: <0100019e79cbfeba-7b2cf549-f869-4572-bc78-b32ebf16eb7c-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 17:57:49 +0000
Message-Id: <20260530175749.D22751F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Late Validation / Out-of-Bounds Memory Access
--

commit a9f4bec62b4b3e100b1ed11c3e4fa29bdbf57a95
Author: John Groves <John@Groves.net>

dax/fsdev: fail probe on invalid pgmap offset

This commit converts the WARN_ON when pgmap_phys > phys into a fatal error,
failing the probe with -EINVAL. This prevents the probe from continuing with
a misaligned virt_addr when the remapped region starts after the data regio=
n.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index a2d2eb20fb4d0..aac0130ab2833 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -310,8 +310,13 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		u64 phys =3D dev_dax->ranges[0].range.start;
>  		u64 pgmap_phys =3D dev_dax->pgmap[0].range.start;
> =20
> -		if (!WARN_ON(pgmap_phys > phys))
> -			data_offset =3D phys - pgmap_phys;
> +		if (pgmap_phys > phys) {
> +			dev_err(dev, "pgmap start %#llx exceeds data start %#llx\n",
> +				pgmap_phys, phys);
> +			rc =3D -EINVAL;
> +			goto err_pgmap;
> +		}

[Severity: High]
This is a pre-existing issue, but does adding this explicit validation check
here occur too late to prevent a kernel panic?

Looking at fsdev_dax_probe(), devm_memremap_pages() populates the vmemmap
starting at pgmap_phys. Just before this block, the code unconditionally
calls fsdev_clear_folio_state(), which iterates over dev_dax->ranges
starting at phys.

If pgmap_phys > phys (the invalid state checked here), phys falls before
the region where the vmemmap is populated. Accessing unpopulated memory
during the folio state cleanup would panic before we even reach this new
validation check.

Additionally, the devres cleanup action is registered immediately before
this check. If this new check fails and jumps to err_pgmap, the devres
unrolling will execute on the error path:

fsdev_dax_probe()
   fsdev_clear_folio_state(dev_dax);
   devm_add_action_or_reset(..., fsdev_clear_folio_state_action, ...);

   if (pgmap_phys > phys) {
       ...
       goto err_pgmap;
   }

Would this trigger the unsafe memory access again during cleanup?

Should the validation of pgmap_phys vs phys be moved earlier in the probe
sequence, before clearing the folio state?

> +		data_offset =3D phys - pgmap_phys;
> =20
>  		pr_debug("%s: offset detected phys=3D%llx pgmap_phys=3D%llx offset=3D%=
llx\n",
>  		       __func__, phys, pgmap_phys, data_offset);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019e79caead2-57=
95328c-af48-4a93-b147-c11df7446e1a-000000@email.amazonses.com?part=3D6
