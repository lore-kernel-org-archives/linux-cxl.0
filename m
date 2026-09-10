Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAC3D953E
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034092; cv=none; b=uuAhXjQveLvAWx6Uo2D+Msx5jlH4CcgysMQ9LC29iS6L8ttxJYOHZZ0l7Y1iroO7Jy7nSlq3VWeNoAmmd7dC4u/1GpkNNITKImcF5Ni1Xkwz6KAnvIeJ87bPlPFRU+AYxxo3GUeA4siCniV4Ve26HObNVuU2OecgeO1bAu9/bSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034092; c=relaxed/simple;
	bh=TKC7GoSwCHZzgx7QOXahQBbsFAQ6LetlRRP+IrVfaVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R5C6+C1vq+PJxp5LidKBWV4igVhO6IWsDzPdst1HW/aO4DHA878rvYDT2jKb1aKAdXyXOUpNVZFeQGjyxoxrXZpgP8kGSI1p3iTwWf4UJq3P4buOAvUwZvUsPBQk7y0uKkMOy00eChVF7B8PJxaEu13IEvd53ZMFdQhyGBJczjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuG3B62x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuG3B62x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EE01F000FF;
	Thu, 10 Sep 2026 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034090;
	bh=7KYIlLh9Rg2uTzvaKgTafWeyqMbL0wzFISHY5RXRGe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SuG3B62xwkAYC6/SnU2h96oq8k3GZiw1HfwUBC1O9nEG1oToZJemh7DPzLE11iQlB
	 aXhFLZepZx68bFeTi3UEKW0FJZuGzyP5/YgEgK3WueIYRD3dTljtMROz07E+c/hgHl
	 H4KRGsuLWo/zU3DrtlDbpK0T77QYrEbMADWfcUMEDNvAkzgJJCf+4RF9vswtMpSnN5
	 +nGUaFrNqkhstPid42rmBgkWSeIS2ZRDnQx1C36CCvyj6rdhNNeF2o7LE5KzB23ugt
	 jvB7ZfaDOB1YGi/1Lau9UiHYgN7l8mY9ZIIzrOMz+SAcA8oifwbLyrr3WXfrHjiWCS
	 +jZbaSsMqJX6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/regs: Reject register blocks in an unassigned BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junjie Cao" <junjie.cao@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260910093858.535969-1-junjie.cao@intel.com>
References: <20260910093858.535969-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:54:50 +0000
Message-Id: <20260910095450.A3EE01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of CXL register locator BIR and resource type a=
llows mapping non-memory or bridge window resources, leading to memory corr=
uption.
- [High] Insufficient bounds validation allows out-of-bounds MMIO reads dur=
ing CXL capabilities probing, leading to kernel panics.
--

commit 1001d63b6bc0f0959235c2291ef3e197cc4ca650
Author: Junjie Cao <junjie.cao@intel.com>

cxl/regs: Reject register blocks in an unassigned BAR

cxl_decode_regblock() only checks that the Register Locator offset fits
pci_resource_len(). A BAR the PCI core could not place is reset to zero
start, end and flags while config space keeps the firmware value, so a
zero offset passes and the block is mapped at physical address 0.

Link: https://github.com/tianocore/edk2/issues/13104

> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7d..41416fa2ce4a4 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -277,6 +277,20 @@ static bool cxl_decode_regblock(struct pci_dev *pdev=
, u32 reg_lo, u32 reg_hi,
>  	u64 offset =3D ((u64)reg_hi << 32) |
>  		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW);
> =20
> +	if (reg_type =3D=3D CXL_REGLOC_RBI_EMPTY)
> +		return false;
> +
> +	/*
> +	 * A BAR the PCI core could not place is reset to zero; decoding it
> +	 * would map the block at physical address 0.
> +	 */
> +	if (!pci_resource_len(pdev, bar) ||
> +	    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {

[Severity: High]
This isn't a bug introduced by this patch, but since bar is extracted from =
the
untrusted CXL DVSEC register locator before this check, is there anything
verifying that it falls within the standard endpoint BAR range (0-5)?

Additionally, could a malicious device bypass this validation by configurin=
g a
standard BAR as an assigned I/O BAR (IORESOURCE_IO)? This code does not
verify if pci_resource_flags(pdev, bar) & IORESOURCE_MEM is true.=20

If an I/O port address bypasses this check and is passed to ioremap(), could
it map low physical RAM on x86 and corrupt memory during register setup?

> +		dev_warn(&pdev->dev, "BAR%d: not assigned (type: %d)\n", bar,
> +			 reg_type);
> +		return false;
> +	}
> +
>  	if (offset > pci_resource_len(pdev, bar)) {

[Severity: High]
This is a pre-existing issue, but this bounds check allows offset to be
arbitrarily close or equal to the resource length without ensuring enough
space remains for the capabilities array.

If this computes a very small max_size (such as 4 bytes), wouldn't the driv=
er
subsequently perform out-of-bounds MMIO reads during capabilities probing:

drivers/cxl/core/regs.c:cxl_probe_device_regs() {
    ...
    for (cap =3D 1; cap <=3D cap_count; cap++) {
        cap_id =3D FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
                           readl(base + cap * 0x10));
    ...
}

and read past the end of the mapped pages, causing a kernel panic?

>  		dev_warn(&pdev->dev,
>  			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,
>  			 &pdev->resource[bar], &offset, reg_type);
>  		return false;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910093858.5359=
69-1-junjie.cao@intel.com?part=3D1
