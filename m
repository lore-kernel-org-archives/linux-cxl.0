Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156040803F
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201613; cv=none; b=n+fOYlT/bzPVpP8KPD1nDzEn8CuaZuSHWxvskxX55eKWHXZYacJ5CyLjDYt6ABqwIXeGnGeB0nf9GHexfUiB8N+AihhjdBhKWGykN+6g5cwfgDC7uyceruDgAS/MLtm1epitzTOxL+28EjVCorF567s0Zf4FOJjFB/8nLKvJ7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201613; c=relaxed/simple;
	bh=Ci6oEuCur5o1nXizIAJXZvk0zYJ5kt3z15NvaLRguP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tL5XHzgf8hdzmAGrviIUi0DjjZ+30mCUdd1FR2TzhMiZjYWY2DI2a11HLGhvRT2PzAfyIgg+R81xg3np2Thhijykbacx9JXTtEE6aHL+gvsBNQL8rvXKSJE52Y84HHikBS4cc9J+U+ECUNDAvnUk5cu1A9PuOdVColiwWBAfAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEFwZonO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEFwZonO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858F31F000E9;
	Thu, 11 Jun 2026 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201611;
	bh=4F8EeuCBGtkkS30TrG0xsp8hAEIcFTO91cKZl9qTnmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEFwZonOzvmfbF+xlVkk0uRViowXLcWZh1NKYguyu/Zk6NvbcnpxwYhTGr0qbVtpG
	 ZFqEzxeRmxBYDdcga1zatgYk1xdadkZFKMWHqoFk0qcaz3DkGMoigLNxUDNI0X86XY
	 hQmmBb4i4AgoVwnUoGi4XIch4lJGYULZfkSBYNABgUm6jN083tmy1QEZR26kKWt1tb
	 n3zQAR1I2NTQzdntsKmxmWiL5KKJePwddoImVFFqN36+xQ0wAzXiiocGaqiGgki0hz
	 GoelhopnK7k56dLSm5P9crnuQctIi8+tDVIe7SrX6xtk4vFXH1WfkjpkrGX502hTbp
	 Ri6Vh20+fcaOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 6/9] dax/fsdev: fail probe on invalid pgmap offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019eb7be3bc2-972d848b-bc38-4b24-9ee1-f0dd5610355f-000000@email.amazonses.com>
References: <0100019eb7be3bc2-972d848b-bc38-4b24-9ee1-f0dd5610355f-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:13:31 +0000
Message-Id: <20260611181331.858F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Validation check for 'pgmap_phys > phys' executes too late, allowi=
ng 'fsdev_clear_folio_state()' to process out-of-bounds PFNs and crash the =
kernel.
--

commit e78e60f7b38932158f6316aad6c7a8308838e5b2
Author: John Groves <John@Groves.net>

dax/fsdev: fail probe on invalid pgmap offset

This commit converts a WARN_ON to a fatal error when pgmap_phys exceeds phy=
s,
preventing probe completion with an impossible state. It now returns -EINVA=
L=20
with an error message instead of proceeding with an invalid offset.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -320,8 +320,12 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
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

[Severity: High]
This is a pre-existing issue, but does this validation check execute too la=
te
to prevent a crash?

Looking at fsdev_dax_probe(), the call to fsdev_clear_folio_state() happens
just before this check is reached. fsdev_clear_folio_state() iterates over
the physical PFNs defined in dev_dax->ranges, starting at phys.=20

Because devm_memremap_pages() only populates vmemmap starting from
pgmap_phys, any PFNs between phys and pgmap_phys lack vmemmap backing. This
causes an out-of-bounds access when attempting to read the folio state:

fsdev_dax_probe()
  fsdev_clear_folio_state()
    struct folio *folio =3D pfn_folio(pfn);
    int order =3D dax_folio_reset_order(folio);

Could this trigger a fatal kernel page fault on the unmapped PFNs before the
probe has a chance to fail gracefully?

Should the validation block be moved above the call to
fsdev_clear_folio_state() to reject the invalid configuration before memory
is accessed?

> +		data_offset =3D phys - pgmap_phys;
> =20
>  		pr_debug("%s: offset detected phys=3D%llx pgmap_phys=3D%llx offset=3D%=
llx\n",
>  		       __func__, phys, pgmap_phys, data_offset);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019eb7bcda4b-3f=
8edae9-d7a4-4bfa-aaea-fcef77fdbbc3-000000@email.amazonses.com?part=3D6
