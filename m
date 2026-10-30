Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355365;
	b=PnOccGImHrHACMewFlHydALyAVS5r/GdFlSnyqi0Nqp7qdK4FgE0Td/gYd/N5sOExXK1
	 QpismoRAn93kIxvOCVjtnLCxnao8qLkv/NgipJHkltaMHmUvge+hyR5z5l6uP5iL20j1O
	 LZu40Zi/Q7j+9lqPHi/C4bNMah4UVvQp6LvcTwsm2EV485lmqNRc5NzCLpzGdqxBMae52
	 x2MAuS7Nvo0bSwYTnqgso57qXOocXthunzlhWsBZj5X3tccd4SL2b7NbYQDoJ+cVWrJCY
	 n8l3eU++qJzkDFz8Es2QQNRbsnKlvWdFXqBClpNtY8MyV8n0WRKKMT0RnDAp4L3HqIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=an3FxMxhz2UHF4RsfjX0k/4QfEP5hWTXcWTDKpPOENU=;
	b=LMxRd8Sk6DksbOzDVpXoTZzxC+9eZmC+R10FeADrxyeTgey6V07RBt5OlOWTSeS146SJ
	 IjBI8EjAIm1l3f/tY/SFwclKogU8CRtEI2jJtvOvGsRS8I/NUvWZwO5Yzqqj7/UocCI9C
	 /HpQRExvYgW/jB2+cYk8aVy6B2z8+J+IoP7dTX0JRSKvPIjdIl7yJESyhwf7Px67gcH4c
	 aoUHoZAVSYn+Qd+7ao0ah5jnzg39TiGnTwNmUdLxwJclVRIeHesUax3ufQQD4YIcWwAIy
	 mtgbVcs0TX2ZcI4xMbQpqilZib55ka8MvClOdPTOyYMZd/RBjLC1TOGDoai89ayoHFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i/B2j4ww";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772C606A31C
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/B2j4ww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49CC1F00A15;
	Fri, 30 Oct 2026 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793355364;
	bh=an3FxMxhz2UHF4RsfjX0k/4QfEP5hWTXcWTDKpPOENU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i/B2j4ww93yidBZ8sGsmHn6w1Z37hKupFMF3bWCdfNxtxhS1MShaXJhT+1+DKa9Tz
	 OwvXzv8e4rsfC0sNjGt2UIHt2zutreeAhIdowozHR1jg48csFWxHjo1ydhEeHGylig
	 vnnAD/drxlV7Pk+i79OSBKpJORUdGBef6Cxf78GHH6h3otv5RMWylg7/6BL5tbEu/P
	 x901mh5FvmxqgyU5SSv+fovFYPmph79F20E2QPN4vsnVvQTobxcBMR8iIDnF0afHTt
	 51+TZUDzaLy0LU2iTPXxMGE7rKqT02dc1OQEHsscSJjTSQAbKZWzMyETTu0l98N+4S
	 vHKhUXiGwZyYQ==
Message-ID: <sashiko-outbox-190819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/port: Unmask AER internal errors for VH endpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261030095951.46080-1-icheng@nvidia.com>
References: <20261030095951.46080-1-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:16:04 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl/port: unreachable pci_aer_unmask_internal_errors() in cxl_ras_=
unmask()
--

commit d1558f7f8a341adaa60fba2aa3820ba77f94d9bf
Author: Richard Cheng <icheng@nvidia.com>

cxl/port: Unmask AER internal errors for VH endpoints

This commit unmasks PCIe AER internal errors during CXL endpoint RAS setup
for Virtual Host (VH) devices and exports pci_aer_unmask_internal_errors()
to the cxl_port module.

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c12fd0b89883a..2da8fd9e33a39 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -118,6 +118,13 @@ static int cxl_ras_unmask(struct cxl_port *port)
>  			orig_val, val);
>  	}
> =20
> +	/*
> +	 * RCH errors are reported by the RCEC. VH endpoints report CXL
> +	 * protocol errors as PCIe AER internal errors.
> +	 */
> +	if (!is_cxl_restricted(pdev))
> +		pci_aer_unmask_internal_errors(pdev);

[Severity: High]
Can pci_aer_unmask_internal_errors(pdev) ever be reached here?

The only caller of cxl_ras_unmask() is cxl_endpoint_port_probe(), where
port->uport_dev is the struct cxl_memdev device on cxl_bus_type rather than
the underlying struct pci_dev (which is port->uport_dev->parent):

drivers/cxl/port.c:devm_cxl_add_endpoint() {
	...
	endpoint =3D devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
				     parent_dport);
	...
}

drivers/cxl/port.c:cxl_endpoint_port_probe() {
	struct cxl_memdev *cxlmd =3D to_cxl_memdev(port->uport_dev);
	...
	devm_cxl_port_ras_setup(port);
	if (cxl_ras_unmask(port))
		dev_dbg(&port->dev, "failed to unmask RAS interrupts\n");
	...
}

At the start of cxl_ras_unmask(), port->uport_dev is checked with
dev_is_pci():

drivers/cxl/port.c:cxl_ras_unmask() {
	...
	if (!dev_is_pci(port->uport_dev))
		return 0;
	pdev =3D to_pci_dev(port->uport_dev);
	...
}

Because port->uport_dev is &cxlmd->dev on cxl_bus_type,
dev_is_pci(port->uport_dev) always evaluates to false, causing
cxl_ras_unmask() to return 0 immediately without unmasking the CXL RAS
registers or calling pci_aer_unmask_internal_errors(pdev).

Should cxl_ras_unmask() inspect port->uport_dev->parent (similar to how
read_cdat_data() in drivers/cxl/core/pci.c checks uport->parent when
is_cxl_memdev(uport) is true) to obtain the endpoint's struct pci_dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030095951.4608=
0-1-icheng@nvidia.com?part=3D1
