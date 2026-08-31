Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1311416849
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182642; cv=none; b=LNGbBfB70RcNOZfayaRbfurCnlEiKZyqHqynSE6ZcUjojrcis/8jre/pP7cZZrSq6VzD5KYu7WEmnKv6iDr9p/oXS8AkaBo9Hi+hCbJbfgaUmPIjj1hdy++uMzF1TO0ZEv2V+mR8uAu8puzjMLUky8iT8S/yK6NERPa1xgXtIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182642; c=relaxed/simple;
	bh=OFURnFTE+gQ13q4dRfeWIG5TxiPHuXtpUbA5qewxOfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl1h7phD/u+IwwBbwteWajk0S2xq2wUYYtrn0/MLRZGrwzUpuXnMi4ULgZOzl2AvGMx60k7TrYUBdCQWgja0i/gsmqbiTF0XbmTsL74AzJ2SirKgZlMpUQ8fJ/EfncCbe/9l3O8ks303zU4kwp7IPvcf8R4LycQGUXQn+HfUbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kJntb+y8; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kJntb+y8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788182637; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qUoiwS+nVtbX4Kx79t0Lc82rPB+U+QOyOnVoT6G/J5I=;
	b=kJntb+y8cwRjcIEgJirLLUXIM5a+hZE2/y2QnLboe05wH9/cyx1GUa0FYOYq8KLKigiVjUGMJcu5hmcW+14DVsZIevgLPV6kHe1U0Slnk/O+iPKQkDvHSgfoOoA6GjKyKEoYTw9oLJPMzTv3y1cJke16B7h8ul2p50a8pI6Knzc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9znfql_1788182635;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9znfql_1788182635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 21:23:56 +0800
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
Subject: [PATCH v5 4/6] tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
Date: Mon, 31 Aug 2026 21:23:35 +0800
Message-ID: <20260831132340.5345-5-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-1-cp0613@linux.alibaba.com>
References: <20260831132340.5345-1-cp0613@linux.alibaba.com>
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

