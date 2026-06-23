Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508A33B14AC
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218459; cv=none; b=kGGNxjywtYacuAy772Owkb2eJYkFTbzl5IxIBWCMIX2+j4V9N5K82iy5yYKKLFh4H1TqsR4n3NDQbYoX9gvunhsreWoYbYGC8BpLj7JGOWCUGO0CaQEj1mqsl4HgGQFkJOXmCHW0wL7ybsxaGglV4vT4Ybsuwh7hDGc5F0qN6pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218459; c=relaxed/simple;
	bh=IxhxKbhY+j4citQg9ZIatgRjlSkDftpTfMJgDVkEe6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7SEziSiGR0MHhwUmUDd2fSiCou2J2Ts14Z6IsvMlIP9Sc9WOzaHgACH2YFJ+XQfPTl902QsQoeJyaP8osM8MDq/6zXSMRdVb+Qb5ZDfHUeWnirzJzHa5J5j3WlSK8YJa4Pe6fhOGEMo96XE5PvI2JpB9rA/8JvJkbbBHZEP2o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBpOLiMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBpOLiMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCAF1F000E9;
	Tue, 23 Jun 2026 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218458;
	bh=PV9luMXVVssVT6m47BRWoIbBDxepuvtnk4mfbKBIWZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBpOLiMCgKk8GU6uDpMoz54Ye26ceTPQQrFJnAaINe36nxM3zuHor2EoabuYMKiSH
	 bXJu1XlsEdPX3KfmSimALCR8w7Lobz2hdc6n3742uWi+6AY/1rM502OEGqScuJnpvM
	 BwmDEMLlbfs8g+SyZwU4kNI15wangRAc3hhz2KxYuWqWifUzkDEdxrXtLQV88LTLcT
	 XvAAiEC7yUNkpvYhqT+fQq30LSBH4llRi668pjgIUyaf35rZ5pnaCx1quXepDIk+WS
	 m1TUvYRh70i17Aoa7qzR66m0lEI8df/AFC8luQJlhCDQeLIE1LmoQ/r+yCpAihH6ao
	 105m3ZUyy0Erg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 2/5] cxl/sfc: Map cxl regs
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260622124010.2192888-3-alejandro.lucero-palau@amd.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:40:56 +0000
Message-Id: <20260623124057.CDCAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_dport_map_rcd_linkcap() maps RCD link capability registers usi=
ng devm on the endpoint's pci_dev, but stores the pointer in the longer-liv=
ed cxl_dport, creating a dangling pointer when the endpoint driver unbinds.
--

commit 521897a4e4d35020c7cc57f7004dd3c659771f44
Author: Alejandro Lucero <alucerop@amd.com>

cxl/sfc: Map cxl regs

This patch exports cxl core functions to allow a Type2 driver to discover
and map device registers. It then utilizes these exported functions during
the sfc driver's cxl initialization path.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> index be252af972ab3..704b0ebae9374 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
[ ... ]
> @@ -42,6 +45,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	if (!cxl)
>  		return -ENOMEM;
> =20
> +	rc =3D cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxl->cxlds.reg_map);

[Severity: High]
This is a pre-existing issue, but does adding this call in a new endpoint
driver expose us to a use-after-free when the endpoint driver unbinds?

Looking at the call chain, cxl_pci_setup_regs() can call
cxl_dport_map_rcd_linkcap(). In that function, it allocates an I/O memory
mapping bound to the endpoint device (pdev) via devres, but stores the
pointer in the longer-lived dport structure:

drivers/cxl/core/regs.c:cxl_dport_map_rcd_linkcap() {
    ...
    dport_pcie_cap =3D devm_cxl_iomap_block(&pdev->dev, ...);
    ...
    dport->regs.rcd_pcie_cap =3D dport_pcie_cap;
}

Since dport belongs to the upstream CXL port and outlives the pdev binding,
if the sfc driver unbinds, the devm mapping is freed, leaving
dport->regs.rcd_pcie_cap as a dangling pointer.

In a multi-function Restricted CXL Device (RCD), all functions share the
same upstream host bridge and therefore the same cxl_dport. If multiple
functions bind to drivers (e.g., cxl_pci and sfc) and sequentially
overwrite the devres-managed mapping, could unbinding the most recently
bound function cause a kernel oops later if a user reads the sysfs
attribute via rcd_pcie_cap_emit()?

> +	if (rc) {
> +		pci_err(pci_dev, "No component registers\n");
> +		return rc;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622124010.2192=
888-1-alejandro.lucero-palau@amd.com?part=3D2
