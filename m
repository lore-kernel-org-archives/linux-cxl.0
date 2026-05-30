Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920473AFAE2
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162625; cv=none; b=Ar/UkihNiAJEyKZ7yOQn5pmbH91/iYR9P503Srvdnql0IQAYm1NHa5umP/jj6f1ClRchtmI28HMvPrqC3Froav9xz3YzMPYSM8ouUse7WzYXnY6Gfa6PqV2b09cn1kJDRg8acFtEe81kfJW2LRU94XdYfEnuBN0221xI4nasMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162625; c=relaxed/simple;
	bh=5w/pT4eZW8zejxujOJCF+wrjZZbKanC/K8GxdbAPX2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uo0EOijKWE6kpji375aR5iZd5KMJy6ZljgUGxq0ImZNVp69vCqO9Pwc10SGDX7klUJZp9r+ZLN4yf4sTEROIwqHk3UtcIMGIPcQ14f2AWuSfWQEAcIfYtMKyzW1A9h1jYmrRR/al3CWwnazq5BtgGThEhsJN43uB3De8Rvfhcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzIHIO2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzIHIO2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB0D1F00898;
	Sat, 30 May 2026 17:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780162624;
	bh=dQ0B6hVCV2vSaDM2XuqJe0WpioY7DXzR3O0I1Gk6Ulo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzIHIO2GXJhmW/hcBr4BgZYgIxCAh7jQ6rX0irRgNLxPYWF1KoQZImLn7dNOAWU61
	 fyXJWjovqtTn0NI/6VRQX6suHrrf4c+LZ6f8sZC3sfltLywXFHSNPDv5uSiD9mU18g
	 P+uWtWNhfYb6qfHBcQYXgQ4fA+mCazdA+onApJusSLEq6Y9HlKoNu1AN9D/1Z4V4tp
	 YCxhpko2g4SF/uURFJ46oThDN57LUyTsB1XI9Scdx9NlMnmQ5VzaRc+JRWklbXo2AY
	 DN0mK4WIDmWHkeguhqdrxyaMQ3H2Es0GVthnCKfsrEkSBnP4t2Rnin5UQDLj5Llj+I
	 7benTEdvT0PfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 4/9] dax/fsdev: clear dev_dax->pgmap on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019e79cbc3fa-cdb45b69-de84-4cc0-8aeb-71d0673c1a9c-000000@email.amazonses.com>
References: <0100019e79cbc3fa-cdb45b69-de84-4cc0-8aeb-71d0673c1a9c-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 17:37:03 +0000
Message-Id: <20260530173704.4BB0D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Permanent Probe Failure in `dev_dax_probe()`
--

commit e06a09a1cbe1a16c2fbebd7c33f2df95d4149ac0
Author: John Groves <John@Groves.net>

    dax/fsdev: clear dev_dax->pgmap on probe failure

Clear dev_dax->pgmap on probe failure for dynamic devices to prevent a dang=
ling
pointer that causes subsequent probe attempts to permanently fail.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -253,6 +254,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
> =20
>  		pgmap->nr_range =3D dev_dax->nr_range;
>  		dev_dax->pgmap =3D pgmap;
> +		pgmap_allocated =3D true;

[Severity: High]
This is a pre-existing issue, but does this exact same problem also exist in
drivers/dax/device.c:dev_dax_probe()?

In dev_dax_probe(), a dynamic DAX device allocates pgmap via devm_kzalloc()
and assigns it to dev_dax->pgmap. If a subsequent initialization step fails
(e.g., devm_request_mem_region() returning -EBUSY), the function returns
directly without clearing dev_dax->pgmap.

Devres then frees the devm_kzalloc'd pgmap, leaving dev_dax->pgmap as a
dangling pointer.

When the user subsequently attempts to re-bind the driver to the device,
dev_dax_probe() executes "if (dev_dax->pgmap)", sees the non-NULL dangling
pointer, and unconditionally fails with -EINVAL ("dynamic-dax with
pre-populated page map").

This permanently breaks driver binding for the device until the device itse=
lf
is completely destroyed. Could dev_dax_probe() in device.c use a similar fi=
x?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019e79caead2-57=
95328c-af48-4a93-b147-c11df7446e1a-000000@email.amazonses.com?part=3D4
