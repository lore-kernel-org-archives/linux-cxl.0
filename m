Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9F3B47FB
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916779; cv=none; b=XbM7tvWPeKPpeZFE8B1W6Ahh6gUuyZcn2AXYr9+XiCAQBOEHcede74rrsclTTjc+xAqUC3WjvomGqKg2gK5HnBx7URq0qeOPeecN4O2d+phehQoX7YdG7tObcQqELwQaUxzjTEYYz36mWp5SdxNAqX10JdXhN13bXmRZIbpHzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916779; c=relaxed/simple;
	bh=x6wkN/uTvY8TwSKF+uzCv2kJIWR95MzYD1cWlk2GOLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b6Y4FOEuH9L/OwxU+PXfT5Lj11sSAwhHCMuivpoUAldj8Flg0SJI8btUf0AIyuULwlVpfu/IdxrCTMD1xJ57/meaxuG/11zLR25SgMJ3GcUr4rG6wGf6iS3SW1XPcD3NWBss21j8ve1vATwgrWqdX1V3XagmCeXorKGjY6fmcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hchT4opd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hchT4opd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC791F000E9;
	Wed,  5 Aug 2026 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785916778;
	bh=s3uFNNlH0JI52bLdkI62FqrMwJT5MV+h4yxOgcmpqaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hchT4opdN0Y06Ry51sP7J68OFdzcwjjFEEgmHxRDBqoXK0EloECU2JJxhNa85im9L
	 3Qc6xKlenEpJU+5L1mpNHjZukNrftvEDbGnD/RDbPrze1ysV4CMYJVdLrbj3V5/SMS
	 9G75IYXF9COnoeDVoU5DWv1/gyPW4zT9M5wfadyK0SboQ4yiCvOwmVub7CLuSCf3nr
	 wFVntUPpjdzWRef4LBsxor4dZtUnm68b7hFQsiO09huZDXbE0tLrZ8hBRR+Qjwfegf
	 0rJoqi/6zBRiLXe6iftmUco99gICkhtP++pwWWbASM5cFL2sc1r426acOKPO9EMnXu
	 dA8huTx0gisIw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] cxl/test: Exercise Type-2 automatic region
 creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260805074042.30173-4-icheng@nvidia.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
 <20260805074042.30173-4-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:59:37 +0000
Message-Id: <20260805075937.DAC791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Failure to restore a previously-enabled manual decoder permanent=
ly destroys its manual configuration across unbind/rebind cycles.
--

--- Patch [3]: [RFC PATCH 3/3] cxl/test: Exercise Type-2 automatic region c=
reation ---
commit e8d600bcac1235041afc295954c1b2f226a9c8d7
Author: Richard Cheng <icheng@nvidia.com>

cxl/test: Exercise Type-2 automatic region creation

This patch adds a second mock Type-2 accelerator with an independent
single-target CFMWS and an uncommitted manual DEVMEM decoder. It verifies
that devm_cxl_probe_mem() creates the missing region and preserves the manu=
al
decoder config after reset so the fallback remains available across unbind =
and
rebind.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8ab2ce1262f30..305a0c3705da4 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

[ ... ]

> @@ -1121,7 +1159,9 @@ static enum cxld_init_type get_decoder_init_type(st=
ruct cxl_decoder *cxld,
>  			    MOCK_DECODER_INIT_TYPE3_AUTO;
>  }
> =20
> -static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct c=
xl_test_decoder *td)
> +static bool mock_decoder_handle_saved(struct cxl_decoder *cxld,
> +				      struct cxl_test_decoder *td,
> +				      struct platform_device *pdev)
>  {
>  	bool enabled;
> =20
> @@ -1133,6 +1173,11 @@ static bool mock_decoder_handle_saved(struct cxl_d=
ecoder *cxld, struct cxl_test_
>  	if (enabled)
>  		return !cxld_registry_restore(cxld, td);
> =20
> +	if (is_type2_manual_decoder(cxld, pdev)) {

[Severity: Medium]
If cxld_registry_restore() fails, does this bypass the manual fallback logi=
c?

Looking at the preceding lines:

	if (enabled)
		return !cxld_registry_restore(cxld, td);

If the decoder was enabled but cxld_registry_restore() fails (e.g., due to a
DPA reservation error), this function returns immediately.=20

Since cxld_registry_restore() internally calls init_disabled_mock_decoder()
on failure, the decoder is forcefully reverted to a HOSTONLYMEM state inste=
ad
of the intended DEVMEM fallback state.

Would it be better to fall through to the is_type2_manual_decoder() check
when cxld_registry_restore() fails, so the manual configuration isn't lost
across unbind and rebind cycles?

> +		init_type2_manual_decoder(to_cxl_endpoint_decoder(&cxld->dev));
> +		return false;
> +	}
> +
>  	init_disabled_mock_decoder(cxld);
>  	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805074042.3017=
3-1-icheng@nvidia.com?part=3D3
