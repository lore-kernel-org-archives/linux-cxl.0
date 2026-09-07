Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C74964F
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773883; cv=none; b=Zr7LYGHa4CVovXv7NaG8+2rzUZokWRNZp3ebhr2t4G4GB4s4GsuJ7YCYzE7wQfwTBYgRzZhggzG4Fiy1hw1z6+sXXDOhRmTVR0EwSquB8BPYIW7YYCVCQTAqeT23sNWDqNEXcCqEqQUznJoH9hkjJmZUy9CJulZT3x63cWzaBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773883; c=relaxed/simple;
	bh=HolcMjWX/oomi7HiXY+Dwr6XnEvk30Oh7BgYRL9KIfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2FevU/A380Zjr3cR+iQFNHT9D/DWYPE4bwHQ5s6GlpVW6hmW/HG6PfjO/7EMXIUnq6XHlytAyp5f4hVUCyJnYRY9ceVnw6T9Cu/avjHVBQV7hwjNNNROiEaT9j5A5W78wCaZ4TlUClrDbaIW53UoXsLv5p5rIr0o3qm8rcSaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TXYiNKeC; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TXYiNKeC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788773873; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SryhVp4byEGg6KmzuMhyCoIC7fPCJskTOvbJYaKTFMg=;
	b=TXYiNKeCRw6/IGVqZADIxInMUJpPzKFg6mVs5NZWdxq6UJus1j3hCQo/f/u1hX9zid5gqZ6J7SNtir7naMLBAvtw8n6TqHCzj6QyYkk7ERtSv+Yixw+AcBVW7pb345dJ7i3DT2IteUVbbXGaItdLrLki1sxZbB4MCSbFHYf+i6U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XATXGzQ_1788773870;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XATXGzQ_1788773870 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 17:37:51 +0800
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
Subject: [PATCH v6 6/6] tests/qtest: Update RISC-V CXL ACPI golden master binaries
Date: Mon,  7 Sep 2026 17:37:33 +0800
Message-ID: <20260907093735.2753-7-cp0613@linux.alibaba.com>
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

Populate the DSDT.cxl and CEDT.cxl golden master binaries for the
RISC-V CXL bios-tables test and empty
bios-tables-test-allowed-diff.h, following the bios-tables-test update
process.

The expected AML added by this series is:

DSDT.cxl:
  Device (PC0C)        // ACPI0016 CXL host bridge (pxb-cxl, bus 0x0C)
    Name (_CRS, ResourceTemplate () {
        DWordMemory (... 0x40400000 .. 0x405FFFFF ...)   // 32-bit MMIO
        QWordMemory (... 0x400100000 .. 0x40010FFFF ...) // 64-bit MMIO
        WordBusNumber (... 0x000C .. 0x000D ...)
    })
    Method (_OSC, ...)   // PCI host bridge + CXL UUIDs
  Device (CXLM)        // ACPI0017 CXL memory controller
    Name (_HID, "ACPI0017")
    Name (_DEP, Package () { \_SB.PC0C })
    Method (_STA, ...) / Method (_DSM, ...)

CEDT.cxl:
  CHBS : CXL Host Bridge Structure, Register base 0x800000000
  CFMWS: CXL Fixed Memory Window, base 0x810000000, size 4G

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tests/data/acpi/riscv64/virt/CEDT.cxl       | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl       | Bin 0 -> 6331 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/riscv64/virt/CEDT.cxl b/tests/data/acpi/riscv64/virt/CEDT.cxl
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..81d746dfb09ccb147e26bb64060404ca3191d097 100644
GIT binary patch
literal 108
zc-nJzbqUE~U|?VjaPoKd2v%^42yj*a0!E-1hz+6{7!(+IKx!BefCEf2LP-snumA^?
O0aMEg#QH!C(hmS*@&^F`

literal 0
Hc-jL100001

diff --git a/tests/data/acpi/riscv64/virt/DSDT.cxl b/tests/data/acpi/riscv64/virt/DSDT.cxl
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c3d68cf3a080ab66160f6847267fe4b9f8a8c6fc 100644
GIT binary patch
literal 6331
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

literal 0
Hc-jL100001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index c05fb697a5..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"riscv64/virt/DSDT.cxl",
-"riscv64/virt/CEDT.cxl",
-- 
2.50.1

