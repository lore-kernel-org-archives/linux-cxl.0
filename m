Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EF3D4117
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218457; cv=none; b=WQh+Xh2MMEEJar4r6TNkuHCDvIQkMuV3zXlOU9w8LkpAHC2wd2Om+1jo3e2gkR2LRW/g9xgIFKEjzOsLxGVgrbAkrqNIbIhLc411O6anL6qKZVW+vyLB/ELGTKjwrfD7oQ286sa+F1oWLrBixom2kpsvSV9r5+hr5raTaaXQxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218457; c=relaxed/simple;
	bh=1taQu3s4oH7Wtxfm/lLUikrirF7ZTBiNtdboSpI/1/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KwaRGbypAh2/Vvr13TvqHUuvc+FfzUJvG48aguGfl6dKuqZcblGUpQ21mogCCiBdEGh9K5LDU9brGucBQf5QnvmOkIC1+yMCaUO3aQmw360CsH64JcOF7MkrakoeQCK+wEwvGQI/s+deecuc84kPv6qDsrbPAEC+YTDdf6/12Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV0j0YRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV0j0YRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5DE1F00A3A;
	Tue, 23 Jun 2026 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782218456;
	bh=+SP8HBqlsBkvpj9hKhzJPcvNSCfYdjn46PddkgC5XX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gV0j0YRrPJ/FIFqfa4dM3LV1I1TZLTe970lnTYXYcB2jHwiB8St3cXCLtIYuYMe6Z
	 PFn6WIWFIA+lxsG0obdq+Bw2LfdWd56X6chG631FinF71C96xRg6G1fbjREwI7uuXi
	 zgr5snoW2hlDzwMcxBUnIy19Imwrzn3MesDAfWOHq8GKNhz8aKSJx7kgnDUwCVwYgU
	 bE95NCBsC4LBszAdbkuN4MaIRG6knSzuWZMFLQxaaFEZRSHWn/Ju9qrGRwbTqXL8yU
	 xtGtkn6HOfZS9TQDPjsd9a0f1a2hMhb7hWvo3m5PdT0ul6J5/XGSoz85deqRPAOZY9
	 va4vJwlNEGtJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 5/5] sfc: support pio mapping based on cxl
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260622124010.2192888-6-alejandro.lucero-palau@amd.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:40:55 +0000
Message-Id: <20260623124056.0D5DE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver aborts the entire NIC probe if CXL initialization fails=
, breaking the device on platforms with incomplete CXL support.
--

commit 3b1f648d427984478265f9b668913970af1efedf
Author: Alejandro Lucero <alucerop@amd.com>

sfc: support pio mapping based on cxl
   =20
A PIO buffer is a region of device memory to which the driver can write a
packet for TX, with the device handling the transmit doorbell without
requiring a DMA for getting the packet data, which helps reducing latency
in certain exchanges. With CXL mem protocol this latency can be lowered
further.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> index 3e7c950f83e93..348d7404cd7aa 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -88,6 +88,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENOMEM;
>  	}
> =20
> +	probe_data->cxl_pio_initialised =3D true;

[Severity: High]
If efx_cxl_init() fails earlier in the function (for example, if
devm_cxl_probe_mem() returns an error on a platform with incomplete CXL
support), it appears the caller in efx_pci_probe() will abort the entire
NIC probe.

Since CXL-based PIO buffers are an optional latency optimization and there =
is
a perfectly functional fallback to legacy PCI BAR PIO mapping in
efx_ef10_dimension_resources() when cxl_pio_initialised is false, shouldn't
the driver gracefully fall back to legacy PIO rather than breaking the devi=
ce
when CXL initialization fails?

>  	probe_data->cxl =3D cxl;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622124010.2192=
888-1-alejandro.lucero-palau@amd.com?part=3D5
