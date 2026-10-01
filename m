Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F93E3C4F
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870579; cv=none; b=Zw72NC8dgxZHz6vOAddqFE29+rJ2jRFSVWiXrGtRI6SYrEIW3cz7EAuFQmE5qCRdpBDCWs4t8ShRMMbo+eVQbXIK8jCJL5KP7FtzHj100GXh5XD5JgmtEOtYHjyMaZfCIZNDXPAuz6/lVEDNkR6ArGSe2hiY+628x6SS6/yet1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870579; c=relaxed/simple;
	bh=tIfCjZm0pY4/nw4v60HZK2LeLMba8looo3It/S75R4I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u2ScuJDoDXtNWJzUmJlBZFePdndm9EWnNmBIlwEgVVzZWBNJtIBzS43fY1S8CBc/SgnBLGKfUTNIulU/TqCQfTpQHLKh1UYlv74S59CAu6Hv32ffwUE94RZ3FvR3/nWplCBQRcXlC8zkh/5qbSFuD/cF2bt7OXpIttxfZuMClhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzy8Eysl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzy8Eysl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BEC1F000FF;
	Thu,  1 Oct 2026 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870578;
	bh=1U98s3BqtsvvQaJwjVn152UyuoPFmgBuR+zkfC+r2sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gzy8EyslIqYb9W7m7J9xVQm7RJWq22Q3ytdPOGGzYa3DCWXB2742Xmhwe8SdoQ1V9
	 QY6L11Mpg0EMQF0tniJaZN1aVXCw/nIa36BCs9cQGxxBpTUkr2Jr9Kz+Lqvzx8S+KX
	 ZIaDlI98c1rhOjZxInfdSs4dzUCtlJ2ZoMvWvB2aO9LEebgtRfrJqAn+9TUI9s8MVj
	 JR2fFNHv0mVPFLh9WZKFTHf9xiBJRt7tzqf9MPYU/GFAlwhNLFPWvOymlW9CP1wIEV
	 zx7ITvr5qFdF4kNystSRPUBFc8dcONm8sZOz1tQdUQ3zwicsAm3nE75OngBSPfEHkr
	 6OwwuvP60q2Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] cxl/core: Hold the dport host lock across dport
 lookup and use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261001154744.1095902-3-dave.jiang@intel.com>
References: <20261001154744.1095902-1-dave.jiang@intel.com>
 <20261001154744.1095902-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:02:57 +0000
Message-Id: <20261001160257.E0BEC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl/core: AB-BA deadlock in RCH topologies due to child-to-parent =
lock inversion
--

commit 689adbac9a3f5c00d58408df886ec90fd00ca46d
Author: Dave Jiang <dave.jiang@intel.com>

cxl/core: Hold the dport host lock across dport lookup and use

Callers of cxl_pci_find_port() and cxl_mem_find_port() can be handed a
struct cxl_dport that is already freed, and all four dereference it
without the lock that would prevent that.
   =20
A dport is kzalloc()'d into a devres group on its host device, so it dies
when that host unbinds. The host is &port->dev for a switch port and
port->uport_dev for the root port.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..55a571f86d477 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -734,10 +734,16 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum c=
xl_regloc_type type,
>  	if (rc && type =3D=3D CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pde=
v)) {
>  		struct cxl_dport *dport;
>  		struct cxl_port *port __free(put_cxl_port) =3D
> -			cxl_pci_find_port(pdev, &dport);
> +			cxl_pci_find_port(pdev);
>  		if (!port)
>  			return -EPROBE_DEFER;
> =20
> +		guard(device)(cxl_port_dport_host(port));

[Severity: High]
Does acquiring the ancestor host bridge lock here while the driver core hol=
ds
the descendant (pdev) device lock cause an AB-BA deadlock?

If concurrent device removal locks the parent device and then iterates to l=
ock
children, could it deadlock against this path in cxl_pci_setup_regs() during
device probe?

> +
> +		dport =3D cxl_pci_find_dport(pdev, port);
> +		if (!dport)
> +			return -EPROBE_DEFER;
> +
>  		rc =3D cxl_rcrb_get_comp_regs(pdev, map, dport);
>  		if (rc)
>  			return rc;

[ ... ]

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index e0e01aa5eba6c..3c6aae26deedd 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -118,10 +118,20 @@ void cxl_handle_rdport_errors(struct cxl_dev_state =
*cxlds)
>  	int severity;
> =20
>  	struct cxl_port *port __free(put_cxl_port) =3D
> -		cxl_pci_find_port(pdev, &dport);
> +		cxl_pci_find_port(pdev);
>  	if (!port)
>  		return;
> =20
> +	/*
> +	 * The dport may have been freed since the lookup above, so take the
> +	 * lock that pins it and find it again.
> +	 */
> +	guard(device)(cxl_port_dport_host(port));

[Severity: High]
Could this also lead to an AB-BA deadlock on Restricted CXL Host (RCH)
topologies?

This acquires the ancestor host bridge lock while the caller holds the
descendant (&cxlmd->dev) device lock. Concurrent device hot-remove paths
typically lock from parent to child, which seems like it would deadlock aga=
inst
this AER handling path.

> +
> +	dport =3D cxl_pci_find_dport(pdev, port);
> +	if (!dport)
> +		return;
> +
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001154744.1095=
902-1-dave.jiang@intel.com?part=3D2
