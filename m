Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8F29BDBF
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201092; cv=none; b=sVV4xLXhMuYJsjwR+KvBItCFIVyNJKlAFsCRfyU13UbEpRHU/PdIO15OWLLcbA4s9vSW8PbAZQgb61DP1fUkspF0KFU34D9epfqMhJQlRakhmf+paA8thmlbpVPGdJhveNSA8JkKPtW8NyRVDn3pZcE8LheG1jPwRzPfF7usDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201092; c=relaxed/simple;
	bh=Mio4WHv482318wtJ7wv55rRVsJbL+Hosznr93weVA10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d4RGDNlo2qWS17Y2NKg5tOYryLYLCdt0kaTbYb96ZUbkB+z2LYKadGVL8YHYfCmWH4/lSk3GbRvYy58PB1kTZFq8JhgZxczZQt/R+16A8vHPsdYmshs0VbmbmKQsPpqyhPIWy1JVwwA0fwPaM0khnU7E1XdCCPqnyNDRzO1dqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDd9fbGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDd9fbGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8130B1F00ACA;
	Thu, 11 Jun 2026 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781201091;
	bh=lu9OpDSQVP+W1aU9W8fPS2nNSZlbMYP8AWmOQc6ky1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fDd9fbGcxsApKOAmILePEbPVqyrS4wRQZ3ClgVPGZ6A7MPhs7syWHd+Yhz8bfdKYU
	 ADI7tgaLgEMzMBajQEtXtqkAVI1RdoU9SR7CxTh8j5cor9jaZHp3JNlAmImnXUQJir
	 c9BqWIlZHN3P4uetn7onaTk+bfWikzobWmOd/9PGwANJA+Kx9Wys0LvyjQqCYVEBXz
	 jrga8e8zcr0CiM5y7ub0mEZmeDNg5PMDWij2KB4nLmyQsLduw5dnHp1IzUzgov1J/A
	 xPWGwmmG0p3vy0/VlLFMtRs7hjpe9uJF5+uk1ilyT44eD/+E8XUFn64SQ8upzVmgAn
	 KycRuKZQ8jinQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 4/9] dax/fsdev: don't leave a dangling dev_dax->pgmap
 on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019eb7bde24e-442d75b0-0dcc-416d-8f89-040ce73b183f-000000@email.amazonses.com>
References: <0100019eb7bde24e-442d75b0-0dcc-416d-8f89-040ce73b183f-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:04:51 +0000
Message-Id: <20260611180451.8130B1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unpatched dangling pointer in device.c leading to permanent probe =
failure and potential UAF
- [High] Concurrent sysfs mapping_store() execution causes TOCTOU heap buff=
er overflow and Use-After-Free in probe pathways
--

commit f0cb55dd27105cfc1116641d11d0187ba63297c0
Author: John Groves <John@Groves.net>

dax/fsdev: don't leave a dangling dev_dax->pgmap on probe failure

This patch factors out pgmap acquisition into fsdev_acquire_pgmap() and
defers the dev_dax->pgmap assignment until the probe can no longer fail.
This ensures a failed probe does not leave a dangling pointer.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index 52f46b3e245ea..cc097167ad2c7 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -219,47 +219,62 @@ static const struct file_operations fsdev_fops =3D {
>  	.release =3D fsdev_release,
>  };
> =20
> -static int fsdev_dax_probe(struct dev_dax *dev_dax)
> +/*
> + * Acquire the dev_pagemap for probe: the static (pre-populated) one if
> + * present, or a devm-allocated one for the dynamic case. Note that
> + * dev_dax->pgmap is not set here; fsdev_dax_probe() sets it only once
> + * probe succeeds, so a failed probe never leaves a dangling pointer
> + * to a devres-freed pgmap.
> + */
> +static struct dev_pagemap *fsdev_acquire_pgmap(struct dev_dax *dev_dax)
>  {

[ ... ]

> +	if (dev_dax->pgmap) {
> +		dev_warn(dev, "dynamic-dax with pre-populated page map\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> =20
> -		pgmap_size =3D struct_size(pgmap, ranges, dev_dax->nr_range - 1);
> -		pgmap =3D devm_kzalloc(dev, pgmap_size, GFP_KERNEL);
> -		if (!pgmap)
> -			return -ENOMEM;
> +	pgmap_size =3D struct_size(pgmap, ranges, dev_dax->nr_range - 1);
> +	pgmap =3D devm_kzalloc(dev, pgmap_size, GFP_KERNEL);
> +	if (!pgmap)
> +		return ERR_PTR(-ENOMEM);

[Severity: High]
This is a pre-existing issue, but does this allocation race with a concurre=
nt
sysfs mapping_store() execution?

Since mapping_store() in drivers/dax/bus.c dynamically adds memory ranges
without checking if dev->driver is bound, it can run concurrently while the
driver is probing.

If dev_dax->nr_range increments after pgmap_size is calculated but before
the loop below executes, couldn't this cause a heap buffer overflow when
writing to pgmap->ranges[i]?

> -		pgmap->nr_range =3D dev_dax->nr_range;
> -		dev_dax->pgmap =3D pgmap;
> +	pgmap->nr_range =3D dev_dax->nr_range;
> +	for (int i =3D 0; i < dev_dax->nr_range; i++)
> +		pgmap->ranges[i] =3D dev_dax->ranges[i].range;
> =20
> -		for (i =3D 0; i < dev_dax->nr_range; i++) {
> -			struct range *range =3D &dev_dax->ranges[i].range;
> +	return pgmap;
> +}
> =20
> -			pgmap->ranges[i] =3D *range;
> -		}
> -	}
> +static int fsdev_dax_probe(struct dev_dax *dev_dax)
> +{
> +	struct dax_device *dax_dev =3D dev_dax->dax_dev;
> +	struct device *dev =3D &dev_dax->dev;
> +	struct dev_pagemap *pgmap;
> +	struct inode *inode;
> +	u64 data_offset =3D 0;
> +	struct cdev *cdev;
> +	void *addr;
> +	int rc, i;
> +
> +	pgmap =3D fsdev_acquire_pgmap(dev_dax);

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
dangling dev_dax->pgmap pointer vulnerability here in fsdev_dax_probe(),
should the exact same fix be applied to dev_dax_probe() in drivers/dax/devi=
ce.c?

It appears device.c still assigns dev_dax->pgmap immediately after
devm_kzalloc(), which would leave it dangling if a subsequent operation like
devm_request_mem_region() fails, causing subsequent probe attempts to
permanently fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019eb7bcda4b-3f=
8edae9-d7a4-4bfa-aaea-fcef77fdbbc3-000000@email.amazonses.com?part=3D4
