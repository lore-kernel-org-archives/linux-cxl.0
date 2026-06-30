Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D34435B657
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831895; cv=none; b=RJa0semsUgvQJLEsEJD90qegZmuSVrfb+nMFwrneVLLHfjELa66F4bIYqQ3HpKpLN0ITWWT8RK4D/UQ6aY1yq5VtHsBXGjaCPgvIqLvLfmkkI88l3nQSGHz73ZeB79f4zE9FgD2S9fmAZPtYlw9LtMNQVTPuY9NWKzzs1iLPXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831895; c=relaxed/simple;
	bh=ax4t1mFtv+iIyY1dRTT73kD4bpOfm9Jfk7od/khJTk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZIn8VyVPT5EEbdfVnfFlsnQo2vIitiHTOwex+OOytq7swduhWP4XdF4wNcEqp2CnPfkoZVCmNjn2384lwKznZSwm41d73JHiybheDcIqu53xfCEE/Xo95d61MHwTmJ+EMGKZZL9w+ykV+JY7wxCcANS9z8xxTnMXk7476xRX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOQcV81O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOQcV81O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0784E1F000E9;
	Tue, 30 Jun 2026 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831894;
	bh=FtMBgvCx7dXRqjGNgOcV5wq5zrFV4ZwkZa8rRbLZhlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOQcV81OzNpCGskV3o4hLSUNsHm2k8Y2+Vy3aB0OZw84lEZJq5AFgdH4TtyKlqTr3
	 Rhy7dRswLXSbQKzL3gGtKAzHwvz3yl04GDbT4VjLuyW3uJ0n6UlvGPHFBQ9YruzsTu
	 sRnXOCFyAyZ/VepQghNzO+Gy6hDMo3khRBVDEJ4Ok0Rlbzx65DBtabq30PsqxuSjTQ
	 Rw3QK3MgYpVeW1Dj4shRtBIZw4Om2rIp6XNiPD6YM6ypAN4kbHf+KAxfm7P2I+MExc
	 FQ7EAIMbzWuLIcQEHKt+zV0EU46xIbgMF3e3PNU7doJ2ohrvJiyk5TJebkkugDgyDE
	 8ckw/Kibd2JRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v31 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260630151346.31201-5-alejandro.lucero-palau@amd.com>
References: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
 <20260630151346.31201-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 15:04:53 +0000
Message-Id: <20260630150454.0784E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Inverted teardown order unmaps write-combining memory and cleans u=
p devm CXL resources after the PCI device is disabled.
--

commit 8a6ea64dcd83c4ec06b3116375770f0f9dce6ca6
Author: Alejandro Lucero <alucerop@amd.com>
Subject: sfc: obtain and map cxl range using devm_cxl_probe_mem

This commit uses the core CXL API to safely obtain and map the CXL range
linked to an HDM committed by the BIOS. The mapped range is used as the ctp=
io
buffer.

> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/ef=
x.c
> index 61cbb6cfc3602..3806cd3dd7f48 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_fini_io(efx);
> =20
>  	probe_data =3D container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);

[Severity: High]
Does this sequence unmap the Write-Combining memory after the PCI device is
disabled?

In efx_pci_remove(), efx_fini_io() is called first, which calls
pci_disable_device(). Then efx_cxl_exit() calls iounmap() on the ctpio_cxl
mapping.

If a CPU write-combining buffer flush occurs during iounmap() on a disabled
device, could it trigger a fatal PCIe error (Master Abort) and a kernel pan=
ic?

Also, since devm_cxl_probe_mem() and devm_cxl_dev_state_create() are used
during initialization, devres will clean up these resources after
efx_pci_remove() returns. Does this mean the devm cleanup also accesses the
device after it has been disabled?

> =20
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
> =20

[ ... ]

> @@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	return 0;
> =20
>   fail3:
> +	efx_cxl_exit(probe_data);
>  	efx_fini_io(efx);

[Severity: High]
Does this error path cause devm-managed CXL resources to be cleaned up on a
disabled device?

While efx_cxl_exit() correctly unmaps the region before efx_fini_io()
disables the device here, the devm-managed resources (like the CXL accel
memdev) will be destroyed by devres after efx_pci_probe() returns.

By the time devres runs, efx_fini_io() has already called pci_disable_devic=
e(),
so the devm cleanup will happen with the PCI device already disabled.

>   fail2:
>  	efx_fini_struct(efx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630151346.3120=
1-1-alejandro.lucero-palau@amd.com?part=3D4
