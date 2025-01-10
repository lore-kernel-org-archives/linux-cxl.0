Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE62066E5
	for <linux-cxl@vger.kernel.org>; Fri, 10 Jan 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524382; cv=none; b=YYbP5Nh9tGnOyGMtRra175dWdTIrQ0Ad73AAoTz1nt9RP6AeEd6ALhcZI/DdVJ88x5HcqdRfjBqKz/rH2+vG99n4BBrJcQukEbb98cjvKdSVvags4jkhH7nejx3pZjMLnRMUuw/hmP7rjFM/g8R4jlTjfnyDlXaGNUO9bj4TfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524382; c=relaxed/simple;
	bh=LEQ/D9H5I3uyR8TjkX7p3P7Da3skJXhP5T0sjrkC9no=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROb1I70gRTa9OhzCz9TgJEYaXyx9IMjA7Js08aeMk3OxucULUPHluErI6qmaHqw5MZa5+08gSyAX/TN8Bpr0nKmG5UN580Bo+dMXkDRZYdJUCGO0L2oICSk/FFLuTSx5vQHHDR9DZy/SaQpLmglww+LzVHGMVUcQsEuJ40bPT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV5jg0tgCz6D9Pm;
	Fri, 10 Jan 2025 23:51:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F62E1401F4;
	Fri, 10 Jan 2025 23:52:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 16:52:56 +0100
Date: Fri, 10 Jan 2025 15:52:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Huaisheng Ye <huaisheng.ye@intel.com>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<ming.li@zohomail.com>, <pei.p.jia@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Message-ID: <20250110155255.00003a1e@huawei.com>
In-Reply-To: <20241230122239.3445117-1-huaisheng.ye@intel.com>
References: <20241230122239.3445117-1-huaisheng.ye@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Dec 2024 20:22:39 +0800
Huaisheng Ye <huaisheng.ye@intel.com> wrote:

> In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was
> added for counting regblocks of a given RBI (Register Block Identifier).
> It is workable, but has two drawbacks that can be improved.
>=20
> 1. In order to get the count of instances, cxl_count_regblock has to tent=
atively
> repeat the call of cxl_find_regblock_instance by increasing index from 0.=
 It
> will not stop until an error value is returned. Actually, It needs to sea=
rch for
> Register Blocks in dvsec again every time by taking a start from the head=
. This
> is a bit inefficient.
>=20
> For example, to determine if PMU1 exists, cxl_find_regblock_instance must=
 check
> all Register Blocks by the type and index from RB1 to RB4. If there are m=
ore RBs
> of the same type in the future, the situation will be even worse.
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
> all function calls. This is a good behavior, but cxl_count_regblock could=
n't.
>=20
> With this patch, only need to add two lines of code in cxl_find_regblock_=
instance,
> which can return the count of regblocks by given RBI in just one call. It=
 is
> more effective than before. Besides, the error code could be obtained by =
the
> called function, here is cxl_pci_probe.
>=20
> Based on the above reasons, refactor out cxl_count_regblock for counting
> instances more efficiently.
>=20
> This patch is tested by ndctl cxl_test and physical CXL expander card
> with v6.13-rc5.
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
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> v1 -> v2:
>=20
> 1. Reserved cxl_count_regblock() for original function interface
> 2. Reset 'map->resource' to 'CXL_RESOURCE_NONE' before returning the coun=
t of instances in
>    cxl_find_regblock_instance()
> 3. Append results of ndctl test suite and Qemu testing PMU devices to com=
mit log
> 4. Rebase patch to v6.13-rc5
>=20
>  [v1] https://lore.kernel.org/all/20241225083539.2230150-1-huaisheng.ye@i=
ntel.com/
>=20
> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
> ---
>  drivers/cxl/core/regs.c | 19 +++++++++----------
>  drivers/cxl/cxl.h       |  1 +
>  drivers/cxl/pci.c       |  3 +++
>  3 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 59cb35b40c7e..d0db954da0ff 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -290,17 +290,19 @@ static bool cxl_decode_regblock(struct pci_dev *pde=
v, u32 reg_lo, u32 reg_hi,
>  }
> =20
>  /**

The idea seems good.

I'm not keen on this function gaining super powers if we can avoid it.
Instead you could rename the implementation to __cxl_find_regblock_instance=
()
which does what you have here (but static) and have a cxl_find_regblock_ins=
tance()
that takes an unsigned index parameter and is documented as this was previo=
usly.

If someone wants the count they should use cxl_count_regblock().

If they want an entry they should call cxl_find_regblock_instance()

Both call the same implementation underneath.

Jonathan
> - * cxl_find_regblock_instance() - Locate a register block by type / index
> + * cxl_find_regblock_instance() - Locate a register block or count insta=
nces by type / index
>   * @pdev: The CXL PCI device to enumerate.
>   * @type: Register Block Indicator id
>   * @map: Enumeration output, clobbered on error
>   * @index: Index into which particular instance of a regblock wanted in =
the
>   *	   order found in register locator DVSEC.
>   *
> - * Return: 0 if register block enumerated, negative error code otherwise
> + * Return: 0 if register block enumerated, non-negative if instances cou=
nted,
> + * negative error code otherwise
>   *
>   * A CXL DVSEC may point to one or more register blocks, search for them
>   * by @type and @index.
> + * Use CXL_INSTANCES_COUNT for @index if counting instances by @type and=
 @index.
>   */
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_typ=
e type,
>  			       struct cxl_register_map *map, int index)
> @@ -342,6 +344,9 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, =
enum cxl_regloc_type type,
>  	}
> =20
>  	map->resource =3D CXL_RESOURCE_NONE;
> +	if (index =3D=3D CXL_INSTANCES_COUNT)
> +		return instance;
> +
>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock_instance, "CXL");
> @@ -371,19 +376,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, "CXL");
>   *
>   * Some regblocks may be repeated. Count how many instances.
>   *
> - * Return: count of matching regblocks.
> + * Return: non-negative count of matching regblocks, negative error code=
 otherwise.
>   */
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type)
>  {
>  	struct cxl_register_map map;
> -	int rc, count =3D 0;
> =20
> -	while (1) {
> -		rc =3D cxl_find_regblock_instance(pdev, type, &map, count);
> -		if (rc)
> -			return count;
> -		count++;
> -	}
> +	return cxl_find_regblock_instance(pdev, type, &map, CXL_INSTANCES_COUNT=
);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_count_regblock, "CXL");
> =20
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..18bd05f29354 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -302,6 +302,7 @@ int cxl_map_device_regs(const struct cxl_register_map=
 *map,
>  			struct cxl_device_regs *regs);
>  int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *=
regs);
> =20
> +#define CXL_INSTANCES_COUNT -1
>  enum cxl_regloc_type;
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_typ=
e type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..c68c4a0bdbe0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1009,6 +1009,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  		return rc;
> =20
>  	pmu_count =3D cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
> +	if (pmu_count < 0)
> +		return pmu_count;
> +
>  	for (i =3D 0; i < pmu_count; i++) {
>  		struct cxl_pmu_regs pmu_regs;
> =20

