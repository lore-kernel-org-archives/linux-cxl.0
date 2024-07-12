Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B62D512
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782858; cv=none; b=nI7JGDRbfOgl1ghQcedp5aVRLI9ER+or/d3+BEcO6hrLS4NMa3RaeoS0rDmLJ2M5b6hot9yxrCPN3kaffnqOIPXnqmb7W60cJtp8IMhr1YmULqHypXGKlIw6Hu1m+1hI4kmti1/6PlHdrnGzjtlHQjuB4l2utBXGlVvwcMB2I08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782858; c=relaxed/simple;
	bh=oZKX9xBZwRGWNI7o5ka5dKL7+n/XPzCaGafRXxN7HGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8m+9+ukJwZMVuh3nhfk/ZFamuJtVABRtgvK5HhFn5ghIDrk61pRwPJqqggLzSYTl8S7RQ5bkY0s6HYenbRzqyhFLDaay+T51wtVc3eN7TDpZmhyiUmK7bxXZNInFP7RzQbzeyS9zX9NyN51iop7tFu4gXpy67xPhZtnVbnL/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL87X0kRwz6K982;
	Fri, 12 Jul 2024 19:12:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D4564140B63;
	Fri, 12 Jul 2024 19:14:14 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:14:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 11/13] bios-tables-test: Allow for new acpihmat-generic-x test data.
Date: Fri, 12 Jul 2024 12:08:15 +0100
Message-ID: <20240712110837.1439736-12-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

The test to be added exercises many corner cases of the SRAT and HMAT table
generation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5: No change.
---
 tests/qtest/bios-tables-test-allowed-diff.h     | 5 +++++
 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x | 0
 6 files changed, 5 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3c0967078f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/APIC.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x b/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.43.0

