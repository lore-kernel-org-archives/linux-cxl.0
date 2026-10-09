Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E837A822
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584646; cv=none; b=oh8P3PHwKPfAEpk5M8mbpy0+XIaU40kSscOxO/G83shN9paiUSUpZjGxJsMf3tWL41keYmpSYAjdSV/XaG4QxFAghM3JgtDbMFIwNdHoknX7z8E0qst9T6utjmctkyG1qa569T3Q4PxTvgHZt7Bxf1vRwipzKcOJw22hgF4D94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584646; c=relaxed/simple;
	bh=3W5KPRMEQ2PjssdvYSo1ttIbSgl44NGxSMPg+JjE8OY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nK08XHovBsabb1LLAplvlfdSs1dj5e8N6PQA0QkagVgw8nlYRqwUCY5rCc7WSqBYKYe56+hRCAJzHXy5rA8dmoETm9jKHSYULlJnAKXhgBasgbu3lnpuvzPbJ8no8bTQTT0lK9Bfk2aSnfRVLYfnmmcGWXqXc8kNlvELu3GtyDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebrp1y2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebrp1y2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AA51F00893;
	Fri,  9 Oct 2026 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791584644;
	bh=STRky7WB+8xeOBY5ztCgbjhaxYXwHHMRVNSacvxg3dU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ebrp1y2x33BNCUbDb96wuKz1YFKJjd9mB3qBfZDmoa6/aTjM92CR0F73ZPW0AWste
	 19Pwq1/Yi8+6EONpaq9XZC07NB0VsoW3T6G//X5MDmG8gRKYAfkoR/IA1UkzJXCbzy
	 x5GpmOr1Tvab1KjT7Pez0OuRGuDa+hPkTLBanWNpSUYq6PCyx+jpwtGN+SNz7Aag2n
	 GlLl9mtpFf9/E9e9QtmyaGEuzvCHsuNV8Cm0YhQnZ0FPfXe2BqUo4D6To6BnMKIPKC
	 vuWqfUEKD9jWuRJHysMdtONGkTmVrzYVodtCWCskcTeP/RUU3f32Y6YsulMWbUkp1y
	 XiwMRPYKevpSg==
Message-ID: <sashiko-outbox-166129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] tools/testing/cxl: Skip the auto region when no
 volatile window is active
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <08e082b7f77318f295fe700b2ec917e0e0815c08.1791582353.git.alison.schofield@intel.com>
References: <cover.1791582353.git.alison.schofield@intel.com>
 <08e082b7f77318f295fe700b2ec917e0e0815c08.1791582353.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:24:03 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl_test: mock HMEM and region APIs still hardcode inactive mock=
_cfmws[0]
--

commit ab47ae118b5deca13e8e911d3065f4b4d5bbbf01
Author: Alison Schofield <alison.schofield@intel.com>

tools/testing/cxl: Skip the auto region when no volatile window is active

This commit updates the mock auto region in the CXL testing infrastructure =
to
dynamically locate an active volatile window instead of hardcoding CFMWS0.
It sets up the auto region only when a volatile window is available, avoidi=
ng
issues where endpoint decoders are programmed at HPA 0 during XOR interleave
tests.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index aa140307e0c3c..46a87633e9621 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -423,6 +423,18 @@ struct acpi_cedt_cxims *mock_cxims[1] =3D {
>  	[0] =3D &mock_cedt.cxims0.cxims,
>  };
> =20
> +static struct acpi_cedt_cfmws *mock_auto_region_cfmws(void)
> +{
> +	for (int i =3D cfmws_start; i <=3D cfmws_end; i++) {
> +		struct acpi_cedt_cfmws *window =3D mock_cfmws[i];
> +
> +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> +			return window;
> +	}
> +
> +	return NULL;
> +}
> +

[ ... ]

> @@ -1135,9 +1154,9 @@ static bool mock_decoder_handle_saved(struct cxl_de=
coder *cxld, struct cxl_test_
>  }
> =20
>  static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
> -				      struct cxl_port *port)
> +				      struct cxl_port *port,
> +				      struct acpi_cedt_cfmws *window)
>  {
> -	struct acpi_cedt_cfmws *window =3D mock_cfmws[0];
>  	struct cxl_decoder *cxld =3D &cxled->cxld;

[Severity: Medium]
With this patch introducing `mock_auto_region_cfmws()` and removing the
hardcoded `mock_cfmws[0]` here, should the mock HMEM and region APIs also be
updated to use the dynamic window?

Looking at `mock_walk_hmem_resources()`, `mock_region_intersects()`, and
`mock_region_intersects_soft_reserve()`, they all still unconditionally
reference `mock_cfmws[0]`:

tools/testing/cxl/test/cxl.c:mock_walk_hmem_resources() {
	struct acpi_cedt_cfmws *cfmws =3D mock_cfmws[0];
	struct resource window =3D
		DEFINE_RES_MEM(cfmws->base_hpa, cfmws->window_size / 2);
    ...
}

If `interleave_arithmetic=3D1` (XOR tests) is active, `mock_cfmws[0]` is in=
active
and its HPA base is left as 0. Will these functions falsely report soft-res=
erved
memory and CXL intersections at HPA 0 instead of the real volatile window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791582353.gi=
t.alison.schofield@intel.com?part=3D2
