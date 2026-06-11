Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2B38B7A6
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781222373; cv=none; b=qeSSOibsEG0KN9FiE1ILTrIV8ICSxnK5bdwpj+B0UzXBSDefL8YMSRcGMgAquyPzMbluS9JOdRArbZgMRtuGREiSfmFY2HFXGlaKooLo3CQhWpHIrH1v/bHkuqM7SR/quN+3PEAunD2VEmrHFwPgtWQbnC+yGY1JFs4S2T0j4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781222373; c=relaxed/simple;
	bh=X7Dyg0gVoBt42n5li+xQcJoaHBZ4J4jhkm2Fh6uKLbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TlG2vOZWZPU93ZJvFv6ILxnJHOB1E2o4w6ST8CG/dprhrWGwuuR73CTjadh8i0AUkSGQjz88sRGdUdYgbvWwNfXlC9/DkcW4s76BgJLBborAwoFSSUF6HAN6FOoEmyu8HiOhCDCFzccfUnWhZ3jR6TPGF50/VlEuVaBLBz9Ml6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeGqaYPO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeGqaYPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37021F000E9;
	Thu, 11 Jun 2026 23:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781222366;
	bh=cgZQ+I8LcQg19/jCKlyE5zjABRBrEARYq64SWSW9p9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KeGqaYPOA8r4HX0WdK3206CbAgn6k7Aa97ke9w4v7G57eXavgMw7Bo147ll8ong20
	 2Z9r6LeXXttrNo7rEHCh1SGHWseRfztOKOt4r9I3JCWKCCFFNRSgPB+4EWhLj5GduN
	 +OFa1qcP1TwefMkyVdU9Eb/I8pjU89FjCvw6awwgogTLMIYxzdOUx6KaAepcq/lACt
	 lB1F4msjGTz+aAtzLMef5q/Bjslv5sgFLJbBMD1WmjJtMrYEou474RuMQTq0mMn3xa
	 Sb8DYN156kRI+3Mq65EL7Y9vJFBbCSpPHVAVj4ED0nJp7+5hVSjBdEt8pn65LizXDT
	 NoKWE76jr8q0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] cxl/test: Add test for module parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611234409.256765-2-dave.jiang@intel.com>
References: <20260611234409.256765-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 23:59:26 +0000
Message-Id: <20260611235926.A37021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The statically allocated `hmem_test_device.work` work item is not =
flushed or cancelled when the `cxl_test` module unloads, leading to a poten=
tial use-after-free.
- [High] cxl_test_init() leaks the cxl_acpi platform device on the err_root=
 error path, leading to a use-after-free.
--

commit 3d4ed8e7e71c954497e1a45802d1e8387b3fcfc0
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add test for module parameters

Add a test for module paraters during module init to make sure that
only one is activated.

> Add a test for module paraters during module init to make sure that

[Severity: Low]
This isn't a bug, but there is a typo (paraters) in the commit message.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 296516eecfd6a..1c8ac8bdd8f7a 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

[ ... ]

>  static __init int cxl_test_init(void)
>  {
>  	int rc, i;
>  	struct range mappable;
> =20
> +	/* Enforce a single module param active at a time */
> +	if (have_multiple_modparms())
> +		return -EINVAL;
> +
>  	cxl_acpi_test();
>  	cxl_core_test();
>  	cxl_mem_test();

[ ... ]

>  	rc =3D hmem_test_init();
>  	if (rc)
>  		goto err_mem;
> =20
>  	return 0;
> =20
>  err_mem:
>  	cxl_mem_exit();
>  err_root:
>  	platform_device_put(cxl_acpi);

[Severity: High]
This is a pre-existing issue, but does cxl_test_init() leak the cxl_acpi
platform device on this err_root error path?

Since cxl_mock_platform_device_add() successfully added the device to the b=
us,
should this use platform_device_unregister() instead of platform_device_put=
()
for the already active device?

Dropping the initial allocation reference leaves the device active on the b=
us.
The device's mock companion data (acpi0017_mock) is statically allocated in
the module. When the module initialization fails and the module is unloaded,
the backing memory is freed, leaving a dangling pointer on the active platf=
orm
bus that can cause a kernel panic upon access.

> diff --git a/tools/testing/cxl/test/hmem_test.c b/tools/testing/cxl/test/=
hmem_test.c
> index 3a1a089e1721b..0fa00f7e16db5 100644
> --- a/tools/testing/cxl/test/hmem_test.c
> +++ b/tools/testing/cxl/test/hmem_test.c
> @@ -3,8 +3,9 @@
>  #include <linux/moduleparam.h>
>  #include <linux/workqueue.h>
>  #include "../../../drivers/dax/bus.h"
> +#include "mock.h"
> =20
> -static bool hmem_test;
> +bool hmem_test;

[ ... ]

>  static struct hmem_platform_device hmem_test_device =3D {
>  	.pdev =3D {
>  		.name =3D "hmem_platform",
>  		.id =3D 1,
>  		.dev =3D {
>  			.release =3D hmem_test_release,
>  		},
>  	},
>  	.work =3D __WORK_INITIALIZER(hmem_test_device.work, hmem_test_work),
>  };

[ ... ]

>  void hmem_test_exit(void)
>  {
>  	if (hmem_test)
>  		platform_device_unregister(&hmem_test_device.pdev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this leak the
hmem_test_device.work item when the cxl_test module unloads, leading to a
potential use-after-free?

The hmem_test_device is statically allocated in the module. When the dax_hm=
em
driver binds to this device, it queues hpdev->work on dax_hmem_wq.

On module unload, hmem_test_exit() unregisters the device but fails to call
cancel_work_sync() or flush_work(). The device release callback zeroes out
the structure while the work might still be queued. Since the module memory
is then freed, the workqueue will access freed memory when it eventually
processes the work item.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611234409.2567=
65-1-dave.jiang@intel.com?part=3D1
