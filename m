Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8F78F4A
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773886; cv=none; b=GUM12gZ1zZNe5ivyZyOQFkixojxJlIDsrpPDGhTnGrk9TWDTNpa4XS1zOBc4FKXTzgm172TxGnDisCQDqkIEbJyq6hjF5iPVovK9jqLnkTqJHRvV+s0m22FY7XvwrRkvowRkrYZYZWzH9ohA0Y58cHgeFgsK3KsG1uvBP4+cors=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773886; c=relaxed/simple;
	bh=aP2ttmSOLuRsXGetq36Ck+xZ+S2JO6OFoT7vqWQwxfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDDEUEivNe9ERAPMDzC+V/Gzeiui/mnFpvsc/856cv8MyME8Vo1AbRlaKOe1OTQL07srJvlf3imzmHK0LUq8L3gIxUDLTAJq+JMX5Davdv8Z0u4kt2JGDYgTegvbI9xl8j4BY3Ky5C97OiUUdI5LJNyB6jadBoRzJePzfuTOmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O1hvc0ZA; arc=none smtp.client-ip=47.90.199.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O1hvc0ZA"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788773868; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zYZIRnVm4EVgjOeiEy+OXbDkRrDL+s/FNTgJFXZLnu0=;
	b=O1hvc0ZAVb5X0VWMPURi7WvfoX4mU+c+vY7Lb0V/QomItSC49aXK+++vOvQ0Gwr5cjowbqHEu3OO0Iagc6kaet1PlnFzmoq15+aAN0hBfVoKdco8xSEtPE6s5su7T58qGMmP504HqQeK8MDoQBW7N6NcM4B0hdyHhxDYfpe/4tM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XATXGyA_1788773866;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XATXGyA_1788773866 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 17:37:46 +0800
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
	linux-cxl@vger.kernel.org,
	Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH v6 2/6] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge dependency
Date: Mon,  7 Sep 2026 17:37:29 +0800
Message-ID: <20260907093735.2753-3-cp0613@linux.alibaba.com>
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

On RISC-V QEMU virt platform with CXL enabled, the probe ordering
of acpi_pci_root (ACPI0016) and cxl_acpi (ACPI0017) is not
guaranteed. If cxl_acpi probes before acpi_pci_root has attached
the CXL host bridges, the CXL port topology will be incomplete
because to_cxl_host_bridge() silently skips devices whose PCI root
is not yet ready.

Add a _DEP object to the ACPI0017 device in the DSDT, declaring
its dependency on the ACPI0016 CXL host bridge devices. This tells
the OS to defer ACPI0017 enumeration until all ACPI0016 devices
have been attached by acpi_pci_root.

This pairs with two kernel commits, both merged in v7.2:
bf5418a5fe63 ("ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host
bridge") makes the ACPI core defer ACPI0017 enumeration while its
_DEP targets are unattached, and 3a59c3b772e5 ("ACPI: PCI: Clear _DEP
dependencies after PCI root bridge attach") clears the dependency
from acpi_pci_root_add() once the host bridge is attached.

Note on kernel compatibility: this is a "new QEMU feature requires a
sufficiently new kernel" situation.  Kernels that process _DEP but
lack the acpi_dev_clear_dependencies() call will leave the CXLM device
deferred, so CXL memory is unusable there; kernels old enough to ignore
_DEP entirely behave exactly as before this change.  In neither case is
existing (non-CXL) PCIe affected.

The resulting DSDT fragment (iasl -d output) for a single CXL host
bridge at bus 0x0C looks like:

  Device (CXLM)
  {
      Name (_HID, "ACPI0017")
      Name (_DEP, Package (0x01)
      {
          \_SB.PC0C
      })
      Method (_STA, 0, NotSerialized)
      {
          Return (0x0B)
      }
      ...
  }

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 2be8c6d572..e1beb2068d 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -525,6 +525,38 @@ static void build_dsdt(GArray *table_data,
     if (s->cxl_devices_state.is_enabled) {
         Aml *cxl_dev = aml_device("CXLM");
         aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+        /*
+         * Declare a _DEP on every ACPI0016 CXL host bridge so the OS
+         * defers ACPI0017 enumeration until acpi_pci_root has attached
+         * the CXL host bridges. Without this, cxl_acpi may probe before
+         * to_cxl_host_bridge() can resolve the PCI root and the CXL
+         * port topology comes up empty.
+         */
+        if (s->pci_bus) {
+            PCIBus *bus;
+            uint32_t num_cxl_hbs = 0;
+
+            QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
+                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
+                    num_cxl_hbs++;
+                }
+            }
+
+            if (num_cxl_hbs > 0) {
+                Aml *dep_pkg = aml_package(num_cxl_hbs);
+
+                QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
+                    if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
+                        aml_append(dep_pkg,
+                                   aml_name("\\_SB.PC%.02X",
+                                            pci_bus_num(bus)));
+                    }
+                }
+                aml_append(cxl_dev, aml_name_decl("_DEP", dep_pkg));
+            }
+        }
+
         Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
         aml_append(method, aml_return(aml_int(0x0B)));
         aml_append(cxl_dev, method);
-- 
2.50.1

