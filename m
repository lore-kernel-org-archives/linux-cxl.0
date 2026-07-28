Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99391200110
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251791; cv=none; b=CUaCt2+YPlfjpil0q8v/KYcDj4QI569Xku3ak0CXz17G8/W9RGmsnfAaGKtd2rl3J3ckLPq8ItRqjeWET1MehWrqzGbhXrKRwsKOWhz5SeLeq7jBGFfPYEYblbrRXEr3oN5Q7SQf2vBpt+3QgrmKwz/j8PLWlpYA9ALUgIkOBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251791; c=relaxed/simple;
	bh=IpJqVtqK2DxckWWw5/oHblwFsTFKuxXYhtRRymQnvMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AKqWWmTxLH/0FZpceuzqtaynLORkzSdvfp0GzR0PNfH7TspOrBdAzjSgbgZin5XzDEUJeyd25mICv9cHwrOSIE4XlqzZKWPblLe4PQ5F10jWi3oS39LPaQxjMjbsAkQkXVRdhBtavjRP6KwC5USLUFHSF8fJtsB2eiN63nttmCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHG6wfca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHG6wfca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F0D1F000E9;
	Tue, 28 Jul 2026 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251789;
	bh=kdrCvv3MTvszt9CrCzZ9WqTVh2caQQ1Evgdz1l9jqfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHG6wfcaLtjwM7KKGPTZnSJo9EJh7oY30qN/2Q6gDqd1IkP8iolopxN3trSOzedj/
	 AwYy30MTuhyrF/7TsqzDZseQknRaqnh4n2goHZ1xz4j28E9Ge8CXvfVE1cBwG0o/ka
	 lGhNfJG0ZBBKOUeJppA4O1cF+YNi/BRnYEEiC711kxEsDEyreM7vhxBBQSUP2OSz2T
	 g3dNcspg2P7sGxNjbD/GBvIDVPn3zPxxqKhPoOpQOSgNvpRY+04uUyoyncp3bYURKf
	 jGlU1jnIKsdsP5W+MtfV1zeVWy3wu96ogXWTLGimsIbAGsMEqVwEuVn6TlLA+ROD/G
	 QpV63rYdDttfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/8] cxl/pci: Add BI topology enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260728144136.709882-3-dave@stgolabs.net>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-3-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:16:28 +0000
Message-Id: <20260728151629.20F0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Topology walk loop exits early, completely skipping CXL Root Ports=
 and breaking BI enablement.
- [High] Missing explicit hardware commit for Endpoints and Root Ports.
- [High] Premature BI disablement on shared Switch DSPs due to missing `nr_=
bi` reference counting.
- [Medium] Hardware register state is leaked (left enabled) when a downstre=
am port fails to commit.
- [Medium] Writing to the BI_COMMIT control bit without waiting for the BI_=
COMMITTED status bit to clear introduces a race condition.
--

--- Patch [2]: [PATCH v7 2/8] cxl/pci: Add BI topology enable/disable ---
commit 60c6baf3b8f67e918530663c4dbf82d8c044cc21
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/pci: Add BI topology enable/disable

This commit implements cxl_bi_setup() to enable Back-Invalidate (BI) flows
on a device and every component in its path. It also implements the teardown
counterpart cxl_bi_dealloc(). The setup runs during endpoint port probe and
walks the topology to enable BI capabilities.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f82559d8a8c5a..a87c2ad9ac533 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
[ ... ]
> @@ -964,3 +966,380 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dpor=
t)
[ ... ]
> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl =3D readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);

[Severity: Medium]
Will this sequence cause a race condition with the subsequent polling loop?

If the hardware was previously in a committed state, the status bit might
still be set when the polling starts.

Could this allow the polling loop to succeed instantly before the hardware =
has
processed the new commit request?

[ ... ]
> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dport->dport_dev);
> +	void __iomem *bi =3D dport->regs.bi_decoder;
> +	struct cxl_port *port =3D dport->port;
> +	u32 ctrl, value;
> +	int rc;
> +
> +	guard(mutex)(&port->bi_lock);
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl =3D readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		if (enable) {
> +			/*
> +			 * There is no point of failure from here on,
> +			 * BI will be enabled on the endpoint device.
> +			 */
> +			dport->nr_bi++;
> +
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +
> +			value =3D ctrl | CXL_BI_DECODER_CTRL_BI_FW;
> +			value &=3D ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (WARN_ON_ONCE(dport->nr_bi =3D=3D 0))
> +				return -EINVAL;
> +			if (--dport->nr_bi > 0)
> +				return 0;
> +
> +			value =3D ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		return 0;

[Severity: High]
Does this code need to explicitly commit the BI Decoder for Root Ports?

The control register is updated, but a hardware commit is never performed.

Will this fail to enable BI on Root Ports that require an explicit commit?

> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (enable) {
> +			value =3D ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
> +			value |=3D CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +			value =3D ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);

[Severity: High]
Is there a missing reference count for Downstream Ports here?

Unlike Root Ports which check dport->nr_bi, this unconditionally clears the
CXL_BI_DECODER_CTRL_BI_ENABLE bit when disabling.

If this is a shared Switch DSP in a cascaded switch topology, will unbinding
one endpoint instantly break BI functionality for all other active endpoints
below the same upstream switch?

[ ... ]
> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enab=
le)
> +{
> +	struct cxl_port *endpoint =3D cxlds->cxlmd->endpoint;
> +	void __iomem *bi =3D endpoint->regs.bi_decoder;
> +	u32 ctrl, val;
[ ... ]
> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi =3D enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n",
> +		str_enabled_disabled(enable));
> +
> +	return 0;
> +}

[Severity: High]
Does the endpoint need an explicit hardware commit here?

Similar to the Root Port case, this modifies the CXL_BI_DECODER_CTRL_BI_ENA=
BLE
bit but never calls __cxl_bi_commit_decoder() to commit the change to
hardware.

[ ... ]
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_port *endpoint =3D data;
> +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +
> +	if (!cxlds->bi)
> +		return;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		cxl_bi_ctrl_endpoint_disable(cxlds);
> +
> +	/*
> +	 * Walk the same parent_dport chain that enabled the path. A bus
> +	 * lookup cannot stand in for it: an ancestor-driven teardown
> +	 * delists the parent port before this devres action runs.
> +	 */
> +	dport_iter =3D endpoint->parent_dport;
> +	port_iter =3D dport_iter->port;
> +	while (!is_cxl_root(port_iter)) {
> +		int rc =3D cxl_bi_ctrl_dport_disable(dport_iter);

[Severity: High]
Does this loop terminate before processing the Root Port?

When port_iter reaches the top, its owning port is cxl_root. Since
is_cxl_root(cxl_root) evaluates to true, it looks like the loop exits
immediately before executing the disable body for the Root Port.

[ ... ]
> +static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
> +			      struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	struct cxl_dport *dport_iter, *failed;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	port_iter =3D port;
> +	dport_iter =3D dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc =3D cxl_bi_ctrl_dport_enable(dport_iter);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport_iter =3D port_iter->parent_dport;
> +		port_iter =3D dport_iter->port;
> +	}

[Severity: High]
Does this also skip enabling the Root Port?

Using the same !is_cxl_root() condition as cxl_bi_dealloc(), this loop will
exit before calling cxl_bi_ctrl_dport_enable() for the Root Port, leaving t=
he
host path incomplete.

[ ... ]
> +err_rollback:
> +	failed =3D dport_iter;
> +	dport_iter =3D dport;
> +	port_iter =3D port;
> +	while (!is_cxl_root(port_iter) && dport_iter !=3D failed) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		dport_iter =3D port_iter->parent_dport;
> +		port_iter =3D dport_iter->port;
> +	}
> +	return rc;
> +}

[Severity: Medium]
Should the failed dport be included in the rollback loop?

If cxl_bi_ctrl_dport_enable() writes the enable bit but the hardware commit
fails, the control register has still been modified.=20

By stopping the rollback when dport_iter !=3D failed,
cxl_bi_ctrl_dport_disable() is never called for it, potentially leaking the
hardware register state as left enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144136.7098=
82-1-dave@stgolabs.net?part=3D2
