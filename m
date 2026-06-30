Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE0285CAE
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832938; cv=none; b=pteS8FV0R7IKgFDLSZeKfo5kbKBQZTbUsVixuPmCN0prZHBsQQkMrQqM39IlqaZKaxm7D+Ia935X4dwDaTWXv7fYyJP/J1C5FW+bRj2Lx/wfj/h3QhL+O7jnkrrQimAbSRgBC7HoYp7ZUXSIlcJgE2dw5GA38ixW/7/xmvLKBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832938; c=relaxed/simple;
	bh=O6D/D26p3Agqno4RwVn18jQgxFAg/80qO7ai+y0vjmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RLMngyd9u6f+mx55thPEfrTUmIO/jLK+zURT01G0H8leSa3GT3K4L/AmnQfqqz3Tjc9BNw2IDNp374mu8zASH0ntHlgtEKbN1N7bq4fx6e4gZXkbHuNM50oDa31K8fPdmIkiqlSPP9q1czNOnNe2maTdsIumlsKipZFjNJ1FRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE9+sYwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE9+sYwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2811F000E9;
	Tue, 30 Jun 2026 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782832937;
	bh=SvLQMun4tJq8YvLN2AVJsUEdqn5zk2ii1ftoVRQk4YU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fE9+sYwiBOeW/iY/TnPo0vzodUe63141dNGZSanKPSDifBcVbFLLVn/sRrPgu/hkx
	 dAKdxqEfT4ZgZcaMgqupma/AVguxdMGhwDQ1k2QZRAQm+W7TzvmnYMmJkWo48vjbco
	 71PHOQ6BV3mUGslOGmxOOp6ROLsMCV7E82H5OMCTcZjEw/GezPaByUuuJAxR0aBVzm
	 24AQ++GneYxIuL41rvnj/uJDJgLx2Fjhl9IOt00OuJORxLDPkeopING86oZWQ0T9/5
	 xlJWrkMZzKfgVX34jkdk20wwG5v9A2opP93KaHnlgfEpDIv0Iv5YRQLLiCE9QqO+GZ
	 g1y/LDYRFPC5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v31 5/5] sfc: support pio mapping based on cxl
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260630151346.31201-6-alejandro.lucero-palau@amd.com>
References: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
 <20260630151346.31201-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 15:22:17 +0000
Message-Id: <20260630152217.8C2811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing VI base and PIO register offsets in CXL PIO mapping, l=
eading to hardware register corruption
--

commit 125e7b168b7494938907570e29acc3c906cb9a0a
Author: Alejandro Lucero <alucerop@amd.com>

sfc: support pio mapping based on cxl

This patch adds support for mapping PIO buffers using CXL memory if the dev=
ice
supports it and is successfully initialized. Using CXL for the PIO buffer r=
egion
can help further reduce latency during TX packet exchanges.

> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/e=
f10.c
> index 7e04f115bbaaa..73bc064929f63 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
[ ... ]
> @@ -1263,8 +1273,23 @@ static int efx_ef10_dimension_resources(struct efx=
_nic *efx)
>  	iounmap(efx->membase);
>  	efx->membase =3D membase;
> =20
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
Does this assignment miss the required hardware offsets for the VI base and=
 PIO
buffer register?

In the legacy PIO BAR mapping path just below, the base is calculated with
these offsets:

    pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF - uc_mem_map_size

When efx_ef10_link_piobufs() sets up the TX queue, it computes the pointer
using this base:

    tx_queue->piobuf =3D
        nic_data->pio_write_base +
        index * efx->vi_stride + offset;

Without adding the VI base and PIO register offsets to the CXL mapping,
will the calculated pointer target the doorbell registers at offset 0
(e.g., ER_DZ_EVQ_RPTR, ER_DZ_TX_DESC_UPD) instead of the PIO buffers,
causing packet data writes to corrupt hardware state?

> +		nic_data->pio_write_vi_base =3D pio_write_vi_base;
> +	} else
> +#endif
> +	{
> +		/* Using legacy PIO BAR mapping */
>  		nic_data->wc_membase =3D ioremap_wc(efx->membase_phys +
>  						  uc_mem_map_size,
>  						  wc_mem_map_size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630151346.3120=
1-1-alejandro.lucero-palau@amd.com?part=3D5
