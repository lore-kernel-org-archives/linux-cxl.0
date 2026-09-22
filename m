Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509624772B1
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099776; cv=none; b=MGARvOUomP+wtzQ1ci9CG51VUxYSZoA56rrjUbZ0wsK8pNLhbbaisLEQQc7MV4dW/nLMDJo43TF4ZbYKfmgIXODXfDeTMVAw0Lgywg3htRm4IAD3Ply/jbiUFU6syYPAQctLWwUjYOTMbImZuRDAymY0Xq5sa3kr1PzB3fdwsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099776; c=relaxed/simple;
	bh=OymV4i0Ei2i1cEBu8NB5WpkoPOrgDmtLqNoEQmhDnRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPk53LOSQkCq8YQZV7ipNCy9RwpVWgk/fFSK2hm74UC1tMsWo6pefkAiSHhsCMELi4hBUNs6zH57accuwUbiKUT0ATs8yP/QysqwUictwUWdcMLlDxmgQwvc57W54Xq12Vd/donmq/zp/HTgmqpE0ZPMtOGj4wAdLW7RCJ+2OEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjFcU0xZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjFcU0xZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043971F000FF;
	Tue, 22 Sep 2026 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099773;
	bh=z2soNh18bB6QPFZ7SjhWjHJ50e53rv3nvvnCGoj2T2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjFcU0xZ/rQdsId5FSZ6WuM8GJI/GHW3gaKHJPmbq6BGVhPIowxRfXmpa/jCjlsWV
	 TlhFsU+dH1bg/kHyDHcGXNO3A/dVaosFjc0QaZIvqgBGkUb8oBw/VZCSV7jAhGmXfr
	 DHjM+Jzeppk9g9+ik++CbBPcHUCOhW/5FsdZZXrX+6i+U9q7KvQUNokxH1VxIUvDy+
	 CNBjwzsvvgXGHWBdQRK2bv6++wp2gAgSNgeiHD3wcEKfDQt6mmQTZCzNEL0gY8K0jS
	 yeO2UDhmhC7jd3IB6eUxiAxmgje6nNZiwVdJhDJC8QI/zso/jImrZG5TZGdoh7/i7S
	 DeF1KEFaza+Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] sfc: add multipf support
Reply-To: sashiko-reviews@lists.linux.dev
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260921191239.4249-5-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-5-alucerop@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:56:12 +0000
Message-Id: <20260922175613.043971F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sfc: inverted error check for cxl_map() causes UAF on success
- [Medium] pci: reference leak of pf0_pci_dev in efx_cxl_init()
- [Medium] sfc: memory leak of non-PF0 cxl struct in efx_cxl_exit()
--

commit d0979ed10895deac33baab224f2c0e771350412b
Author: Alejandro Lucero <alucerop@amd.com>

    sfc: add multipf support
   =20
    Use CXL core accelerator API for registering non-PF0 PFs to the memdev
    linked to the PF0, along with its complementary unregister.
   =20
    Adapt the ioremap call per PF to be an offset based on the PF function
    index and a hardcoded per PF CXL.mem slot size.

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c
> index 348d7404cd7aa..bed8d9c591853 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -21,8 +46,48 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
[ ... ]
> +	/* are we PF0? */
> +	devfn =3D PCI_FUNC(pci_dev->devfn);
> +	if (devfn !=3D 0) {
> +		struct pci_dev *pf0_pci_dev;
> +		struct cxl_memdev *cxlmd;
> +
> +		pf0_pci_dev =3D pci_get_slot(pci_dev->bus,
> +					   PCI_DEVFN(PCI_SLOT(pci_dev->devfn),
> +						     0));

[Severity: Medium]
Does this code leak the reference to the parent PCI device structure?

pci_get_slot() increments the reference count of the returned PCI device.
However, pci_dev_put() is never called to release this reference in any of =
the
subsequent return paths within the non-PF0 branch of efx_cxl_init().

> +		/* This should not happen! */
> +		if (!pf0_pci_dev)
> +			return 0;
> +
> +		/* Is the PF0 device configured with and using CXL? */
> +		if (!pcie_is_cxl(pf0_pci_dev))
> +			return 0;
[ ... ]
> +		cxl =3D kzalloc_obj(*cxl, GFP_KERNEL);
> +		if (!cxl)
> +			return -ENOMEM;

[Severity: Medium]
Does the non-PF0 cxl struct memory get leaked during device removal or probe
failure?

The cxl object is allocated manually here using kzalloc_obj(), whereas for =
PF0
devices it uses devm_cxl_dev_state_create() which is automatically freed via
device resource management.

Since the unified teardown function efx_cxl_exit() only unmaps the I/O memo=
ry
and doesn't call kfree(probe_data->cxl), wouldn't this manual allocation be
leaked?

> +
> +		cxl->cxlmd =3D cxlmd;
> +
> +		if (!cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
> +			kfree(cxl);
> +			return -ENOMEM;
> +		}

[Severity: High]
Is the error check for cxl_map() inverted here?

cxl_map() returns 0 on success and sets probe_data->cxl:

static int cxl_map(struct efx_probe_data *probe_data, struct efx_cxl *cxl, =
...)
{
        ...
        probe_data->cxl =3D cxl;
        ...
        return 0;
}

Because of the inverted check, a success (0) evaluates to true, triggering
this error path which calls kfree(cxl) and returns -ENOMEM.

When the device probe eventually fails, the teardown path efx_cxl_exit() wi=
ll
see that probe_data->cxl is non-NULL and attempt to dereference it to unmap
I/O memory:

void efx_cxl_exit(struct efx_probe_data *probe_data)
{
        if (!probe_data->cxl)
                return;

        iounmap(probe_data->cxl->ctpio_cxl);
}

Could this lead to a Use-After-Free crash on every successful mapping of a
non-PF0 device?

> +		return 0;
> +	}
[ ... ]
> @@ -80,16 +145,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
> =20
> -	cxl->ctpio_cxl =3D ioremap_wc(cxl_pio_range.start,
> -				    range_len(&cxl_pio_range));
> -	if (!cxl->ctpio_cxl) {
> -		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> -			&cxl_pio_range);
> +	if (!cxl_map(probe_data, cxl, 0, cxl_pio_range))
>  		return -ENOMEM;

[Severity: High]
Does this similarly abort initialization on success for the PF0 path due to=
 the
inverted error check on cxl_map()?

> -	}
> -
> -	probe_data->cxl_pio_initialised =3D true;
> -	probe_data->cxl =3D cxl;
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191239.4249=
-1-alucerop@amd.com?part=3D4
