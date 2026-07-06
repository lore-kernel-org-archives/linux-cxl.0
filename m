Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F172EBDDE
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378610; cv=none; b=hKqxJJnAc22NdghnUGbFTGijjcZ/c26U9BMPKVTjq1eSzin13clRWHK6slQpPkFQ9sLkrgzrGVwNfmTkXefSS9EKXKGv+wi3ktk3zmlGGe6TgS9X31VNC1ES2xkQCrb10kuPkrcaGYNYeKZL5CYK1IYefaTTgX/aChwDhbxdQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378610; c=relaxed/simple;
	bh=znwEUHzUVkt0Fl30VQMT9l6EXqO+ehphZwnGwHyjZbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=daFQtr3DSioV9Ra5Yh3c+Opf5t3drL27knq/vKzw7L51SBiftar925kmstZ2Y51aEsMm9DFOgX4Cfi8DSCnhEt9UtgWqAHXy/ITzwf7WBUEE9IdMeqthm7F6Eou1f5BO7mjimauuXuu4jFqUG+TBu7cCDYdHP0UPbYuosuq7y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2H/CwO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2H/CwO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C031F000E9;
	Mon,  6 Jul 2026 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783378609;
	bh=pBOIFZermgCFixCNoNh21jvFnMyflRQkLOkVIimAtt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X2H/CwO/T211MZq+kGeDvfi6vvta23nYjq+XlxwWBKdWcNv9RKvAi4PTChOam+yFu
	 3bSAOMskS11oqaPAL/tssU8p8GDxBQEZjIdgSGf85QvXPZpfv4SWMeDY69t7Xih3tq
	 f80V2AF0aB0dDbK+BnolOjoDZyNGXHar3Wn6790Hft1WuqpljW+sVsUunCkFJ+S1l0
	 0hUdSP7AidymWsjZTc5KUnrICIuy+7s0Py+tJaQHyy4d8D63BeDGs66EqcapPF6mcC
	 QZRVK81woTGEUre6YhxslsjcvJIsKZznjbPn4LnyVt1Xz7WEKC+mI6AGbj8GjXcl3+
	 ALq4ey0k/8nLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/pci: Honor -EPROBE_DEFER from component register
 setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260706224322.714934-1-dave.jiang@intel.com>
References: <20260706224322.714934-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 22:56:48 +0000
Message-Id: <20260706225648.C6C031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_pci_type3_init_mailbox() incorrectly evaluates component_map.r=
as.valid instead of device_map.mbox.valid to check mailbox presence, leadin=
g to kernel panics or functional regressions.
--

--- Patch [1]: [PATCH v2] cxl/pci: Honor -EPROBE_DEFER from component regis=
ter setup ---
commit 04637d8b82b95fbc354ce623ffbeb09e3d57ae3e
Author: Dave Jiang <dave.jiang@intel.com>

cxl/pci: Honor -EPROBE_DEFER from component register setup

cxl_pci_setup_regs() can return -EPROBE_DEFER on a Restricted CXL Host (RCD)
when the upstream port has not yet been enumerated. This patch ensures that
cxl_pci_probe() returns -EPROBE_DEFER instead of continuing so the probe is
retried once the upstream port is available.

Link: https://lore.kernel.org/linux-cxl/ajzhsubot_PSYtHQ@MWDK4CY14F/T/#m063=
bbf76b1c9c293ade52ab311018ae6bba11a44

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c2..6a132a6c4c5b3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -829,10 +829,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  	 */
>  	rc =3D cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>  				&cxlds->reg_map);
> -	if (rc)
> +	if (rc) {
> +		if (rc =3D=3D -EPROBE_DEFER)
> +			return rc;
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> -	else if (!cxlds->reg_map.component_map.ras.valid)
> +	} else if (!cxlds->reg_map.component_map.ras.valid) {
>  		dev_dbg(&pdev->dev, "RAS registers not found\n");
> +	}
> =20
>  	rc =3D cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)

[Severity: High]
This isn't a bug introduced by this patch, but looking at the mailbox
initialization, cxl_pci_type3_init_mailbox() checks the mbox valid flag:

drivers/cxl/pci.c:cxl_pci_type3_init_mailbox() {
    if (!cxlds->reg_map.device_map.mbox.valid)
        return -ENODEV;
    ...
}

Since cxl_pci_setup_regs() was just called above with
CXL_REGLOC_RBI_COMPONENT and populated cxlds->reg_map, does this mailbox
check inadvertently evaluate component_map.ras.valid due to the union
in struct cxl_register_map?

If a device lacks a mailbox but has RAS registers, could the presence
check incorrectly pass?

drivers/cxl/pci.c:cxl_pci_setup_mailbox() {
    ...
    const int cap =3D readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
    ...
}

Would this lead to a null pointer dereference in cxl_pci_setup_mailbox()
because cxlds->regs.mbox is null?

Conversely, if a device has a valid mailbox but no RAS registers,
would cxl_pci_type3_init_mailbox() incorrectly return -ENODEV and fail the
probe of a functional device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706224322.7149=
34-1-dave.jiang@intel.com?part=3D1
