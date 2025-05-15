Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7510E4
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267787; cv=none; b=eLXiO3ygrzz+hpewrSnR+y/Apo3W4v9W5wRSyjOgGIrOP/rSN1MeX/Iq9NfaP0EkdLwi8AUH5uTI1jguKDOv17N/waORAWlneGPFz0kz/Vbhc8e4fADM8FpnNk5C0XJPJBdOcZFq3ZiJyxdd/o5kd9wf/CzLLQmtKAWq37LR57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267787; c=relaxed/simple;
	bh=RizAUUkKxsQrjyQa28rDw0JbPSPSjmeFS2QuK7QRjAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgI+Rv+3TL8TWiFRPHptgqsEBUNpokgj+4kvCJKP4QYJcKtAfgJ77eoC81vnfelXYRxI4ZxtxatAZ8lmrLB28b8mhFn3E6ZXWuh12jpu2dARGQmuPQEIl6JoRgn8+2uZ8wzMpDY9XSJQT0M0ezlDANN0CT0/QgYG+2BzdAeezQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBEDC4CEED;
	Thu, 15 May 2025 00:09:46 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH v2 2/3] cxl: docs/platform/acpi/srat Add generic target documentation
Date: Wed, 14 May 2025 17:09:22 -0700
Message-ID: <20250515000923.2590820-3-dave.jiang@intel.com>
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

Add description in the SRAT document to descript the Generic Port
Affinity sub-table.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Clarify sentence in usage description. (Gregory)
- Added association of SRAT to HMAT.
---
 .../driver-api/cxl/platform/acpi/srat.rst     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/driver-api/cxl/platform/acpi/srat.rst b/Documentation/driver-api/cxl/platform/acpi/srat.rst
index 56d7bbb18c3b..cc98ca0e508e 100644
--- a/Documentation/driver-api/cxl/platform/acpi/srat.rst
+++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
@@ -42,3 +42,30 @@ Example ::
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
+This is used to construct performance coordinates for hotplugged CXL DEVICES,
+which cannot be enumerated at boot by platform firmware.
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
+
+The Proximity Domain is matched up to the :doc:`HMAT <hmat>` SSLBI Target
+Proximity Domain List for the related latency or bandwidth numbers. Those
+performance numbers are tied to a CXL host bridge via the Device Handle.
+The driver uses the association to retrieve the Generic Port performance
+numbers for the whole CXL path access coordinates calculation.
-- 
2.49.0

