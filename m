Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F0409630
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540703; cv=none; b=CH4UrYQar9yGrYlogVuSekoSjaPXwEAU3rEguebOcsQ8g0lQj6Nuu9H0R8KKUN41q1HxDQWaWLBctJjcn/Dwyf1i5wsW94AcMXlXc9sJy30E8fYQWCVC4NpqrAaB9Id3c15J/VRz3MlhiwDs2598jUn13fhJGuXX8RLqgxjMtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540703; c=relaxed/simple;
	bh=AJV5RDAa7vxGroyRlgZKl/eMRDw/u9rZS3qCiYKzCIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KcJ9jyrMJg5MjEmuzY73ieODpuQFAtFrwD7UgkF2SlHwmkefAyO+u4Z50o4eWYLtx+KkzPHLLipEwIkupjVxDLJz89V2m9wx5oZeTAzreax1maJedBrcMhySfZnLdBAC+2OK8bK3HIYRZqopm1hfbykuKdmTuIcT0U0i7XsPvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4Dl+XTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4Dl+XTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D1C1F000E9;
	Mon, 15 Jun 2026 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540701;
	bh=oe4NXm5c1ALTSzG+B4Jbj6aBAEAiJaeZGHBzWlFiUss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S4Dl+XTmpp/rrCAW6zbn6N19NUMKydzAptvF4sC0Bn0YZ4UNgDI+myanQiwkXSUBb
	 oZTkj6ptp37Xnd5VBFpW/wkJCWNYaeFupYaO6G4nkqLKyWlH86fg8xLUiorYNoyELy
	 57+icuCy3+V9vzX3/U+euWDAwFIl7LSVE6lDsiNEcUI5sNyfmmJ/bwG53roSQu8KuD
	 hCS4ObtyYXRSqNPt6f6b3d0AFm7aVCTg11tSKAWWymc9brLiAs2Ek0ga3jSoTJXhKx
	 bLX854MdYnsk6jVlTCtstz7c9BeyrjO1a/XYmlPYyBL3ryEopZMEO2L179caUXCOpT
	 96GXHbiFhyw6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 03/10] dax/fsdev: clear vmemmap_shift when binding
 static pgmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Groves" <john@jagalactic.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <0100019ecc090eea-7c46f51e-5393-402c-850d-78059bb6d343-000000@email.amazonses.com>
References: <0100019ecc090eea-7c46f51e-5393-402c-850d-78059bb6d343-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 16:25:01 +0000
Message-Id: <20260615162501.92D1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer in `dev_dax->pgmap` on probe failure for dynamic =
DAX devices permanently breaks subsequent driver binds.
--

commit fd456f28017271824ad7d531a3c134c95b20881f
Author: John Groves <John@Groves.net>

dax/fsdev: clear vmemmap_shift when binding static pgmap

This commit clears the vmemmap_shift on the shared pgmap for static DAX
devices when rebinding from device_dax to fsdev_dax. This explicitly
zeroes the shift before devm_memremap_pages() so the vmemmap is built
for order-0 folios.

> diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> --- a/drivers/dax/fsdev.c
> +++ b/drivers/dax/fsdev.c
> @@ -237,6 +237,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
>  		}
> =20
>  		pgmap =3D dev_dax->pgmap;
> +		pgmap->vmemmap_shift =3D 0;

[Severity: High]
This is a pre-existing issue, but while reviewing the probe logic here,
could a dangling pointer occur during probe failure for dynamic DAX
devices in drivers/dax/device.c?

Looking at dev_dax_probe() in drivers/dax/device.c, dev_dax->pgmap is
assigned to a devm-managed allocation:

drivers/dax/device.c:dev_dax_probe() {
    ...
    dev_dax->pgmap =3D pgmap;
    ...
}

If a subsequent devm operation fails, such as:

drivers/dax/device.c:dev_dax_probe() {
    ...
    if (!devm_request_mem_region(dev, range->start,
                                 range_len(range), dev_name(dev))) {
        dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve range\n",
                 i, range->start, range->end);
        return -EBUSY;
    }
    ...
}

The probe aborts and devres frees the pgmap. However, since dev_dax_kill
has not yet been registered as a devm action, dev_dax->pgmap is not reset
to NULL.

If a subsequent probe attempt occurs, would it hit this earlier check and
permanently fail by evaluating the dangling pointer?

drivers/dax/device.c:dev_dax_probe() {
    ...
    if (dev_dax->pgmap) {
        dev_warn(dev,
                 "dynamic-dax with pre-populated page map\n");
        return -EINVAL;
    }
    ...
}

Since the underlying dev_dax structure persists on the DAX bus, does this
effectively block the dynamic DAX device from being bound until it is
explicitly deleted and recreated?

>  	} else {
>  		size_t pgmap_size;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0100019ecc080a68-8d=
c0c99f-ab17-4aa9-83d9-490e9c97ac2e-000000@email.amazonses.com?part=3D3
