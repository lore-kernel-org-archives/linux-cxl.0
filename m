Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29B1B14E9
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899686; cv=none; b=RKFrDE0qhO01yBPZQy4ibMbf1uNW1X0QkLDeE2QhvnnxXOUsbbeVIYvGYXfdtubEh+DuNhNPlwaA2gX7GIkV5ROgHHFgFdeUj5sFl736N/0fc9abT+e68T+qf8Ywdx3+wOfm89WgOfwsCRZMdZvB0jJO/YVuFRtbgI2uEmIwrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899686; c=relaxed/simple;
	bh=BNjJ5RtLXDvDGYO29/q5ilhlTdI37FXceAYKvWVg/mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3pKodl2IFsjxgeZTNDXwQPdJ/ivyP8ZGszVmXVnU4dqD6HDWfeZlXltaRUba0tMcurFxzEEEqvL9GdByp+XCS2a9x8jqIW1RleVw1bCH+6M7SK+gvqlkdJPP12+qqFtJUEajJJcGPoDKnzrS9A3Wum5BQ4dLvg6PUN+ZCs1R+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4ll44B4Hz6GD5J;
	Fri, 21 Jun 2024 00:08:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D8A851409EA;
	Fri, 21 Jun 2024 00:08:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:08:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 09/11] bios-tables-test: Allow for new acpihmat-generic-x test data.
Date: Thu, 20 Jun 2024 17:03:17 +0100
Message-ID: <20240620160324.109058-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

The test to be added exercises many corners of the SRAT and HMAT table
generation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3: No change
---
 tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
 tests/data/acpi/q35/APIC.acpihmat-generic-x | 0
 tests/data/acpi/q35/CEDT.acpihmat-generic-x | 0
 tests/data/acpi/q35/DSDT.acpihmat-generic-x | 0
 tests/data/acpi/q35/HMAT.acpihmat-generic-x | 0
 tests/data/acpi/q35/SRAT.acpihmat-generic-x | 0
 6 files changed, 5 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a5aa801c99 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/APIC.acpihmat-generic-x",
+"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
+"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
+"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/q35/APIC.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/q35/CEDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/q35/DSDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/q35/HMAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/q35/SRAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.43.0

