Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89F15532A
	for <linux-cxl@vger.kernel.org>; Thu,  5 Sep 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575836; cv=none; b=W4LEk3+nXuPodvdrrfrXPHTdGW5rxRrlNfx0eb3N9iT3VSxvMnE6Wgw7sG0Ipf+n23DKph1mfRWsFioPltVy0Xhq6P/mT2Vfz6z4WvGrPM1A3dc3X9jSLJHpIgR5wBw/NJafX/ckzN+ycvXSLV06wR1F4WYR00IYHVUeGJMw5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575836; c=relaxed/simple;
	bh=+GLIRKeCDczP6Y7fnnDDDPbtKSEATbn7dSZi+Ih/+W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsgYAZrSUKx+GVYpHgzYiryioGH74OqiHu2gNzWkV4i5voyFtZSYRbr3TOSXhUzsB4MuoqIWHjt5HOzhvC22tRYLK7oSTZavFAVVDPqMJ6i5cL/wVB/1yKPtlA2mwhjAQ5ehF+E344NidfjdWKMJ8R0vOlNHa9FPSwmQbCHor3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F42CC4CEC3;
	Thu,  5 Sep 2024 22:37:15 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	fan.ni@samsung.com
Subject: [PATCH v4 1/3] cxl: move cxl headers to new include/cxl/ directory
Date: Thu,  5 Sep 2024 15:35:45 -0700
Message-ID: <20240905223711.1990186-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905223711.1990186-1-dave.jiang@intel.com>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Group all cxl related kernel headers into include/cxl/ directory.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Move to 1/3 (Dan)
- Move to include/cxl/ (Dan)
---
 MAINTAINERS                                | 3 +--
 drivers/acpi/apei/einj-cxl.c               | 2 +-
 drivers/acpi/apei/ghes.c                   | 2 +-
 drivers/cxl/core/port.c                    | 2 +-
 drivers/cxl/cxlmem.h                       | 2 +-
 include/{linux/einj-cxl.h => cxl/einj.h}   | 0
 include/{linux/cxl-event.h => cxl/event.h} | 0
 7 files changed, 5 insertions(+), 6 deletions(-)
 rename include/{linux/einj-cxl.h => cxl/einj.h} (100%)
 rename include/{linux/cxl-event.h => cxl/event.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe83ba7194ea..df59354af438 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5620,8 +5620,7 @@ L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	drivers/cxl/
-F:	include/linux/einj-cxl.h
-F:	include/linux/cxl-event.h
+F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 8b8be0c90709..4f81a119ec08 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -7,9 +7,9 @@
  *
  * Author: Ben Cheatham <benjamin.cheatham@amd.com>
  */
-#include <linux/einj-cxl.h>
 #include <linux/seq_file.h>
 #include <linux/pci.h>
+#include <cxl/einj.h>
 
 #include "apei-internal.h"
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..ada93cfde9ba 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -27,7 +27,6 @@
 #include <linux/timer.h>
 #include <linux/cper.h>
 #include <linux/cleanup.h>
-#include <linux/cxl-event.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -50,6 +49,7 @@
 #include <acpi/apei.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
+#include <cxl/event.h>
 #include <ras/ras_event.h>
 
 #include "apei-internal.h"
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..e0b28a6730c1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -3,7 +3,6 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
-#include <linux/einj-cxl.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -11,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/node.h>
+#include <cxl/einj.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
 #include <cxl.h>
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index afb53d058d62..a81a8982bf93 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,8 +6,8 @@
 #include <linux/cdev.h>
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
-#include <linux/cxl-event.h>
 #include <linux/node.h>
+#include <cxl/event.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
diff --git a/include/linux/einj-cxl.h b/include/cxl/einj.h
similarity index 100%
rename from include/linux/einj-cxl.h
rename to include/cxl/einj.h
diff --git a/include/linux/cxl-event.h b/include/cxl/event.h
similarity index 100%
rename from include/linux/cxl-event.h
rename to include/cxl/event.h
-- 
2.46.0

