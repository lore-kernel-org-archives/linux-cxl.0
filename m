Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03A331EB7
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889886; cv=none; b=DBSlZiYKJpNSt8ZQ00vES7UtuoZE5Nnl1mmsNBgsvXnDlP9OUKDCInTzu3PIXaL2blRArT3OX8GKupv6AhqDzZlwbBtSN+XNU3Gwsu+zosUKw416oHm1jfmRfuJsa/Aw5AlwDG9a+6Pae+dGdNl78q8dnOHObq+yCm12Autte/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889886; c=relaxed/simple;
	bh=eErQtOTgtwuIhxG30YhdpmU8HrmYt2O8CZHh3+JWwzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZGom/SGTMpRGWp5c0NbdP5nhU1WWQq66LoVB2rwcmj8Z2Fl1B2i6fEgZ/ytU+miJW8q8DCJQIiTj/jXHP4bl+eA9p0Hg/NzuZNjwV3P0d6NhnSmjbkap3+SPlV0+UBDommcFUNRSCywDohqHs4mKIM1K1Hze7qG/Aq9cCD6XHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIOEyYRk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIOEyYRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CC31F000E9;
	Fri, 19 Jun 2026 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781889885;
	bh=1xy5PGlOwNzqcQjahSQceKWq2U5jYuIjQI3wyCF00iQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIOEyYRkciAsORzsJQFPRhitECdhoZ8116jPVEaVzg/ZAZQ1yXCD/ysw0YiLFbDM1
	 219kqqZ05jqzRy13cnqH2cf6qvos377wzMIguNZFwhq+hkYY4CiQh1ZCfvW+rzlMST
	 ff1dZsORKL1rtLnpmSAS4AskB7Ds9xfcvEKUFzTo0mynX8KwKwFqYrI/FuDJAFJj9Y
	 H8WnkjftTp17cJHwAycMlzTs3ps1IhOsLew4MoJE818iezyXO2Ec3P7+uafHQMArkK
	 /ycOc1WEiDCzlIenqssew5ssefA/jC5N4wRHFQZBNxIfMJsa1o6PKruw680YPZSEgk
	 CiwjKr+ptbMFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 5/5] sfc: support pio mapping based on cxl
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260618181806.118745-6-alejandro.lucero-palau@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:24:45 +0000
Message-Id: <20260619172445.74CC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Incorrect Address Calculation / Out-of-Bounds Memory Write in =
CXL PIO Buffer Mapping
--

commit 7aab6942f29d4c0369d1d6d644627cf376efd5b7
Author: Alejandro Lucero <alucerop@amd.com>

sfc: support pio mapping based on cxl

This commit introduces support for mapping PIO buffers via a CXL memory
region to lower transmit latency. It uses the CXL region to map the memory
range when a CXL device is successfully initialized.

> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/e=
f10.c
> index 7e04f115bbaaa..73bc064929f63 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
[ ... ]
> @@ -1263,8 +1273,23 @@ static int efx_ef10_dimension_resources(struct efx=
_nic *efx)
[ ... ]
> -	/* Set up the WC mapping if needed */
> -	if (wc_mem_map_size) {
> +	if (!wc_mem_map_size)
> +		goto skip_pio;
> +
> +	/* Set up the WC mapping */
> +
> +#ifdef CONFIG_SFC_CXL
> +	probe_data =3D container_of(efx, struct efx_probe_data, efx);
> +	if ((nic_data->datapath_caps3 &
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
> +	    probe_data->cxl_pio_initialised) {
> +		/* Using PIO through CXL mapping */
> +		nic_data->pio_write_base =3D probe_data->cxl->ctpio_cxl;

[Severity: Critical]
Does this assignment miss the VI stride and PIO buffer offsets?

In efx_ef10_dimension_resources(), the raw CXL memory base is assigned=20
directly to pio_write_base. In the legacy path below, the base is adjusted
by the VI stride and PIO buffer offset:

nic_data->pio_write_base =3D
        nic_data->wc_membase +
        (pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
         uc_mem_map_size);

Without these adjustments in the CXL path, subsequent PIO buffer address
computations seem to resolve to offset 0 of the VI, which corresponds to
the hardware doorbell registers like ER_DZ_TX_DESC_UPD.

Could this cause untrusted network packet payloads to be written directly
into the active RX/TX doorbell registers instead of the PIO buffer area?

> +		nic_data->pio_write_vi_base =3D pio_write_vi_base;
> +	} else
> +#endif
> +	{
> +		/* Using legacy PIO BAR mapping */
>  		nic_data->wc_membase =3D ioremap_wc(efx->membase_phys +
>  						  uc_mem_map_size,
>  						  wc_mem_map_size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618181806.1187=
45-1-alejandro.lucero-palau@amd.com?part=3D5
