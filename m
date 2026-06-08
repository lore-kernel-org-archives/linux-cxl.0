Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C853AFCE1
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959251; cv=none; b=DpSlDxZ+L9OmeCg7JJm1Jg2ORhUm6XqkmLdkimG551t3QOxRj/B/riM1gs+gSygVG16RFM9RgOG4zq3RUCc4KHtP6fnPskSkXkoqQH9kw56D8CFHca83hEw3NUtKTsJARQcIQDjKOhRwp7jrMNZQTv6+lfuWR3T+an+Hj0tzI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959251; c=relaxed/simple;
	bh=OimtFzkI2Mvz0JSE6xMOICroBKjbcZpYZP3kwdei9w8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=otNddooFKV7/b8GZXMFpGnoP5yS14Bjlpij7D/uvtNRRI508aBpoFmMNQ4W28g62iQsz3fqgxXlrPib4Rah2/4l+9/Xoavan2IqE32ylTUxOsAPkPrEtdRCmTa6xuNfI4pg5ds0A0+IIw/LAcGc7I+bSlfJR0YKfXBZh0kvomPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJRhIG1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJRhIG1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330311F00893;
	Mon,  8 Jun 2026 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780959250;
	bh=p2eo4tQ8unwIxyUmkJ44g/I0swuEO7Ke5h5isSTT9xE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJRhIG1TIUXfiVb+n6Fm4gQuekwpntg/WGuCD3KSe5+ztSE26RutE58GaetpnMfMq
	 KK0KH/bUBayalTUiZA4pQw0T6SILU6eBODfycC+5OL6tpu2c82mi3XvisIY33kkRC7
	 nUS/iYIEN3NTxkcxDt7sqY87s+UaREhoCUxERj13FDen9qQFzq4GmK4XVPTxKDdLB+
	 mnMoSyo5FB4NOIGRIIOt8FCYLkhw8Pgh4bjOc/XPS94MHX6CYNy8ZZWRUmC9GjV0sn
	 5kVRQEStf0qHZRgQl+BbqMEUCNfPmPC6eHWgAO5Ife1h3e3skRHgL4MfhPpGg6lmjD
	 L++M8of4afiQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/port: Fix missing port lock in
 cxl_dport_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260608223533.583278-1-terry.bowman@amd.com>
References: <20260608223533.583278-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 22:54:09 +0000
Message-Id: <20260608225410.330311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for use-after-free vulnerabilities. The patch fixes=
 use-after-free races in `cxl_mem_probe()` and `rcd_pcie_cap_emit()` by avo=
iding the dereference of locklessly-obtained `dport` pointers. However, it =
missed identical vulnerabilities in `cxl_pci_setup_regs()` and `cxl_handle_=
rdport_errors()`. Both functions use `cxl_pci_find_port()` to locklessly ca=
pture a `dport` pointer (via `xa_load`) and then immediately dereference it=
 without holding a device lock (such as `uport_dev->mutex`) that would excl=
ude concurrent devres teardown. A concurrent surprise removal could cause `=
cxl_dport_remove()` and `free_dport()` to free the `dport` structure while =
these functions are dereferencing it, leading to a Use-After-Free.
- [High] Use-After-Free in the error path of `devm_cxl_add_nvdimm()` due to=
 a cleanup ordering violation. The function holds the device lock via `guar=
d(device)(&cxl_nvb->dev)`. On the `err_alloc` failure path, it manually cal=
ls `put_device(&cxl_nvb->dev)`. If this is the last reference to the device=
, the object is immediately freed. Upon returning, the `guard` goes out of =
scope and calls `device_unlock(&cxl_nvb->dev)` on the already-freed memory,=
 resulting in a use-after-free.
--

commit 643083e519043c77cd0a30288dae3823f932ab9f
Author: Terry Bowman <terry.bowman@amd.com>

cxl/port: Fix missing port lock in cxl_dport_remove()

This commit addresses a use-after-free race condition in cxl_dport_remove()
by properly managing the port lock for root ports. It also updates callers
to re-fetch the dport pointer under the appropriate locks.

Link: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowm=
an@amd.com/

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index ab88eaa31d1db..419ae58acce81 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
[ ... ]
> @@ -133,21 +132,57 @@ static int cxl_mem_probe(struct device *dev)
[ ... ]
> +	if (rch) {
> +		struct device *uport_dev =3D parent_port->uport_dev;
> +
> +		scoped_guard(device, uport_dev) {
> +			if (!uport_dev->driver) {
> +				dev_err(dev, "CXL port topology %s not enabled\n",
> +					dev_name(uport_dev));
> +				return -ENXIO;
> +			}
> +			/*
> +			 * Re-fetch dport under uport_dev lock.  uport_dev->mutex
> +			 * is held for the full devres teardown sequence including
> +			 * free_dport()/kfree(), so this excludes concurrent
> +			 * hotplug removal through the entire dereference.
> +			 */
> +			dport =3D cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->paren=
t);
> +			if (!dport) {
> +				dev_err(dev, "CXL RCH dport not found\n");
> +				return -ENXIO;
> +			}
> +			rc =3D devm_cxl_add_endpoint(uport_dev, cxlmd, dport);
> +			if (rc)
> +				return rc;
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, but while this patch fixes use-after-free
races here and in rcd_pcie_cap_emit() by avoiding the dereference of
locklessly-obtained dport pointers, could similar vulnerabilities still
exist in other functions?

For example, in drivers/cxl/core/pci.c:cxl_pci_setup_regs():

    rc =3D cxl_rcrb_get_comp_regs(pdev, map, dport);
    ...
    rc =3D cxl_dport_map_rcd_linkcap(pdev, dport);

And in drivers/cxl/core/ras_rch.c:cxl_handle_rdport_errors():

    if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))

Both functions appear to use cxl_pci_find_port() to locklessly capture a
dport pointer (via xa_load) and dereference it without holding a device
lock (like uport_dev->mutex) that would exclude concurrent devres
teardown. Could a concurrent surprise removal cause cxl_dport_remove()
and free_dport() to free the dport structure while these functions are
dereferencing it?

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
in the error path of devm_cxl_add_nvdimm(), which is called during
cxl_mem_probe().

In drivers/cxl/core/pmem.c:devm_cxl_add_nvdimm():

    guard(device)(&cxl_nvb->dev);
    ...
    err_alloc:
        cxlmd->cxl_nvb =3D NULL;
        cxlmd->cxl_nvd =3D NULL;
        put_device(&cxl_nvb->dev);
   =20
        return rc;

Since guard() releases the device lock when returning, and the error path
manually calls put_device(&cxl_nvb->dev) before returning, wouldn't
device_unlock() be called on the already-freed memory if this was the
last reference, causing a use-after-free and lockdep crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608223533.5832=
78-1-terry.bowman@amd.com?part=3D1
