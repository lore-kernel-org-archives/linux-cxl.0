Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33954652
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889884; cv=none; b=YjScbVMIubGzPx03jFxzQEjDLy6J/3DPLKIONQW8e/7u7R4EpCn1B336QN0IAVohCaF/1E+GCkSnQrS9QT1pHFo4QlBajKclIsTUgopQJrhaih2u/htytTIZfK41vrmMieGB/Ha9+PZ/JAEOq8JTsnO78D/Orj8vwOuUO7AhlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889884; c=relaxed/simple;
	bh=D/94SFi1dn4/Z1I/Kyn/g/Z71KZ85FG7Cb/HtXXDtbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M2km1ZqeI2XR4E1g2m3vpK4VQyjMY7wbiAOhTMt8GiNDVBiiknp0PxiBqHz5zGpaIPVLxEDJSnwIUzUNg/s85otQbrj+yCXTRcdojzpVkBeev7SRbb16ngJS7QmC99I1AI4cAiYQYiH5E28NWh+LLLM7MGxqVonRsU8gltksQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z67OuEFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z67OuEFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7555F1F000E9;
	Fri, 19 Jun 2026 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781889883;
	bh=XYjoN7RwZr2wxT2Z+kktG/vntAq7GvpZJV/LGSWQrPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z67OuEFZ8LgoT04dmrgYOkIb2RrZ76TwfN6x5hh20Ocu64vkuCwJFjJxZxgVlB8ax
	 uKtsnzhfyMKS1dSpvQ5SgbvYKIS8eABopVtOuMqT8Pn/4ucwruX0XWQHBEyaw2Pp5S
	 8Q9JlgXRqAOoPp6iMnWjMfoh8s+V2r3JLFgiyjrsVnw6A4eSkLvsCed4qVnxb8pFbC
	 1sj0GaLlgc1pkiCelVHDW1HbjgJqq9eX2+wcVAu7kI624JuM5ndhoPLg2c2xkY6+YC
	 ze8DKVzIDzBTtnAt+gBnSy97vhgNp9CxNHNaak7XBjI5zGmTmWmvxsXOlHIP+YqpSG
	 OO3yXKZGl6THA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 1/5] sfc: add cxl support
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260618181806.118745-2-alejandro.lucero-palau@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:24:43 +0000
Message-Id: <20260619172443.7555F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Probe error path skips `efx_fini_io` cleanup when `efx_cxl_init` f=
ails, leaking PCI I/O mappings and regions.
--

commit f3841c5aaa83257b810b3b73eb3877f94fb0a964
Author: Alejandro Lucero <alucerop@amd.com>

sfc: add cxl support

This commit adds CXL initialization based on the new CXL API for accel
drivers and makes it dependent on kernel CXL configuration.

> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/ef=
x.c
> index 8f136a11d3968..da008462096d0 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
[ ... ]
> @@ -1190,6 +1193,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	if (rc)
>  		goto fail2;
> =20
> +	/* A successful cxl initialization implies a CXL region created to be
> +	 * used for PIO buffers. If there is no CXL support legacy PIO buffers
> +	 * defined at specific PCI BAR regions will be used. If there is CXL
> +	 * support and the cxl initialization fails, the driver probe fails.
> +	 */
> +	rc =3D efx_cxl_init(probe_data);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +		goto fail2;

[Severity: High]
Does this leak PCI I/O mappings and regions if efx_cxl_init() fails?

If efx_cxl_init() fails, the code jumps directly to fail2:

	rc =3D efx_init_io(...)
	if (rc)
		goto fail2;

	rc =3D efx_cxl_init(probe_data);
	if (rc) {
		...
		goto fail2;
	...
 fail3:
	efx_fini_io(efx);
 fail2:
	efx_cxl_exit(probe_data);
	efx_fini_struct(efx);

Because efx_init_io() completes successfully just prior to this, shouldn't
this error path jump to fail3 so that the I/O resources and PCI device
enable state are properly cleaned up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618181806.1187=
45-1-alejandro.lucero-palau@amd.com?part=3D1
