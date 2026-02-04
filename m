Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0363ED137
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207307; cv=none; b=dCag5etY1ZpVvlOyrreRf/irAbtJauH3M4APcgYNk7Bk2qLLnaNJuwcXgZ/lu6EPu4ffB9Uab4x7kxnOjU7F7GFr2ThipReBv8fnJmeoCeEHbIrvX9DPD+l7DfqtEA/71Bg/UHBzeO6oouOVzOQf6Gzh6/eR16y+mTrdE5LYlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207307; c=relaxed/simple;
	bh=wJ1kIT8aDAWXvUFoKBRLkZAjU2awy+0TgG8CP8yqO6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXdpe+GE4zVHZTM1Fq1AJGfDhbmdlU61pI7EXC1yHnqxp7OGyprb8MH8/HuCbn3ml1dzKodasm2s0MspeQ606XspzQU9/FyzaU4BtRrKQABm2Rd1nMFdbJN3eV6uVF0QQBySXibH/dy0aSn5xn+L7voBVacRs4dftZgqVRqB/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5fRC5YV4zJ46Cq;
	Wed,  4 Feb 2026 20:14:15 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BF1A240584;
	Wed,  4 Feb 2026 20:15:04 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 12:15:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v6 5/7] tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
Date: Wed, 4 Feb 2026 12:12:13 +0000
Message-ID: <20260204121215.68897-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204121215.68897-1-Jonathan.Cameron@huawei.com>
References: <20260204121215.68897-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

With the addition of back invalidate support in the CXL emulation relax
the restriction on the CXL Fixed Memory Window Structures so all
advertised ranges continue to support being used with all features that
QEMU emulates.

[064h 0100 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[065h 0101 001h]                    Reserved : 00
[066h 0102 002h]                      Length : 0028
[068h 0104 004h]                    Reserved : 00000000
[06Ch 0108 008h]         Window base address : 0000000110000000
[074h 0116 008h]                 Window size : 0000000100000000
[07Ch 0124 001h]          Interleave Members : 00
[07Dh 0125 001h]       Interleave Arithmetic : 00
[07Eh 0126 002h]                    Reserved : 0000
[080h 0128 004h]                 Granularity : 00000005
[084h 0132 002h]                Restrictions : 002F # Changed from 000F
[086h 0134 002h]                       QtgId : 0000
[088h 0136 004h]                First Target : 0000000C

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/x86/q35/CEDT.cxl            | Bin 184 -> 184 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b4646b5b3147..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/CEDT.cxl",
diff --git a/tests/data/acpi/x86/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
index ff8203af070241bd23dd0eb8a51460692bb7d229..c35f3882eee67aa5613af427234d1ccd196aa249 100644
GIT binary patch
delta 36
ncmdnNxPy_)+0`Xv2Ll5G<Hm_xRgC%*Th)2=fm|LSz6Znrs#OQB

delta 36
ncmdnNxPy_)+0`Xv2Ll5G<Hw0yRgC--Th)2^fm|LSz6ZnrtThL&

-- 
2.51.0

