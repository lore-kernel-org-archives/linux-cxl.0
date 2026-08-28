Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007F47255B
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930019; cv=none; b=Us7wyzO6hYllzHAERY8apmeFZXHma+pAtRMCcg3/LA7dXALngSMi+E+ppuEp5JMO79IcdTVMWS9U64Httpx+m0bGMYJEMqhH9irRVnV6BljsMbz9VZcGYnoUktSw0n0XdoPZfHwn8rK+WTd31jQa9w8HEx7XaY86iDyBZC9WwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930019; c=relaxed/simple;
	bh=JjaaEl00RR5XNAFD2B8bPFRX/hHOt9201Cns37AtaZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEqb1Ma4XvYdAqqQ0pjHdJXdKBwUA7o1Bay30cUiRV82kFM9efUZ1ySvWDCqoJbPNafGc0f7JeGOjlbnjuQbyBG8bUT0DxtjLM4E/bi0gOkmtVh58Q4RVqtrx4UH1NhSCDx56JuLIvd29pDQWw1BY/rcEH+Fh+75wVyDrsUJxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VtYqamkE; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VtYqamkE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787930015; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UQbJXq6uKESS/KbL945Kj00dHUab8gFhyfT/6+OH6JE=;
	b=VtYqamkE8Z9IP7fM7m2u+40+ev1BKhrUA+I1eCB8aWSMyec8d9r6HOeJu/JcU9CKLfg6JWrCEXgAWP75CUwmpn492xmZE88NdtNt1leI3QxZt/j3gUu8Fmmz6ec503W/gDrjGuefogAX4WmyBZc2s44ZKmaGEt5wW9IJ7DOHGsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9md4yg_1787930012;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9md4yg_1787930012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 23:13:33 +0800
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
Subject: [PATCH v4 4/6] tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
Date: Fri, 28 Aug 2026 23:13:03 +0800
Message-ID: <20260828151317.815-5-cp0613@linux.alibaba.com>
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

Add empty DSDT.cxl and CEDT.cxl golden files and list them in
bios-tables-test-allowed-diff.h, in preparation for the RISC-V CXL
bios-tables test added in the following patch.  The populated golden
master binaries are committed separately in a final patch, following
the bios-tables-test update process.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

v4:
- Split the CXL bios-tables test into the staged flow documented in
  bios-tables-test.c: empty golden files + allowed-diff.h, then the test
  code, then the populated golden master binaries with an emptied
  allowed-diff.h in a final patch (matching how the riscv64 goldens were
  originally added upstream).

 tests/data/acpi/riscv64/virt/CEDT.cxl       | 0
 tests/data/acpi/riscv64/virt/DSDT.cxl       | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 3 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

diff --git a/tests/data/acpi/riscv64/virt/CEDT.cxl b/tests/data/acpi/riscv64/virt/CEDT.cxl
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/riscv64/virt/DSDT.cxl b/tests/data/acpi/riscv64/virt/DSDT.cxl
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..c05fb697a5 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"riscv64/virt/DSDT.cxl",
+"riscv64/virt/CEDT.cxl",
-- 
2.50.1

