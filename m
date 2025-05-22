Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05932882BC
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922191; cv=none; b=o6byJoSwtKIEkGgW8IyMWRuxpsBld68pk2eErka67ZPWHDGCk8c/3GetMK9IfoVqVfrTK2sb6ojEsHxJS1pHT9OULwSlBIWEWE7+EQM8MGMAZcaN6vBnMZYvK69qO/9fOOLJ6TTt31xubNjSaT4ZjoH3xoGhBSLjHBN94svMVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922191; c=relaxed/simple;
	bh=l5bMALYMc1kxMd2+r9hzJ6sHUhAaL/H3DKczpeUjduM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ui/Z//1I13PeXq350JtLgB4gKCaoCcjBY3NAn7QhfUp0iTQjeoG2v5Nnxa7fZK+oZRARcgOVTXXZyEMLF5qH0vyl4hiVho8q7LzxXkk4Bw2qsT9v910hwNTdFhb4V4VJ8/2i0aRE92LhRi6wFfre3v3/16fKf6qotKyUkArODQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b38pW6K1yz6M4R3;
	Thu, 22 May 2025 21:51:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DB379140605;
	Thu, 22 May 2025 21:56:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 15:56:24 +0200
Date: Thu, 22 May 2025 14:56:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Itaru Kitayama <itaru.kitayama@linux.dev>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: Internal error: Oops: 0000000096000044 [#11] SMP
Message-ID: <20250522145622.00002633@huawei.com>
In-Reply-To: <682e62f8e7073_1626e10066@dwillia2-xfh.jf.intel.com.notmuch>
References: <aC2RKceK4HqYEQo/@vm4>
	<96235d4d-2bb7-4743-b519-0c35a9a21749@intel.com>
	<98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
	<71238a94-361f-4264-a5e4-510d428f5f66@intel.com>
	<B0A9901C-E0FE-48C1-A584-B0090B43A5C4@linux.dev>
	<682e62f8e7073_1626e10066@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 16:34:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Itaru Kitayama wrote:
> > Dave et al., =20
> [..]
> > Rebuilt the rootfs image and tried today=E2=80=99s cx/next
> > (6.15.0-rc4-00046-g6eed708a5693) again to boot now I don=E2=80=99t see =
the
> > splats, so something I was messing my dev environment sorry about
> > that.
> >=20
> > CXL utility commands work reasonably now and I can execute meson test
> > =E2=80=94suite cxl, while most of them still fails due to the HPA alloc=
ation
> > error which makes me wonder as the resource requests are quite modest. =
 =20
>=20
> So cxl_test_init() just "hopes" that the top of the system physical
> address space is free to use to emulate CXL windows. That might be an
> assumption that only works for x86_64, not ARM64. I would double check
> that this code in cxl_test_init()
>=20
>         rc =3D gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64=
G,
>                           SZ_64G, NUMA_NO_NODE);
>         if (rc)
>                 goto err_gen_pool_add;
>=20
> ...is not setting up CXL Windows that overlap with existing resources in
> that range.
>=20

I think there are checks that block use of ranges up there.

Print I'm seeing is
Hotplug memory [0xfffffff010000000-0xfffffff030000000] exceeds maximum addr=
essable range [0x40000000-0xf80003fffffff]

I think right answer is to use mhp_get_pluggable_range(true); to check
for limits on the range we can use.

On architectures that don't define arch_get_mappable_range()
that ends up the as (unsigned long)-1 which I think would work
though there may be other stuff up there.  Maybe min(iomem_resource.end + 1=
 - SZ_64G,
						     mappable_range.end + 1 - SZ_64G)
or something like that adapted to avoid wrap around.

I haven't yet sanity checked this doesn't break x86 but I think it should
end up making no difference to the locations on x86.


With the below - all 11 tests in ndctl cxl test suite pass for me.

=46rom b287ff2c5ee7fbe507ef8cb61df3e4e156a9773f Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 22 May 2025 14:20:42 +0100
Subject: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/testing/cxl/test/cxl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8a5815ca870d..b4e6c7659ac4 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1328,6 +1328,7 @@ static int cxl_mem_init(void)
 static __init int cxl_test_init(void)
 {
 	int rc, i;
+	struct range mappable;
=20
 	cxl_acpi_test();
 	cxl_core_test();
@@ -1342,8 +1343,11 @@ static __init int cxl_test_init(void)
 		rc =3D -ENOMEM;
 		goto err_gen_pool_create;
 	}
+	mappable =3D mhp_get_pluggable_range(true);
=20
-	rc =3D gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
+	rc =3D gen_pool_add(cxl_mock_pool,
+			  min(iomem_resource.end + 1 - SZ_64G,
+			      mappable.end + 1 - SZ_64G),
 			  SZ_64G, NUMA_NO_NODE);
 	if (rc)
 		goto err_gen_pool_add;
--=20
2.43.0

