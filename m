Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E740D567
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130742; cv=none; b=JQtDHmc+KUKjTdBChSRqh21k1mqIf0EFAlosK9jZo+M2VUVnm9lFtPxlQtsPhtu9uGmOeVO8ZJQ9odFxAW5qWp61nu2E7b+f3uuh7THxfocdXI+mcC6rwqYKexcmzT1fzNaPbjoKdTPa+ruPmkjULauHNsisNRXvRFmRfXv8IHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130742; c=relaxed/simple;
	bh=K1/RlXXlNGvjpLj95IvbaGsT3YrznvdIsSZ1sq+GfxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dhtk8f3vrtqxjw5a8iL3ujwkd29fSrN77nHmIWnXhzgrdTj0mBzzOyAV8YzemrDFH/cBNZgM8OpLkIYdh7XFHWmHmwUC66bEDHna+IeOw3jZu6cPwcmoU6LdXrea8EXXY7DyoEu21G02haNJb/oRjV8XP/mjD6FhXRXmk98YAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWKwcNHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWKwcNHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6DC1F00893;
	Wed, 10 Jun 2026 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781130741;
	bh=C85QGUYI/5DE5PpIL+EWIeaUv6nHHGEq5VGT0B4NDXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWKwcNHkp0m1TkLfqzLFFnOMR3SIJpF973TqAMJIRhIudRZernBkHaLne0Ktkc0E/
	 mbt3HTRwpB2upEMYFuXYTFb8uUOlSDOQ1WtLumL3/Rh6vKMSdEeVbdUoHMZ3KbXNt+
	 OavioIzhmVtEuzi34wN3KEYYQ4QDaDkNNukzQOdvYstXGKNSh/owOsrLml3UDmWbkg
	 ciYOMV2pN9hDozWNdKa3jsco7/TG8RQMvjO01jakgnHY5Jab0d9MOUqFRkaAckhp0p
	 1E45WBoFpIUFgdzbT2Rqkeog/vNEn8haGA3hZR+oXv93JU372IxTcQQp5yoNn+DeFr
	 KEbGz7brvxq7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] cxl/test: Refactor platform device enumerations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260610222328.2272427-4-dave.jiang@intel.com>
References: <20260610222328.2272427-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 22:32:20 +0000
Message-Id: <20260610223221.3B6DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing error code assignments on `platform_device_alloc` failure =
cause populate helpers to falsely return success, leading to an invalid poi=
nter dereference crash.
- [Medium] Error handling cleanup loops mistakenly use `break` instead of `=
continue` in reverse iteration array cleanup functions, causing resource le=
aks on error paths.
--

commit 166861bc24df0a0108568d617198fe4532f08924
Author: Dave Jiang <dave.jiang@intel.com>
cxl/test: Refactor platform device enumerations

This commit refactors the platform device enumeration in the cxl test
module by splitting host bridges, root ports, and switch port setups
into separate helper functions.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index e91c125d557d9..b29be2597064e 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> +static void host_bridges_remove(void)
> +{
> +	int i;
> +
> +	for (i =3D ARRAY_SIZE(cxl_host_bridge) - 1; i >=3D 0; i--) {
> +		struct platform_device *pdev =3D cxl_host_bridge[i];
> +
> +		if (!pdev)
> +			break;

[Severity: Medium]
Since this cleanup loop iterates backwards from the end of the array, won't
a break here immediately terminate the loop on the first empty slot?

In the original code, this used a continue to skip empty slots and
successfully reach the populated devices at lower indices. Does this cause
resource leaks when initialization fails partway through?

This same pattern appears to be repeated in cxl_rootports_remove(),
cxl_usps_remove(), and cxl_dsps_remove().

[ ... ]
> +static int host_bridges_populate(void)
> +{
> +	int rc =3D 0;
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(cxl_host_bridge); i++) {
>  		struct acpi_device *adev =3D &host_bridge[i];
>  		struct platform_device *pdev;
> =20
[ ... ]
> +		pdev =3D platform_device_alloc("cxl_host_bridge", i);
> +		if (!pdev)
> +			goto err_bridge;

[Severity: High]
If platform_device_alloc() fails here, does this function return 0
instead of an error code?

Because rc is initialized to 0, returning 0 would cause the main init
function to assume success and proceed.

If initialization proceeds to cxl_rootports_populate(), it will try to set
the parent pointer using a NULL bridge device:

cxl_rootports_populate()
    bridge =3D cxl_host_bridge[...];
    pdev->dev.parent =3D &bridge->dev;

Could this cause an invalid pointer dereference when platform_device_add()
is subsequently called? Should this set rc =3D -ENOMEM before jumping to
the error label?

This missing error code assignment also appears to happen in the new
cxl_rootports_populate(), cxl_usps_populate(), and cxl_dsps_populate()
helper functions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610222328.2272=
427-1-dave.jiang@intel.com?part=3D3
