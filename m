Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072572EA754
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192312; cv=none; b=GjldDggJgk3bk6rLf4W5BAYFIKUc416Fxz2TqVAvRVJR4CNmiERJ1r+Ydyc0jAvJehrtMb4BW+wSAJ760zpgKhe1pEmhXUhKkH3+mRoypmwPeEPnVLlRytQhDgU2pVLS04Wzpbk2ImNUX+f018om58JCziaxts9JnvXaISp74EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192312; c=relaxed/simple;
	bh=4BmGvw8dpkzxwJ+UTq1r2eC7cw5K/T/IrqWiMU7H0OM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IqlBXq4t5oJd7eVs8bUl+Uc0XhFXYIj+a+p4MTyUflCJMNRTMKyXaFBKilR7+EG4qZ6yTYhexNS3sMh4sp/S4ivKDgwDIhYfKC242P91csk3Pw1DRlOcp7VXjEJRd0o46rAw1qGDLwb4vkW61uhP6+B2cObG7Rscb+/lPR4AYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZKJTblF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZKJTblF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5EE1F00898;
	Thu, 11 Jun 2026 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781192310;
	bh=avoYp7e1HFexGgdikMtyB2oinADwsByGeXykZpXpytU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fZKJTblFnpz1QcVnVi7ZVDusuGuAo6Z578700BllfVnCobY7tB5MbuyOcuIGCT6FH
	 Msyak/bALJQVI7keajYRu2ok/p/K31KJwimo0HDw0uelAfPgG+m0zAj1Lk+/kRSehs
	 UfslpvFp1zbv1hAfLmjlqEJxFJjD551aJcOgYRn1mM9mM4KlTSmFHJ5659E3X/IQZQ
	 k8d2+K73hT42Ku8kyPeUApTJpqFz7rT1TdH3E8+cQZm3jn5HrNMbKRofumpZjh8XDV
	 D2/5M7PX3pNwvMQ25skGXMXkfZ0aJTAWM6h/g9YY70ysSuGmOFJfe8An4q5ETOfLEQ
	 //J+82vdfTpxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] cxl/test: Add type2 support for mock CFMWS0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611152124.3656434-3-dave.jiang@intel.com>
References: <20260611152124.3656434-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:38:30 +0000
Message-Id: <20260611153830.7D5EE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper teardown of `cxl_acpi` platform device in `cxl_test_init(=
)` error path leads to double-put or stranded device.
- [High] Missing NULL check after `kzalloc` in `alloc_mock_res` causes a NU=
LL pointer dereference on allocation failure.
--

commit 4122a7a4346775c8cc5370b036f6cfe7a92557ff
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add type2 support for mock CFMWS0

Add a module parameter 'type2_test' for triggering type2 test support
in cxl_test. Setup the CFMWS0 configuration to be type2 when 'type2_test'
is set.

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
This is a pre-existing issue, but does alloc_mock_res() have a potential nu=
ll
pointer dereference on allocation failure?

tools/testing/cxl/test/cxl.c:alloc_mock_res() {
        struct cxl_mock_res *res =3D kzalloc(sizeof(*res), GFP_KERNEL);

        INIT_LIST_HEAD(&res->list);
        ...
}

If kzalloc() fails, INIT_LIST_HEAD() will unconditionally dereference the n=
ull
pointer. Could a check be added to handle the allocation failure before
initializing the list head?

>  		if (!res)
>  			return -ENOMEM;
[ ... ]
> @@ -2050,6 +2075,8 @@ module_param(extended_linear_cache, bool, 0444);
>  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache su=
pport");
>  module_param(fail_autoassemble, bool, 0444);
>  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-=
region");
> +module_param(type2_test, bool, 0444);
> +MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
>  module_init(cxl_test_init);

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
cxl_test_init() improperly tear down the cxl_acpi platform device?

If cxl_mock_platform_device_add() fails, it already drops the reference, so
calling platform_device_put(cxl_acpi) again in the err_root path would cause
a double-put.

Alternatively, if subsequent initialization fails, calling
platform_device_put() instead of platform_device_unregister() leaves the
device registered but drops the initial module reference, leading to a
stranded device when the module unloads.

Could this error path be updated to safely unregister the device?

>  module_exit(cxl_test_exit);
>  MODULE_LICENSE("GPL v2");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611152124.3656=
434-1-dave.jiang@intel.com?part=3D2
