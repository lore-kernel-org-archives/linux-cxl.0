Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4F331EB7
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889885; cv=none; b=X6nnGuIHQbSZnESjTD6SMZnDMy4O5R0A1xULXnIeZwYRLUyY3csYcX7xohMcl6IVCt93vphxiCHafvFFTauOIFfCj9OtPAKixny5eKTOEOjpk0uytPEdhG7818TwWQQCAXMhms1qFSUCBkvcHTPS27T5LWhQzufv0V2M0WrXqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889885; c=relaxed/simple;
	bh=Bm17roUjJvwxpSFumwtzU5NLAK2pczIvXor/0phOU14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tYUkWwnPc0CacBNMiAcukp9Jm2m0rh+phY7KchMe8loxYQdNPvb+zd6ziNdRM1qqC53YrvzhTP/a67OaXkIsBGFr0zQ1bTHscUUfI8E+1Qafou9g/6gAELApMnsI34i0NMCgGl3XJ0jVrPs8cjNXKQHE5bGwPmhINVq4aSdiWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdDSOde0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdDSOde0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDE31F00A3A;
	Fri, 19 Jun 2026 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781889884;
	bh=eThbfQ67ylct3f3SsutyQqc0NkzoO2S4693xoWPmC0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XdDSOde0RCVvwp/wSizsCXcMmR7QsRARpoqDqmAyYAPWaVh6JQDrHtXzdYJouU0SH
	 +M9HGSdiGZp/h6DD7jfXpjymsOC/z+9hWcnZYHmqNMa0GWc8IhOCR6IkYzpyVclf0j
	 CRBD1RsRwdjl7GOTrOo0jGiWhzuXUGIDc+nEY8+uAs0vKEsiEG4U7Cr72gwW+c9E9s
	 DKoqLGcac4MWrbkhYnAu45OmDTSSBILhTu3SOppnEuCqFjKzdSKY9xsaYrXTF5Pu+N
	 LUqLlPzzGA3LYtgsaa2KlmEwvetdOh4C4pSrvfrg84K21tIz1eJWeyqEtwleLAqdgY
	 egkWGfr98QXJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:24:43 +0000
Message-Id: <20260619172443.EFDE31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Resource Leak in Error Path during driver probe.
--

commit 1149d7e604f29e1a5ccc2f2d5632fca5c521f213
Author: Alejandro Lucero <alucerop@amd.com>

sfc: obtain and map cxl range using devm_cxl_probe_mem

Use core API for safely obtain the CXL range linked to an HDM committed
by the BIOS. Map such a range for being used as the ctpio buffer.

> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/ef=
x.c
> index da008462096d0..abfa0ce2b4d1e 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c

[ ... ]

> @@ -1244,6 +1245,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>   fail3:
>  	efx_fini_io(efx);
>   fail2:
> +	efx_cxl_exit(probe_data);

[Severity: Medium]
In efx_pci_probe(), if efx_cxl_init() fails, the code jumps to fail2:

	rc =3D efx_cxl_init(probe_data);
	if (rc) {
		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
		goto fail2;
	}

Does skipping fail3 here cause a resource leak by bypassing efx_fini_io()?

efx_init_io() allocates memory and reserves PCI regions that are not
devres-managed, so bypassing efx_fini_io() would leave the memory mapped
and the device enabled.

>  	efx_fini_struct(efx);
>   fail1:
>  	WARN_ON(rc > 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618181806.1187=
45-1-alejandro.lucero-palau@amd.com?part=3D4
