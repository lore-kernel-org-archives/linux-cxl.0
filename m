Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8E494835
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942536; cv=none; b=cBxfa1eU32bDMlhdw8RD15Kf7qX8oBjXRhOtQrTPQe5sx8FQ13Et2za9GXtr4CJWmfkHG2mkM/LCdANAWkdY4/S5InwCzMRL8F5hbSiHSG6f15PgraaEO3ZzJWtQzPHdaBvKj0rFJQ5gIr41ZuyxyWo0I5duWr/XRCJH0uu+/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942536; c=relaxed/simple;
	bh=3FOWLXGlCG3RVyIHcsZr/v1j+CawipBdOQaLfbR48kY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R76UpuSMM0gx4nte9l41l6PrksVXb1WDd6mLY3irmMNEfSwzyzP82on+WAYT6/qlSsZPU3uFVeyzDIrm4D7LnHDYCbRyxw2BXcFSalOFJcPH2NLgMiaAdRB/cSNQdblz/WsjElu600ktE+S8IkUjuoAaYb4QrhcIxJdgLNJU/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwbWYukK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwbWYukK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685261F00898;
	Fri,  2 Oct 2026 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942534;
	bh=5sqsgoUQyH8E8uARFaW10E776iS2nbpyNMwpM1goK/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VwbWYukKRvvP6eqZ3lXg+aaVIdqIvEvXoVzeaHj79N16/tkcK1ycANhYuhHmilvoI
	 Ot64Wyv7keDtCC4wOTYtE7kS23aO+/MNcAIqpLmItb7G8e0cL4xRrN75btNLAHb1kc
	 DJ4hdp/tHT15FEsuxAS3tpcQbdR3JuIQxu32jh6MZJlcM9zAj51HhiOwrYEUSzOLLG
	 25kSyaxOhY/MbbTnWcrhuyUBxyEIpygVkkyKCiAODSbhaKHiwTdb2/NEb0Pnk96MD9
	 QzDROl/FEoLwZrOiEw5IP1HrvpeuIlZUPIkOxq+BziyDphKntHoItl+m6WAaWpd0mm
	 LXzeYkgOsQDSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] cxl/memdev: Add support for multi PF devices
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261001132023.17032-4-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-4-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:02:13 +0000
Message-Id: <20261002120214.685261F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] cxl/memdev: NULL pointer dereference when accessing missing cxlmd-=
>attach
- [High] cxl/memdev: data race leading to NULL dereference of attach->cxlr
- [High] cxl/memdev: TOCTOU NULL pointer dereference on cxlmd->cxlds
--

commit ad669ced94a784d488cc194089a6921ef73d1404
Author: Alejandro Lucero <alucerop@amd.com>
Subject: cxl/memdev: Add support for multi PF devices

This commit enables non-PF0 Physical Functions to access CXL memory by
establishing a device link between the CXL region attached to the PF0 memdev
and the non-PF0 devices. Unbinding the PF0 device will naturally release the
memdev and region, safely unwinding the non-PF0 drivers first.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9c..799cb6e756390 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
[ ... ]
> @@ -802,6 +802,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cx=
l_dev_state *cxlds,
>  	return ERR_PTR(rc);
>  }
> =20
> +static int match_memdev_by_parent_device(struct device *dev, const void =
*data)
> +{
> +	const struct device *pf_dev =3D data;
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!is_cxl_memdev(dev))
> +		return 0;
> +
> +	cxlmd =3D to_cxl_memdev(dev);
> +	return (cxlmd->cxlds->dev =3D=3D pf_dev);

[Severity: High]
Does this create a race condition that could lead to a NULL pointer
dereference? When bus_find_device() iterates over the CXL bus using
match_memdev_by_parent_device(), it evaluates cxlmd->cxlds->dev =3D=3D pf_d=
ev
without holding a lock protecting cxlmd->cxlds.

Concurrently, if an unrelated cxl_memdev on the bus is shutting down,
cxl_memdev_shutdown() explicitly sets cxlmd->cxlds =3D NULL. If the matching
loop encounters this shutting-down memdev, could it trigger a deterministic
NULL pointer dereference?

Since dev->parent is stably assigned to cxlds->dev at creation, could this
check use dev->parent =3D=3D pf_dev to bypass this race entirely?

> +}
> +
> +static int __cxl_get_range_and_link(struct device *pf0, struct device *p=
fx,
> +				    struct range *range)
> +{
> +	struct device *mem_dev __free(put_device) =3D
> +		bus_find_device(&cxl_bus_type, NULL, pf0,
> +				match_memdev_by_parent_device);
> +	struct cxl_attach_region *attach;
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!mem_dev)
> +		return -ENODEV;
> +
> +	cxlmd =3D to_cxl_memdev(mem_dev);
> +	attach =3D container_of(cxlmd->attach, struct cxl_attach_region, attach=
);
> +
> +	/*
> +	 * The cxlmd object does exist and it can be found in the cxl bus after
> +	 * creation but before attach probe setting the proper HPA range. If so,
> +	 * the caller will need to try later.
> +	 */
> +	if (attach->hpa_range.end =3D=3D CXL_RESOURCE_NONE)

[Severity: High]
Could this blindly dereference a missing cxlmd->attach? When
cxl_get_range_and_link() retrieves a cxl_memdev by parent device, if the
target device was created without an attach callback (e.g., via
devm_cxl_add_classdev()), cxlmd->attach is NULL.

Since container_of(NULL, struct cxl_attach_region, attach) evaluates exactly
to NULL because the member is at offset 0, evaluating attach->hpa_range.end
would trigger an immediate kernel crash. Should this exported subsystem API
validate its state first to prevent remote subsystems from inducing crashes?

> +		return -EPROBE_DEFER;
> +
> +	/*
> +	 * Create the device link between the region and the consumer device.
> +	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
> +	 * consumer unbinds first with no consequences for the supplier.
> +	 */
> +	if (!device_link_add(pfx, &attach->cxlr->dev,
> +			     DL_FLAG_AUTOREMOVE_CONSUMER)) {

[Severity: High]
Does reading attach->hpa_range.end and attach->cxlr here lack synchronizati=
on
against the cxl_mem probe writer?

While __cxl_get_range_and_link() relies on device_lock(pf0) to serialize
access:

cxl_get_range_and_link() {
    ...
    device_lock(pf0);
    rc =3D __cxl_get_range_and_link(pf0, pfx, range);
    device_unlock(pf0);
    ...
}

cxl_memdev_attach_region() writes to attach->cxlr and attach->hpa_range
during the cxl_mem driver probe, which executes asynchronously under the
child's device lock (device_lock(&cxlmd->dev)).

Due to the lack of synchronization and memory barriers between these distin=
ct
lock contexts, could a reader observe an updated non-NONE hpa_range.end whi=
le
attach->cxlr remains NULL, passing &attach->cxlr->dev to device_link_add()
and crashing the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001132023.1703=
2-1-alucerop@amd.com?part=3D3
