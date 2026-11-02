Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655032;
	b=LtdB2DmTle1J477/0Vz0qKdTU47BaqPEaYY0rfemi4/+f2hvXOutZ7zKQibuSdby8jKQ
	 WJkynrFwfHY787IcHLiOLzsWEh3F24kWlPXwVHgBTqqSaHZB1l1b+Zck5zpm3QfQQj8nx
	 CLRkTphzAABNU50rc/soMVBVMsW72gCZ8ceX/fFSRY3K7MjNVB8lCgG3j0ha8DcIOiwqg
	 DolGzGmeGHEh5j82nCIYhRxnUbBtIdymg8f/P9QxioDJgo2Z3MoHgcT1AyeB5hFfP2kiA
	 s63KanCWzz83KW1RehxdB6rVzv91QbJ10tJuuzTO9NEtSpIyoamROmlhC6DoC7pS6MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YOjPM2J1+d4U1pBAPxA3pvCaUi5KcfdRPs1hi1i0vGI=;
	b=Jjc/V0Z/8gVmhD1LrH6nuSPW1js55btNye1hDJM13yfaovPdLchVRHJ5cNPVu+dYBa5l
	 AU1kCns5vSyC4tn3wd7W5Sv+ddGyvky6jkX0LXqnL214nFqCOBSCVFvmd47EiSMWLFiMz
	 x36Ai9jpaVjf8Chxln87tuoufMO7OhlDJRgH7AVw/nk63ilWAr1Hx7HOhoBASK+NwfWda
	 rmKIFlQ0lwFOasWbzNXQu/Vyqf30CZwxmY/HGGUZl0RS4ODa7mhYmRHuVHj5MqI8Tnkl8
	 wWkRjnyOkzKQG6WdEAxm+gsfeOBkGuIclysQwix9ttygVwkBZz+kSErmOj3uL8v2iZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7c0gu1s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7F606D801
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7c0gu1s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13051F00A16;
	Mon,  2 Nov 2026 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655031;
	bh=YOjPM2J1+d4U1pBAPxA3pvCaUi5KcfdRPs1hi1i0vGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7c0gu1sI3JZkmTnW+U52My7IbZzZkFzIXTsHKfrmtlynbSmrwyussPl1gB3QoOXD
	 CSVPkiCwDpj0S7zYEwj8xZxJEjdWO11wMRurY4BjBOrJ6GVLMbRn5EwBqYKQ6icPB2
	 9KSFrJZGJX6BQ6uYbNT1IGuLTac2XnRl7uMK5JjpBfJfj5VHQWWslL4wEkphdQiij9
	 6BdM7xN53FyLHv7sSPsBF+ymUcvA1I/lhEKNyd3BrcPU7OzyqAU+OA5+HxZ7dIomin
	 6bTAAePJZQjKLKtwNoeW5vgr8vgPEB0Bo+n7Ic98YB2TO9A0EUaPUM/3StL1bRLiji
	 dAkgf6Ou5b2gQ==
Message-ID: <sashiko-outbox-194200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
References: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:30:31 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl/region: duplicate occupied-position check in cxl_region_attach()
--

commit 8e6a6e0273b1dca525bf14e3930192ed09907f10
Author: Alison Schofield <alison.schofield@intel.com>

cxl/region: Reject a repeat write of an endpoint decoder to targetN

This commit rejects repeat writes of an already-assigned endpoint decoder to
a CXL region targetN sysfs attribute with -EBUSY before modifying region
state.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb6..90226327e03c8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1764,9 +1764,6 @@ static int cxl_region_validate_position(struct cxl_=
region *cxlr,
>  		return -ENXIO;
>  	}
> =20
> -	if (p->targets[pos] =3D=3D cxled)
> -		return 0;
> -
>  	if (p->targets[pos]) {
>  		struct cxl_endpoint_decoder *cxled_target =3D p->targets[pos];
>  		struct cxl_memdev *cxlmd_target =3D cxled_to_memdev(cxled_target);
> @@ -2130,6 +2127,14 @@ static int cxl_region_attach(struct cxl_region *cx=
lr,
>  		return -EINVAL;
>  	}
> =20
> +	/* Already at @pos: fail before changing any region state */
> +	if (pos >=3D 0 && pos < p->interleave_ways && p->targets[pos] =3D=3D cx=
led) {
> +		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
> +			pos, dev_name(&cxlmd->dev),
> +			dev_name(&cxled->cxld.dev));
> +		return -EBUSY;
> +	}

[Severity: Low]
This isn't a bug, but once the early return for p->targets[pos] =3D=3D cxle=
d is
removed from cxl_region_validate_position() in drivers/cxl/core/region.c,
doesn't the immediately following block in cxl_region_validate_position()
already handle this case with the same dev_dbg() message and -EBUSY return?

drivers/cxl/core/region.c:cxl_region_validate_position() {
	if (pos < 0 || pos >=3D p->interleave_ways) {
		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
			p->interleave_ways);
		return -ENXIO;
	}

	if (p->targets[pos]) {
		struct cxl_endpoint_decoder *cxled_target =3D p->targets[pos];
		struct cxl_memdev *cxlmd_target =3D cxled_to_memdev(cxled_target);

		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
			pos, dev_name(&cxlmd_target->dev),
			dev_name(&cxled_target->cxld.dev));
		return -EBUSY;
	}
}

In cxl_region_attach(), cxl_region_validate_position() is called before
cxl_region_attach_position(), so attachment only proceeded previously
because cxl_region_validate_position() returned 0 instead of falling through
to the p->targets[pos] check.

Also, placing this check in cxl_region_attach() ahead of the
CXL_REGION_F_AUTO branch means that if an auto-discovered region is partial=
ly
assembled (with cxled staged in p->targets[pos] by cxl_region_attach_auto())
and userspace writes cxled to targetN via store_targetN() -> attach_target()
-> __attach_target() -> cxl_region_attach(), it will now return -EBUSY
instead of reaching cxl_region_attach_auto() and returning -EINVAL for
pos >=3D 0.

Could cxl_region_validate_position() simply be called before
cxl_region_perf_data_calculate() (or inside the manual attachment branch)
instead of duplicating the bounds and p->targets[pos] check in
cxl_region_attach()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3e5af9d6d59f8df52b9=
d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com?part=3D1
