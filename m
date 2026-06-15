Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2331327A
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547765; cv=none; b=clDZpz0vui3D0IheaDAQet4F1R/5lyIIuWDTMe84X/fS2hTQtSpekta12s/zUmwZbb+fxqXfjczzTug98H2zX7iFRD/jtz3jLeWwTSiKhczCKmUR33YAx7R22AnDX0SMUmjqf0o9CxycHLUWgdKNaIlZ6mCPaa3niq0GRax5ELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547765; c=relaxed/simple;
	bh=2ejbfMDuL0PNcCPvYRh3iPbYiB7iV7iyru/M3f1wxDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+skdUcPcCqui9OTSpbaKLA3kSt4qlC9W0z7zMB70pfgUMHSGFguW3vaFnpIZa90Iny+1W2NPabID0nTLg+hWGqLZZn21ryrbNdZB53viz+7hRWoZOwBXjlrUJ/PK9POQvzAri1JJW0N+vzA5cCUXxYx8d7fHW0/NTqxB1JCzoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuyMaV7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuyMaV7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA83B1F000E9;
	Mon, 15 Jun 2026 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547764;
	bh=PteNdAadwszeUB5TBvuGrGeCg0Sm/f42CV48Z2ghWjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KuyMaV7D7S8R6Jwz5l/7tIRtyJR+Iq/Ob0j+MmO77u3HgXOFl6IWaR9bU32HZD5//
	 9+pZjpNBkVTYoZGjv9pUg6/K0ECFfnJ+xcl2ev14TUglLzIsDpLjNC107DhE3Oel6O
	 Bq64ZmjG4nKU3od8J1+dGbpBOtZalnFd5zO2iE8uIhFf0eVm2ne5wajR3vMY5VDrIV
	 W/bIHs0/j4fZqCFO6QOKeKdIVr3p4/AeJb//iNYJdydMHypPL0RAU0ljmpjmXbrbnA
	 nepqUa9yu8jym+A36QKgWcZLsiRz2/qBRP0edzk//isG5PjZucEcwBLyZ9koieKUHe
	 BDJAH9BL2PpWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 07/10] dax/fsdev: fail probe on invalid pgmap offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc0999fa-97574544-8b6b-46cf-9f33-423abdbeee7f-000000@email.amazonses.com>
References: <0100019ecc0999fa-97574544-8b6b-46cf-9f33-423abdbeee7f-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:22:43 +0000
Message-Id: <20260615182243.EA83B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The validation check for an impossible mapping state (`pgmap_phys =
> phys`) is executed after iterating and modifying folio states, leading to=
 a potential kernel panic or memory corruption before the error can be grac=
efully caught.
- [High] The devm action `fsdev_clear_folio_state_action` is registered aft=
er `devm_memremap_pages`. On unbind, it executes before the release of memo=
ry, violently clearing compound folio states while the folios might still b=
e pinned by active users.
--

commit e4852035a220057fe89d87ee2e638d326fb3c8e1
Author: John Groves <John@Groves.net>

dax/fsdev: fail probe on invalid pgmap offset

This commit converts a WARN_ON into a fatal error during device probe when
the remapped region starts after the device's data region. If this invalid
state is detected, the probe now returns -EINVAL instead of continuing with
a misaligned address.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 57c589e19b539..d50891d6dc135 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -342,8 +342,12 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		u64 phys =3D dev_dax->ranges[0].range.start;
>  		u64 pgmap_phys =3D pgmap[0].range.start;
> =20
> -		if (!WARN_ON(pgmap_phys > phys))
> -			data_offset =3D phys - pgmap_phys;
> +		if (pgmap_phys > phys) {
> +			dev_err(dev, "pgmap start %#llx exceeds data start %#llx\n",
> +				pgmap_phys, phys);
> +			return -EINVAL;
> +		}
> +		data_offset =3D phys - pgmap_phys;

[Severity: High]
This isn't a bug introduced by this patch, but does this check happen too
late?

Looking at fsdev_dax_probe(), fsdev_clear_folio_state() is called before th=
is
validation check occurs. fsdev_clear_folio_state() iterates over the ranges
starting from phys. If pgmap_phys > phys, devm_memremap_pages() mapped the
vmemmap starting from pgmap_phys.

Will accessing pfn_folio() for physical addresses before pgmap_phys access
unpopulated vmemmap or memory belonging to someone else, leading to a kernel
panic or memory corruption before we ever reach this return -EINVAL?

[Severity: High]
This is a pre-existing issue, but does the tear-down order of devm actions
cause a race condition on unbind?

In fsdev_dax_probe(), fsdev_clear_folio_state_action is registered via
devm_add_action_or_reset() after devm_memremap_pages() is called.

Since devm actions run in LIFO order, fsdev_clear_folio_state_action will
execute on unbind before memunmap_pages() has a chance to wait for active
folio references to drop. Can this violently clear compound folio states
(like setting folio->share =3D 0 and splitting compound folios) while exter=
nal
subsystems might still be actively holding references, leading to refcount
underflows and memory corruption?

> =20
>  		pr_debug("%s: offset detected phys=3D%llx pgmap_phys=3D%llx offset=3D%=
llx\n",
>  		       __func__, phys, pgmap_phys, data_offset);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D7
