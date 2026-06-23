Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52663546CB
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218456; cv=none; b=ICAbOn767mqfyn19Racza8xTiBlQXDhfdSsToScKREbZVObx+zAIkx0r96GmeVP3LQDpCaaLHdNhldCeaoNreQdozP3KzdPbZEZ+LGgwYIma2vRud/KZvO3uUcZ0yzXTF9Q5ylz80xcrES3d00AcsbVCAfCqv/5UDdKuRuA2h+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218456; c=relaxed/simple;
	bh=dG4IF5QE7dmqwt873MWoKRTjsC86AEDQW1DO99aB/wc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PJ7TM1QwDis3o1JAI9pX5ae57H5pPOfWl2s6APKUYNpNxireKD4ZCmNv6MHQE1nEudY16CRKyuhmTZxJtsLIG8IOxsQiBFLq70OgE4k8hUTs0BFdqr48KSn6OGnhywAjTq5ea0ZO/TLdIQiE6Tm/UwYl5Y00Vo0B3gYFDVBsW6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHr7xrCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHr7xrCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291BB1F000E9;
	Tue, 23 Jun 2026 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218455;
	bh=mlMTCfU6VG+KuA1pfqDMlJsXnrQtZeUGXlEo8JdTajg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHr7xrCk/uY6nMYpbgI386jKzipqFAx7UiO5VQhZvS0LpRJq/WcuyG30tH0il/bS+
	 n/99MpL+rQSA7bMS2U/ZJoVRnIw/VOG7r1qhhkUBEEp6mIs735iKT8uVeqMz7w5KWN
	 FXbPiil2MjzmgyzbQByz54MSvCFaAsKhGGq31YT2Vo7r+alvOSk6BSD/m9ogSldr7M
	 6Mnl8KIVHQS/EORS1dNc9CqOrsmpZXcaFSGIk9oxdaVBXRRitijBRhZA5Y6muiVlk/
	 1LgBC3y42nDGRPIqj+s1KvRQZTkNdf4rATv17GELyp2Mbt8ZJpI7umYY4gpxMVJP4M
	 p+yMBmc9IaCAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:40:54 +0000
Message-Id: <20260623124055.291BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Resource Teardown Ordering Violation in efx_pci_remove
- [High] Missing Hardware State Restoration for CXL HDM Decoders After FLR
--

commit cd561fb9993e195accb646b7a8524a13a2dd0b79
Author: Alejandro Lucero <alucerop@amd.com>
Subject: sfc: obtain and map cxl range using devm_cxl_probe_mem

This commit introduces CXL support to the sfc driver by creating a CXL
memory device using devm_cxl_probe_mem() and mapping the CXL range for
CTPIO buffer usage.

> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/ef=
x.c
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_fini_io(efx);
> =20
>  	probe_data =3D container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);

[Severity: High]
Does this tear down resources in the correct order?

efx_fini_io() calls pci_disable_device() which disables memory decoding for
the endpoint.

Because the CXL memdev and its sysfs interfaces are managed by devres
(created via devm_cxl_probe_mem() during probe), they remain active until
devres_release_all() runs after efx_pci_remove() returns.

If userspace (e.g., CXL utilities, udev) accesses the CXL sysfs attributes
in this window, the CXL core will attempt to read memory-mapped component
registers on the disabled device.

Could this result in PCIe Unsupported Requests (UR) and a fatal AER fault or
kernel panic?

> =20
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");

[ ... ]

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c

[ ... ]

> @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENODEV;
>  	}
> =20
> +	cxl->cxlmd =3D devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);

[Severity: High]
Is there a mechanism to restore the CXL HDM decoders after a Function Level
Reset (FLR)?

When the driver performs a device reset via pci_reset_function() (e.g.,
during efx_mcdi_reset() in drivers/net/ethernet/sfc/mcdi.c to recover from
an MCDI timeout), the PCIe endpoint undergoes an FLR. This wipes the
internal device state, including the CXL Component Registers and HDM
decoders.

While the PCI core automatically saves and restores standard configuration
space, it does not restore the memory-mapped CXL HDM decoders.

Without notifying the CXL core or manually re-initializing the CXL DPA
capacity and reprogramming the HDM decoders, the device silently stops
decoding the physical address range mapped to cxl->ctpio_cxl.

Could subsequent PIO packet transmissions to the ctpio_cxl mapping trigger
PCIe Unsupported Requests (UR) and lead to AER faults or kernel panics?

> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
> +		return PTR_ERR(cxl->cxlmd);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622124010.2192=
888-1-alejandro.lucero-palau@amd.com?part=3D4
