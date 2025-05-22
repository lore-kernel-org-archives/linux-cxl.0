Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD92580DE
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950440; cv=none; b=gi5fj3efyk1bgVsxtexyD5HRY8mOzEz2yx0vAarnn+1Uzcm/thrhcXxoLBoxluM0ymCTuQ0QUqqZ2lCr/MylhJK5WAt5t11viVbQpIdwiNbp+LKN9aQXy98CwL+oPeDjTE+wgF6dsjp9xuS2WdqIFmHMWAyVk3fLlfI3BVECHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950440; c=relaxed/simple;
	bh=L5d7Hz9WPOeL5+6Nmgr1ZDg+wmH2lNapzOazwcGXoQ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tcSaKVY7NSBXWLPIvdAl3IDMopzqdxyzQGaoxqnf9IxsqAAzD4SCqKXmsn4BoXePTyceQ2zvMNZ/OoH1DzfvvZRWUkNH/KZ0jb7nuokGZ4Qa40dfxN8bPovUl0xB93u/cSPqY2ompLB88RXU26nlBoO3WO9XR2j9aAqnLM6B1YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OUO4CUy9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OUO4CUy9"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747950431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVfGg8e4neK1dV4CcxrFW6Zz3CtQKLWtdzww+Op4utU=;
	b=OUO4CUy9ccl3i8awLYUfX7jZdT2fboSVU8T36WBPy/lUngtOpJw3Co9PH4bS66ueJhSBsg
	mJd7jjeyoFcelrhENDofeJ+6T15uGqzritp9CvNjCZH0djy+k8gEB68fjPwewbJdNEWTMn
	sEPOQ6+dGRmX1ltN9tnQ89yySO9VcLI=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Internal error: Oops: 0000000096000044 [#11] SMP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <20250522145622.00002633@huawei.com>
Date: Fri, 23 May 2025 06:46:53 +0900
Cc: Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD4183E1-162E-4790-B865-E50F20249A74@linux.dev>
References: <aC2RKceK4HqYEQo/@vm4>
 <96235d4d-2bb7-4743-b519-0c35a9a21749@intel.com>
 <98DE3B2C-1393-4ED8-BB6A-E72D6131F97A@linux.dev>
 <71238a94-361f-4264-a5e4-510d428f5f66@intel.com>
 <B0A9901C-E0FE-48C1-A584-B0090B43A5C4@linux.dev>
 <682e62f8e7073_1626e10066@dwillia2-xfh.jf.intel.com.notmuch>
 <20250522145622.00002633@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT

Hi Jonathan,

> On May 22, 2025, at 22:56, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Wed, 21 May 2025 16:34:16 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>=20
>> Itaru Kitayama wrote:
>>> Dave et al., =20
>> [..]
>>> Rebuilt the rootfs image and tried today=E2=80=99s cx/next
>>> (6.15.0-rc4-00046-g6eed708a5693) again to boot now I don=E2=80=99t =
see the
>>> splats, so something I was messing my dev environment sorry about
>>> that.
>>>=20
>>> CXL utility commands work reasonably now and I can execute meson =
test
>>> =E2=80=94suite cxl, while most of them still fails due to the HPA =
allocation
>>> error which makes me wonder as the resource requests are quite =
modest.  =20
>>=20
>> So cxl_test_init() just "hopes" that the top of the system physical
>> address space is free to use to emulate CXL windows. That might be an
>> assumption that only works for x86_64, not ARM64. I would double =
check
>> that this code in cxl_test_init()
>>=20
>>        rc =3D gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - =
SZ_64G,
>>                          SZ_64G, NUMA_NO_NODE);
>>        if (rc)
>>                goto err_gen_pool_add;
>>=20
>> ...is not setting up CXL Windows that overlap with existing resources =
in
>> that range.
>>=20
>=20
> I think there are checks that block use of ranges up there.
>=20
> Print I'm seeing is
> Hotplug memory [0xfffffff010000000-0xfffffff030000000] exceeds maximum =
addressable range [0x40000000-0xf80003fffffff]
>=20
> I think right answer is to use mhp_get_pluggable_range(true); to check
> for limits on the range we can use.
>=20
> On architectures that don't define arch_get_mappable_range()
> that ends up the as (unsigned long)-1 which I think would work
> though there may be other stuff up there.  Maybe =
min(iomem_resource.end + 1 - SZ_64G,
>     mappable_range.end + 1 - SZ_64G)
> or something like that adapted to avoid wrap around.
>=20
> I haven't yet sanity checked this doesn't break x86 but I think it =
should
> end up making no difference to the locations on x86.
>=20
>=20
> With the below - all 11 tests in ndctl cxl test suite pass for me.
>=20
> =46rom b287ff2c5ee7fbe507ef8cb61df3e4e156a9773f Mon Sep 17 00:00:00 =
2001
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Date: Thu, 22 May 2025 14:20:42 +0100
> Subject: [PATCH] cxl_test: Limit location for fake CFMWS to mappable =
range
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> tools/testing/cxl/test/cxl.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/cxl/test/cxl.c =
b/tools/testing/cxl/test/cxl.c
> index 8a5815ca870d..b4e6c7659ac4 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1328,6 +1328,7 @@ static int cxl_mem_init(void)
> static __init int cxl_test_init(void)
> {
> int rc, i;
> + struct range mappable;
>=20
> cxl_acpi_test();
> cxl_core_test();
> @@ -1342,8 +1343,11 @@ static __init int cxl_test_init(void)
> rc =3D -ENOMEM;
> goto err_gen_pool_create;
> }
> + mappable =3D mhp_get_pluggable_range(true);
>=20
> - rc =3D gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> + rc =3D gen_pool_add(cxl_mock_pool,
> +  min(iomem_resource.end + 1 - SZ_64G,
> +      mappable.end + 1 - SZ_64G),
>  SZ_64G, NUMA_NO_NODE);
> if (rc)
> goto err_gen_pool_add;
> --=20
> 2.43.0
>=20

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com =
<mailto:itaru.kitayama@fujitsu.com>>

# meson test --suite cxl
ninja: Entering directory `/root/ndctl/build'
[1/82] Generating version.h with a custom command
 1/12 ndctl:cxl / cxl-topology.sh                OK              33.96s
 2/12 ndctl:cxl / cxl-region-sysfs.sh            OK              18.00s
 3/12 ndctl:cxl / cxl-labels.sh                  OK              23.78s
 4/12 ndctl:cxl / cxl-create-region.sh           OK              43.03s
 5/12 ndctl:cxl / cxl-xor-region.sh              OK              19.30s
 6/12 ndctl:cxl / cxl-events.sh                  FAIL             6.40s  =
 exit status 1
>>> =
LD_LIBRARY_PATH=3D/root/ndctl/build/daxctl/lib:/root/ndctl/build/cxl/lib:/=
root/ndctl/build/ndctl/lib MALLOC_PERTURB_=3D45 =
TEST_PATH=3D/root/ndctl/build/test =
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pri=
nt_stacktrace=3D1 =
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1 MESON_TEST_ITERATION=3D1 =
DAXCTL=3D/root/ndctl/build/daxctl/daxctl =
NDCTL=3D/root/ndctl/build/ndctl/ndctl =
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 =
DATA_PATH=3D/root/ndctl/test /bin/bash /root/ndctl/test/cxl-events.sh

 7/12 ndctl:cxl / cxl-sanitize.sh                OK              14.77s
 8/12 ndctl:cxl / cxl-destroy-region.sh          OK              13.69s
 9/12 ndctl:cxl / cxl-qos-class.sh               OK              14.31s
10/12 ndctl:cxl / cxl-poison.sh                  FAIL             3.46s  =
 exit status 1
>>> =
LD_LIBRARY_PATH=3D/root/ndctl/build/daxctl/lib:/root/ndctl/build/cxl/lib:/=
root/ndctl/build/ndctl/lib =
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1 MALLOC_PERTURB_=3D80 =
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pri=
nt_stacktrace=3D1 TEST_PATH=3D/root/ndctl/build/test =
MESON_TEST_ITERATION=3D1 DAXCTL=3D/root/ndctl/build/daxctl/daxctl =
NDCTL=3D/root/ndctl/build/ndctl/ndctl =
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 =
DATA_PATH=3D/root/ndctl/test /bin/bash /root/ndctl/test/cxl-poison.sh

11/12 ndctl:cxl / cxl-update-firmware.sh         OK              66.23s
12/12 ndctl:cxl / cxl-security.sh                SKIP             0.34s  =
 exit status 77

Ok:                 9
Expected Fail:      0
Fail:               2
Unexpected Pass:    0
Skipped:            1
Timeout:            0

My understanding is that these CXL tests are using mock CFMWs, not the =
actual physical memory regions at their fixed locations. So I wonder =
executing these set of test on a =E2=80=9Csane" CXL emulation setup =
(run_qemu.sh creates) that the Intel folk is using does matter or not.

Itaru.=
