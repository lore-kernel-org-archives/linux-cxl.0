Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C215746F
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780816394; cv=none; b=f4HQj/re5WKsCs4KvlFp4XkPLbHgGEauNdoslEPvdCLlG4+1CF7dEssroGb9d7Pc2CbuD1imdxUR8uuGNTtlXjSmxwUUuaTMwwRZwdBoXZd0QIQJuIxjIknM3p5/DtrhT2bDZvSKYewY5xxbp+2fe4N6GsmqXdHBugg+VT+wHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780816394; c=relaxed/simple;
	bh=QzQOeeBjtbjs30T99uMzj6IiJ2mD3gmi2Mx2JoISNJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eIRYAuVj0zPVmhkzAZ5zBmvjRm/4TpzvmGofeD1O1qAADSneHsU3BJvIS40auVQWP3B+lhALAhYRfIuZ6UiPzqG6utKP9oH2NpzqXxH+jLfBRinVYIokhaQ7AnJ81wQWKLD7FGfrCh3n19MFBmNDQ92GEcQDa79SAAeG3CGTUcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDW+M/ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDW+M/ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83331F00893;
	Sun,  7 Jun 2026 07:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780816392;
	bh=vlusanbdEkJr6y8Cjsu/7/tWIyPGVe9RRrsr7aHL9uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDW+M/kiEr/TDcPhdWBxudOnU4FC8BjsXJtiVyvZlCRGAVyT2oDwbZme6yj1I9ODX
	 F5xdI6UMfvxUqlGN5HhOQkemW7bPM5x+oSR/aHDF19a6m5D1iPlO6rRgzCSaFJ8OKe
	 usqjfRTOafY0b727FTxuW28F8YNk4U4oJMGdmleyIpxPNQPmjxzmXcvsQUBmYKmhUB
	 WT59H3BtwPN2ptrze/EkNpFvFoEaqnS9CjcAW503o+GQ7+lTaO2VVsGEKZFZ/vLBrt
	 I96zvQ9M2SLEV5mMpzebm34w6EAvWIULTjUPP9WBcagNcRJCUbGAXcMR5ocqh5BUf6
	 8Y892dAlLEJBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] cxl: Convert PCIBIOS errors to errno on remaining
 DVSEC/PCIe accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260607070241.48978-2-icheng@nvidia.com>
References: <20260607070241.48978-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 07:13:12 +0000
Message-Id: <20260607071312.B83331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete conversion of PCIBIOS error codes leaves `update_gpf_=
port_dvsec()` with an inconsistent return type.
--

commit 84be8b4e0a3d7e5cbd94897e592a3a721caed448
Author: Richard Cheng <icheng@nvidia.com>

cxl: Convert PCIBIOS errors to errno on remaining DVSEC/PCIe accesses
   =20
PCI config and PCIe capability accessors return positive PCIBIOS_*
status codes on failure, not negative errnos. update_gpf_port_dvsec()
and cxl_setup_parent_dport() propagate these raw values to callers that
test for failure with "if (rc)" and expect a negative errno, which can
misreport the error.
   =20
Conver the positive PCIBIOS status with pcibios_err_to_errno() on these
error paths.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e4338fd7e01b4..ea81a170132fb 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -852,7 +852,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev=
, int dvsec, int phase)
>  		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
>  			phase, GPF_TIMEOUT_BASE_MAX);
> =20
> -	return rc;
> +	return pcibios_err_to_errno(rc);

[Severity: Medium]
Does this function still return an unconverted PCIBIOS error code on the ea=
rly
read failure path?

Looking earlier in update_gpf_port_dvsec():

	rc =3D pci_read_config_word(pdev, dvsec + offset, &ctrl);
	if (rc)
		return rc;

If pci_read_config_word() fails, it returns a positive PCIBIOS error code.
This leaves the function with an inconsistent return type where it returns
positive error codes for read failures and negative errnos for write failur=
es.

Should the read failure path also be converted with pcibios_err_to_errno()?

>  }
> =20
>  int cxl_gpf_port_setup(struct cxl_dport *dport)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607070241.4897=
8-1-icheng@nvidia.com?part=3D1
