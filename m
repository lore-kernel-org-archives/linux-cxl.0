Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A548595D
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942536; cv=none; b=UcBRolfQdUznrzw3hXCJrgorCR+fE8hUaKZXzM0NQKDYLgBivG7goZxxvHXSkvnDtUo1T6ZsZyL8vRyoQUMi8MMwCLv8pjCTgfjP0pBgrx5kCIruJguo73wKhL8caz+eibdzz6umOt7VLVmoPKlLkErS5ffGnKk2pQoFwlvMi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942536; c=relaxed/simple;
	bh=h+/BWVGb+kF/Zod1IwlXDGhiRsLHvfqla4WAMF8ObW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OqBYbiq+GXU2oyZRnPkgVvU2ZJlDly7/P3A49anVSEBUFDPhIB6qkJaaAz3U3oLgwTrn6VBHoAMujogUhJ9nuppNjTa0Gt2kNkrZcmR7zVKH8RbxKyO305qVPvpzmrOZvIawQ2QOnyvGALvP6wErJCKZ0PkL+JJR5lQUc8hels8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY3ZqII3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY3ZqII3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115201F000FF;
	Fri,  2 Oct 2026 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790942535;
	bh=McFHil6UNWyrh1A6ps+dTHFRxsCGQ35zMy5TsHx6aDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IY3ZqII354w/I6kCi1XyTt5e0zJOkyQVeh56yMPGNFzL+Za1dIFYpkLcY5CiIh/ZA
	 7hM8a2KnVNFQXnpbgvcwamLVW2fpXFpS/zotX5Sniv9GsDxqObGP1SkV0xQN2j0BY3
	 SPxqqSr54kVVLHBdsYvqwAds+29+OjCgycLedBZj7UkA5xDqGA97g2ZteLg++E9qqH
	 cE1kGb8/UXGAc6cuQ1E2go/ZU+KAGzvz8w3pd2CPquSXcS63wxooXggwrK7iMMZ3+t
	 jQ7RuVFUY0/54j2bx0b0+WEnqDDrptE59PO2EZ5N3sd2zoGduLTQZn1jzODT0B7kc0
	 4TxmU7I2ShSUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4]  sfc: add multipf support
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261001132023.17032-5-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-5-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:02:14 +0000
Message-Id: <20261002120215.115201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sfc: inverted error check causes uninitialized memory mapping
- [High] sfc: incorrect slot extraction links non-PF0 to wrong PF0 device
--

commit f448ba0f4a9e4a95bf07bd91e1ee5f0a1a822aff
Author: Alejandro Lucero <alucerop@amd.com>

sfc: add multipf support

This commit introduces multipf support by using the CXL core accelerator API
to link non-PF0 PFs to the CXL region of their associated PF0. It obtains
the CXL HPA region and maps it using an offset based on the PF index.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> index 348d7404cd7aa..f884580cb5286 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
[ ... ]
> @@ -13,8 +13,69 @@
[ ... ]
> +static int efx_cxl_non_pf0_init(struct efx_probe_data *probe_data)
> +{
> +	struct efx_nic *efx =3D &probe_data->efx;
> +	struct pci_dev *pci_dev =3D efx->pci_dev;
> +	struct range cxl_pio_range;
> +	struct efx_cxl *cxl;
> +	u64 devfn;
> +
> +	devfn =3D PCI_FUNC(pci_dev->devfn);
> +
> +	struct pci_dev *pf0_pci_dev __free(pci_dev_put) =3D
> +		pci_get_slot(pci_dev->bus, PCI_DEVFN(PCI_SLOT(devfn), 0));

[Severity: High]
Does this code query the correct PCI slot? The devfn variable is assigned t=
he
result of PCI_FUNC(pci_dev->devfn), which extracts only the 3-bit function
number. Passing this isolated function number into PCI_SLOT() will always
yield 0 since it shifts right by 3.

This means non-PF0 functions will query slot 0 instead of their actual PCI
slot. If the NIC is located in a slot other than 0 and another CXL-enabled
NIC is in slot 0, would this cause the driver to link its non-PF0 function
to the wrong NIC's CXL region, bypassing mutual exclusion by taking the wro=
ng
device's lock in cxl_get_range_and_link()?

> +
> +	/* This should not happen! */
> +	if (!pf0_pci_dev)
> +		return 0;
> +
> +	/* Is the PF0 device configured with and using CXL? */
> +	if (!pcie_is_cxl(pf0_pci_dev))
> +		return 0;
> +
> +	if (!cxl_get_range_and_link(&pf0_pci_dev->dev, &pci_dev->dev,
> +				    &cxl_pio_range))
> +		return  -EPROBE_DEFER;

[Severity: High]
Is the error check here inverted? If cxl_get_range_and_link() successfully
finds a region (returning 0), this condition evaluates to true and aborts
with -EPROBE_DEFER.

Conversely, if it fails (e.g., due to a missing region), it returns an error
code which evaluates as true, meaning the condition fails and the code falls
through. This leaves the cxl_pio_range stack variable uninitialized.

> +
> +	cxl =3D kzalloc_obj(*cxl, GFP_KERNEL);
> +	if (!cxl)
> +		return -ENOMEM;
> +
> +	if (cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {

[Severity: High]
Following up on the inverted check above, if cxl_get_range_and_link() fails
and we fall through, won't we pass the uninitialized cxl_pio_range stack
variable by value to cxl_map()?

Looking at cxl_map() in this same file:

cxl_map(...) {
    ...
    cxl_pio_pf_start =3D cxl_pio_range.start + ...;
    cxl->ctpio_cxl =3D ioremap_wc(cxl_pio_pf_start, ...);
    ...
}

Could this result in ioremap_wc() mapping arbitrary physical memory based
on the uninitialized stack data?

> +		kfree(cxl);
> +		return -ENOMEM;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001132023.1703=
2-1-alucerop@amd.com?part=3D4
