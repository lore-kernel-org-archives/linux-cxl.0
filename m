Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796993D5C0C
	for <linux-cxl@vger.kernel.org>; Sat, 22 Aug 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787409835; cv=none; b=Fyt2GpJPoXhX6d3N2hepBAEB5r+ZsX2HjksDSRKQZqKcekkzLm+4zbJF0c44Xg67smQo6lTy7/saapWT7OPdoLWDAzXqSp0v5blRylZJM5ppve7/5Q/PxRQKl44fTfeOhGq3Ut8O85zfx02JL2CywXK+pLk2jDZqQnlWLCC7QUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787409835; c=relaxed/simple;
	bh=25RblJjqRx8yONZpteM1v7Yw0KCeVTNMQIQZHomxM+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hsr2OUpWxyJimJZbMR+ulMFfGmtBSJOeNm9eeHbV+4p4VBdy84hwlceHKOegq2FL1AL/+dM91TSRYHlVpteA4IfNuST2quJS1Lt5LHNqIC1+RXy4uGMn8HGOoYBb952Kni0GvgnAlxXF6jnzO5Jdmqh+UygWpA3VK2IsxPqxhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObG7pdgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObG7pdgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D4A1F00A3A;
	Sat, 22 Aug 2026 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787409834;
	bh=q1R/asDOoQo8xP+3W+lGMUScHFgK/f2Y6GQ46vZ2NhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ObG7pdgmbsU7Yk6n+8HEamQc4VRht7sByVsmMKuRXCH4ofGZ/GiVLh/LecQ3J6KeH
	 0bS1G3yXo6vuqZtk2T7UdRmwzX4sM4+J+HeDIXcwogA0Yi72EdSSNwC0kiJ+RxhKBK
	 jaTuxrs4GDIhXsc55EX+3x35WDCzwwT2M+ScRtzwXRTgsVuNzRDjlQG+Ci4kdPQSNv
	 uhTEWbFSUQUGqw9yDoO6aj1/UB5WvFGKPNHQzXfAhgV2jLrXwzvWDlZMFOW8B/v0zM
	 ae2D6adPRV8345rflIHaGZVZazX5TVB6Xuj84Bsy88Cu2qLJrOaAMa34qW0Z53Ox9W
	 uiSlSfOgm1Owg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 2/2] sfc: add multipf support
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260821155134.260053-3-alejandro.lucero-palau@amd.com>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
 <20260821155134.260053-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:43:53 +0000
Message-Id: <20260822144354.20D4A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] The variable `pf0_pci_dev` is used uninitialized as the starting p=
ointer for the `pci_get_device()` search, leading to memory corruption or c=
rashes.
- [High] The return value of `cxl_map()` is checked using inverted logic, t=
reating success as failure (causing a Use-After-Free) and failure as succes=
s (silently bypassing initialization failure).
- [High] The `struct pci_dev` reference acquired by `get_pf0_pci_device()` =
is never released, resulting in a persistent object leak.
- [High] Memory is dynamically allocated for the undefined or incorrect typ=
e `struct cxl` instead of `struct efx_cxl`.
- [High] The PF0 device matching logic compares `pci_dev->slot`, which can =
be NULL, potentially associating unrelated physical devices.
- [Medium] Missing teardown of `cxl_get_pf0_memdev()` on error paths in `ef=
x_cxl_init()`.
- [Medium] The manually allocated `struct efx_cxl` for non-PF0 devices is p=
ermanently leaked on driver teardown.
- [Medium] An early return in the `efx_cxl_exit()` non-PF0 path permanently=
 leaks the I/O memory mapping.
--

--- Patch [2]: [RFC 2/2] sfc: add multipf support ---
commit e798dff2eb0bc8eafa5e5bca36069e0989d743a9
Author: Alejandro Lucero <alucerop@amd.com>

sfc: add multipf support

Use CXL core accelerator API for registering non-PF0 PFs to the memdev
linked to the PF0, along with its complementary unregister. Adapt the
ioremap call per PF to be an offset based on the PF function index and
a hardcoded per PF CXL.mem slot size.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> index 348d7404cd7aa..e45c8dd1969c2 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -13,6 +13,48 @@
>  #include "efx_cxl.h"
> =20
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> +#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
> +
> +#define X4_PF_DEVICE_ID 0x0c03
> +
> +static struct pci_dev *get_pf0_pci_device(struct pci_dev *pfx)
> +{
> +	struct pci_dev *pf0_pci_dev;
> +
> +	while ((pf0_pci_dev =3D pci_get_device(PCI_VENDOR_ID_SOLARFLARE,
> +					     X4_PF_DEVICE_ID, pf0_pci_dev))
> +					     !=3D NULL) {

[Severity: High]
Since pf0_pci_dev is an uninitialized stack variable on the first iteration,
will pci_get_device() attempt to drop a reference on a wild pointer via its
internal pci_dev_put() call?

> +		/* With multiple X4 installed check against pci_slot as well. */
> +		if (pf0_pci_dev->slot =3D=3D pfx->slot &&

[Severity: High]
Could the slot pointers be NULL on systems where PCI slots are not described
by firmware?

If so, a NULL =3D=3D NULL comparison could inadvertently match the first PF=
0 of
any X4 card in the system, even if it is a completely different physical
adapter. Does this require checking bus or domain topology instead?

> +		    PCI_FUNC(pf0_pci_dev->devfn) =3D=3D 0)
> +			break;
> +	}
> +	return pf0_pci_dev;
> +}

[ ... ]

> @@ -20,9 +62,48 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev =3D efx->pci_dev;
>  	struct range cxl_pio_range;
>  	struct efx_cxl *cxl;
> +	u8 devfn;
>  	u16 dvsec;
>  	int rc;
> =20
> +	if (efx->type->is_vf)
> +		return 0;
> +
> +	/* are we PF0? */
> +	devfn =3D PCI_FUNC(pci_dev->devfn);
> +	if (devfn !=3D 0) {
> +		struct pci_dev *pf0_pci_dev;
> +		struct cxl_memdev *cxlmd;
> +
> +		pf0_pci_dev =3D get_pf0_pci_device(pci_dev);

[Severity: High]
Are we leaking the pf0_pci_dev reference here?

The pci_get_device() function increments the reference count of the returned
PCI device. Is there a missing pci_dev_put(pf0_pci_dev) after this function
is done using it?

> +
> +		/* This should not happen! */
> +		if (!pf0_pci_dev)
> +			return 0;
> +
> +		/* Is the PF0 device configured with and using CXL? */
> +		if (!pcie_is_cxl(pf0_pci_dev))
> +			return 0;
> +
> +		cxlmd =3D cxl_get_pf0_memdev(&pf0_pci_dev->dev, &pci_dev->dev,
> +					   devfn, &cxl_pio_range);
> +
> +		if (IS_ERR(cxlmd))
> +			return -EPROBE_DEFER;
> +
> +		cxl =3D kzalloc_obj(struct cxl);

[Severity: High]
Is the struct type passed to kzalloc_obj() correct?

It looks like this allocates memory for 'struct cxl' instead of the intended
'struct efx_cxl'. Will this lead to heap out-of-bounds writes when fields l=
ike
cxl->cxlmd or cxl->ctpio_cxl are accessed?

> +		if (!cxl)
> +			return -ENOMEM;

[Severity: Medium]
If this allocation fails, does the code leak the sibling entry created earl=
ier
by cxl_get_pf0_memdev()?

Should there be a call to cxl_put_pf0_memdev() before returning?

> +
> +		cxl->cxlmd =3D cxlmd;
> +
> +		if (!cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {

[Severity: High]
Is the return check for cxl_map() inverted here?

Looking at cxl_map(), it returns 0 on success. If cxl_map() succeeds, the
condition (!0) evaluates to true.

Does this mean the success path incorrectly triggers error handling, which
calls kfree(cxl) while leaving a dangling pointer in probe_data->cxl,
causing a use-after-free?

> +			kfree(cxl);
> +			return -ENOMEM;
> +		}
> +		return 0;
> +	}

[ ... ]

> @@ -80,25 +161,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
> =20
> -	cxl->ctpio_cxl =3D ioremap_wc(cxl_pio_range.start,
> -				    range_len(&cxl_pio_range));
> -	if (!cxl->ctpio_cxl) {
> +	if (!cxl_map(probe_data, cxl, 0, cxl_pio_range)) {

[Severity: High]
Does this have the same inverted return logic as the non-PF0 case?

If cxl_map() returns 0 on success, will this evaluate to true on success,
incorrectly logging an error and returning -ENOMEM?

>  		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>  			&cxl_pio_range);
>  		return -ENOMEM;
>  	}
> =20
> -	probe_data->cxl_pio_initialised =3D true;
> -	probe_data->cxl =3D cxl;
> -
>  	return 0;
>  }
> =20
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	struct efx_nic *efx =3D &probe_data->efx;
> +	struct pci_dev *pci_dev =3D efx->pci_dev;
> +	u8 devfn;
> +
>  	if (!probe_data->cxl)
>  		return;
> =20
> +	/* are we PF0? */
> +	devfn =3D PCI_FUNC(pci_dev->devfn);
> +	if (devfn !=3D 0) {
> +		struct pci_dev *pf0_pci_dev;
> +
> +		pf0_pci_dev =3D get_pf0_pci_device(pci_dev);
> +
> +		/* This should not happen! */
> +		if (!pf0_pci_dev)
> +			return;

[Severity: Medium]
If this early return is taken, does it bypass the trailing iounmap() call
and permanently leak the CXL PIO mapping?

> +
> +		cxl_put_pf0_memdev(&pf0_pci_dev->dev, &pci_dev->dev, devfn);

[Severity: High]
Does get_pf0_pci_device() leak another reference to the PCI device here,
similar to the init path?

> +	}
> +
>  	iounmap(probe_data->cxl->ctpio_cxl);

[Severity: Medium]
For non-PF0 devices, probe_data->cxl is allocated dynamically using
kzalloc_obj() during initialization. Is there a missing kfree(probe_data->c=
xl)
in this teardown path?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821155134.2600=
53-1-alejandro.lucero-palau@amd.com?part=3D2
