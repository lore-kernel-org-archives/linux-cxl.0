Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC2146D53
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jan 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785909; cv=none; b=YlfnRdiPUO5qx4Kp5vCaLOUI2rTqzxQUCIX7JklevsDwNrskZk6JOTOuR7ukdN2fGG21Yf4DFcK3bhsmdki30ihnxdmy29ZRuBNBRN81Q/h3CWKWVp78pnTVTs+O6MO1eu2I/RSX9KAs6JhaUJ2TXxkEAkBzMUddT6xUGKNYrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785909; c=relaxed/simple;
	bh=xCFKKftamKpQ2Fn/B0AizQlYw2Gf0hTQyNm1nNttNko=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0e4Xl2tJ95JWtKDvf9PAKh/57wP8lqiua7/aKEmwnQSqXD91NXBFLxW4HoUCgQcRN0j5/66PUmorS0QClJvCoc/QkgT1dM0U/YHcOFkZA0QvYyWceN38vIsut/R1iKeHb23sQJyv7mQlc4Fv5PVTcU6X2vxQlYeMXK3/43eG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWyQx1nYNz6M4PB;
	Tue, 14 Jan 2025 00:30:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A19B214039F;
	Tue, 14 Jan 2025 00:31:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 17:31:43 +0100
Date: Mon, 13 Jan 2025 16:31:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Huaisheng Ye <huaisheng.ye@intel.com>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<ming.li@zohomail.com>, <pei.p.jia@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Message-ID: <20250113163141.00002a10@huawei.com>
In-Reply-To: <20250113064345.6835-1-huaisheng.ye@intel.com>
References: <20250113064345.6835-1-huaisheng.ye@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 13 Jan 2025 14:43:45 +0800
Huaisheng Ye <huaisheng.ye@intel.com> wrote:

> In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was
> added for counting regblocks of a given RBI (Register Block Identifier).
> It is workable, but the implementation can be improved.
>=20
> 1. In order to get the count of instances, cxl_count_regblock has to tent=
atively
> repeat the call of cxl_find_regblock_instance by increasing index from 0.=
 It
> will not stop until an error value is returned. Actually, It needs to sea=
rch for
> Register Blocks in dvsec again every time by taking a start from the head=
. The
> operations can be optimized.
>=20
> For example, to determine if PMU1 exists, cxl_find_regblock_instance must=
 check
> all Register Blocks by the type and index from RB1 to RB4, starting from =
scratch,
> even if PMU0 just has been searched. If there are more RBs of the same ty=
pe in the
> future, the situation will be even worse.
>=20
> 16 81 00 23             PCIe extended Capability Header
> 02 c0 1e 98             Header 1
> 00 00 00 08             Header 2
> --------------------------------------
> 00 00 01 00             RB 1 - Offset Low       Component
> 00 00 00 00             RB 1 - Offset High
> --------------------------------------
> 00 00 03 02             RB 2 - Offset Low       Device Register
> 00 00 00 00             RB 2 - Offset High
> --------------------------------------
> 00 01 04 02             RB 3 - Offset Low       PMU0
> 00 00 00 00             RB 3 - Offset High
> --------------------------------------
> 00 02 04 02             RB 4 - Offset Low       PMU1
> 00 00 00 00             RB 4 - Offset High
>=20
> RB: Register Block
>=20
> 2. cxl_count_regblock blocks the opportunity to get error codes from
> cxl_find_regblock_instance. cxl_pci_probe has error code checking for alm=
ost
> all function calls. This is a good behavior, but existing cxl_count_regbl=
ock
> couldn't return error codes.
>=20
> With this patch, only need to have minor modifications in
> __cxl_find_regblock_instance, which can return the count of regblocks by =
given
> RBI in just one call. It is more effective than before. Besides, the erro=
r code
> could be obtained by the called function, here is cxl_pci_probe.
>=20
> Based on the above reasons, refactor out cxl_count_regblock and create
> __cxl_find_regblock_instance for counting instances more efficiently.
>=20

I'd suggest moving the testing setup to a cover letter.  It is more detail
that we necessarily need in the git log.  Maybe if this change is otherwise
acceptable, Dave might tidy this up whilst applying.


> This patch is tested by ndctl cxl_test and physical CXL expander card
> with v6.13-rc6.
>=20
> 1. Ndctl CXL test suite v80 could pass with this patch applied.
> $ meson test -C build --suite cxl
> ninja: Entering directory `/home/work/source/ndctl/build'
> [1/48] Generating version.h with a custom command
>  1/11 ndctl:cxl / cxl-topology.sh               OK               3.48s
>  2/11 ndctl:cxl / cxl-region-sysfs.sh           OK               2.74s
>  3/11 ndctl:cxl / cxl-labels.sh                 OK               1.75s
>  4/11 ndctl:cxl / cxl-create-region.sh          OK               3.51s
>  5/11 ndctl:cxl / cxl-xor-region.sh             OK               1.89s
>  6/11 ndctl:cxl / cxl-events.sh                 OK               1.63s
>  7/11 ndctl:cxl / cxl-sanitize.sh               OK               4.48s
>  8/11 ndctl:cxl / cxl-destroy-region.sh         OK               1.90s
>  9/11 ndctl:cxl / cxl-qos-class.sh              OK               2.65s
> 10/11 ndctl:cxl / cxl-poison.sh                 OK               2.86s
> 11/11 ndctl:cxl / cxl-security.sh               OK               0.91s
>=20
> 2. Test patch with Qemu x4 switch topology:
>=20
>                        ACPI0017:00 [root0]
>                            |
>                          HB_0 [port1]
>                         /             \
>                      RP_0             RP_1
>                       |                 |
>                 USP [port2]
>             /    /    \    \
>           DSP   DSP   DSP   DSP
>            |     |     |     |
>           mem1  mem0  mem2  mem3
>=20
> Every card has 2 PMU RBs, here are the pmu_mem devices.
>=20
> $ pwd
> /sys/bus/cxl/devices
> $ tree
> [snip]
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem0.0 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.0
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem0.1 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.1
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem1.0 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.0
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem1.1 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.1
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem2.0 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.0
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem2.1 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.1
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem3.0 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.0
> =E2=94=9C=E2=94=80=E2=94=80 pmu_mem3.1 -> ../../../devices/pci0000:0c/000=
0:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.1
>=20
Change log belongs below the ---
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> v2 -> v3:
>=20
> 1. Create static function __cxl_find_regblock_instance() for implementati=
on of
>    locating a register block or counting instances by type / index
>    underneath. (Jonathan Cameron)
> 2. cxl_count_regblock() and cxl_find_regblock_instance() respectively call
>    __cxl_find_regblock_instance for the purpose of counting instances and
>    locating RB. (Jonathan Cameron)
> 3. Change parameter index's type to 'unsigned int' in cxl_find_regblock_i=
nstance (Jonathan Cameron)
> 4. Rebase patch to v6.13-rc6
>=20
> =3D=3D=3D=3D=3D=3D=3D
> v1 -> v2:
>=20
> 1. Reserved cxl_count_regblock() for original function interface (Ming Li)
> 2. Reset 'map->resource' to 'CXL_RESOURCE_NONE' before returning the coun=
t of instances in
>    cxl_find_regblock_instance() (Ming Li)
> 3. Append results of ndctl test suite and Qemu testing PMU devices to com=
mit log (Ming Li)
> 4. Rebase patch to v6.13-rc5
>=20
>  [v2] https://lore.kernel.org/all/20241230122239.3445117-1-huaisheng.ye@i=
ntel.com/
>=20
> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
> ---

Put change logs here.

The code looks good to me. I did wonder if it made sense to keep so much do=
cumentation
for the static helper function, but on balance I think that is fine.

So with the patch description tidied up
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

