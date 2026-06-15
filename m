Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCC3F99F2
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540349; cv=none; b=eR4PPmgHsHb9bFWTqo9y6KiOSmxSxWGUVKcZMdQuCLmLzr3hhF+nECBu86lL2td326BXRzbZCapyR+7/aTrAvHjUfVqp9wpRr4fmfQTz4yjCAH3ShdyVXtAaioCTqKG9mEeSbifQ9BggrCJL5GEIxglZpk2v2+k+xMnbl2OrjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540349; c=relaxed/simple;
	bh=oOVf5Q2c8ZxfzvyeyCOI4dviG0FnoFBEoqrkvGvS5gA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ERBGwQBbeiK7K9ixREdS0QJsFj5KuJ7V5DbVs4nPcYtdhDQuBcepwZJ5xx+7WAKWxIw+TK9SppuWd9B3qIM9m/0GQ9GQDFPAJk+gIjacMGdues/SVbsLSvm+GoM6JVFvANDTbeTtQojvKbJ/n5B8Rdf8sJPFJQMUnGX6guvxQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY5r459c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY5r459c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6005E1F000E9;
	Mon, 15 Jun 2026 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540348;
	bh=v1+WdThdQ6M0tyZF+/sT20m0JIQytES91L+AdkvpLJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TY5r459cLf69c6WVf6a/4F6Byp8LnH9Cq9/thaMisC/FDWM6b+XPhEfoaKnlN79fx
	 S2DQCgxVWyMpgkcHvMHjqAVmLf9GFAYPWJCxGhDnD1WzwJbhI3atSyk1ivevCvcsZd
	 HVuJzuZrrDXVRJ9W+g1CGOvdvsk9Ds/0O0bQfdmFIjJn6Q8WwNJm9H1eV2WvxMZtS/
	 YkM4EZZyBSnKF25TSoUM9nDLUMooBXUg8VeUWd2+quv7phmwPRxA0/vNeUXJ7XzTKm
	 YOPL/Fgm3swY1m0LS475GokB/VmE8pAZPnwi6xYOOhoY+eOAmZ8nOYVxo7/W4bsUar
	 r+iEsAk9/WsqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 06/10] dax/fsdev: use __va(phys) for kaddr in
 direct_access
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc096de8-8bc254a7-d2cc-44b6-82b1-1394fda8bb41-000000@email.amazonses.com>
References: <0100019ecc096de8-8bc254a7-d2cc-44b6-82b1-1394fda8bb41-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:19:08 +0000
Message-Id: <20260615161908.6005E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Multi-range dax_direct_access requests fail entirely instead of tr=
uncating to the contiguous physical range.
--

commit c552716e20bf1f475210a52b517ec59a7c2e9fd1
Author: John Groves <John@Groves.net>

dax/fsdev: use __va(phys) for kaddr in direct_access
   =20
This commit changes __fsdev_dax_direct_access() to use __va(phys) instead of
a linear offset to correctly calculate virtual addresses for multi-range
devices. It also removes the now-unused virt_addr field from struct dev_dax.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -51,9 +51,7 @@ static long __fsdev_dax_direct_access(struct dax_device=
 *dax_dev, pgoff_t pgoff,
>  	struct dev_dax *dev_dax =3D dax_get_private(dax_dev);
>  	size_t size =3D nr_pages << PAGE_SHIFT;
>  	size_t offset =3D pgoff << PAGE_SHIFT;
> -	void *virt_addr =3D dev_dax->virt_addr + offset;
>  	phys_addr_t phys;
> -	unsigned long local_pfn;
> =20
>  	phys =3D dax_pgoff_to_phys(dev_dax, pgoff, size);
>  	if (phys =3D=3D -1) {
>  		dev_dbg(&dev_dax->dev,
>  			"pgoff (%#lx) out of range\n", pgoff);
>  		return -EFAULT;
>  	}

[Severity: High]
This is a pre-existing issue, but does the current multi-range logic cause
valid requests to fail outright if they span a physical boundary?

When __fsdev_dax_direct_access() is called with a size that crosses a
physical range gap, dax_pgoff_to_phys() evaluates the full request size.
Because it enforces phys + size - 1 <=3D range->end, it returns -1 when the
request exceeds the current contiguous range.

Instead of truncating the response length to the contiguous pages available
in the current range (as the direct_access API contract requires),
__fsdev_dax_direct_access() completely rejects the request and returns
-EFAULT.

Could this prevent chunked processing of large requests, such as I/O reads
or huge page faults, that happen to cross a range gap?

Furthermore, the return value at the end of this function appears to ignore
physical boundaries:

return PHYS_PFN(min(size, dev_dax->cached_size - offset));

If dax_pgoff_to_phys() didn't fail on requests spanning gaps, wouldn't this
erroneously report non-contiguous memory as contiguous?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D6
