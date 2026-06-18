Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FE280A56
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803090; cv=none; b=J5BYKAbGbyV5azL7g4gHDeFlUzZMkJ59rzNXzE7vhSd4ySiEkCkbY+SmVpIsUbKeManNxB1D5UHXVlvd/V80PKoiNjoEpRqEhlhC08DySPISOkNhmcHWG1RTfPLNB8T0jMZShTaxOWDXRC1p9LC2divTEMpL1ZA2zsFSMUXRh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803090; c=relaxed/simple;
	bh=gka5RQpJKO/4eIR7emUFuzW9zpatLovIncjxjf4FFEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A7oQ6ZKzH79dRyS7zwIGbGIOXsghGT/0l4vpsA7D4SrtkXj5He45XP3vonQmLXpZORVXhvSbWN1aXxSbfhvL7rfsq5gdcOYDh+7VfbCzbsgxCAgdvuQ0VzACec8GNnby9llHn4kHr1Qc6fd19UneG44+NfAGsQ7xpbOU4kr7G6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8xmBckr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8xmBckr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABDF1F000E9;
	Thu, 18 Jun 2026 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781803089;
	bh=S+2n2mFf7MGtYkXR+1K6IVfnrpux4m2PsorSQdQk3y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8xmBckr//cukn4v2PFAAjDyiJ6m0CDrjLPlLyiDjmetYCfHCZHnMIHSv3YWfFsOE
	 B2iVJfsciaI8wNLFcFTP3ycpuOwBMoSqnEPS2g7wfpHC0lPFs8KFIphASlzk4AvgK0
	 6O4l9ymLXodEPZtrIALzKGlXyj57khwt9rs9Eu9D1PTkubHFwJipa3wvW8QPLYzEa4
	 DIqK10Jx1hbaHmH6kpIN53ufnUWe24MqDYqZQvAlK0xDgIGxnIh6aHLxjj9o2IguKt
	 7TYmCxRTegvzNoHsP0c96JoXx8DWdmO7U1VIjLNLuH+aGzmw0XVEgFIpmPcQPZUaag
	 ZyINSW7G5jZ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/pci: Remove incorrect mbox.valid check in
 cxl_pci_type3_init_mailbox()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hou" <wei.hou@scaleflux.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260618170356.25382-1-wei.hou@scaleflux.com>
References: <20260618170356.25382-1-wei.hou@scaleflux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 17:18:08 +0000
Message-Id: <20260618171809.2ABDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver swallows -EPROBE_DEFER (and potentially other errors li=
ke -ENOMEM) returned from cxl_pci_setup_regs() when initializing component =
registers. For Restricted CXL Host (RCH) topologies, cxl_pci_setup_regs() e=
xplicitly returns -EPROBE_DEFER if the upstream port isn't initialized yet.=
 However, cxl_pci_probe() only logs a warning and falls through, where the =
rc variable is subsequently overwritten by cxl_pci_type3_init_mailbox(cxlds=
). As a result, the probe succeeds and the device binds permanently without=
 its component registers, disabling features like RAS.
--

commit 4e1380c792dda7219b704feca6c3a617dfdf2972
Author: Wei Hou <wei.hou@scaleflux.com>

cxl/pci: Remove incorrect mbox.valid check in cxl_pci_type3_init_mailbox()

This commit removes the mailbox validation check from
cxl_pci_type3_init_mailbox() since mailbox presence is already verified
by the MEMDEV probe. It notes that missing component registers should
not prevent initialization.

> The driver's design intent is that missing or malformed component
> registers should not prevent mailbox initialization. cxl_pci_probe()
> already reflects this: the CXL_REGLOC_RBI_COMPONENT setup path only
> emits a dev_warn() and continues when component registers are absent,
> rather than returning an error.

[Severity: High]
This is a pre-existing issue, but does this design intent inadvertently
swallow -EPROBE_DEFER or other errors like -ENOMEM?

If cxl_pci_setup_regs() returns -EPROBE_DEFER (such as for Restricted CXL
Host topologies when the upstream port isn't initialized yet),
cxl_pci_probe() logs a warning and continues. The rc variable is then
immediately overwritten:

drivers/cxl/pci.c:cxl_pci_probe() {
    ...
	rc =3D cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
				&cxlds->reg_map);
	if (rc)
		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
	else if (!cxlds->reg_map.component_map.ras.valid)
		dev_dbg(&pdev->dev, "RAS registers not found\n");

	rc =3D cxl_pci_type3_init_mailbox(cxlds);
    ...
}

Will this cause the probe to succeed without component registers and
bypass probe deferral, permanently disabling features like RAS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618170356.2538=
2-1-wei.hou@scaleflux.com?part=3D1
