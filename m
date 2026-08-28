Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9D3DAADD
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930033; cv=none; b=bR/vTPmfcg8s2y9oB+6/CoJVbgjQJy/qhrBUIKcDyDQiN4B2+pbHbs/nIcueEOMIo37PZPKKfKGV0G2O6z2iPem8xzRTfgwZHABqP9gYu596KsW7FY2nEs5Hnk4cnwO9ROUM9frzy7etX/IFP0L7v3uv1b1V1EjD2ytSXW5Bi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930033; c=relaxed/simple;
	bh=ZJwIOYk+f/fiogKFtzynB3tBpSKcAYzWEOw8qwQvHJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQTzjpqXIN+mXZzvT0TnR2mZfKs2LcPAD8wDtcbyKxWYCv7SE02b8kZpNvcAq5aEOfLkdWfpnBUxAiRn3bxfG/qKGoV/2d2HExdKpaZr6jdGIKLxwsxQn8FiQ/Pjvx3EKqa1tb5gjTSUvj81xHlxOSC9md28+x35kltpcEPSW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vFyrLj3O; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vFyrLj3O"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787930017; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ooUWlanYV7gNkQZNCh6ZXUk1lJgKVukrOSt2aaGbE7k=;
	b=vFyrLj3O+A08k9zhKfOagDKR6WOX3hhpUWbJKtV+xTwzG8MyTvkR1a57EwjPq2h6SbK7cYp4dWj11dMapRrBWxufTtNHx/NiBP8UiGwihwcHdGll0COIPkmd0boCNlcAdpvkd687fKSwtAyqyBZ/qGbzSRrguL1rqgvhxA11f/w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9md4z4_1787930015;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9md4z4_1787930015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 23:13:35 +0800
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
Subject: [PATCH v4 6/6] tests/qtest: Update RISC-V CXL ACPI golden master binaries
Date: Fri, 28 Aug 2026 23:13:05 +0800
Message-ID: <20260828151317.815-7-cp0613@linux.alibaba.com>
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

Populate the DSDT.cxl and CEDT.cxl golden master binaries for the
RISC-V CXL bios-tables test and empty
bios-tables-test-allowed-diff.h, following the bios-tables-test update
process.

The expected AML added by this series is:

DSDT.cxl:
  Device (PC0C)        // ACPI0016 CXL host bridge (pxb-cxl, bus 0x0C)
    Name (_CRS, ResourceTemplate () {
        DWordMemory (... 0x40400000 .. 0x405FFFFF ...)   // 32-bit MMIO
        QWordMemory (... 0x400100000 .. 0x40020FFFF ...) // 64-bit MMIO
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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c42c37a6a25998a70c42098b500a5e7163ae1513 100644
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

