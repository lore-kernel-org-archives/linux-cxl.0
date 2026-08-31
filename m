Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F135975
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175047; cv=none; b=HbzRMUy1qMYbJuoI62FTWB5SAYcD9PK2DvXPAp7z6N1+RQlmRjJjQBQwKvc1xkzoPuWMnvSkaDbxKtgsJt50bCQbJA9EzAUlsc18yzushn/Z6B09XtKHkCbbiShBhUgFPLdKDhXT0RvFu4t8JSHE8DNWTjyxKRk74kmK/Ud3l70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175047; c=relaxed/simple;
	bh=T2q+zbV9732e/6e0wYWRVjJN771U/5q0XfmBHV4hV6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gligcHdQu8ULDmG6KdYYNXankb4FaCxWQnFb9g9KktwC4hug06Zasgep26zo+AgliKLV/VYVvaq6VggANAAMxMx3goehXiulYsaFiC6GxuTE5+21C+P1ShkKxrDwPViOKGYiAciNe8mL4R9/5zBZBNZMc1bjle2ynvm2ZhjrGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJtdHT0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJtdHT0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A741F000E9;
	Mon, 31 Aug 2026 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175046;
	bh=pnVGCBbiRbsbM4QVY64/WTZncrAOW6LwEW9Y4GoMESA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJtdHT0g5BZC/nmT3aub1tVjvHil3x3xIE/EaUjAZiPO+aDapLvMGVs6m88u+2v2s
	 +ZzBuR6NMdUuXFG9Fsqz4mkfTi05l+kvLVBFGa5iZwWYfexMBh6Ucn59ORUYBNt7+B
	 dwRB3pZWkEZHkWefPTfIrPBwfCBP08pTxPRQJPfep5zOtXPxGLD3a/lcokO6PlUzFW
	 ExJ8khHFgzyl+N5KNeRikOnf3zvcZR4AnvZ6urh0hc4gMpCFshu8e7DKZPhkiRknFG
	 P01XLMaxDDSeacU4f5QT4SjUSTAzWi029jCXhNCoVGNMhUed8IwextxxC6sQlel6kS
	 8nCShmbMgoxvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260831110449.719086-1-kanie@linux.alibaba.com>
References: <20260831110449.719086-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:17:25 +0000
Message-Id: <20260831111726.19A741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Bypassing reset detection for DVSEC-emulated decoders masks hardwa=
re configuration loss on Secondary Bus Reset (SBR).

Pre-existing issues:
- [High] Concurrent read-modify-write data race on cxld->flags in cxl_endpo=
int_decoder_clear_reset_flags.
- [High] Missing exclusion against cxl_port unbind causes a potential use-a=
fter-free of devm-allocated cxlhdm.
--

commit 5cb99f1a9d781a36990dc77bd01012f502a6380b
Author: Guixin Liu <kanie@linux.alibaba.com>

cxl/pci: Skip reset detection for DVSEC emulated decoders

This commit changes the CXL PCIe reset detection to skip checking the
hardware reset state for HDM decoders that are emulated from DVSEC range
registers. It does this by returning early from
__cxl_endpoint_decoder_reset_detected() if cxld->commit is NULL.

Link: https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linu=
x.alibaba.com/

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002ca..d8b07f86bab09 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(str=
uct device *dev, void *data)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) =3D=3D 0)
>  		return 0;
> =20
> +	/*
> +	 * Decoders emulated from the DVSEC range registers have no commit
> +	 * callback and no HDM decoder registers to consult.
> +	 */
> +	if (!cxld->commit)
> +		return 0;
> +

[Severity: High]
Does bypassing reset detection for DVSEC-emulated decoders in
__cxl_endpoint_decoder_reset_detected() mask hardware configuration loss
on Secondary Bus Reset (SBR)?

When a bus reset occurs on a CXL endpoint with DVSEC-emulated HDM
decoders, this early return unconditionally skips hardware reset
verification. On physical hardware, SBR wipes non-sticky PCI configuration
registers, disabling the DVSEC memory mapping. By skipping verification,
the OS will attempt to use disconnected memory, which could lead to a
system crash (Machine Check Exception) or data corruption.

>  	cxlhdm =3D dev_get_drvdata(&port->dev);
>  	hdm =3D cxlhdm->regs.hdm_decoder;

[Severity: High]
This is a pre-existing issue, but does the missing exclusion against
cxl_port unbind cause a potential use-after-free of the devm-allocated
cxlhdm?

In __cxl_endpoint_decoder_reset_detected(), a concurrent unbind of the
cxl_port driver while cxl_reset_done() iterates endpoints could allow the
driver core devres to free cxlhdm mid-execution, since the reset handler
fails to lock the port device. This use-after-free could lead to a kernel
panic, undefined behavior, or memory corruption.

>  	ctrl =3D readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));

[ ... ]

Additionally, there is another pre-existing issue in the reset handling
path in drivers/cxl/pci.c:

drivers/cxl/pci.c:cxl_endpoint_decoder_clear_reset_flags() {
...
	cxled =3D to_cxl_endpoint_decoder(dev);
	cxled->cxld.flags &=3D ~CXL_DECODER_F_RESET_MASK;
...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this non-atomic
read-modify-write operation access shared state concurrently modified
by region paths?

When concurrent device reset handling (calling
cxl_endpoint_decoder_clear_reset_flags) and region management paths
(like commit/teardown) modify the same cxld->flags word without holding
a shared lock (e.g., cxl_rwsem.region), concurrent flag changes can be
overwritten. This can cause state bits like CXL_DECODER_F_ENABLE or
CXL_DECODER_F_LOCK to be lost, leading to mapping issues or crashes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831110449.7190=
86-1-kanie@linux.alibaba.com?part=3D1
