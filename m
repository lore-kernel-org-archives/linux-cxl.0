Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A004928C869
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192082; cv=none; b=dybs3pH1qn1MYiRA0nYKnYRfGUD2AZe7hVUgMiix97qUaxiD1dneuTQKknkGK1p/9ffrka5mBavCUBCc0V/21EV++tsifeAKIP3n2Et9iYntpDYjFvO/K5hEC2vdHKHucg4tw6K6iuWcjDkjHw/TqCkHiwSovBpAHRltbIGUjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192082; c=relaxed/simple;
	bh=WqcXU2dJBQgoMk21kRXdFV5w8wM4j9IID5hvKkN8cds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cZ0kCxbOHIQaOdNTg4vdfHD9vxpaDwWsDnYQv9s3RICUe4/BqlFldDZqV9esZsz53mnPGGkb+LDpUYDVC+YdgFQ9pQGHKeW+hVbPYTTgDEsKdT7JaaKvNhJdUGhOYOL3scAgEHblnZn4MzSanGoyhTu+42TCoUB3fULep+EI2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4dFggeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4dFggeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2170E1F00893;
	Thu, 11 Jun 2026 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781192081;
	bh=MQNcwQBVJktM+UWXexmX/QqNRY45ZKBQqwzAsNhNepE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q4dFggeQJQkV1YdAVeGtQMnTRhFEwaNspB1NeBV4rT0iBjIOqUIW4/6YKjwSgin1z
	 rwF5kR7toT+Wp5kpYofXcR56TvrsF3mPl99QRBXEFOMyz5GO4AfSZWX0MvVykrYOij
	 sP2Sw7y21+bkPcQYlPoFbpk1iC/Rlqm4g5OIjzyNc4TGY/IRSRweNw19KAgQIF7PSN
	 Vgnaqe1HKSirLm8/54C8zFeLaWQDg3Lv2TelT66A/R6vwKFkaEbj6rImdNEODUlTf0
	 dM+G/rUhBonuCuk6oLruh+e1uWxvxgd/sIILlUikt1f78EAMVzHtN6Rllajd0CFIgW
	 K/bVV/OM+f8DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] cxl/test: Add test for module parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611152124.3656434-2-dave.jiang@intel.com>
References: <20260611152124.3656434-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:34:40 +0000
Message-Id: <20260611153441.2170E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The module unregisters `hmem_test_device` without flushing or canc=
eling its pending work, leading to a use-after-free and execute-after-free =
when the `cxl_test` module unloads.
--

commit 25e58b40eb66000f930689ce58f1f38f11a8a5bd
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Add test for module parameters

Add a test for module parameters during module init to make sure that
only one is activated.

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
> =20
>  static void hmem_test_work(struct work_struct *work)
>  {

[Severity: High]
This is a pre-existing issue, but does the hmem_test module leak
outstanding workqueue references upon unload?

The module unregisters hmem_test_device in hmem_test_exit() without flushing
or canceling its pending work:

tools/testing/cxl/test/hmem_test.c:hmem_test_exit() {
	if (hmem_test)
		platform_device_unregister(&hmem_test_device.pdev);
}

Because hmem_test_device is statically allocated in the module:

tools/testing/cxl/test/hmem_test.c:
	static struct hmem_platform_device hmem_test_device =3D { ... };

and its release function is in the module's text section:

tools/testing/cxl/test/hmem_test.c:hmem_test_release() {
	struct hmem_platform_device *hpdev =3D
		container_of(dev, typeof(*hpdev), pdev.dev);

	memset(hpdev, 0, sizeof(*hpdev));
}

could the module unload, allowing its memory to be freed before the
workqueue executes?

If the pending work executes after the module is unloaded, it would access =
the
freed hmem_test_device memory and trigger hmem_test_release() from the unlo=
aded
text section, causing a kernel crash. Should there be a call to cancel the
work before unregistering the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611152124.3656=
434-1-dave.jiang@intel.com?part=3D1
