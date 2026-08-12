Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7413955DE
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515970; cv=none; b=JytoWk4nb5/RSaHCEiB2BlVBdKUoJOGqDoHxDM1T1wyfo2Oh9+XrdBlExiEohDj2UcU2JObcyGqp0nO2EL7B5deZfO7B9etXLRQlJbhbJSfP0b6khtg/leZT7Lf/53Q77OfCIuX80hqUhYcHaxTMcpktczbf9fBIBlMNBNXPwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515970; c=relaxed/simple;
	bh=//Mbfs2MyhU5p9vYtU2ja9VLrC2zoz1LnHFh4Fm2SIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BH+5fI6H5yA0tvUR8dtFZgg2Ujh4A5IaKZGZLK06nY7gHG7nFw0hz1CtbjkEMcnd/AcF02MwaAVN9DAqMwFai5Cqv2bLwnDQBBQvN7V2TwlJk6heUJsL1GJpH3xZY5qpY4hVY16w9JIIJAfGYA2FJTLhOcLJ/7sYhwQfOIxAFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoZ97Ze0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoZ97Ze0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610B61F000E9;
	Wed, 12 Aug 2026 06:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786515965;
	bh=I2G5i7FerotOH2oJntvyFpVs2N7dLJ54DVKM+JjrvDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FoZ97Ze0SEQbHui89/mXdVfOC4k4g6Yb/fsYI6hKyVIYpKqugmPZe9qI/FiCf/VK2
	 uoreio3naGrLB/hVz+eI/uIe7MqYcXoAeGw4r0917oCTD/k+jB0bN1+Rkoxdx/mT8r
	 x96qNINIhpTQWjL6OD2vVpb9s+w7dVHNfId6WVKe3KV3PoPtA9xJyjSZVGdREaKsvf
	 J3ponB6NkKPdwfDrjQ+mIga3qNuTlDuyisblOavKLPJy52T44BHiMFtMy+KeXuvUCD
	 QZVX9cQuOetdvwai2sZR4F2yxtmxe82EHqOxRMOW5kQ9RDvkedgMuhVMwdJ/0ZRPJX
	 U39Objy44B1yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/hdm: Fix out of bounds read of the decoder
 target list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812061017.56916-1-kanie@linux.alibaba.com>
References: <20260812061017.56916-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:26:04 +0000
Message-Id: <20260812062605.610B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Endianness bug when decoding the HDM decoder Target List registers=
 on big-endian architectures.
- [High] Permanent port state corruption on decoder initialization failure =
due to un-reverted `port->commit_end`.
--

--- Patch [1]: [PATCH v2] cxl/hdm: Fix out of bounds read of the decoder ta=
rget list ---
commit c692efbe782398330e6841bfdd1146cdee44ef3b
Author: Guixin Liu <kanie@linux.alibaba.com>
Subject: cxl/hdm: Fix out of bounds read of the decoder target list

This commit fixes an out-of-bounds read in the HDM decoder initialization. =
It
adds a check to ensure the interleave ways do not exceed the size of the
target list array when programming the target map.

Link: https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linu=
x.alibaba.com/

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b4..9d49b48a4456e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1084,6 +1084,18 @@ static int init_hdm_decoder(struct cxl_port *port,=
 struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
> =20
>  	if (!cxled) {
> +		/*
> +		 * The Target List register only holds
> +		 * ARRAY_SIZE(target_list.target_id) entries, so a switch
> +		 * decoder cannot interleave across more ports than that.
> +		 */
> +		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: Interleave ways: %d exceeds target list size\n",
> +				 port->id, cxld->id, cxld->interleave_ways);
> +			return -ENXIO;

[Severity: High]
This is a pre-existing issue, but does returning here leave port->commit_end
permanently advanced?

Earlier in init_hdm_decoder(), port->commit_end is updated:

	if (committed) {
		...
		port->commit_end =3D cxld->id;
	}

If we fail here and return -ENXIO, port->commit_end is not rolled back.  If
initialization is retried, cxl_num_decoders_committed() will return an
inflated count, which could cause the out of order commit check to fail.
Could this permanently prevent the port from initializing?

> +		}
> +
>  		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value =3D (hi << 32) + lo;

[Severity: High]
This is a pre-existing issue, but does this code read the target IDs=20
incorrectly on big-endian architectures?

target_list.value is populated as a native 64-bit integer.  The subsequent =
loop
reads it byte-by-byte via the target_id union:

		for (i =3D 0; i < cxld->interleave_ways; i++)
			cxld->target_map[i] =3D target_list.target_id[i];

On big-endian hardware, accessing the native 64-bit integer byte-by-byte wi=
ll
read the most significant bytes first, which could scramble the port target
routing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812061017.5691=
6-1-kanie@linux.alibaba.com?part=3D1
