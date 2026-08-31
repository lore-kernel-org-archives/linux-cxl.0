Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474051419A4
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157594; cv=none; b=LNw4nXLQVstFpI8MLkzx1uC1zmuB3O/AMUSnkF/Eca7xDtfkGlHgSyVc8evWF+w5bTs4O8tsh30uMAopqNhwnYfNenxaA89G/CJ5Yj8seeJXD10gwIYuIVELpjIEpMyncRG/AixskLHWgavzIhuL5C52mLKblmEDFKpOXN6tHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157594; c=relaxed/simple;
	bh=b0GVPFn1jo7pFGGemKg+vQ4Wd/deErfoC9y93zdOyT0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hMSfh11IoSwcMRKnzBYfGh2pjn3lFq0NwHieM/OK5cASy/Bz21Ezj0WdLnSUav16h2GkgHpetOG+UZ2pw15rBnkTa9+RYu1/0kYolAlbwLXsK361rUEWmHpI7ZQceTen0gswodizz+iirAh9jAtScsIBddYwF8w4x+GMa+Ht0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2i9Jhsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2i9Jhsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEECD1F000E9;
	Mon, 31 Aug 2026 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788157592;
	bh=R2Bg3ZR6rfyo4yzEIKohsK+dqxzsI9VOG3PiXqGis8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X2i9Jhsc5XlRqo0LmQfuD7R1M14Rwpob62Yz80d8dB+deM48Ew5Bcax/3KbT6FOJv
	 /wgQ9yAa7iB36DrHZCesUlWIDgmo4IJ3mlweaprWhM2vCjM0nOTQaydAwZsiZmgwBu
	 /sw8A6JSZE9FrL2UxsarquK9vtDG8Fokx30ta7YyFHbQC20me+kJX7GjwFpMaH+bOk
	 lZ83XzeUzpTlNyUJ5j/Hx14AyXddkln0jD+IFfSG8X1Oy50PoghE7/d1w/Rh+fKt5H
	 M+jAddm7C6xzhO5v9pY7Kj64wy0Ndg9kVyOfzdCCYNQhZkxdZKI8FkYAEsfm2Eyygh
	 dyardWVo23+bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] cxl/region: Unregister the pmem region when the
 bridge is unbound
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260831061120.200790-1-kanie@linux.alibaba.com>
References: <20260831061120.200790-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 06:26:32 +0000
Message-Id: <20260831062632.AEECD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition leading to NULL pointer dereference in cxl_pmem_reg=
ion_probe().
--

commit 46b44f91e80687bcb216394e5b204e067ed40c6d
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/region: Unregister the pmem region when the bridge is unbound

This commit addresses an issue where removing cxl_acpi unbinds the nvdimm
bridge before the regions it serves, leaving an orphan pmem region. It
updates devm_cxl_add_pmem_region() to unregister the cxl_pmem_region
synchronously when the bridge is unbound.

> diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pme=
m.c
> index 23d97e3d78b6a..7ab1373a95e01 100644
> --- a/drivers/cxl/core/region_pmem.c
> +++ b/drivers/cxl/core/region_pmem.c
> @@ -168,12 +168,14 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxl=
r)
>  		dev_name(dev));
> =20
>  	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> +		if (cxl_nvb->dev.driver) {
>  			rc =3D devm_add_action_or_reset(&cxl_nvb->dev,
>  						      cxlr_pmem_unregister,
>  						      cxlr_pmem);
> -		else
> +		} else {
>  			rc =3D -ENXIO;
> +			cxlr_pmem_unregister(cxlr_pmem);

[Severity: High]
This isn't a bug introduced by this patch, but this patch extends the
usage of cxlr_pmem_unregister() in the synchronous error path, keeping a
vulnerability active.

Can a race condition lead to a NULL pointer dereference in
cxl_pmem_region_probe()?

If the cxl_pmem driver is loaded (e.g., via modprobe) concurrently with the
unbinding of the cxl_acpi bridge (or if devm_cxl_add_pmem_region() fails on
the bridge unbound check), cxlr_pmem_unregister() is called on another CPU.

cxlr_pmem_unregister() sets the pointer to NULL without holding the region
device's lock:

drivers/cxl/core/region_pmem.c:cxlr_pmem_unregister() {
    ...
    cxlr_pmem->cxlr =3D NULL;
    device_unregister(&cxlr_pmem->dev);
    ...
}

Simultaneously, the driver core calls cxl_pmem_region_probe() which holds t=
he
device lock, but reads the concurrently nullified pointer and dereferences =
it:

drivers/cxl/pmem.c:cxl_pmem_region_probe() {
    ...
    struct cxl_region *cxlr =3D cxlr_pmem->cxlr;
    struct cxl_nvdimm_bridge *cxl_nvb =3D cxlr->cxl_nvb;
    ...
}

Does this code open a race window against the probe function, resulting
in a crash?

> +		}
>  	}
> =20
>  	if (rc)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831061120.2007=
90-1-kanie@linux.alibaba.com?part=3D1
