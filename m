Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999F2E7394
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 05:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780118253; cv=none; b=GWNOhY3ohOCTV2GqcjxLQ61FpbGdRgAilF63lTi3pqXAi+E+6FmVvWc4phH4t2vyrCFyjoygmX71u5WDOhMc/1Hda9xR4CBX3g2JU8iwErg8twNMlS3jzfBMQPjqWK4houiyDwdvRAMSyDOIk2uDcPZENFesWVjsA+YNf750C/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780118253; c=relaxed/simple;
	bh=VgRZ1zNt+qIJPs0WzjpRdWKRhWobBn2J1o6P+L8VkmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ssr+d3KaFdmgvl1T/xDyD6Nz0GNEWc09NRKqM1KUGBHDjtoOIz7pdpoLO86UpjCsXAw7gHTpsXrnQZFu1sv+faIYigyGo1ShxYLFDdwcTt/kTMpo+LjZVgZ77atkNhSL1hsbVDO79entYeFm3foTUG1zHBBHUbHuGpAodBqt26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRXp60xP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRXp60xP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A75D1F00898;
	Sat, 30 May 2026 05:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780118251;
	bh=99Ai/0zwwFDVL8RgphHe1K2sUnKGpAC+BjdH9n1XLCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BRXp60xPymfpuhaGHKC4jMKS/5w7MUeVljQ6OvTT9JeKDvypBvLIkfjclJchrk82B
	 SImasHnbGrxaTGQEoO10cXzldrYHgWtlfr767C+zNSEgJwVqwo5gBg06wfRa7pCzum
	 7jmeWonGTC0yH2CSQk64mnO8Ys7Thfrzcb4TfK1RjJdD8Ibw2YM79qcFouUbp9HkfW
	 7RDmpWxI1Lra+7lRqr0xYuXwu9uDWy8xluECCB3BJb0b3+tvV/TbcMjI7PZPPlwkoX
	 nby69T7xgd4RK2AyQYIJb661HF74Hn2fDN/stzhr2fyz9k0CFrlFy9eLx+dCDWl/3u
	 TqJLEjUut/Yvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] cxl/test: Add a topology to test mixed-granularity
 regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <2ab2466fafa96f07df65ee5f6b4f8511240f4c93.1780095671.git.alison.schofield@intel.com>
References: <2ab2466fafa96f07df65ee5f6b4f8511240f4c93.1780095671.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 05:17:31 +0000
Message-Id: <20260530051731.9A75D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Evaluating `&array[i]->dev` on uninitialized legacy topology arr=
ays causes Undefined Behavior when `mixed_gran_regions=3D1`.
--

commit 8ff651f212fbb657c03e4fc54d032f721af040e6
Author: Alison Schofield <alison.schofield@intel.com>

cxl/test: Add a topology to test mixed-granularity regions

This commit adds a cxl_test topology for mixed-granularity region coverage.
Setting the module parameter mixed_gran_regions=3D1 creates three host brid=
ges
with two switch levels below each bridge and twelve endpoints total.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb00..b44db749873f3 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

[ ... ]

> @@ -130,6 +172,9 @@ static bool is_mock_dev(struct device *dev)
>  	for (i =3D 0; i < ARRAY_SIZE(cxl_rcd); i++)
>  		if (dev =3D=3D &cxl_rcd[i]->dev)
>  			return true;

[Severity: Medium]
When mixed_gran_regions is enabled, cxl_test_init() skips initializing the
legacy topology arrays by jumping to the topo_done label. Could evaluating
&cxl_rcd[i]->dev (and similar legacy arrays like cxl_mem, cxl_host_bridge)
cause undefined behavior here since those arrays are now left filled with
NULL pointers?

> +	for (i =3D 0; i < ARRAY_SIZE(cxl_mem_mix_gran); i++)
> +		if (cxl_mem_mix_gran[i] && dev =3D=3D &cxl_mem_mix_gran[i]->dev)
> +			return true;

The new arrays correctly check for NULL before evaluating the dev pointer
offset, but the legacy array loops preceding it in is_mock_dev(),
is_mock_bridge(), and is_mock_port() do not. This also affects functions
like mock_init_hdm_decoder() which unconditionally checks against
&cxl_host_bridge[0]->dev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780095671.gi=
t.alison.schofield@intel.com?part=3D5
