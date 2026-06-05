Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F553F5BFD
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685842; cv=none; b=qNJx4lCClhNMxZY80E71vqOqaaEnQFvV2npNoA++l6NQLhLicQyOI8dB/iepi7N1bEk2I4u4eRnRX42U6bqSERSZzitzurd+7n7NsEjs2m2fFGT4Mc7M285ZDRlIh1dAM/Dhy1WWS3UcpBtBia/Bj4gVDwDF7eTMY6rhEPNy/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685842; c=relaxed/simple;
	bh=tFGpafNVUTtxZewwk1taPdSOmYmbrLHhi8rvmQVv9ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lA9Bs+n5YVdZJ6EMoZJ75vyLro1cRdv7u0GFCR/EPQ8rJeVKRo9f+gtxc6SFdu6zsILdCKuNOtYHuX1e3FpRgodxx9qz8zVXDeE8pPEjthPwCUckFJHZTcchIdrPJZ6fL4gH0TUrM3d460F3DTFIdMss5aFtzJkBPzUscspIUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2pKKogd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2pKKogd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065D51F00893;
	Fri,  5 Jun 2026 18:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780685840;
	bh=jvgFFK9C1XJJtGbhSAbNELO0xAdCJj4BX7UlQ+8IJyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2pKKogdDSDDrSp1MU5x/ZJyMCKDzSnrF10txNpqlFn4aKiKmc7/xIBPPGQzDQyJn
	 YTTw7fwtUhPn/sb8rjZJGIUVuHzyLpKEcEw3iawhiCjLsSQ36FF6bRVJqnEVk/VARy
	 4f1bbtIu0hMC4AiIh7pKiTUlAVe/4WhJK/UGFJG0blxEEAT051q9mhkS1bX1KUyk1n
	 pos6Cb+W+9NONAZuxD5bsuNh+J5aa7+JELmPkYPaUrnJm8oFp5Gpi5MFdtvd4X2CGO
	 tZax7i86VpluxrMjZoyXsvv3scg7nmDx8e/MB7RlCVgfxCzi4Aov0wZ+w/HSOAQ3eR
	 5LDRUhTVoPqxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/test: Zero out LSA backing memory to avoid leaking
 to user
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605184426.4070913-1-dave.jiang@intel.com>
References: <20260605184426.4070913-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:57:19 +0000
Message-Id: <20260605185720.065D51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in mock mailbox command bounds checking allows ou=
t-of-bounds memory reads and writes.
- [High] Uninitialized `vmalloc` memory in `mdata->fw` is processed by SHA-=
256, causing a KMSAN use-of-uninitialized-value bug and theoretical info-le=
ak.
- [High] Race condition between character device exposure and probe complet=
ion leads to Use-After-Free in delayed work.
--

commit 8a5efeb3136cc5d1dd28b13e54923a6be8c62677
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Zero out LSA backing memory to avoid leaking to user
   =20
Memory through vmalloc() is not zeroed out. When this memory is copied
into output payload, it leaks memory content to user. Use vzalloc()
instead to zero out the memory.

Link: https://lore.kernel.org/linux-cxl/20260605173146.2B9A31F00893@smtp.ke=
rnel.org/

> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32c..3b68752ca7e1e 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1703,7 +1703,7 @@ static int cxl_mock_mem_probe(struct platform_devic=
e *pdev)
>  		return -ENOMEM;
>  	dev_set_drvdata(dev, mdata);
> =20
> -	mdata->lsa =3D vmalloc(LSA_SIZE);
> +	mdata->lsa =3D vzalloc(LSA_SIZE);
>  	if (!mdata->lsa)
>  		return -ENOMEM;
>  	mdata->fw =3D vmalloc(FW_SIZE);

[Severity: High]
This is a pre-existing issue, but since mdata->lsa is being updated to use
vzalloc() here, should mdata->fw also be updated?

If a user issues a CXL_MBOX_OP_TRANSFER_FW command with a large offset but
no payload, it can artificially inflate mdata->fw_size without initializing
the memory.

When reading the fw_buf_checksum sysfs attribute:

fw_buf_checksum_show()
    sha256(mdata->fw, mdata->fw_size, hash);

Does this process uninitialized memory and trigger a KMSAN
use-of-uninitialized-value, acting as a side-channel information leak?


[Severity: High]
This isn't a bug introduced by this patch, but could the 32-bit addition
in the mock mailbox command bounds checking overflow?

In mock_get_lsa() and mock_set_lsa():

    if (offset + length > LSA_SIZE)

If a large offset is provided alongside a small length, will the 32-bit
math wrap around and bypass the bounds check?

On 64-bit systems, the 32-bit offset is zero-extended during memcpy().
Can this allow an attacker with mailbox access to read or write
out-of-bounds kernel memory at offsets ahead of the target buffer?

Similarly, in mock_get_log():

    if (offset + length > sizeof(mock_cel))

Could this also overflow and bypass the limit?


[Severity: High]
This is a pre-existing issue, but is there a race condition between
character device exposure and probe completion in cxl_mock_mem_probe()?

devm_cxl_add_memdev() registers the character device and exposes it to
userspace before all probe setup steps are finished:

cxl_mock_mem_probe() {
    ...
    cxlmd =3D devm_cxl_add_memdev(cxlds, NULL);
    if (IS_ERR(cxlmd))
        return PTR_ERR(cxlmd);

    rc =3D devm_cxl_setup_fw_upload(&pdev->dev, mds);
    ...
}

If userspace immediately opens the device and issues a CXL_MBOX_OP_SANITIZE
command, it schedules the mds->security.poll_dwork delayed work.

If a subsequent probe step like devm_cxl_setup_fw_upload() fails, devres
automatically destroys the mds state.

Since devm_cxl_sanitize_setup_notifier() either hasn't executed or failed,
the teardown notifier that cancels poll_dwork is never registered.

Will the pending work execute later, accessing the freed mds structure and
causing a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605184426.4070=
913-1-dave.jiang@intel.com?part=3D1
