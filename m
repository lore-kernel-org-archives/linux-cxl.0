Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90C1C84BC
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130763; cv=none; b=VdtZ12kz13BVhGJf8xonykreD7snVBQrx/ktaBXDogO0LdI8WXbTIKihHm9NQF+icLhp+yEc4fp/pXbey4shLRYMr7bEuYVypAMpoziiL59t4rL8pLjqQVh53f8SzYoQPk5xA2bF5Af5yhTFrZelBaAJF6HadSe65NLoisGbWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130763; c=relaxed/simple;
	bh=7VFrr2dqBG6oLXrPFhTOuLfLqNNlqCzkUAImqqAbR2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i5a3TYupocn2uOytoOmZBRhod6+FrOF3L3X7ccgqFg+89HBoxsOLXT+tDpELS5hAT2oA+/ltiqOctFWO0eTpZzWJy43rSpf6mJ7mMnJzE2d9gqFKbG/84W8ym4HnScMN6KdQFGNR0dEnwvjYaglIg5FB0Gpw/ueMPS0wslJH9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eANjCZV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eANjCZV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C1A1F00893;
	Wed, 10 Jun 2026 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781130762;
	bh=l30UNXmNVT1iDi1mGmfxv4rYs4AZg0jAfC6KZcdSj+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eANjCZV6Jb35wtCgeEvTw8gTSevrYrgLut9B1W5+O289c0UVE1Rga3w0rzqhNXGv+
	 bSlBOldgXwvQITbV+jWftts/EtJ9Z5SRjEOSF01cVmbFb15Cz2JwJEkUlJs4/Fjkhg
	 Z0BWetm596E7Q+I35QSPHpMGcRxHZ2rDu0G9zN4kwQoaaQwJfcX+huatX2B2zYPV3L
	 ZjK5k1wsBSHSTtbZmXVrDXCKQXTVfEVmMwZfKS8+VdjNs+7AIeJkNeRzexZk2OgNsh
	 lAf2R1HfDafBzZyXVnEEyVq1eYCKcNt8gxtgsyo8jgI7msPKvynku7sVLBZHe72NL2
	 pG7iLfOM3PD1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] cxl/test: Add type2 support for mock CFMWS0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260610222328.2272427-3-dave.jiang@intel.com>
References: <20260610222328.2272427-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 22:32:41 +0000
Message-Id: <20260610223241.E1C1A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential null pointer dereference if `kzalloc` fails in `alloc_mo=
ck_res()`.
--

commit 93dc9b7df44c3fa959f67249d56eb6d830e6a336
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add type2 support for mock CFMWS0

This commit adds a module parameter to trigger type 2 test support in
cxl_test and sets up the CFMWS0 configuration accordingly.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index b00f5161b5f0c..e91c125d557d9 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

[ ... ]

> @@ -493,10 +512,14 @@ static int populate_cedt(void)
>  		chbs->length =3D size;
>  	}
> =20
> +	if (type2_test)
> +		update_type2_cfmws();
> +
>  	for (i =3D cfmws_start; i <=3D cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window =3D mock_cfmws[i];
> =20
> -		cfmws_elc_update(window, i);
> +		if (i =3D=3D 0 && !type2_test)
> +			cfmws_elc_update(window, i);
>  		res =3D alloc_mock_res(window->window_size, SZ_256M);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the use of
alloc_mock_res() here, I noticed a pre-existing issue in that function.

If kzalloc() fails in alloc_mock_res(), does it cause a NULL pointer
dereference?

tools/testing/cxl/test/cxl.c:alloc_mock_res() {
	struct cxl_mock_res *res =3D kzalloc(sizeof(*res), GFP_KERNEL);
	struct genpool_data_align data =3D {
		.align =3D align,
	};
	unsigned long phys;

	INIT_LIST_HEAD(&res->list);
	...
}

Since list is the first member of the struct, &res->list evaluates to NULL
when kzalloc() fails. INIT_LIST_HEAD() will then attempt to write to
list->next and list->prev.=20

Should there be a NULL check before initializing the list head?

>  		if (!res)
>  			return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610222328.2272=
427-1-dave.jiang@intel.com?part=3D2
