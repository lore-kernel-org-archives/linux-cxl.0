Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB752DF68
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182700; cv=none; b=aYV3BSVeMONsaZTHGdDYT8ElCyj7hKBTR2oFj36UlsYnQB8bYhBPKCrXEB9fPp3A7wOCU4j706oNMmsBTXiEkxcjMEVM69Ieu5E+mFo50NFVBL0Mp/cgITrAcqvIjihmr8EKO5eUAozVg5ulmSr1JjSq+RCQHxWz7/VFbtXHV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182700; c=relaxed/simple;
	bh=JsECoFxdH2WSSQjwVZ3sfrsREVyyl6kTU30w/228gj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpxZlWdPOMzr8xN/7RysJb9FQxGoe4tlf5JszasRUXYuW1ogw0meodBiG09kVRKgqNCFpAfnfyhhdLao+iec0OdgHlKdJHLoBymJs1aMcTKqiLeanpqQmh48vCKGZ0sHJXvwMAUQ/zKns1QAgExQUbJU23nyWYqOnUfyw29QgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DC9C4CEE4;
	Wed, 14 May 2025 00:31:39 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH 3/4] cxl: docs/platform/acpi/srat Add generic target documentation
Date: Tue, 13 May 2025 17:31:32 -0700
Message-ID: <20250514003133.584401-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514003133.584401-1-dave.jiang@intel.com>
References: <20250514003133.584401-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description in the SRAT document to descript the Generic Port
Affinity sub-table.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 .../driver-api/cxl/platform/acpi/srat.rst     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/driver-api/cxl/platform/acpi/srat.rst b/Documentation/driver-api/cxl/platform/acpi/srat.rst
index cc7687645de7..500413b96e70 100644
--- a/Documentation/driver-api/cxl/platform/acpi/srat.rst
+++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
@@ -42,3 +42,24 @@ Example ::
                Enabled : 1
          Hot Pluggable : 1
           Non-Volatile : 0
+
+
+Generic Port Affinity
+=====================
+The Generic Port Affinity subtable provides an association between a proximity
+domain and a device handle representing a Generic Port such as a CXL host
+bridge. With the association, latency and bandwidth numbers can be retrieved
+from the SRAT for the path between CPU(s) (initiator) and the Generic Port.
+This helps with constructing the performance coordinates for CXL devices that
+are hot-plugged and not able to be enumerated by the platform firmware.
+
+Example ::
+
+         Subtable Type : 06 [Generic Port Affinity]
+                Length : 20               <- 32d, length of table
+              Reserved : 00
+    Device Handle Type : 00               <- 0 - ACPI, 1 - PCI
+      Proximity Domain : 00000001
+         Device Handle : ACPI0016:01
+                 Flags : 00000001         <- Bit 0 (Enabled)
+              Reserved : 00000000
-- 
2.49.0

