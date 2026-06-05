Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82038C43F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622987; cv=none; b=eaVu/B2fhC3DFWtSUOCv1KdjcIV+raHFM9Vhr88X4SC6F+tqQeX/68pUlXiEIc+bCQtxcoKITby0XyllUI99mb6Ijuk7myI+lp3OpMt0oE9fSi9TGQpxvuu1k9XD3SGkv2u3dc4ZDxWMCTu2c9fPLHlIYCniaDo4Cg0URZ67FmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622987; c=relaxed/simple;
	bh=wggFfjgZiAH6SsLXPYROcKQQCAHIyGnNb54wWiwaLjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bDwcZAG9iSyRFeRb5A7p0UlEeKrESk3AFFwnc3+SDsXDD7o8Id9vBDyZ/u5l6i2op0CzftVLo+qngEdwd4umATsDPNfaCUhaLiN2kGDV714xKyF6sJuPVo7CItkuPMv5eeLHADNYHgFoabbznK6LY0SvZtdYPuLySSeMfIGKQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcH57pLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcH57pLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1EC1F00898;
	Fri,  5 Jun 2026 01:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622980;
	bh=6yvccuELjk0WfCBNEDiqeIoG3Tg9w7lk0TDCOm4tB5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZcH57pLZAi6Gsur/R6Wc1GdXYTr2O97jzGIBZiUSfGSxeExkHiYzHsvdbGFW0HvPY
	 2D5u5QFeW7ON5BRWBfxM+NMXVXirtSJBo6gswUd/yrTKLxwonoi0BZT4uz7vO0G7qq
	 SSv6cPj9qLmlJCUwjpjle9a8D7tjSE0OimH4SFnKkhQVK9tgb6PpuOekKssvBXuuFT
	 ty3MvlPd4SrBvowjqyRsVSstrGZwyVZEL6slD/JwxH4/atwSQQybOg3VMRUkhy3Iax
	 paKYMf3ycIl7uwBF0sJRBiknzDI0TgiIsbRYgX991cobj7GcoDQoauj5de/NUyVHZI
	 nHL5FzY2AqPNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605003329.2584012-3-dave@stgolabs.net>
References: <20260605003329.2584012-3-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:29:39 +0000
Message-Id: <20260605012940.1A1EC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Missing BI reference counting for shared Downstream Ports breaks B=
I coherence in cascaded switch topologies.
- [High] A hardware-reported timeout base of 0 causes an infinite polling l=
oop in `readx_poll_timeout`, leading to a kernel hang.
- [High] Missing explicit commit sequence for the BI Decoder on the endpoin=
t device.
- [High] Topology walks in `cxl_bi_setup` and `cxl_bi_dealloc` stop early, =
failing to configure or rollback BI on the Root Port.
- [High] `cxl_bi_dealloc` returns early and fails to disable BI on the endp=
oint hardware if the upstream port topology is unbound prior to memdev tear=
down.
- [Medium] Mixing `goto`-based error handling with `__free()` scope cleanup=
 attributes in the same function violates subsystem guidelines.
--

commit 6dd8e8661d8e77fc7f88e425d2633e5ccda84b51
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/pci: Add BI topology enable/disable

Implement cxl_bi_setup() which walks the CXL port topology to enable
BI flows on the device and every component in the path between the
device and the root port. The teardown counterpart, cxl_bi_dealloc(),
runs automatically on cxl_mem unbind.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
> +					     unsigned int scale,
> +					     unsigned int base)
> +{
> +	static const unsigned long scale_tbl[] =3D {
> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> +	};
> +
> +	if (scale >=3D ARRAY_SIZE(scale_tbl)) {
> +		dev_dbg(dev, "Invalid BI commit timeout scale: %u\n", scale);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;
> +}

[Severity: High]
If the hardware provides a base of 0, could this return a 0 timeout?

[ ... ]

> +static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status=
_reg,
> +				u32 committed_bit, u32 err_bit,
> +				unsigned int scale, unsigned int base)
> +{
> +	unsigned long tmo_us, poll_us;
> +	ktime_t start;
> +	u32 status;
> +	int rc;
> +
> +	tmo_us =3D min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
> +		       __cxl_bi_get_timeout_us(dev, scale, base));
> +	poll_us =3D max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
> +	start =3D ktime_get();
> +
> +	rc =3D readx_poll_timeout(readl, status_reg, status,
> +				status & (committed_bit | err_bit),
> +				poll_us, tmo_us);

[Severity: High]
Does a tmo_us of 0 passed to readx_poll_timeout cause it to poll
indefinitely?

If a faulty or malicious device sets base to 0 and never sets the commit
or error bits, this looks like it might result in a kernel thread spinning
forever.

[ ... ]

> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dport->dport_dev);
> +	void __iomem *bi =3D dport->regs.bi_decoder;
> +	struct cxl_port *port =3D dport->port;
> +	u32 ctrl, value;
> +	int rc;
> +
> +	guard(device)(&port->dev);
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

[ ... ]

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

[Severity: High]
Should this case maintain a reference count for the downstream port similar
to how dport->nr_bi is used in the PCI_EXP_TYPE_ROOT_PORT case?

In cascaded switch topologies, an upstream switch's downstream port can be
shared by multiple downstream endpoints. If one endpoint is unbound,
cxl_bi_dealloc will clear the BI_ENABLE bit on the shared downstream port
unconditionally.

Could this silently break Back-Invalidate for all other active endpoints
relying on that same path?

[ ... ]

> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enab=
le)
> +{
> +	struct cxl_port *endpoint =3D cxlds->cxlmd->endpoint;
> +	void __iomem *bi =3D endpoint->regs.bi_decoder;
> +	u32 ctrl, val;
> +
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl =3D readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (enable) {
> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already enabled in hardware\n");
> +			return -EBUSY;
> +		}
> +		val =3D ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (!cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already disabled in hardware\n");
> +			return -EBUSY;
> +		}
> +		val =3D ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	}
> +
> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi =3D enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n",
> +		str_enabled_disabled(enable));
> +
> +	return 0;
> +}

[Severity: High]
Is an explicit commit sequence required here after writing the control
register?

Unlike __cxl_bi_ctrl_dport which calls __cxl_bi_commit_decoder after
modifying the control register, the endpoint function does not commit
the changes.

If the endpoint's BI decoder requires an explicit commit, it seems the enab=
le
or disable operation might not take effect on the hardware.

[ ... ]

> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_dev_state *cxlds =3D data;
> +	struct cxl_dport *dport_iter, *dport;
> +	struct cxl_port *port_iter;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return;
> +
> +	struct cxl_port *port __free(put_cxl_port) =3D
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);
> +	if (!port || !cxlds->bi)
> +		return;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		cxl_bi_ctrl_endpoint_disable(cxlds);

[Severity: High]
Does this early return prevent proper endpoint cleanup if the port topology
is torn down before the memdev teardown?

If cxl_pci_find_port returns NULL because the upstream port was removed
or unbound, cxl_bi_ctrl_endpoint_disable is skipped. This leaves the
endpoint hardware with BI_ENABLE set and cxlds->bi equal to true.

If the device is subsequently rebound, cxl_bi_ctrl_endpoint_enable will see
the hardware bit already set, print 'BI already enabled in hardware',
and fail the probe with -EBUSY.

> +
> +	port_iter =3D port;
> +	dport_iter =3D dport;
> +	while (!is_cxl_root(port_iter)) {
> +		int rc =3D cxl_bi_ctrl_dport_disable(dport_iter);
> +
> +		/* best effort */
> +		if (rc)
> +			dev_dbg(&port_iter->dev,
> +				"BI dport disable failed: %d\n", rc);
> +
> +		dport_iter =3D port_iter->parent_dport;
> +		port_iter =3D dport_iter->port;
> +	}
> +}

[Severity: High]
Does this loop terminate before disabling BI on the Root Port?

In the CXL topology, the Root Port is a downstream port (dport) owned by
the CXL Root or Host Bridge (port). When the traversal reaches the Host
Bridge, is_cxl_root(port_iter) evaluates to true and the loop terminates
before executing the loop body for the Root Port's dport.

[ ... ]

> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_port *endpoint =3D cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport_iter, *dport, *failed;
> +	struct cxl_port *port_iter;
> +	struct pci_dev *pdev;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	pdev =3D to_pci_dev(cxlds->dev);
> +	struct cxl_port *port __free(put_cxl_port) =3D
> +		cxl_pci_find_port(pdev, &dport);
> +
> +	if (!port)
> +		return -EINVAL;

[ ... ]

> +	port_iter =3D port;
> +	dport_iter =3D dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc =3D cxl_bi_ctrl_dport_enable(dport_iter);
> +		if (rc)
> +			goto err_rollback;

[Severity: Medium]
Is it safe to mix goto-based error handling with __free scope cleanup
attributes in the same function?

The Cleanup and Guard Subsystem Details explicitly forbid mixing goto-based
cleanup labels and scope-based __free declarations within the same function
due to the potential for confusing ownership semantics and double-free bugs.

[ ... ]

> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far, including the failed one.
> +	 */
> +	failed =3D dport_iter;
> +	dport_iter =3D dport;
> +	port_iter =3D port;
> +	while (!is_cxl_root(port_iter)) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		if (dport_iter =3D=3D failed)
> +			break;
> +		dport_iter =3D port_iter->parent_dport;
> +		port_iter =3D dport_iter->port;
> +	}
> +	return rc;
> +}

[Severity: High]
Does this rollback loop also skip the Root Port because of the
is_cxl_root check, similar to the teardown loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605003329.2584=
012-1-dave@stgolabs.net?part=3D2
