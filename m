Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4B39902B
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516286; cv=none; b=ZRBxbn+hyLF9LTnGy/W7zi6227b/SektINVqNP6vbvfJx5v7ayhQPv8KdfRH1iO5E4557ihamY39XvYI429/kcu1CFO4K8FqPLzN03ZqCPZa8dtP35KBgy2rqPvD+hVQLuX0uKpFeI7/t6p6cA0mBJmV2isQUpqw7tLgm6UZXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516286; c=relaxed/simple;
	bh=spVtXQTpYG0SqtBbCevMp5bIL6X9hjSRGuqvSMu4Z0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=belRTk6Xc4XaUgwEdc3cDWnrKdhxW+P7eZUXirdc7ZOdGPqnGzJTizcgc109JmMVDRavJJBo/qEtIaq2djfGIHkSSL7pn58DGqnRJL8vqBkNiSR9YppSg1OOuMbRlki+WeCORoXsH7o7to4Yw+Dy6McmOuHxmhSqSnbmQzcHOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9FEe0NH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9FEe0NH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136981F000E9;
	Wed, 12 Aug 2026 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786516284;
	bh=uyYd5DJVhq+mH3FVvu/G0DD0bT0bglGcmQmc0h+DW6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9FEe0NHh6FNBOOdcsV/jEcdT3vFG3MS3GFeaboViQ7E6fzXbs+2xXVqKfYxMUQ8c
	 +qGD3qUiiXKQ9LNvfj5xjRk+XDDU+JrK2ZT5Udu6CaQFSdndD7rA7mT2ReTH5Wa9sl
	 bgla3YIvdac+DhrmtyDrfAFuieBfdp7gK4a799ldpuwKtrjAhZ4LhE0GZz8mD7Txu7
	 tZB5qq30TYWydb09uKWTD+oqTtpMERGs5cFSTi4pX5/dlmVN0WLDztCfg0ECRgjff6
	 WKfpDmYKdceyILEZ5tUDbis75yHWicokLuZjHjrfaWrrSsIyjZUoLNkQMjLXSdSNu/
	 0bAYOYQHUgOSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/pci: Fix NULL pointer dereference in reset
 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812061027.57037-1-kanie@linux.alibaba.com>
References: <20260812061027.57037-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:31:23 +0000
Message-Id: <20260812063124.136981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for DVSEC-emulated decoders allows spurious reset w=
arnings and kernel tainting.
- [High] Race condition between PCIe reset and sysfs driver unbind leading =
to NULL pointer dereference or UAF.
- [High] Data race on `cxld->flags` due to missing synchronization.
--

--- Patch [1]: [PATCH v2] cxl/pci: Fix NULL pointer dereference in reset de=
tection ---
commit 0a3a66bfcbdad33db13f3c33dd88b689403ca622
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/pci: Fix NULL pointer dereference in reset detection

This commit adds a check for a NULL hdm pointer before reading the control
register in __cxl_endpoint_decoder_reset_detected(). This prevents a kernel
oops during PCIe resets on memory devices that emulate their HDM decoders
using DVSEC ranges instead of physical registers.

Link: https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linu=
x.alibaba.com/

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..611175f29d245 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -685,6 +685,14 @@ static int __cxl_endpoint_decoder_reset_detected(str=
uct device *dev, void *data)
> =20
>  	cxlhdm =3D dev_get_drvdata(&port->dev);
>  	hdm =3D cxlhdm->regs.hdm_decoder;

[Severity: High]
This is a pre-existing issue, but is there a race condition here between
the PCIe reset handling and sysfs driver unbind?

Looking at cxl_reset_done(), it iterates over the endpoint's children using
device_for_each_child() without holding the port's device lock:

drivers/cxl/pci.c:cxl_reset_done() {
    ...
    device_for_each_child(&cxlmd->endpoint->dev, NULL,
                          cxl_endpoint_decoder_clear_reset_flags);
    ...
}

If a concurrent sysfs unbind of the cxl_port driver clears the driver data
and frees the cxlhdm structure, could dev_get_drvdata() return NULL or a
stale pointer, leading to a crash when cxlhdm is dereferenced?

> +
> +	/*
> +	 * Devices that describe their HDM ranges with the DVSEC range
> +	 * registers have no HDM decoder registers to consult.
> +	 */
> +	if (!hdm)
> +		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does this check fully cover
all DVSEC-emulated decoders?

In should_emulate_decoders(), a device can fall back to DVSEC emulation
even when the hdm pointer is not NULL (for example, if HDM decoders are
present but globally disabled by firmware).

In this fallback case, the decoder is emulated but the hdm pointer remains
valid. This function would bypass the !hdm check, read the HDM control
register where the COMMITTED bit is likely 0, and falsely trigger a reset
warning.

Since cxl_setup_hdm_decoder_from_dvsec() sets cxld->commit to NULL for all
emulated decoders, would checking for emulation directly (e.g.,
if (!cxld->commit)) be a more robust approach?

> +
>  	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> =20
>  	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
>  }

[Severity: High]
This is a pre-existing issue, but does modifying cxld->flags during reset
handling lack necessary synchronization?

In cxl_endpoint_decoder_clear_reset_flags(), which is called during
cxl_reset_done(), the flags are modified using a non-atomic operation:

drivers/cxl/pci.c:cxl_endpoint_decoder_clear_reset_flags() {
    ...
    cxled->cxld.flags &=3D ~CXL_DECODER_F_RESET_MASK;
    ...
}

This happens while holding only the parent memory device lock.
Concurrently, sysfs operations can commit a decoder:

cxl_decoder_commit() {
    ...
    cxld->flags |=3D CXL_DECODER_F_ENABLE;
    ...
}

Because cxld->flags is modified concurrently without a common lock or atomic
bit operations, could flag updates be lost, potentially causing the loss of
the ENABLE flag?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812061027.5703=
7-1-kanie@linux.alibaba.com?part=3D1
