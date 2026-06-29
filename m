Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66F327BFC
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765517; cv=none; b=Qei94T+tQW7aepKvy6fP9z0XjY70DMhMarNTmYYFz1rcVJ7YhiJwkWu7qgYVb/rlLW89Iv/cmgPRuIfCYCgqG+E5zTaGrgpV4/dVJFVaarWtWUNybkF5GDgJnMCGi3uAdYKIYtK7GI8V8UshfqsuOiOhKrSy0jR3q5XAe/KJmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765517; c=relaxed/simple;
	bh=zcHzs/ZmpiF6uLNHCquQcHMu2LNTgTyAkpghWpv2QXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tm0AqeSC6svol1Z2VRoNoQ9Vkg/K5Mzdmt30163GmxAmCwKS6M402q19ldnDJAGuwD7lu8viVMRNUCmsCdaHHjVcCB+P+foIN44qwpx+b8wtWCm51kq72dbTXBjXNOLvmR386Lrx8HTxfZobD3mEOzpw56o2Bs5fuySBPQ7QrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaRO4Rpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaRO4Rpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088C21F000E9;
	Mon, 29 Jun 2026 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782765516;
	bh=wDcEYNoIC4VmVekpCDZrurLIEmG16l8LuCR989vFT9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaRO4Rpy6E8ShUpviRvweC61BrE7ge43pHHkK1bEupS3uSJzdNwzcOJBhrgTDhcNg
	 BgQ0UiRyncqiWhwfKPQYEP+5MsY3EThFJNQ0+fo7dcLhcvd+sgUWoRGa9YFQKyPfMe
	 R2gVXzlaHhm7TI8v9N48M5mLLZoBF5keqU8CMe0TZhZkcG/Jp/+radpXmrjEvCu1QU
	 56a6Atyeoz9YFQtNJHnRu2XWNngJvsSeZRuFUFYGOk0QEZJWJP5J/DwS8PYlu1yDRh
	 9zYL80z7l26gxJtvJgtXrv4fzVh4aJN47IzHcb5mNouZYiaRAEsB6yoq8S98Z4b/QC
	 0G+AS38PyHLuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] cxl/test: Fixup hdm init for auto region to
 support type2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260629202720.3658117-6-dave.jiang@intel.com>
References: <20260629202720.3658117-1-dave.jiang@intel.com>
 <20260629202720.3658117-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 20:38:35 +0000
Message-Id: <20260629203836.088C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] mock_init_hdm_type2_cxled bypasses cxl_port_update_decoder_targe=
ts() and modifies the live decoder target array directly without the cxl_rw=
sem.region lock.
- [Medium] Missing return value check for devm_cxl_dpa_reserve().
- [Low] Unused parameter `pdev` in `mock_init_hdm_type2_cxled`.
--

commit 0f9c8e2fe22ac8d4fe6d8be6b13b11102337bb2b
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Fixup hdm init for auto region to support type2

This commit adds support to set up the initialization of decoders
to support type 2 auto regions in the cxl test framework.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 1eac06ad46601..910c8b9abc003 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

[ ... ]

> +static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
> +				      struct cxl_port *port,
> +				      struct platform_device *pdev)

[Severity: Low]
This isn't a bug, but it looks like pdev is never evaluated or used in
this function. Is this parameter necessary?

> +{
> +	struct acpi_cedt_cfmws *window =3D mock_cfmws[0];
> +	struct cxl_decoder *cxld =3D &cxled->cxld;

[ ... ]

> +	cxld->target_type =3D CXL_DECODER_DEVMEM;
> +	cxld->flags =3D CXL_DECODER_F_ENABLE;
> +	cxled->state =3D CXL_DECODER_STATE_AUTO;
> +	port->commit_end =3D cxld->id;
> +	devm_cxl_dpa_reserve(cxled, 0,
> +			     mock_auto_region_size / cxld->interleave_ways, 0);

[Severity: Medium]
Does this code need to check the return value of devm_cxl_dpa_reserve()?

If this call fails with an error like -ENOMEM or -EBUSY, the mock framework
will silently proceed with an invalid or unreserved DPA state, which could
mask bugs or cause test crashes later on.

> +	cxld->commit =3D mock_decoder_commit;
> +	cxld->reset =3D mock_decoder_reset;
> +
> +	WARN_ON_ONCE(!cxld_registry_new(cxld));
> +	/*
> +	 * Now that endpoint decoder is set up, walk up the hierarchy
> +	 * and setup the root port decoder targeting @cxlmd.
> +	 */
> +	dport =3D port->parent_dport;
> +	root_port =3D dport->port;
> +	dev =3D device_find_child(&root_port->dev, NULL, first_decoder);
> +	/*
> +	 * Ancestor ports are guaranteed to be enumerated before
> +	 * @port, and all ports have at least one decoder.
> +	 */
> +	if (WARN_ON(!dev))
> +		return;
> +
> +	cxlsd =3D to_cxl_switch_decoder(dev);
> +	cxlsd->target[0] =3D dport;
> +	cxlsd->cxld.target_map[0] =3D dport->port_id;

[Severity: Medium]
Is it safe to directly assign to the live decoder target array here
without holding the cxl_rwsem.region lock for synchronization?

Bypassing cxl_port_update_decoder_targets() and modifying the decoder target
array directly creates a data race against concurrent sysfs readers like
target_list_show() that rely on this lock. Should this use
cxl_port_update_decoder_targets() instead?

> +	cxld =3D &cxlsd->cxld;
> +	cxld->target_type =3D CXL_DECODER_DEVMEM;
> +	cxld->flags =3D CXL_DECODER_F_ENABLE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629202720.3658=
117-1-dave.jiang@intel.com?part=3D5
