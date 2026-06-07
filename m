Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616027FD6D
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780861764; cv=none; b=Yf5k5d6bgKNx0x90TuRPblYqT9AHB65HY2kNGs0KhDKNOs9I0MHWcTHPOVJ7ocG2YzIhT4eNha2sNYOVPeEquS0fEhatf0mEEkb5xpYhJz7JCB/LeZ2tem+8cx7v3r1j4Qp8HM+fTTTw6qrILd0c2y27u/zERjHt9RW6P8lln5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780861764; c=relaxed/simple;
	bh=N+0xKSfXmDVZpuXlkBgzZyjaPiHPL58Ukv+5Oy/Ouqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3K9UuzDv/yMromjwQ6IZ5fgzclAtlSoUDfPFR01R5lAed/4RZ/Xe90lLmPovhmQErA8IqUMzj+T5VHoClEfRGWZgwwxF9tg9GgKPftRgupTfdmFCp4MRe/v4dwTuXSSfV0b3Vty7mfQ9N8IAz6tINnPBOn2z7kHcpn519YnITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmKMVikh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmKMVikh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5561F00893;
	Sun,  7 Jun 2026 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780861762;
	bh=dL7d6B/3KIPTaOSGwQl3TWWbMiVuTO4XKiaB9wPRT5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fmKMVikhcYhEErOtrhTCLAb1iKiuTlJDXwHp3R1+zrw52gT/9Cqys/zHYGlJPdJw1
	 Ka5+QW4RZrFDpMQKqd9DBv65PICGLUZ09iedswMZ7VaSHrW04OodDUTM++v6yqU+bo
	 swtUfVBSPYkxSgkKnvrLxb6LpEk9rL5EVMnfBzxMo+kMcQrRfP2P1wQgG8Cxx/80t9
	 Rv70feqmB94sjQEkrsaG2wH/lrlDfIvRU7+WGZIorWfnmtVKweSa7Ddfp1Q+YyelVo
	 LgigoB4G9GYL83u044fdVnxLSwkv4PMHmVKLhDEcFGVASc/dylDDaH54kGYbBEzRoa
	 wSAOrHad6IWeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 3/9] dax/fsdev: clear vmemmap_shift when binding
 static pgmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ea39374a8-bfa199e6-bd3a-45c6-acf1-9212be962224-000000@email.amazonses.com>
References: <0100019ea39374a8-bfa199e6-bd3a-45c6-acf1-9212be962224-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 19:49:22 +0000
Message-Id: <20260607194922.BC5561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling `pgmap->ops` and `pgmap->owner` function pointers cau=
se Use-After-Free/Panic upon memory failure.
- [High] Stale `vmemmap_shift` in `device_dax` when rebinding static DAX de=
vices with reduced alignment.
- [High] Re-initializing active `cdev` structure in probe leads to Use-Afte=
r-Free and list corruption.
--

commit 98c8cbe94424d5d0c2736d9ed4d3c34493e26f6a
Author: John Groves <John@Groves.net>

dax/fsdev: clear vmemmap_shift when binding static pgmap

This commit explicitly zeros pgmap->vmemmap_shift for static dax devices
before calling devm_memremap_pages() in fsdev_dax. This ensures the
vmemmap is correctly built for order-0 folios, clearing any stale shift
value left behind when rebinding from device_dax.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> index f315533b299e9..dbd722ed7ab05 100644
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -237,6 +237,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		}
> =20
>  		pgmap =3D dev_dax->pgmap;
> +		pgmap->vmemmap_shift =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but does drivers/dax/device.c
also need this fix?

In device.c:dev_dax_probe(), vmemmap_shift is updated conditionally:

	if (dev_dax->align > PAGE_SIZE)
		pgmap->vmemmap_shift =3D
			order_base_2(dev_dax->align >> PAGE_SHIFT);

If a static dax device is bound with an alignment greater than PAGE_SIZE,
unbound, has its alignment reduced to PAGE_SIZE via sysfs, and then rebound
to device_dax, it seems vmemmap_shift is not cleared and retains its stale
value.

Could this cause devm_memremap_pages() to erroneously build compound folios
for an order-0 dax device?


[Severity: Critical]
This is a pre-existing issue, but does rebinding between fsdev_dax and
device_dax leave dangling pointers in the shared pgmap?

When fsdev_dax binds to the pgmap, it populates its module-specific
callbacks:

drivers/dax/fsdev.c:fsdev_dax_probe() {
    ...
	pgmap->ops =3D &fsdev_pagemap_ops;
	pgmap->owner =3D dev_dax;
    ...
}

If the device is later rebound to device_dax, dev_dax_probe() only updates
pgmap->type and does not appear to clear pgmap->ops or pgmap->owner:

drivers/dax/device.c:dev_dax_probe() {
    ...
	pgmap->type =3D MEMORY_DEVICE_GENERIC;
    ...
}

If fsdev_dax is then unloaded and a memory failure occurs, could
memory_failure() invoke the dangling pgmap->ops->memory_failure() pointer,
resulting in a use-after-free and kernel panic?


[Severity: High]
This is a pre-existing issue, but does calling cdev_init() during probe
risk list corruption and use-after-free if the vfs still holds references?

Both fsdev_dax_probe() and dev_dax_probe() call cdev_init() on the cdev
embedded within the long-lived dax_device structure:

drivers/dax/fsdev.c:fsdev_dax_probe() {
    ...
	cdev =3D inode->i_cdev;
	cdev_init(cdev, &fsdev_fops);
    ...
}

If the driver is unbound and rebound while userspace still holds open file
descriptors for the device, the vfs maintains references to the cdev.

Doesn't cdev_init() zero-initialize the cdev and re-initialize its kobject,
overwriting the active reference count and clearing cdev->list?

>  	} else {
>  		size_t pgmap_size;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ea3929225-a0=
f8e6f7-30ae-4f8e-ae6f-19129666c4c3-000000@email.amazonses.com?part=3D3
