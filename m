Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751838887D
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775522; cv=none; b=MdldqrdB+BHjIsn2ZtvkdMSfq2YOoIUTJJl/f22zibleG6MVwovw0RX/BjNoxcUlPFrDFHOGdVzWKcfhP2LXV8h4+9CEgymGmaaYZ5bSZbhg5PPe/wRLiX3uQH1M+aYnNal6Ui54hzMvo0TaEXQ69ueBygIZhs4op1yaT5DH6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775522; c=relaxed/simple;
	bh=GGXA1nS3QTOJzyazW+bmXjlqXpi0NwDnrxzu9N4dTE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDLO6HgLEfod6Yo3wv4DWeTytF9QxWiCEEQ0xtnETiPzCyuGRVLC0KcKysMObeDsR+jQ7RZDcWfkuRbyPGtxOBlIFvAH1rqV6gnW2xwlXuAeIfPZv/vbNYpKbYkgKf4j0z1RPH/SjP5hU7zT5548V8szfyA0EL/nvBQzVkYNm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B8/In50F; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B8/In50F"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781775516; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XfZ905nYQgkGS4XfPh5nE3bF0mThL6pU9qgBQH+MnRE=;
	b=B8/In50FKB8xlGUI4knSFx1YwG8l3f+Vk5fqV8TwApd4fSPdyVGOsSKpjFg4v7B1KPAriiKDegwJ1e5kr+YEyECiADroy07OhWlfwdDJ3jhhZW+drm7KhpU+uStgA02FLKWRuwQijF9iflzuLLxbpo9i0uszsoYPTxyC/scT6I4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X56RwMn_1781775515;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X56RwMn_1781775515 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:38:36 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org,
	pbonzini@redhat.com,
	palmer@dabbelt.com,
	alistair.francis@wdc.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu.zevorn@gmail.com,
	sunilvl@ventanamicro.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	imammedo@redhat.com,
	mst@redhat.com,
	guoren@kernel.org
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge dependency
Date: Thu, 18 Jun 2026 17:38:24 +0800
Message-ID: <20260618093827.3507-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618093827.3507-1-cp0613@linux.alibaba.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
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

This requires a corresponding kernel change to call
acpi_dev_clear_dependencies() in acpi_pci_root_add().

The resulting DSDT fragment (iasl -d output) for a single CXL host
bridge at bus 0x01 looks like:

  Device (CXLM)
  {
      Name (_HID, "ACPI0017")
      Name (_DEP, Package (0x01)
      {
          \_SB.PC01
      })
      Method (_STA, 0, NotSerialized)
      {
          Return (0x0B)
      }
      ...
  }

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 309d64b322..3598e55243 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -510,6 +510,38 @@ static void build_dsdt(GArray *table_data,
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

