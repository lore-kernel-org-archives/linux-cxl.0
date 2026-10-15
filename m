Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB87381B0A
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044004; cv=none; b=jrpXD6E7Q20Xw1wCtbAE1ShWqk4Eae+IxrRHDbngurv5XyKbBKHd/6BjMoKzvI3Zos6mbki0o1TDNB31GsNRiGxwWum+EghBJ1tv4Sag7pxvUp+SBZqtGzT76xTFTRXOUniwYAgF5v1X9+PqYDVJpWtUWthMLRChch01ERGaa90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044004; c=relaxed/simple;
	bh=UXPB+iznH867aSCbpL68ivwTIAgzb17gEZEzmp+J8Io=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=k67Qd5O67T6rxPj5XGp2WBZ8X32XGKdbL7tsYEm5VkipaT+U1k76ixdZvAY8AmkYdV6/xLqlRHeGwwKn2MNJaaPqCC1aQwCuoyybOCSu84qTlPetyhDiPlTyxq7xgxd0QSFFRNYDtQsIlgi7+bhHlIIU9GoYD65gCd2LWGJH9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IydS6F9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IydS6F9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9B11F000C8;
	Thu, 15 Oct 2026 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792044002;
	bh=YJYM536aOF+kkZ8murHjqJlCnhbMb9Uy7uHhhnCfMas=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IydS6F9bPjF7XVcSKjvd7dV27x5jARH58Ij/HGYP3q/70DazjOrahrkIpSMz9kHUy
	 QKaxjOFR8HQUCWQy3Y208TAuug9maJBJDYpWfe3eBR4+vqEh9kD5yamGlLwQsOhxCY
	 eGVD84b+l4xoimj35SFBzAyCzMAzEX0ijtd1xDtsD4OdTDsTTyO03UE3aODuNc8yZ4
	 EPs44Xp6lRuaN9esZw2MnsJHiW384qmOeLRJsS23LqHoWsp6S+qY9QVK9ODqzvZ+RN
	 5A4JAQ1tdRlM4lQP+/mTBxdvPzM4G7/FFqOZk91ZpeRnQstiW3ZpvXcrbXLCmfBfZB
	 k04j9JIlR7pOA==
Message-ID: <sashiko-outbox-172326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/mbox: Add the CXL 4.0 command return codes 001Fh
 and 0020h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaobin Huang" <huanggaobin23@semi.ac.cn>, linux-cxl@vger.kernel.org
In-Reply-To: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
References: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 06:00:01 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl: OOB array access when parsing hardware return_code
--

commit 15edb1196288251867601cc5b50acf1789f0b357
Author: Gaobin Huang <huanggaobin23@semi.ac.cn>

cxl/mbox: Add the CXL 4.0 command return codes 001Fh and 0020h

This commit adds two new command return codes (001Fh and 0020h) from the CXL
r4.0 specification to the command return code table. A device reporting
either code was previously described as an unknown return code, and both are
now mapped to -ENXIO.

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06f..43f29564c1050 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -190,6 +190,8 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_p=
ort *port,
>  	C(FEATURETRANSFEROOO, -ENXIO, "feature transfer out of order"),		\
>  	C(RESOURCEEXHAUSTED, -ENXIO, "resources are exhausted"),		\
>  	C(EXTLIST, -ENXIO, "invalid Extent List"),				\
> +	C(TRANSFEROOO, -ENXIO, "transfer out of order"),			\
> +	C(REQABORTNOTSUP, -ENXIO, "request abort not supported"),		\
> =20
>  #undef C
>  #define C(a, b, c) CXL_MBOX_CMD_RC_##a

[Severity: High]
Does this code overflow the cxl_mbox_cmd_rctable[] array if the hardware
returns an unknown code?

Since the return code is read directly from the hardware mailbox status
register:

drivers/cxl/pci.c:__cxl_pci_mbox_send_cmd()
	status_reg =3D readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
	mbox_cmd->return_code =3D
		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);

Could a buggy or malicious CXL device return a 16-bit value that exceeds the
size of cxl_mbox_cmd_rctable[]?

When cxl_mbox_cmd_rc2str() or cxl_mbox_cmd_rc2errno() uses this untrusted
return code as an array index:

drivers/cxl/cxlmem.h:cxl_mbox_cmd_rc2str()
static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
{
	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
}

Could this result in an out-of-bounds access that crashes the kernel when
attempting to dereference the garbage .desc pointer, or return a garbage .e=
rr
value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015055048.1765=
042-1-huanggaobin23@semi.ac.cn?part=3D1
