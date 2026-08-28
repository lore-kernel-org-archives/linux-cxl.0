Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9A21A42D
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930018; cv=none; b=o4zQt9xMW9SqSeoOX9LgFbyBPgdmzgpUhjNsfO49Um+xsbpyYkINRlnEjpbmsuzMHsbTyCA0uGaT7n8cZ0vkZEiCaIh6bZuD//eJnHkqlC1eDPfHTYYplPhh+uF7ENNCIEyyPSuGTUvAkQb0nCczJ1SjBdQL61PbWM2QTErWkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930018; c=relaxed/simple;
	bh=/ouOr5EGl7DMMc7FF4YmPuOOGJNDZATjV1/J6Bc6rxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmxSR6Bvm+Y+5ExnCT9Y1VrziDVNn8zLhwP+Mg6pkEbdMec5yvywdrTDcdluLuFcd5+LfZ2RnZOQQrD7P7LXoKiOBqGuWVRde/JmKUD6ML2NTH+LwEn2P4TYaFwCpDQlHvdGKRCUxECxTzCiXxhkDKx5LBdo4+2iQZSi+cOlVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CP6jsUcp; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CP6jsUcp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787930014; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2BGAPnrAKlRIHgW6wkUwX/JJgCvR6yPAhtJ/W6cGgpg=;
	b=CP6jsUcpKvN5IA0fEhnkOGxCYgYm/PF09mcjlc+QTfF/7diw0EuiK+cs0Y37R84kdE8SDodNVwT0B3DWpsSf2KMfH2LDjmA6Y+zgvUM61qOz1nHj2op3vIgkNNNZrDcDo4lBNJDWPQRZu0xntLa9oiPJpMpllo01PUayBbm/ydQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9md4yW_1787930011;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9md4yW_1787930011 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 23:13:32 +0800
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
Subject: [PATCH v4 3/6] hw/riscv/virt: Advertise the CXL host bridge to firmware via extra-pci-roots
Date: Fri, 28 Aug 2026 23:13:02 +0800
Message-ID: <20260828151317.815-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-1-cp0613@linux.alibaba.com>
References: <20260828151317.815-1-cp0613@linux.alibaba.com>
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

This approach also scales to multiple pxb-cxl host bridges (each gets
its own window from the shared aperture) and lets firmware size the
window to what is actually behind the bridge, rather than reserving a
fixed carve-out.

Verified by booting an RVA22 guest: the CXL root port and Type3 device
enumerate, and 'cxl enable-memdev' / 'cxl create-region' /
'daxctl online-memory' bring the CXL memory online as system RAM.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

v4:
- Replaces the v3 QEMU-side firmware simulation with
  pci_bus_add_fw_cfg_extra_pci_roots(), advertising the pxb-cxl
  expander root buses to firmware via etc/extra-pci-roots.  EDK2 then
  enumerates behind the CXL host bridge and assigns the root-port
  window and bus numbers, and build_crs() emits a correct _CRS.  This
  scales to multiple pxb-cxl and lets firmware size the window.

 hw/riscv/virt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e08c76af4d..67f512cde1 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1237,6 +1237,14 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     if (s->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
+
+        /*
+         * Let firmware enumerate the pxb-cxl root buses and assign bus
+         * numbers and windows; build_crs() builds the ACPI0016 _CRS from
+         * the resulting state when the guest reads the ACPI tables.
+         */
+        pci_bus_add_fw_cfg_extra_pci_roots(s->fw_cfg, s->pci_bus,
+                                           &error_abort);
     }
     hwaddr firmware_end_addr;
     vaddr kernel_start_addr;
-- 
2.50.1

