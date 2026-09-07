Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092813A7D81
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773879; cv=none; b=ewNQ1G+R54a4giN1VPEuSbmoaslAH3GC5bNLnVUFb77ZuHJu5sSjTsc0a0DQiZx6zb3JPwX4sao4JJ5RLFMKtcqLBTUZi+D9xJscDrhNVZZYKv3bHz1FLmsgqxWpEmPNzsu4QwgaVyPPgks1lQXWKfAvORZn6p9bUrx4mhzs7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773879; c=relaxed/simple;
	bh=QHSp4WuCJryWZUK5ndvzNV9y+GinboqEPn/IRrdhVLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKU6offneP8NLIIac4z/KFsHHwX+Jtb/FkLSMMtTSMGbOi8Bvw9ckx4nQsMQeshB3cUjnMSXubL7ENwOWMPOR93UFdTJljbNtrNoevXJJlZa4YAAVyCYRF2QR8VSKykTtWoVl8DeDNQSLuLv6/oQCuGecc6LaX/ChRtc25UoV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XnLFMiYS; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XnLFMiYS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788773869; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yc5KhGVgl+0DuLZrt8gjwOQ2YjB/WdP3UupIKvk84hk=;
	b=XnLFMiYS0ql8Iu/oLjA7E8lhKLRY7K04o6iEpozolVffNNkH1FLG/F3tRaeJRC8DQdfV1aaS1N4Dq7ybLhtwXdBbyz9MI8J67hCFsY+CZZ/qMVKSaJGfoMKiXCmN3kL0PjHVMsRkE/LMt+Nl+TwvI6XEunHHqQFztIlSvgeJRLU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XATXGyL_1788773867;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XATXGyL_1788773867 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 17:37:47 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	jic23@kernel.org
Cc: pbonzini@redhat.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu@processmission.com,
	anisinha@redhat.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	junjie.cao@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v6 3/6] hw/riscv/virt: Advertise the CXL host bridge to firmware via extra-pci-roots
Date: Mon,  7 Sep 2026 17:37:30 +0800
Message-ID: <20260907093735.2753-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093735.2753-1-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pxb-cxl expander bridge presents as a class 0x0600 host bridge with
a type-0 header, so EDK2's PciBusDxe never recurses into it and never
assigns the CXL root port a memory window or bus numbers.  As a result
build_crs() produces an empty _CRS for the ACPI0016 host bridge and the
CXL devices behind it are not enumerated by the OS.

Advertise the pxb-cxl expander root buses to firmware via the
etc/extra-pci-roots fw_cfg file, the same way arm/virt and x86 do, by
calling pci_bus_add_fw_cfg_extra_pci_roots() from virt_machine_done().
EDK2's PciBusDxe then enumerates behind the CXL host bridge and assigns
the root-port window and bus numbers.  The ACPI tables are rebuilt when
the guest reads them (after that firmware enumeration), so build_crs()
then emits a correct _CRS for the ACPI0016 host bridge.

The call is made unconditionally, in line with arm/virt, pc and hppa,
so plain pxb-pcie expander bridges, which likewise depend on
etc/extra-pci-roots, are advertised as well; the generator simply
returns nothing when there is no expander root bus.

This approach also scales to multiple pxb-cxl host bridges (each gets
its own window from the shared aperture) and lets firmware size the
window to what is actually behind the bridge, rather than reserving a
fixed carve-out.

Verified by booting an RVA22 guest: the CXL root port and Type3 device
enumerate, and 'cxl enable-memdev' / 'cxl create-region' /
'daxctl online-memory' bring the CXL memory online as system RAM.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/riscv/virt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 70090ca70a..885020af83 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -657,6 +657,15 @@ static void virt_machine_done(Notifier *notifier, void *data)
         cxl_fmws_link_targets(&error_fatal);
     }
 
+    /*
+     * Advertise the pxb/pxb-cxl expander root buses to firmware so that
+     * it enumerates behind them and assigns bus numbers and windows.  For
+     * the CXL host bridges, build_crs() then builds the ACPI0016 _CRS
+     * from the resulting state when the guest reads the ACPI tables.
+     * This is a no-op without any expander root bus.
+     */
+    pci_bus_add_fw_cfg_extra_pci_roots(s->fw_cfg, s->pci_bus, &error_abort);
+
     /*
      * An user provided dtb must include everything, including
      * dynamic sysbus devices. Our FDT needs to be finalized.
-- 
2.50.1

