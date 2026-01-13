Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9301EB5FD
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297209; cv=none; b=ngR/i17CcqK7l+aUC47aqygbf3angdBnVhRIcSsIuWn7WGFWWMqtEKzUEYVLfPf8olqCIrfF5hjwbnkUFaArqahhD/I5c1gDjRrjMpFVN7Anc1hR0+Elix1Y2tOejL0QZDWxAbYzHJ/Aes6IAucrqCREW+msvIga1d/fthCxufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297209; c=relaxed/simple;
	bh=5qxXz5IBJTdc/jsYacpgwTohIzLix9YrYosovOthiz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=kVHbci48gbxVATuZS/OWuOyspPOpSqHxOCgOZPx5aK4c6aFzbo5yu1YEM3YLQe91aVMEyb0b115D0yit/xJSwkZmYIjLpDSxsi8q1GyzzdthcTYA0Vb/U0iMwPY0Kjjk2kajgSUn+cBe2QFb2hqeMuvG2oeN/zbw7XhBVO3GpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FMaIz3qF; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FMaIz3qF"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260113094005epoutp01f64164853cadae6911a48f8a20593473~KQPB62_gK2903629036epoutp01I
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:40:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260113094005epoutp01f64164853cadae6911a48f8a20593473~KQPB62_gK2903629036epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768297205;
	bh=Z7ab6YNeAN1HurS5UpUjDdbS+gNkGXf3jqS/MKGLWfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMaIz3qFvhf10ifPUcpgTGZkq86L2Xlf17NAT6lp+vagjQX+DpVTxl+IBfNrQWLmW
	 nW2oaRW3EYY/oIENLfnW1BeYoQDcsmXvK0PjhGZCtlhTIHOgF6xsbMz3e/6cc9ccFG
	 rPLLRN2rF6NTRSDZr2aR/r7QACRd8Za9c8ZYXcsk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260113094004epcas5p49671c4e20afc0e84c90c5d271b455ee2~KQPBWD-4x1636116361epcas5p4m;
	Tue, 13 Jan 2026 09:40:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dr43S4ZBNz3hhTF; Tue, 13 Jan
	2026 09:40:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260113093758epcas5p10cc9749a657b8e4d32db75b8b973b67d~KQNMSx0xE3161031610epcas5p1J;
	Tue, 13 Jan 2026 09:37:58 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260113093757epsmtip133a1896b653eae2f6b25fe21bb66e687~KQNKcPSxI2175321753epsmtip1k;
	Tue, 13 Jan 2026 09:37:56 +0000 (GMT)
Date: Tue, 13 Jan 2026 15:07:49 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, gost.dev@samsung.com,
	neeraj.kernel@gmail.com, cpgs@samsung.com
Subject: Re: [PATCH 0/6] CXL: Introduce memory controller abstraction and
 sysram controller
Message-ID: <439928219.101768297204618.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260112163514.2551809-1-gourry@gourry.net>
X-CMS-MailID: 20260113093758epcas5p10cc9749a657b8e4d32db75b8b973b67d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f289a_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260113093758epcas5p10cc9749a657b8e4d32db75b8b973b67d
References: <20260112163514.2551809-1-gourry@gourry.net>
	<CGME20260113093758epcas5p10cc9749a657b8e4d32db75b8b973b67d@epcas5p1.samsung.com>

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f289a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 12/01/26 11:35AM, Gregory Price wrote:
>The CXL driver currently hands policy management over to the DAX
>subsystem for sysram regions.  This makes building policy around
>entire regions clunky and at times difficult - for example, requiring
>multiple actions to reliably offline and hot-unplug memory.
>
>This series introduces a memory controller abstraction for CXL regions
>and adds a "sysram" controller that directly hotplugs memory without
>needing to route through DAX.  This simplifies the sysram use case
>considerably.
>
>This also prepares for future use cases which may require different
>memory controller logic (such as private numa nodes).
>
>We organize the controllers into core/memctrl/*_region.c files.
>
>The series is organized as follows:
>
>Patch 1 introduces the cxl_memctrl_mode enum and region->memctrl field,
>allowing regions to be switched between different memory controllers.
>The supported modes are NONE, AUTO, and DAX initially.  Auto-created
>regions default to AUTO, while manually created regions default to NONE
>(requiring explicit controller selection).
>
>Patch 2 adds the sysram_region memory controller, which provides direct
>memory hotplug without DAX intermediation.  New sysfs controls are
>exposed under region/memctrl/:
>  - hotplug:   trigger memory hotplug
>  - hotunplug: offline and hotunplug memory
>  - state:     online/online_normal/offline
>
>Patch 3 refactors existing pmem memctrl logic out of region.c into the
>new memctrl/pmem_region.c, simplifying controller selection in region
>probe.
>
>Patch 4 adds CONFIG_CXL_REGION_CTRL_AUTO_* options, allowing users to
>configure auto-regions to default to SYSRAM instead of DAX for existing
>simple system configurations (i.e. local memory expansion only).
>
>Patch 5 adds CONFIG_CXL_REGION_SYSRAM_DEFAULT_* options to control the
>default state of sysram blocks (OFFLINE, ONLINE/ZONE_MOVABLE, or
>ONLINE_NORMAL/ZONE_NORMAL).  This provides an alternative to the global
>MHP auto-online setting which may cause issues with other devices.
>
>Online defaults to ZONE_MOVABLE to defend hot-unplug by default.
>This is the opposite of memory blocks "online" and "online_movable".
>
>Patch 6 adds a memory_notify callback that prevents memory blocks from
>being onlined into ZONE_NORMAL when the controller state is set to
>ZONE_MOVABLE.  This protects against administrators accidentally
>breaking hot-unpluggability by writing "offline" then "online" to the
>memory block sysfs.
>
>Gregory Price (6):
>  drivers/cxl: add cxl_memctrl_mode and region->memctrl
>  cxl: add sysram_region memory controller
>  cxl/core/region: move pmem memctrl logic into memctrl/pmem_region
>  cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config options
>  cxl: add CXL_REGION_SYSRAM_DEFAULT_* build options
>  cxl/sysram: disallow onlining in ZONE_NORMAL if state is movable only
>
> drivers/cxl/Kconfig                      |  72 ++++
> drivers/cxl/core/Makefile                |   1 +
> drivers/cxl/core/core.h                  |   5 +
> drivers/cxl/core/memctrl/Makefile        |   6 +
> drivers/cxl/core/memctrl/dax_region.c    |  79 ++++
> drivers/cxl/core/memctrl/memctrl.c       |  48 +++
> drivers/cxl/core/memctrl/pmem_region.c   | 191 +++++++++
> drivers/cxl/core/memctrl/sysram_region.c | 520 +++++++++++++++++++++++
> drivers/cxl/core/region.c                | 358 ++++------------
> drivers/cxl/cxl.h                        |  18 +
> 10 files changed, 1013 insertions(+), 285 deletions(-)
> create mode 100644 drivers/cxl/core/memctrl/Makefile
> create mode 100644 drivers/cxl/core/memctrl/dax_region.c
> create mode 100644 drivers/cxl/core/memctrl/memctrl.c
> create mode 100644 drivers/cxl/core/memctrl/pmem_region.c
> create mode 100644 drivers/cxl/core/memctrl/sysram_region.c
>
>-- 
>2.52.0
>

Hi Gregory,

I am facing compilation issue with this series using CONFIG_CXL_BUS=m
{{{
	  AR      drivers/built-in.a
	  AR      built-in.a
	  AR      vmlinux.a
	  LD      vmlinux.o
	  MODPOST Module.symvers
	ERROR: modpost: "device_offline" [drivers/cxl/core/cxl_core.ko] undefined!
	ERROR: modpost: "lock_device_hotplug_sysfs" [drivers/cxl/core/cxl_core.ko] undefined!
	ERROR: modpost: "unlock_device_hotplug" [drivers/cxl/core/cxl_core.ko] undefined!
	ERROR: modpost: "device_online" [drivers/cxl/core/cxl_core.ko] undefined!
	ERROR: modpost: "walk_memory_blocks" [drivers/cxl/core/cxl_core.ko] undefined!
	make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
	make[1]: *** [/mnt/ssd1/neeraj/dcd/cxl_env/cxl-linux-mainline/Makefile:2004: modpost] Error 2
	make: *** [Makefile:248: __sub-make] Error 2
}}}

Above routines are not EXPORT_SYMBOL_GPL(), thats why with
"CONFIG_CXL_BUS=m" its breaking.

After adding following EXPORT_SYMBOL_GPL() below their respective
routines. This issue is fixed.
{{{
	EXPORT_SYMBOL_GPL(unlock_device_hotplug);
	EXPORT_SYMBOL_GPL(lock_device_hotplug_sysfs);
	EXPORT_SYMBOL_GPL(device_offline);
	EXPORT_SYMBOL_GPL(device_online);
	EXPORT_SYMBOL_GPL(walk_memory_blocks);
}}}

Can you please have a look?


Regards,
Neeraj

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f289a_
Content-Type: text/plain; charset="utf-8"


------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f289a_--

