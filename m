Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904407;
	b=1jWTVbi7Fl27Z7q7gB48KML5bXwMWSKbsFlIaLWyJyx2qbE2RPRp1tPRtl8Nsvtlhfp3
	 X7TFULcplfh+lPWrSTyzzJih0T0OmrQJRMIlqHS7r+KzsTnUdfr+dWI/KvbKQf7uCtiaf
	 eOVvIj1lmxhuhTG0Zy8iqvWB6W9FWCLfMVycHjDSn7zqaFV9CxhWxLJ1QQZSZI9PheGNC
	 hdtk6wErJvvmEMbuoZCLhcD4PXi6zqsUOY7irrJkQxa9frTfPwope1dn+HPIUyRgUJe7h
	 oGYntTu+oEJOB5s7G6oZeUPHw6BRwPMNUoWH6G0W4qpIqnvj6U4IILShiQLm9kc8FDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904407;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VmEtoXLZN28Yd1Sc9a0UP35IDv5GvuAxj1+cjNXXo0A=;
	b=Ze3nX7E/c+9sMAlciPns/x8UqywgeZYafTl2l616omEteblq5zdkgeN/HBU5iQFXGXOx
	 nVviiQHxExUyQCEpiexa4HPxssXuY5CI6Nfj+en8wIKFsrkb39D+H6ehioTHUL8FwtNYJ
	 /Vr8Loq3MnbZo663BUKL8g9QD7E29lfky3wu43dujt8cSQdZzKQ+ySxOLPH98RHo+ArYa
	 uGuGTFUDIXvWkA4Gjbiz6JlxOYKhNCYADMC0XO/xwKl9ngMe0gmDHkVLNl/aBXfQ5uBsx
	 8Ne8gtCNrttrs2CX+c4asxT8tKRcg/ZZQ7vDcdjddMHVbyv88FvoFynncQOb4YNcykA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SRGx4E4F;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62222606A31B;
	Thu,  5 Nov 2026 18:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62222606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SRGx4E4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793904406; x=1825440406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BIoVV/XC8o7hduXTLvTzUlJuObPVpFixG6DuvRMrrJw=;
  b=SRGx4E4FdFoSqRuHpL0OcK28+JWaxedbkKn7nCCaKhNQ4avQO0xqrT2u
   pPbBv/7laMYC//DKidIlHu7PnICgSNsvVdVy9gVwLAeOx5NCyk9dU7raB
   2M1MdiznS8FSaGCvmEVaCkWkmqVTEkzC+hgX/q0yoDVTkfUIlsn8RJajl
   pM2HO+zJtJRuFApMp6z/IO6TBDUANb6s1ygOaKU53GSfnZeHprktYxaok
   REMmoa2RJ5NEC7aW01iNLbYXd5akBjJFW/K7qMkwrPmKeF4kxmuouxTmw
   bdyrufXisE76T3K12SkA6cXzWZKIYnJxKkyz0jNJsI2aQcX7EavIZtKZQ
   w==;
X-CSE-ConnectionGUID: tZw4B/StSpW7R969yTzaWA==
X-CSE-MsgGUID: oq3GEvEZROqfvQNiUWlh4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2699940"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2699940"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:46:46 -0800
X-CSE-ConnectionGUID: uWnG1K/lSwaeLTYKS1OBXw==
X-CSE-MsgGUID: gK9hd52wROmPH6t9bxXt9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8839788"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:46:45 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Pei Gao <pei.gao@intel.com>
Subject: [PATCH] EINJ, CXL: Use PCI domain for CXL root port error injection
Date: Thu,  5 Nov 2026 10:46:41 -0800
Message-ID: <20261105184643.907678-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL protocol error injection identifies the target root port to firmware
using its PCI segment, bus, device, and function (SBDF).

The segment is taken from the PCI host bridge's domain_nr, which is
only populated for emulated PCI domains. On ACPI systems, firmware
receives segment 0 even when the target root port belongs to a nonzero
segment, identifying the wrong PCI device for error injection.

Use the PCI domain of the target root port to obtain the correct segment.
With the host bridge lookup removed, cxl_dport_get_sbdf() can return the
SBDF directly.

Reported-by: Pei Gao <pei.gao@intel.com>
Fixes: 12fb28ea6b1c ("EINJ: Add CXL error type support")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

The ACPI EINJ SBDF field limits the PCI segment to 8 bits, while PCI
segment numbers can be 16 bits. A segment greater than 0xff would be
silently truncated, potentially targeting the wrong device.

I'm unsure how likely systems are to use segments above 0xff. Is this
a practical concern? Would a range check to enforce the ACPI limit
be warranted in a follow-up patch?
---
 drivers/acpi/apei/einj-cxl.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index e70a416ec925..4c8f014378bc 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -47,25 +47,12 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 }
 EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, "CXL");
 
-static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
+static u64 cxl_dport_get_sbdf(struct pci_dev *dport_dev)
 {
-	struct pci_bus *pbus;
-	struct pci_host_bridge *bridge;
-	u64 seg = 0, bus;
+	u64 seg = pci_domain_nr(dport_dev->bus);
+	u64 bus = dport_dev->bus->number;
 
-	pbus = dport_dev->bus;
-	bridge = pci_find_host_bridge(pbus);
-
-	if (!bridge)
-		return -ENODEV;
-
-	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
-		seg = bridge->domain_nr;
-
-	bus = pbus->number;
-	*sbdf = (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
-
-	return 0;
+	return (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
 }
 
 int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
@@ -87,7 +74,7 @@ EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, "CXL");
 
 int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
 {
-	u64 param4 = 0;
+	u64 sbdf;
 	int rc;
 
 	/* Only CXL error types can be specified */
@@ -98,11 +85,9 @@ int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
 	if (rc)
 		return rc;
 
-	rc = cxl_dport_get_sbdf(dport, &param4);
-	if (rc)
-		return rc;
+	sbdf = cxl_dport_get_sbdf(dport);
 
-	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
+	return einj_error_inject(type, 0x4, 0, 0, 0, sbdf);
 }
 EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, "CXL");
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

