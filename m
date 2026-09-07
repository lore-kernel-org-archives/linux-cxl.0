Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01614964F
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773874; cv=none; b=rDVGJ0/WBj8JB4Z9YibZ70dYs/DQ1NpP8MKC3pZ0eR0KB/jdTMjCS9yAW+dwu1mikI3brky4lewVOAELrdlARlPBg2eGtelrWWKt0U6p5UFOmzgFIbQ5psTSp5hjrzbo66QxdQ1DHVDe7xQEDbl5N1ZtAtqFIgxeZmT0I/Ys7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773874; c=relaxed/simple;
	bh=CAKtb2xTYv7nHBWIuBofuzYpsGZ2u9pbATHRpW44bsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry85xyOz9c7t2EGpdI0sBWv+i51Hi/ycQWIT4/s/AFneM70HeeJnW2zYNA0lpeYLoMQ7XnNSSZBGDzlSbxTiuCdbMCmn6/0QKpaUJbhXJSplUxQS9SlgjQCZ8piSPGVVSvKXwgopSZ3OyGPAlU0AH9W0MiGnqKgLFZ+5XoTsnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R5tgHFNb; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R5tgHFNb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788773870; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WmhvmGPUNy77AIuahmD4mTp3kq8V1wWxZtZ1BZHb17w=;
	b=R5tgHFNbtyoH5a1JLq57Z9Q4nThJyCDA9pQavTJGzsE5Dvqqz0sYRhgOg+I9x2TvVDPYZb5OBifj0LPEKTbaDjqZJrXnaWvsK5UnIAatleVnds2d/YMaW/f2vpXa6sco7XW1bP2L6KA09TfNazSuXeO5umfWMtBBSz+kVlKnO1g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XATXGyV_1788773868;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XATXGyV_1788773868 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 17:37:48 +0800
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
Subject: [PATCH v6 4/6] tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
Date: Mon,  7 Sep 2026 17:37:31 +0800
Message-ID: <20260907093735.2753-5-cp0613@linux.alibaba.com>
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

Add empty DSDT.cxl and CEDT.cxl golden files and list them in
bios-tables-test-allowed-diff.h, in preparation for the RISC-V CXL
bios-tables test added in the following patch.  The populated golden
master binaries are committed separately in a final patch, following
the bios-tables-test update process.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
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

