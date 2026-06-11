Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB1380FFA
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781222187; cv=none; b=FKv2x16MqptJpIIf3NgActjkcqFAXmFBQp49Na+4tNiotFOrrHk4kV7WVlu+p9Fg4+Dr7ld/qy1DsmDhfVP9fCwa5yNadHbp75Qd7jZV7N9J4t6cVsLhQROJGkryND+eYRADybhtVN1f1PBlS5//Gx3LvPstheNC+t0zDB0LJcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781222187; c=relaxed/simple;
	bh=1+/fTv8Z4OSojLpOkQGt6RmDEv41cjBxlgtkGl3Jgt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YGgstsoDjY625OnmPkkF65hVybD2J3NrWyvLN/nCYmsuRxo6CSNTHBagV1kHyT3NQnoLreUjoHjV4lxwQFSVEOLghh0WYw/l14O9w4Fyv889CXZ8FUZxQAGaAhNTFi/oruSElTvWPjTDULEi1xo8WAgnESH+6D1obDEWhqN2r2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAhBENTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAhBENTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1BA1F000E9;
	Thu, 11 Jun 2026 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781222186;
	bh=1RkTqYAz7hYC0lc4mFfauhO4PALxMCCST9Qbm5gJZmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lAhBENTe9Lq9K+r1XIqNoiRmeJlsqZsAgLWv/EOQcW/KkcAa+z8sCF7LGv6fqJ2tL
	 jNGLsPv+vkqEWTuKNudN6bYge28wJB0Pz6ZrKpUqXwA5LvUlMN52iLCRh9tm8mbUhZ
	 cFgMLWNgSBM7IrXASUcijpuTD4LSREeyXXHXSozLZcSUUpFRRrYHQ2RHtywMgXCmsE
	 WNCtmrSiRMqpTHJRWlbLY62myYZUF+uNrpDOvcP/mDq9+tthqfNB5uOcDbwN0Hg/Ce
	 JiD3F50A2/hMRC3Pb1pn5BJo+SX5kKrThtJeVqxEg1kv6vN9/Ua306H9xXmbd8zEoI
	 YYC5h/KIf9CDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] cxl/test: Add type2 support for mock CFMWS0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611234409.256765-3-dave.jiang@intel.com>
References: <20260611234409.256765-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:56:25 +0000
Message-Id: <20260611235626.1E1BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] alloc_mock_res() unconditionally dereferences `res` even if kzallo=
c() fails, and leaks `res` if gen_pool_alloc_algo() fails.
--

commit e10eed6f5b8f0ab41fd5d070bd75f2b5f0d1bef4
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add type2 support for mock CFMWS0

This commit adds a type2_test module parameter for triggering type 2 test
support in cxl_test. It also updates the CFMWS0 configuration to be type 2
when the parameter is set.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 1c8ac8bdd8f7a..c5529cee482d4 100644
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
This is a pre-existing issue, but I noticed a potential problem in
alloc_mock_res() which is called here.

Does alloc_mock_res() unconditionally dereference the allocation before=20
checking for success? Looking at the function:

alloc_mock_res() {
    struct cxl_mock_res *res =3D kzalloc(sizeof(*res), GFP_KERNEL);
    ...
    INIT_LIST_HEAD(&res->list);
}

If kzalloc() returns NULL, won't INIT_LIST_HEAD() cause an immediate NULL=20
pointer dereference?

Additionally, if the subsequent memory pool allocation fails:

alloc_mock_res() {
    ...
    phys =3D gen_pool_alloc_algo(cxl_mock_pool, size,
                               gen_pool_first_fit_align, &data);
    if (!phys)
        return NULL;
}

Does this leak the memory allocated for res by returning NULL without calli=
ng
kfree(res)?

>  		if (!res)
>  			return -ENOMEM;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611234409.2567=
65-1-dave.jiang@intel.com?part=3D2
