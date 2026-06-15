Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F732F7F04
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544870; cv=none; b=SioYhuOcoAnWZxv6ZsTbP4pZJoXqGWZOHr9DVtk8UUTbVW3x78B4UA349oseF3IAJR9YnqKxEDOWRSKf+JN46JRAYGTcVj/93tENoudWjCbYTRU6kj7dcUWxZzxiB4ZKYbS4dlq28EkqnlLYRjenWYlg53F7jl73U04puuqncqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544870; c=relaxed/simple;
	bh=gMqjNIp8SrL5Pu30HOvxLaUj5mktAnNgjJJHaM/dzZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1Z9WdRZwt5M8vhPs667SzTZwsqLzDvgC/UXiDEcsYES82uKYBC9cd6vuO3tgDm7SKOxlXnruL5xrSLcDzxlVFfKitT1aiHHJ8xaSR2zubMQxFd2hpZNc2FRSxIZrU6bHbHLRqsCjxyE2WfKOxTnqc/IAUheMvGUhT+Ubl+7eUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mluH/snR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mluH/snR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBB61F000E9;
	Mon, 15 Jun 2026 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781544869;
	bh=jAgVBwBzMYXtP3/hab+OWp0BBfaCRvxNvVazDJnpEyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mluH/snRewQ3+gDaJD2AWVryDVKHSJGAwfrQi/if0cliwIqZaUpF417lhfQZm6wF2
	 CT453YHc5NVmCKFIUsjmUAs3W1kaZQ7jz10G0kZB0FehRpkn33zh5WIy4RPeBwElJE
	 6/0oEXecicIrmjKnXiNDGBHWOLZl5nQ+sstrD7zTNp1CkNAmkOLINiqAWgtuVqUlkm
	 bckBQTUeK0pjJVeSqwyOjtMtauVLXnqvJ2dt0GzRnu7dd2MLK4kbloixCD1mZiomWq
	 82LVt2471DHloguQcjHA7pHCeeiZLAJokAolIcezCp35QQKpe23B6tKuLV4LHjqrXo
	 ikUFGonDAXZ0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] cxl/pci: Add BI topology enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davidlohr Bueso" <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260615145529.13848-3-dave@stgolabs.net>
References: <20260615145529.13848-3-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:34:28 +0000
Message-Id: <20260615173429.0CBB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Mixing `goto` error handling with `__free()` scope-based cleanup d=
eclarations.
- [High] Missing explicit commit for the Endpoint BI Decoder Control Regist=
er.
- [High] Root port BI enablement logic is unreachable and contradicts the c=
ommit message.
- [High] Missing reference counting (`nr_bi`) for shared downstream ports i=
n cascaded switch topologies.
--

commit 31994c2bf9d14374bacdb07d505a19b18a761e35
Author: Davidlohr Bueso <dave@stgolabs.net>

cxl/pci: Add BI topology enable/disable

This commit implements cxl_bi_setup() to walk the CXL port topology and ena=
ble
BI flows on the device and every component in the path. It also implements a
teardown counterpart, cxl_bi_dealloc().

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809a..b1b0f3eab90e8 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dport->dport_dev);
> +	void __iomem *bi =3D dport->regs.bi_decoder;
> +	struct cxl_port *port =3D dport->port;
> +	u32 ctrl, value;
> +	int rc;

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
In cascaded switch topologies, can this unconditionally clear the
CXL_BI_DECODER_CTRL_BI_ENABLE bit while other endpoints below the switch
are still actively using it?

Unlike the root port case which uses dport->nr_bi for reference counting,
downstream ports appear to clear this bit as soon as the first endpoint
unbinds. This might break BI routing for other active endpoints on a shared
downstream port.

Does this need reference counting similar to the root port?

[ ... ]

> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enab=
le)
> +{

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
Is this missing an explicit commit for the Endpoint BI Decoder Control
Register?

The CXL 4.0 specification requires an explicit commit after changing
BI_ENABLE for any BI Decoder via CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ.

While __cxl_bi_ctrl_dport() correctly calls __cxl_bi_commit_decoder() after
updating the downstream ports, __cxl_bi_ctrl_endpoint() omits this step.

Could this cause the endpoint device to ignore the BI enablement state and
silently fail to enable BI flows?

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

[Severity: High]
The commit message states this will write BI Enable on each dport's BI
Decoder Control register. However, doesn't this loop terminate before
processing the root port?

Since the loop condition is !is_cxl_root(port_iter), when port_iter reaches
the CXL root, the loop exits and skips configuring the root port entirely.

Additionally, if the loop did reach the PCI_EXP_TYPE_ROOT_PORT code inside
__cxl_bi_ctrl_dport(), that code actually clears the enable bit:

__cxl_bi_ctrl_dport() {
    ...
    case PCI_EXP_TYPE_ROOT_PORT:
        ...
        value &=3D ~CXL_BI_DECODER_CTRL_BI_ENABLE;
}

Should this loop include the root port, and should the root port logic actu=
ally
set the enable bit rather than clearing it?

[ ... ]

> +	/* finally, enable BI on the device */
> +	rc =3D cxl_bi_ctrl_endpoint_enable(cxlds);
> +	if (rc)
> +		goto err_rollback;
> +
> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
> +					cxl_bi_dealloc, cxlds);
> +
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
Is it safe to mix goto-based error handling with scope-based cleanup in
this function?

This function declares struct cxl_port *port __free(put_cxl_port) at the
top, but also uses a goto err_rollback pattern for failure paths.

Mixing goto labels with __free() declarations in the same function creates
confusing ownership semantics and violates subsystem cleanup guidelines.

Should this be fully converted to scope-based cleanup, or avoid using
__free() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615145529.1384=
8-1-dave@stgolabs.net?part=3D2
