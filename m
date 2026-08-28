Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0472421A42D
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930028; cv=none; b=Iw4PssZVYoMKxOlhX/CYkR0XAE794GpjnReZYlUwCcvPczZfTrFtBgQQe2GhyXsJyn0MigcRoBs/SywJFUACrwkpIc+oIPFoavBf8IMjPlN1A9GLjODqqWTAtL2jfn/yTAV1HWyLE3mDdeTxJcz21HM3nYfxyepdSTPGwrQMRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930028; c=relaxed/simple;
	bh=lWQEokuPavsYrZac67y5iTl8tzqeehrLrSGbe2ebEYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR+s9IKfPPXq3+X1R900nQoaz/5JnGHrXzIa5P5NOG9Hh/zLW+EEtcDkW8l98I2Wn0fdLus9Jid6XUTnUJAr4hxXgMThTkzC43eLgTk2ZCXUAYgOfCuG2la/Y4ajVj0cpImCqKvtG/Ru6OnoocTqvmeD3uFZO6EkuEyDchq9RX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TIcr7pe+; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TIcr7pe+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787930016; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=h9pooA5aBA96lNnW7CUv7B9YADSvf/FDW4PI23kWFUI=;
	b=TIcr7pe+QKkbTsDYTNh0jl+LfHGOjiQQD1ioeLMhrhoz7qw8FIpvswNMfl3EgkBwLHWu16iy9x1pii5IhDQmU8Ef+3ZKnSJy3lYPNbn5WYjeaddfI2SkXoeTkzlV/TDCk37YIdw13cGV0wFFPcQTWsuzTeGZ0Oz4lO1grfO2T0U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9md4yo_1787930013;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9md4yo_1787930013 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 23:13:34 +0800
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
Subject: [PATCH v4 5/6] tests/qtest: Add RISC-V ACPI bios tables test for CXL
Date: Fri, 28 Aug 2026 23:13:04 +0800
Message-ID: <20260828151317.815-6-cp0613@linux.alibaba.com>
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

Add test_acpi_riscv64_virt_tcg_cxl() to verify that enabling CXL on
the RISC-V virt machine produces correct ACPI tables, including the
ACPI0017 CXLM device with _DEP in the DSDT and the CEDT table.

The test boots with cxl=on, one pxb-cxl bus (bus_nr=12), a CXL root
port, a cxl-type3 device and a fixed memory window, mirroring the
existing x86 q35 CXL test pattern.

Since pxb-cxl is a root bus, using -cdrom causes QEMU to auto-plug the
cdrom drive into pxb-cxl, triggering "Only PCI/PCIe bridges can be
plugged into pxb-cxl".  The ISO is instead attached explicitly via a
virtio-scsi-pci controller on pcie.0, following the same approach as
test_acpi_aarch64_virt_tcg_pxb().

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tests/qtest/bios-tables-test.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 5cc526510a..d2b18d8ecb 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2214,6 +2214,56 @@ static void test_acpi_riscv64_virt_tcg(void)
     free_test_data(&data);
 }
 
+#ifdef CONFIG_POSIX
+static void test_acpi_riscv64_virt_tcg_cxl(void)
+{
+    gchar *tmp_path = g_dir_make_tmp("qemu-test-cxl.XXXXXX", NULL);
+    gchar *params;
+
+    test_data data = {
+        .machine = "virt",
+        .arch = "riscv64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
+        .ram_start = 0x80000000ULL,
+        .scan_len = 128ULL * MiB,
+        .variant = ".cxl",
+    };
+
+    /*
+     * While using -cdrom, the cdrom would auto-plug into pxb-cxl because
+     * its bus is also a root bus, triggering "Only PCI/PCIe bridges can be
+     * plugged into pxb-cxl".  Attach the ISO explicitly to a scsi controller
+     * on pcie.0 instead, following the same pattern as
+     * test_acpi_aarch64_virt_tcg_pxb().
+     */
+    params = g_strdup_printf("-cpu rva22s64"
+                             " -machine cxl=on"
+                             " -device pcie-root-port,chassis=1,id=pci.1,bus=pcie.0"
+                             " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                             " -drive file=tests/data/uefi-boot-images/"
+                             "bios-tables-test.riscv64.iso.qcow2,"
+                             "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                             " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                             "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                             " -object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=lsa1,mem-path=%s,size=256M"
+                             " -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1"
+                             " -device cxl-rp,port=0,bus=cxl.1,id=rp1,chassis=0,slot=2"
+                             " -device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1"
+                             " -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,"
+                             "cxl-fmw.0.interleave-granularity=8k",
+                             tmp_path, tmp_path);
+    test_acpi_one(params, &data);
+
+    g_free(params);
+    g_assert(g_rmdir(tmp_path) == 0);
+    g_free(tmp_path);
+    free_test_data(&data);
+}
+#endif /* CONFIG_POSIX */
+
 static void test_acpi_aarch64_virt_tcg(void)
 {
     test_data data = {
@@ -2963,6 +3013,10 @@ int main(int argc, char *argv[])
                            test_acpi_riscv64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/acpispcr",
                            test_acpi_riscv64_virt_tcg_acpi_spcr);
+#ifdef CONFIG_POSIX
+            qtest_add_func("acpi/virt/cxl",
+                           test_acpi_riscv64_virt_tcg_cxl);
+#endif
         }
     } else if (strcmp(arch, "loongarch64") == 0) {
         if (has_tcg && qtest_has_machine("virt")) {
-- 
2.50.1

