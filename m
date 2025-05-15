Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BE4A1D
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267786; cv=none; b=lgudQft7kohQMtVFyoldsY4/ZD65GbO6pW9NVC5UZIJLdx+xuEiRleDjA8I82XznYAphNzEh0OWA+MIZwvMSy2Z4nSjCvSTqPCAIkiFp91oe1cb5euVf4Hx3T/Ybx/Z5qK0P4NcF4cRUUDhZjCGUoT1oTUbh0tMeoK0gQkwZ9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267786; c=relaxed/simple;
	bh=BKKg/9LUKu9i5alv91M7qxvzqFrYYE9l9XI7kpzpNwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD9b2D/0Lf2bs9s0ekVLckS2pT58o9DInBxYB8l8UDiF2XQwijM+ssiDvHtFUOIUnm0CWUs946Ku/OVmbirkxNh9cTVLh24wStiyoh2uU1s1UQVZ7T7hJ4u9M4FtaJnjS14dRt4GAR6KOYPakBgWY726Rd8lZFXSUhWZi+t6PE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5996DC4CEE3;
	Thu, 15 May 2025 00:09:45 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH v2 1/3] cxl: docs/platform/cdat reference documentation
Date: Wed, 14 May 2025 17:09:21 -0700
Message-ID: <20250515000923.2590820-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515000923.2590820-1-dave.jiang@intel.com>
References: <20250515000923.2590820-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for CDAT structures for CXL usages.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Move everything into cdat.rst (Gregory)
- Update various languages in the doc for clarification (Gregory)
- Add a term definition section (Gregory)
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../driver-api/cxl/platform/cdat.rst          | 118 ++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 366faf851fc7..9e1414ad3357 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -27,6 +27,7 @@ that have impacts on each other.  The docs here break up configurations steps.
 
    platform/bios-and-efi
    platform/acpi
+   platform/cdat
    platform/example-configs
 
 .. toctree::
diff --git a/Documentation/driver-api/cxl/platform/cdat.rst b/Documentation/driver-api/cxl/platform/cdat.rst
new file mode 100644
index 000000000000..34bbe7264d71
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/cdat.rst
@@ -0,0 +1,118 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Coherent Device Attribute Table (CDAT)
+======================================
+
+The CDAT provides functional and performance attributes of devices such
+as CXL accelerators, switches, or endpoints.  The table formatting is
+similar to ACPI tables. CDAT data may be parsed by BIOS at boot or may
+be enumerated at runtime (after device hotplug, for example).
+
+Terminology:
+DPA - Device Physical Address, used by the CXL device to denote the address
+it supports for that device.
+
+DSMADHandle - A device unique handle that is associated with a DPA range
+defined by the DSMAS table.
+
+
+===============================================
+Device Scoped Memory Affinity Structure (DSMAS)
+===============================================
+
+The DSMAS contains information such as DSMADHandle, the DPA Base, and DPA
+Length.
+
+This table is used by Linux in conjunction with the Device Scoped Latency and
+Bandwidth Information Structure (DSLBIS) to determine the performance
+attributes of the CXL device itself.
+
+Example ::
+
+ Structure Type : 00 [DSMAS]
+       Reserved : 00
+         Length : 0018              <- 24d, size of structure
+    DSMADHandle : 01
+          Flags : 00
+       Reserved : 0000
+       DPA Base : 0000000040000000  <- 1GiB base
+     DPA Length : 0000000080000000  <- 2GiB size
+
+
+==================================================================
+Device Scoped Latency and Bandwidth Information Structure (DSLBIS)
+==================================================================
+
+This table is used by Linux in conjunction with DSMAS to determine the
+performance attributes of a CXL device.  The DSLBIS contains latency
+and bandwidth information based on DSMADHandle matching.
+
+Example ::
+
+   Structure Type : 01 [DSLBIS]
+         Reserved : 00
+           Length : 18                     <- 24d, size of structure
+           Handle : 0001                   <- DSMAS handle
+            Flags : 00                     <- Matches flag field for HMAT SLLBIS
+        Data Type : 00                     <- Latency
+ Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
+            Entry : 010000000000           <- First byte used here, CXL LTC
+         Reserved : 0000
+
+   Structure Type : 01 [DSLBIS]
+         Reserved : 00
+           Length : 18                     <- 24d, size of structure
+           Handle : 0001                   <- DSMAS handle
+            Flags : 00                     <- Matches flag field for HMAT SLLBIS
+        Data Type : 03                     <- Bandwidth
+ Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
+            Entry : 020000000000           <- First byte used here, CXL BW
+         Reserved : 0000
+
+
+==================================================================
+Switch Scoped Latency and Bandwidth Information Structure (SSLBIS)
+==================================================================
+
+The SSLBIS contains information about the latency and bandwidth of a switch.
+
+The table is used by Linux to compute the performance coordinates of a CXL path
+from the device to the root port where a switch is part of the path.
+
+Example ::
+
+  Structure Type : 05 [SSLBIS]
+        Reserved : 00
+          Length : 20                           <- 32d, length of record, including SSLB entries
+       Data Type : 00                           <- Latency
+        Reserved : 000000
+ Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
+
+                                                <- SSLB Entry 0
+       Port X ID : 0100                         <- First port, 0100h represents an upstream port
+       Port Y ID : 0000                         <- Second port, downstream port 0
+         Latency : 0100                         <- Port latency
+        Reserved : 0000
+                                                <- SSLB Entry 1
+       Port X ID : 0100
+       Port Y ID : 0001
+         Latency : 0100
+        Reserved : 0000
+
+
+  Structure Type : 05 [SSLBIS]
+        Reserved : 00
+          Length : 18                           <- 24d, length of record, including SSLB entry
+       Data Type : 03                           <- Bandwidth
+        Reserved : 000000
+ Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
+
+                                                <- SSLB Entry 0
+       Port X ID : 0100                         <- First port, 0100h represents an upstream port
+       Port Y ID : FFFF                         <- Second port, FFFFh indicates any port
+       Bandwidth : 1200                         <- Port bandwidth
+        Reserved : 0000
+
+The CXL driver uses a combination of CDAT, HMAT, SRAT, and other data to
+generate "whole path performance" data for a CXL device.
-- 
2.49.0

