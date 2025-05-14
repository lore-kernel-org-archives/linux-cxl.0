Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E72566
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182697; cv=none; b=LBV+f28f6UOSBXtty7VEzTax+Ke5BX8Tsxw3s1UULYl8Vc1t7hzCTRm6V3AW5ELxbbYRmpwDMS7l6tmXKMFGyrxGp39NiAi68xO8MP4GDfipE3APMNe7DJQOhNDpMCEkgNjeKYQ2/mbPhBWp1cK3D3Aq7aeo5//mwIKkqIzOsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182697; c=relaxed/simple;
	bh=jmTXE7HxSOhl+gXzjhNbCuHIPWMeDa10ClJv/9y+fnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9btdJwCeeg3GW6vnHduLasFeKlKn5mnFaOPxazaraqW/JeYrFM3xjTyUI4MCo0fEliRwMNAIZUpjq2LR2PsuWCMP20Ta1y+12txSBEuJZ8h8/pt01Mbi/gAm413tHGU6ry79FR2YKb1Trb+5wAlbKB0AZAzoejVm2AHw/CUcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C87C4CEED;
	Wed, 14 May 2025 00:31:36 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH 1/4] cxl: docs/platform/cdat reference documentation
Date: Tue, 13 May 2025 17:31:30 -0700
Message-ID: <20250514003133.584401-2-dave.jiang@intel.com>
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

Add documentation for CDAT sub-tables for CXL usages.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/driver-api/cxl/index.rst        |  1 +
 .../driver-api/cxl/platform/cdat.rst          | 24 ++++++++++
 .../driver-api/cxl/platform/cdat/dslbis.rst   | 33 ++++++++++++++
 .../driver-api/cxl/platform/cdat/dsmas.rst    | 23 ++++++++++
 .../driver-api/cxl/platform/cdat/sslbis.rst   | 45 +++++++++++++++++++
 5 files changed, 126 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/cdat/dslbis.rst
 create mode 100644 Documentation/driver-api/cxl/platform/cdat/dsmas.rst
 create mode 100644 Documentation/driver-api/cxl/platform/cdat/sslbis.rst

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
index 000000000000..3e0ce7099db3
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/cdat.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+CDAT Tables
+===========
+
+The Coherent Device Attribute Table (CDAT) is created to provide a standard way to
+expose the properties of a device such as an CXL accelerator or switch. The table
+formatting is similar to ACPI tables. The tables are created to provide performance
+calculation of a hot-plugged device where ACPI HMAT+SRAT tables are not able to
+enumerate the performance by the BIOS ahead of time.
+
+The following CDAT tables contain *static* configuration and performance data about CXL devices.
+
+.. toctree::
+   :maxdepth: 1
+
+   cdat/dsmas.rst
+   cdat/dslbis.rst
+   cdat/sslbis.rst
+
+The Linux CXL driver uses these tables in addition to attributes of the CXL links and
+Generic Target performance data provided by HMAT+SRAT to create the whole path performance
+for a CXL device.
diff --git a/Documentation/driver-api/cxl/platform/cdat/dslbis.rst b/Documentation/driver-api/cxl/platform/cdat/dslbis.rst
new file mode 100644
index 000000000000..91ae426b2e8b
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/cdat/dslbis.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================================================
+DSLBIS - Device Scoped Latency and Bandwidth Information Structure
+==================================================================
+
+The Device Scoped Latency and Bandwidth Information Structure contains latency
+and bandwidth information based on DSMADHandle matching.
+
+This table is used by Linux in conjunction with Device scoped Memory Affinity
+Structure to determine the performance attributes of a CXL device.
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
diff --git a/Documentation/driver-api/cxl/platform/cdat/dsmas.rst b/Documentation/driver-api/cxl/platform/cdat/dsmas.rst
new file mode 100644
index 000000000000..8c32ddb3381c
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/cdat/dsmas.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================================
+DSMAS - Device Scoped Memory Affinity Structure
+===============================================
+
+The Device Scoped Memory Affinity Structure contains information such as
+DSMADHandle, the DPA Base, and DPA Length.
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
diff --git a/Documentation/driver-api/cxl/platform/cdat/sslbis.rst b/Documentation/driver-api/cxl/platform/cdat/sslbis.rst
new file mode 100644
index 000000000000..e299575493fa
--- /dev/null
+++ b/Documentation/driver-api/cxl/platform/cdat/sslbis.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================================================
+SSLBIS - Switch Scoped Latency and Bandwidth Information Structure
+==================================================================
+
+The Switch Scoped Latency Bandwidth Information Structure contains information
+about the latency and bandwidth of a switch.
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
-- 
2.49.0

