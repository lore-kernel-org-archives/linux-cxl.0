Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CE2E762C
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771691; cv=none; b=kKX0CELtm5DKEJZ4hRehsqKEaEh4TmUX5dVKP7VQx5ma6fazOduKWWkSAmYFEONfNIjPF89JWs6a/bcEGmtSq9yquSWB4IBc0+uENCaXMSd2XLxYHU1xwbG6QelWJ/ff9PcuCwQ5nyRoeCrjw0MMAQsntVbmue8bgHMSEg8HCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771691; c=relaxed/simple;
	bh=ghdhqnJXkKW5PfgYp74AXnumnLvmHeTqRCjc+/kLQew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5KPl8HOrYSC3Ls1n6fKZcDOPHVVBWmgtj2KB7DanCigFnd8SVgc+cnAZrzQrHV7EarA+hCiStVcOQN98ZdiGLNOJqzd/qByjrJUEyMBATh2yvf3O08R3XexrA+Ido6HzQpeFOzBJfuhHyiq9Aqdqx8+5PinAhKmweYxSLeGt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6xriqJq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6xriqJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D01F00A3A;
	Mon, 29 Jun 2026 22:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782771689;
	bh=CILEfj11jks8nr7597Jqn7vr0XZ9JSLoa8+KHxvAr6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P6xriqJqa/w36OynlJLMdlRWADKwlhvvuEkCoSlvA1/vjR9yvOOgJ5yZqW2fjV2f8
	 XHOUNhB6Gs+5569UlUOQE/Q/P7nV4zPrcoNfg7M3gH7FecD3/suotcyw/Mn/aa5xiC
	 OJxrSlOG+z11UUdYmOS6xJ6kwCj4/I5JbO+v1Q7ahU5kpEBU3FJzb5AC1DOL4crirH
	 rlcPBLChrSUmGvaECJX3ewCQ7LWvnrgcZbOs+I/OjDXmMf2SFCN1nYe2Dn3R2vIG09
	 k4WiWu1t3wUBO7PXCf3slo62TZhLkXu3MVsz1bxZwPmKQsmGsKGiRiLtR/7IHHof/k
	 eV7kDgW08hR0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] cxl/test: Add test for module parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260629221104.3891733-2-dave.jiang@intel.com>
References: <20260629221104.3891733-1-dave.jiang@intel.com>
 <20260629221104.3891733-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:21:29 +0000
Message-Id: <20260629222129.771D01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing Use-After-Free due to static `struct platform_device`=
 inside a loadable module.
--

commit 6c236a64c339f0b27ff963a194f46fc253545d89
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add test for module parameters

Add a test for module paraters during module init to make sure that
only one is activated.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index ef92dd35e030c..198a128181b93 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c

[ ... ]

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

[Severity: High]
This is a pre-existing issue, but could this module encounter a use-after-f=
ree
on unload due to how platform_device is managed in this file?

Looking at hmem_test_exit() and the hmem_test_device definition:

static struct hmem_platform_device hmem_test_device =3D {
    ...
};

void hmem_test_exit(void)
{
    if (hmem_test)
        platform_device_unregister(&hmem_test_device.pdev);
}

If the dax_hmem driver has queued work on dax_hmem_wq (which holds a refere=
nce
to the device via get_device()), platform_device_unregister() doesn't appear
to synchronously wait for those references to drop or for the work to compl=
ete
because dax_hmem_platform_driver lacks a remove() callback to cancel the wo=
rk.

Since hmem_test_device is statically allocated in the module's data section,
once the module memory is freed on unload, would the kernel access unmapped
memory when the delayed work executes, or when the final reference drops and
invokes the unmapped hmem_test_release() function?

> =20
>  static void hmem_test_work(struct work_struct *work)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629221104.3891=
733-1-dave.jiang@intel.com?part=3D1
