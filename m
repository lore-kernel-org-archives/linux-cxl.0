Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568303C09E8
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889886; cv=none; b=bL+bgnroJWrvfeV4wXzqTxYDaY037+x+TJ1CAzq3YIx+6IzWn/A7OSbxfqwYEv4AWX6iStSKb5z4+7OR4EdMBbut9OZQht+5HYIqih/KmzzWEalrNEvoOaOeWHZBjLI2a2eytv5SGHmBv2eJQAKpbZE+jRbbqY41PNmkAVFj0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889886; c=relaxed/simple;
	bh=6PNSeOYJDs6BI2dzxdUVsgggPScZRd5wggFS2dr9ziw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o7w7Euyo3999gHdt2WV/f0NsiKncbo2GZLdGsW7HSJiITo/9/9ZGNe4cqtQALp641TvrBm7u15cKS4zYQ6LP7viRIiiq3q6osf3WjzQFwm2V8WKL+0u8RmMGdWfTAGK8etXL/S4wj8AW0Pf6AaqEAswNMnaQEKvyRBUZZFXUEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnE4F8Es; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnE4F8Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0EF1F00A3E;
	Fri, 19 Jun 2026 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781889885;
	bh=btmThH5ANi0m3okEevCJ8wwr4sWFeqq5gZuZUUX8YrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bnE4F8EsVzoTBaw2wPrAHNCjRe3qEztOglsMhsK9Ikl/DRDtpavJvtIojj4EiZeJp
	 h788frx6FoMCKEQ39EnP7VAdnd8K+yekDzBgXvQD7W9nYmH5H5SWFxROd8JYXloFoj
	 TJkMpOtq2k9AGgsHBNVqnC+MfWJNqjx66yQs0qAgIqrUG3wx3aqGjc0rc5nRLKMXcb
	 VMSMWrYUBF/SnAvbTjHBd0BEJT8n232wyV7GS/JezTAElaRZuDOCTGoysDOmVrbKeB
	 8s4cLgXTC7CP1qqrWdzKrygRmG/yi1AUOTFDuaux3E3ydj8G+8BPwDPKh8JG/kps6O
	 4wXd5TbTHAoqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 2/5] cxl/sfc: Map cxl regs
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260618181806.118745-3-alejandro.lucero-palau@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:24:44 +0000
Message-Id: <20260619172444.EF0EF1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `cxl_probe_component_regs()` performs unvalidated reads on the CXL=
 component register block, which can cause a kernel panic if a malformed PC=
Ie device exposes a small or truncated register block.
--

commit 0e4acdaa76943d29ebab4e0ccea9ab0230622629
Author: Alejandro Lucero <alucerop@amd.com>

cxl/sfc: Map cxl regs

Export cxl core functions for a Type2 driver being able to discover and
map the device registers.

Use it in sfc driver cxl initialization.

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
This is a pre-existing issue, but when discovering the CXL register blocks,
cxl_decode_regblock() in drivers/cxl/core/regs.c computes the size of the
block as:

map->max_size =3D pci_resource_len(pdev, bar) - offset;

If a malicious or buggy device presents a Register Locator DVSEC with an
offset close to the end of the PCI BAR, map->max_size could be very small.

Later, cxl_probe_component_regs() blindly advances the base pointer by
CXL_CM_OFFSET (0x1000) and attempts to read the capability array:

base +=3D CXL_CM_OFFSET;
cap_array =3D readl(base + CXL_CM_CAP_HDR_OFFSET);

Are there any bounds checks verifying that map->max_size is large enough
before these reads occur, or can this cause an out-of-bounds I/O memory
read and a kernel panic if a malformed PCIe device exposes a truncated
register block?

> +	if (rc) {
> +		pci_err(pci_dev, "No component registers\n");
> +		return rc;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618181806.1187=
45-1-alejandro.lucero-palau@amd.com?part=3D2
