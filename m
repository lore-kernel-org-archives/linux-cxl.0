Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122993EE1C0
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471249; cv=none; b=gzCJt/j2DpwLGNFPLQLhDHyAyxHy4AMAs4fJJVQHASoBjE4VPEWN1vlzRCog9Wn1/I5d6Kgw0ZILtl+xmtc7xm1B0vGozI+HJ5bpA/rd6rfBBRqipuOxNrI+a4cdFv00LBRyu/z80x6oPgSqzWf1rkyKzVa0/21aTrf+lR7td+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471249; c=relaxed/simple;
	bh=OUvHV3fMlW/hVwpNpdaIOVuylhGyPYHrncJMPCqUVRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fj/P0/oO057fs7Npi0tt6IzrRozyxfmWR3Rbc/wwnpvxawX/4BQ6XFe5ZW/S5opMI/C6IrUpQkgYSPNOaJDmNN3C/9z+wzG8qNY1KImyBWsaYjaeZSI86Q2zOEJZ38C7jWp1Zpbt8BaN49qd+GTeMQDCKHLTcb3tJAnnH6GorII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwbE3DRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwbE3DRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909B31F000E9;
	Fri, 26 Jun 2026 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782471247;
	bh=je52HL5nH/7UhgrU3LV73BayizzjyDzy5i2/I4vzK1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QwbE3DRGZ1ZGwBu9SncSZeWhQbZfz1bVURZ9B+9ypnoG7MrsMm49gQHtyIBC66DjZ
	 CaFi4X9YBtq6foTlmK6Dy21rbHVq98u/Av2iWTXqnjwmrKUIdYKSBI8Lnr9HykHTi8
	 fYAwx1jomwVC0kVxd48dXjixyDGAISl1atbhvwoT4K43/NQwgVtB3SPK21jjDhnlmk
	 HmDDdGaItHUnK975t64Gw5A22pM9wWbYZCftzduqiHEHjIEfDPPet0nJLJbLKYFH5y
	 a/AD03aGqdMRNPwDnvQrw691Ff7Gcxm9Txc1E9ozjHbjKPJKxMS75kyWe68rQvZyiq
	 VCaPBpRp7zaaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] cxl/features: Reject Get Feature count larger
 than the output buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260626104102.53892-2-icheng@nvidia.com>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-2-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 10:54:07 +0000
Message-Id: <20260626105407.909B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds checks on user-provided input length in `cxlctl=
_fw_rpc()` and `cxlctl_set_feature()`, leading to out-of-bounds reads and p=
otential ZERO_SIZE_PTR crashes.
--

commit 1f7098b182e4cdaf480b19545ca818cbf043bd29
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Reject Get Feature count larger than the output buffer

cxlctl_get_feature() sizes its output buffer from the user's
fwctl_rpc.out_len, but the device is told to write count bytes into
rpc_out->payload. This adds bounds checking against out_size to prevent
overflowing the allocated buffer.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 85185af46b72d..9c714ee42a411 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_=
state *cxlfs,
>  	if (!count)
>  		return ERR_PTR(-EINVAL);
> =20
> +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> +		return ERR_PTR(-EINVAL);
> +

[Severity: Critical]
This is a pre-existing issue, but while we are adding bounds checks for
the output buffer here, does cxlctl_fw_rpc() also need to validate the
user-provided in_len?

If the ioctl is called with an in_len of 0, could dereferencing
rpc_in->opcode in cxlctl_fw_rpc() lead to a zero-size pointer crash?

Similarly, in cxlctl_set_feature(), the operation size is calculated without
verifying in_len:

    data_size =3D rpc_in->op_size - sizeof(feat_in->hdr);

Could a small in_len combined with a large rpc_in->op_size result in an
out-of-bounds read, copying adjacent kernel heap memory into the hardware
mailbox? Would validating in_len against op_size in cxlctl_fw_rpc() prevent
this?

>  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =3D
>  		kvzalloc(out_size, GFP_KERNEL);
>  	if (!rpc_out)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626104102.5389=
2-1-icheng@nvidia.com?part=3D1
