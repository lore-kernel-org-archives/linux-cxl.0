Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C643DB327
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jun 2026 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471177; cv=none; b=nq0K/t33GijL45yZ5p85OQ5tRpeRA2JMoT0sUiM4wkGBw1Z7t83QvK6ZPC8Lny4pBS9fRjEXkwI+xhJcN+Ixb4ArSrdsFuxarKuWVV/Mdz6Fj+psaO+aTUBUIOm8nb2vUkca4AlkdLmgT/T8vKYvq+Tg1cCL0v+LT4pCZubK42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471177; c=relaxed/simple;
	bh=mXNhmBeyIPzeMh7g2sbCFp6N8PjTuqUSlTg75FdjMoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ppMcKsk2jMr8nPWWl/is+HfHXQXTQq7zqsEXbg2yyJRT7OSd8INLBBQrDDBIxQtYlazQrBH63nPkSdGxoIhFlsHyV7Yy9QyjimVKdRCYGBvjexc8kvvIcb3u9jdtzmjCrjlYJJTq4cfBPEQWRpBcFALRGJ6mYD2dYIIdZNtuM4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwNDNOsb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwNDNOsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37A41F000E9;
	Fri, 26 Jun 2026 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782471176;
	bh=xLULgvUjTGPi5AZZ3qM1+xmo4kZhIy3YFFsLDpuom6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwNDNOsbTUYZW2cOllvDpz7NnRHSn1Pu+/9e8d/k0QSfPQpaaG/su9GiH4X2/+E9u
	 Cy72FvCcUIUcUimtq9APvbbZH5VXShYk/8u+dAygmj0KlTFBlNZu5Dvp+pNq/lW4WC
	 VkaiHWcjH/tEUqQGv2IiLrd/jQQG8Fl2GxkeI8opl5klTZWXlTsjRqaBH8sKG9X3+6
	 EgTVb1dWF8YG41l7z2qOonkXU4rdDBsWLMa4Q11i9NKKyzKIgSFKVpnRjSAaIbJuOz
	 ehpV1uB0bDcIE+nj5UvfkUpgBNas/ARcEsJMRrIHOWrX3Jkav02L+QodY3QEXZUtUG
	 NaAU7ouDK11DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] cxl/features: Clamp Get Feature output size to
 the remaining buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260626104102.53892-4-icheng@nvidia.com>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 10:52:55 +0000
Message-Id: <20260626105255.D37A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent 16-bit offset wrap-around in CXL feature commands allows de=
vice state corruption.
--

commit 55606972e1fe115ff716307a2dad0a662361b0c3
Author: Richard Cheng <icheng@nvidia.com>

cxl/features: Clamp Get Feature output size to the remaining buffer

cxl_get_feature() reads a feature in a loop but passes a fixed size_out
as the output capacity every iteration. This commit changes size_out
to use the remaining per-iter size, preventing a device from overflowing
feat_out on the last partial iteration.

> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index ed18ccb5e236e..e52371f873006 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
[ ... ]
> @@ -237,7 +237,6 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, =
const uuid_t *feat_uuid,
>  	if (!feat_out || !feat_out_size)
>  		return 0;
> =20
> -	size_out =3D min(feat_out_size, cxl_mbox->payload_size);
>  	uuid_copy(&pi.uuid, feat_uuid);
>  	pi.selection =3D selection;
>  	do {
> @@ -250,7 +249,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, =
const uuid_t *feat_uuid,

[Severity: High]
This is a pre-existing issue, but does pi.offset silently overflow during
the loop if offset + data_rcvd_size exceeds 65535?

Looking at cxl_get_feature(), pi.offset is updated right before this=20
struct initialization:

    pi.offset =3D cpu_to_le16(offset + data_rcvd_size);

Here offset is a u16 and data_rcvd_size is a size_t, but pi.offset
is __le16. If a user requests a large operation through the fwctl
interface that sums to greater than 65535, the offset will wrap around and
truncate the value.

Could this cause the device to read from (or in the case of
cxl_set_feature(), write to) the wrong offset, silently corrupting hardware
feature data?

>  			.opcode =3D CXL_MBOX_OP_GET_FEATURE,
>  			.size_in =3D sizeof(pi),
>  			.payload_in =3D &pi,
> -			.size_out =3D size_out,
> +			.size_out =3D data_to_rd_size,
>  			.payload_out =3D feat_out + data_rcvd_size,
>  			.min_out =3D data_to_rd_size,
>  		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626104102.5389=
2-1-icheng@nvidia.com?part=3D3
