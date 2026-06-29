Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840A38E5D4
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765422; cv=none; b=rPHRGkLo4dd+/8Q48Em5cxqVckRvJJMU15MPYFjQw5X0HkRvyLKlirBrNcBI1Qp6eWNfoh1+9pMGrKTSyinDU82jkYAi7Fzt1IBAs6CkV3GDiJW5m/rlM8HvEfsIBOXMvFedGOR8zH2wusNxnsKdtW9oWlnkfnkh0sQqdiYHkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765422; c=relaxed/simple;
	bh=IUPBtV92RrzqU0S3/m/DDs4Y0ZxapPNweyr7HCXPY/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LUjgtEUWGUHnBEFEvv8RYKhX0AjQ9CdjHlGP4ZEZOVDousHILMPX+9rXWRi1b3iCEuA3Sjyp4YtiNVe5/StbLGfZF1nlN8rnRxM/oVHBAEPDRhn4Bq4cHRMVsoxNKfsyi0O7z4oA34MVkUkQ2dfFsBYFkpoHyJAeIvSig/Hjn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXOBODH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXOBODH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A51F000E9;
	Mon, 29 Jun 2026 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782765418;
	bh=C6BMtpS1lbCKRuTZkT0fxFWN1hIgcrDkPP3KNm1e02E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXOBODH0A2Vxo4qpupyi31sU79iPSTi7i212em6ITMYzOYfPeOfYLw3ixVKDUsp7J
	 y1ElrzEG9HWH4ldH5HaJMokATcKRrP6LDG+8fz9z6TgAbqeMrY5yKzxOInmqKX9C4M
	 E0T9IDFCg1DCYW6TudwFuXentRpbBK5KS0/++0J7fo+Cd2U24lCB71SB0tdtPC2kLP
	 shey5S4xsGZ6RucVWzlhmv17itEZ1E51EHxZydHqjkRc6wvEpSSSjj/K4LsoUtnUjl
	 KZD6aCC4XzwBWnAcNEufwn5vcMnGAhKs6yDVQA1nFkezJV1xK6cWJ3SCfXYtp7AfMF
	 Pw9ucqftddUgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] cxl/test: Add hierarchy enumeration support for
 type2 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260629202720.3658117-5-dave.jiang@intel.com>
References: <20260629202720.3658117-1-dave.jiang@intel.com>
 <20260629202720.3658117-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 20:36:57 +0000
Message-Id: <20260629203658.574A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The error path for cxl_test_init() incorrectly replaces platform_d=
evice_unregister() with platform_device_put() for cxl_acpi, leading to a re=
source leak and potential use-after-free.
--

commit 74917ddebbac04cd137d2f935b0132cdc7d979fe
Author: Dave Jiang <dave.jiang@intel.com>
cxl/test: Add hierarchy enumeration support for type2 device

This commit adds enumeration of type2 device hierarchy in cxl-test. The typ=
e2=20
device is configured to be directly attached to a root port instead of the=
=20
rp -> switch -> device setup used for type3 hierarchy.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 8abe066080bc8..1eac06ad46601 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> @@ -2156,17 +2314,9 @@ static __init int cxl_test_init(void)
>  err_mem:
>  	cxl_mem_exit();
>  err_root:
> -	platform_device_unregister(cxl_acpi);
> -err_rch:
> -	cxl_rch_topo_exit();
> -err_single:
> -	cxl_single_topo_exit();
> -err_switches:
> -	cxl_switches_remove();
> -err_root_ports:
> -	cxl_rootports_remove();
> -err_host_bridges:
> -	host_bridges_remove();
> +	platform_device_put(cxl_acpi);

[Severity: High]
Does this error path properly tear down the device if cxl_mem_init() or
hmem_test_init() fails?

Since cxl_acpi was already successfully registered with the driver core via
cxl_mock_platform_device_add() earlier in cxl_test_init(), it seems
platform_device_unregister() should be used instead of platform_device_put(=
).

Using platform_device_put() here only drops the initial allocation referenc=
e,
leaving the device actively linked in the platform bus and sysfs hierarchie=
s.

Because the module unload upon initialization failure will free its memory,
could any subsequent access to the device's sysfs files dereference invalid
memory and cause a use-after-free?

> +err_topo:
> +	cxl_topo_exit();
>  err_populate:
>  	depopulate_all_mock_resources();
>  err_gen_pool_add:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629202720.3658=
117-1-dave.jiang@intel.com?part=3D4
