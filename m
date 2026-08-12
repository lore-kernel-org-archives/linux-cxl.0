Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA133F8C1
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538470; cv=none; b=uqCVOPY+nMk6Vwx+jhKiBGmD7wIs8C1qfgdN09i9qsJJoammbciUZX8mKcJ2G89U4onAvOo/9+rgT5fEJIXnJr6nSDA4Q95o6SflMY5fUtQF0/4Jl5dS69hfnJ2TiZE50jzZ1JpFvXy/Qcy8MTTpQi8I8aEn3vWNbsb8SRRvkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538470; c=relaxed/simple;
	bh=R0hS0nW1ENGKtn1A+JCZUXuxoxuGBD0uCIeCZ3Y/gTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BSsvNqG0nntgEfZdu2ihk7/5j9c+Si+1VKEVj0At5Zv0FGQw29GjsXkBJRZKH6asJNliwHUfcOc2jHh/21anTtVxfZj84NVvrHmUPAXS5u0+1UAwZjkYMUI2W/EOcD8cW6NKBai8ldQpunYDi9CCCuQMjhWd1pEZrSiyPCt19ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9Cre0OC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9Cre0OC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974531F000E9;
	Wed, 12 Aug 2026 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786538468;
	bh=IF/YwNd6aaAGCdC7cSl6X4drsouMXou7mIe1sw/tAAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9Cre0OCP2sojzW7yVuq2EoAC2nn1TzAZGCjV/x5oMy08VbibbycXUk1PlgPr7EjI
	 QF52QYOm9YleEkimmG0ihdd8M5uQMMVUlaO6KQB/SHQ7KqQMgUPSdEg2jZEyCjDPHZ
	 3wCgM4PEt4DoVbhpnxM/SwLfP8FxUDD83V6MzVN3o5ByWJgoh3E/9w91Z54px9NEcy
	 KxnbeInXi97+vvi5JKtvKWdH1KJIORWxsp+rwYhV60Sml7l+J/I6XDYb1IcnTRjT0K
	 5voJOTSK/fzGq8WFbnbJVL8negOwWBUjZTSdix7Jt8uMa9eQZovmKElvis8snmb9yp
	 Vj0xcmM9o+riQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] cxl/region: Reject poison scan for decoder
 without a partition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260812112107.56181-7-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
 <20260812112107.56181-7-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:41:08 +0000
Message-Id: <20260812124108.974531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Returning `-ENODEV` for an unmapped partition aborts the entire =
poison collection iteration.
--

--- Patch [6]: [PATCH v4 6/6] cxl/region: Reject poison scan for decoder wi=
thout a partition ---
commit 8cb40391df3fd49e0cd36f0f034423d0470da73b
Author: Richard Cheng <icheng@nvidia.com>

cxl/region: Reject poison scan for decoder without a partition

__cxl_dpa_reserve() may leave cxled->part at -1 when a decoder's DPA
range doesn't map to any reported partition, while still keeping
dpa_res. This commit returns -ENODEV before accessing the partition array
when no partition was assigned to avoid an out-of-bounds read.

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b7dc5d4988da7..afe3fb57b7fe2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, vo=
id *arg)
>  	cxled =3D to_cxl_endpoint_decoder(dev);
>  	if (!cxled->dpa_res)
>  		return rc;
> +	if (cxled->part < 0)
> +		return -ENODEV;

[Severity: Medium]
Since poison_by_decoder() is used as an iterator callback for
device_for_each_child(), does returning -ENODEV here prematurely abort the
entire poison collection iteration?

If any decoder on the port has an unmapped partition, returning a negative
error code would halt the traversal. The sysfs trigger would then fail with
-ENODEV, skipping poison collection for all subsequent decoders.

Would it be better to return 0 here to just skip the unmapped decoder and
continue iterating over the remaining ones?

> =20
>  	cxlmd =3D cxled_to_memdev(cxled);
>  	cxlds =3D cxlmd->cxlds;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812112107.5618=
1-1-icheng@nvidia.com?part=3D6
