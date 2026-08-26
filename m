Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C922423A
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751489; cv=none; b=ZTmjSncKsHev2zaxAqAD50IeuKwKfNEV/YYIcy9MBRcA6brp/+3bBAQrwCPZdWaL6s+Mlu4saRhltTEJeIn0DiqkFgwwElKoicg6VH+mncpS8UJZsB48vEs2uwh8B9KPS0uZCbjvP7ZcR81dZUMg47uW1+bCRhBvUS8i9i9pBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751489; c=relaxed/simple;
	bh=JeiFOZyQ5BCZUlGNebhGmJWjUNstn0Bfc1Pre6PhqmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI0UL/Z4j5+OnUkPwdmAGwjYu/eyU92Iv+SO8eEsGNQ9265t7LjtRZNrFUAMgTPNlfWy6fcCTNUjokCMwrTAbaJyvjvMdF/k7F/5JfFRh3Ad6e593hLNHpYaRbFUsrYnH/f/Uza/kPAiMxtZFy41FjeyOin/eDmrNh6eGkHekBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPUU+kQn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPUU+kQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787751487; x=1819287487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeiFOZyQ5BCZUlGNebhGmJWjUNstn0Bfc1Pre6PhqmI=;
  b=UPUU+kQnCveJ8Yh9BECzh0RcqGy7avD5sN1QG3FsZHCBBs54HFHjv3LD
   BwDfLr6EPC3/zno+vCxfFvJO3aGJ6SEhPrgU+8kgmXTdy9psu7+Rl+CkC
   SRw6MpL46enTq6829L5okrO//M6Wj7Tq7tFKCi9Q174QB6VSEZum7VgH1
   JyWTuWIviOM2PwHoeslJeT6/ELko09ttuaCJP61sDO3Ykcu1mou7QHbjJ
   YzHOFGEDeh6NE89h1JEu29IpOqPODIO/C2j+xiqUT1Y6fovmrjndYwHP5
   NJXd64LK8rg7C63XLDx50FskAyjyqzhyoeNVHxNtiy2OePR1NBPJBoFgn
   g==;
X-CSE-ConnectionGUID: j3JHsKPVRfOERp9oA+DKwQ==
X-CSE-MsgGUID: QvqGnYMET5WTgoP1yy8VNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88249854"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88249854"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:38:07 -0700
X-CSE-ConnectionGUID: Z2UJbQyXTn6sN5RYza5cKA==
X-CSE-MsgGUID: ZJa26qTuQ1iE6rSsQABBmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="269529862"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:38:02 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	sunilvl@oss.qualcomm.com,
	jic23@kernel.org,
	pbonzini@redhat.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu@processmission.com,
	anisinha@redhat.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] hw/riscv/virt: Provide a 32-bit MMIO window for CXL host bridges
Date: Wed, 26 Aug 2026 21:37:53 +0800
Message-ID: <20260826133754.355453-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-4-cp0613@linux.alibaba.com>
References: <20260821081954.1171-4-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Chen Pei,

On Fri, 21 Aug 2026 16:19:53 +0800, Chen Pei wrote:
> - The CXL host bridge _CRS is produced by the generic build_crs()
>   path.  EDK2's PciBusDxe only recurses into PCI-to-PCI bridges, while
>   the pxb-cxl expander bridge presents as a class 0x0600 host bridge
>   with a type-0 header, so firmware never enumerates behind it and
>   leaves the CXL root port's window and bus-number registers unset;
>   build_crs() would therefore return an empty _CRS.  Simulate the

I see the same empty _CRS you traced for Igor on v2, but the cause
sits one level up: riscv virt never tells the firmware that the
expander bus is there.

etc/extra-pci-roots is how the other machines advertise expander root
buses. hw/arm/virt.c, hw/i386/pc.c and hw/hppa/machine.c all call
pci_bus_add_fw_cfg_extra_pci_roots(); arm got it in 09fad16744 as
part of the pxb enablement there. hw/riscv/virt.c has no such call,
and since PXB is default y only for Q35 and ARM_VIRT, this series is
what first brings pxb to riscv at all -- so nothing has needed that
fw_cfg entry until now.

Same binary, in-tree edk2-riscv, only difference on the command line
being -fw_cfg name=etc/extra-pci-roots,file=<le64 1>:

  PciHostBridgeUtilityGetRootBridgesBusScan: 1 extra root buses ...
  PciHostBridgeUtilityInitRootBridge: populated root bus 12, ...
  PciBus: Resource Map for Bridge [0C|00|00]
  Type =  Mem32; Base = 0x40400000; Length = 0x200000; ...
     Base = 0x40400000; Length = 0x10000; ... Owner = PCI [0D|00|00:10]

so PciBusDxe does go behind the pxb-cxl once it knows the root bus
exists, and it assigns the root port window and the Type3 BARs itself.

With this patch dropped and pci_bus_add_fw_cfg_extra_pci_roots()
called from virt_machine_done() instead, next to
cxl_fmws_link_targets(), the regenerated DSDT has PC0C as

    DWordMemory (ResourceProducer, ...)
        0x40400000,         // Range Minimum
        0x405FFFFF,         // Range Maximum
    QWordMemory (ResourceProducer, ...)
        0x0000000400100000, // Range Minimum
        0x000000040010FFFF, // Range Maximum
    WordBusNumber (...)
        0x000C,             // Range Minimum
        0x000D,             // Range Maximum

with PCI0 keeping the rest of the 32-bit aperture
(0x40000000-0x403FFFFF and 0x40600000-0x7FFFFFFF). Firmware
partitions the aperture itself, sizes the window to what is actually
behind the bridge, and the 64-bit window comes along too. With a
second pxb-cxl added (bus_nr 12 and 200), the two bridges get
0x40400000-0x405FFFFF and 0x40600000-0x407FFFFF, so the
single-bridge limitation in the TODO would not arise either.

I have only looked at firmware enumeration and the generated tables
here, not at a booting CXL guest, so your RVA22 run may well turn up
something this misses. But if it holds, it drops the 256 MiB carve-out,
virt_cxl_init_bridge_windows() and the reset handler, and it is the
"fix UEFI to perform required initialization" option Igor raised on
v2, with the UEFI side already in place.

Many thanks,
Junjie
