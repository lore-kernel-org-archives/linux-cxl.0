Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B12E645
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 00:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513798; cv=none; b=ktdkqN74b/ilTh+aFdw4CV3Su8BBN+r/Tf0FRbnrg/M+Xnzn1BPSfYq9lWy6Nl4hM/Ei2pGSfa8x9C/XUQ1QzGNXi9iHuwbeDwelel4uGbOtR5wiHX8OozCzDRW5D4R1kRvzc20WnnDrPvuh+JXs3IvwucqqgXydH6NzDV8MV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513798; c=relaxed/simple;
	bh=3rgWS2tA9u0yCa5RSc8hMufyfAqfzpD77DZJYR0gPcE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=MBHkTVmwvlPRrixzJ9RU+EMCc9HxOdIA5QMu55DYLRBgq8+F7YsLBMNHBqbhCuC2JxHFRdDYlwOX/x3Ap9LtVZ/PrI7fh3zR57PSJgMhaopyZnlVQG0wk6JGSgwCQVvoIE+IzeaF7W+onIDB/geWylnc4mEWzTEl3e0So+KKnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dR90k9cD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dR90k9cD"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749513793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCbbT8xb+IQeenNViTbRCfxJLtHL8coXwx9rwCkLhlE=;
	b=dR90k9cDWCiFIW1uWS7MmCuFOqhR5M0577JXQaTysqmIqklSb2F6jtNBzhShnNBkhhc9Ve
	Yn5isTjFKw9Um6bH+ZXwH2KcJDX+qCcx58QvTjXNxDei46WqxNgOKQ3BI2smti/y4BN24Y
	jCJ65Yi0j7MHw/JA5vnIFubUydclnAs=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 10 Jun 2025 09:02:52 +0900
Subject: Re: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range
Message-Id: <BCD3DCBE-C008-4315-BF6E-B5B75EE70A7E@linux.dev>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Marc Herbert <Marc.Herbert@linux.intel.com>,
 Alison Schofield <alison.schofield@intel.com>, linuxarm@huawei.com
To: Dave Jiang <dave.jiang@intel.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 10, 2025, at 2:25, Dave Jiang <dave.jiang@intel.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 5/27/25 8:34 AM, Jonathan Cameron wrote:
>> Some architectures (e.g. arm64) only support memory hotplug operations on=

>> a restricted set of physical addresses. This applies even when we are
>> faking some CXL fixed memory windows for the purposes of cxl_test.
>> That range can be queried with mhp_get_pluggable_range(true). Use the
>> minimum of that the top of that range and iomem_resource.end to establish=

>> the 64GiB region used by cxl_test.
>>=20
>> =46rom thread #2 which was related to the issue in #1.
>>=20
>> Link: https://lore.kernel.org/linux-cxl/20250522145622.00002633@huawei.co=
m/ #2
>> Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
>> Closes: https://github.com/pmem/ndctl/issues/278 #1
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitay=
ama@fujitsu.com>
>> Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Applied to cxl/next
>=20
> Added the config check from Alison

Can this go into the 6.16 release cycle -rc2 or -rc3?

Itaru.

>=20
>>=20
>> ---
>> I haven't given this a fixes tag because it never worked on arm64.
>> So it isn't a regression fix, and I'm not sure we want to back port this
>> which a fixes tag might well trigger.  If people want one shout and I'll
>> try and figure out what is appropriate.
>> ---
>> tools/testing/cxl/test/cxl.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 8a5815ca870d..6a25cca5636f 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -2,6 +2,7 @@
>> // Copyright(c) 2021 Intel Corporation. All rights reserved.
>>=20
>> #include <linux/platform_device.h>
>> +#include <linux/memory_hotplug.h>
>> #include <linux/genalloc.h>
>> #include <linux/module.h>
>> #include <linux/mutex.h>
>> @@ -1328,6 +1329,7 @@ static int cxl_mem_init(void)
>> static __init int cxl_test_init(void)
>> {
>>    int rc, i;
>> +    struct range mappable;
>>=20
>>    cxl_acpi_test();
>>    cxl_core_test();
>> @@ -1342,8 +1344,11 @@ static __init int cxl_test_init(void)
>>        rc =3D -ENOMEM;
>>        goto err_gen_pool_create;
>>    }
>> +    mappable =3D mhp_get_pluggable_range(true);
>>=20
>> -    rc =3D gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
>> +    rc =3D gen_pool_add(cxl_mock_pool,
>> +              min(iomem_resource.end + 1 - SZ_64G,
>> +                  mappable.end + 1 - SZ_64G),
>>              SZ_64G, NUMA_NO_NODE);
>>    if (rc)
>>        goto err_gen_pool_add;
>=20
