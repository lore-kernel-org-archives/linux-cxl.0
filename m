Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950A1EBFF9
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725408028; cv=none; b=fkmJclpsPyK8h/DlK8MkvQ22NHVkacJfEaImcY/RmeBaRu8Mibe/OUucFj1VuGOUyoFBLCSTBpWtvmJKs+sTCKoP1FmX6PzWF64OikUts0dTHDm11m/nKgwNglgC2H7hvFwvsBBS3FecMdq/KA+iHURzzUnZrkiY1njzlNnqm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725408028; c=relaxed/simple;
	bh=U0WzyaAjRYr2+mpbmWElAdgppJDo6syx/mQVnMXOucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMsCBgBMscC5FXW1MgOQsi5wNZK3gbvPALs8QedygFZPPgGSLlxMYE4cGFjTp6kGh4nE7OqSGhFMOMC5YNrK7gVflmydB06mGiZG/ihil4oGSK8DpdWkJLqPGTLvBBcA0lKwq+GmmZC+Z5/ZXhnkiraZThf5UbhbuToah1kxoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98B8C4CEC4;
	Wed,  4 Sep 2024 00:00:27 +0000 (UTC)
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
Subject: [PATCH v3 3/3] cxl: move cxl headers to new linux/cxl/ directory
Date: Tue,  3 Sep 2024 16:59:10 -0700
Message-ID: <20240904000020.1686611-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904000020.1686611-1-dave.jiang@intel.com>
References: <20240904000020.1686611-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Group all cxl related kernel headers into include/linux/cxl directory.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS                                | 2 --
 drivers/acpi/apei/einj-cxl.c               | 2 +-
 drivers/acpi/apei/ghes.c                   | 2 +-
 drivers/cxl/core/port.c                    | 2 +-
 drivers/cxl/cxlmem.h                       | 2 +-
 include/linux/{einj-cxl.h => cxl/einj.h}   | 0
 include/linux/{cxl-event.h => cxl/event.h} | 0
 7 files changed, 4 insertions(+), 6 deletions(-)
 rename include/linux/{einj-cxl.h => cxl/einj.h} (100%)
 rename include/linux/{cxl-event.h => cxl/event.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf59c003da76..45a56af42a79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5620,8 +5620,6 @@ L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	drivers/cxl/
-F:	include/linux/einj-cxl.h
-F:	include/linux/cxl-event.h
 F:	include/linux/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 8b8be0c90709..54ef0eef18fe 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -7,7 +7,7 @@
  *
  * Author: Ben Cheatham <benjamin.cheatham@amd.com>
  */
-#include <linux/einj-cxl.h>
+#include <linux/cxl/einj.h>
 #include <linux/seq_file.h>
 #include <linux/pci.h>
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..55ec68aa417a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -27,7 +27,7 @@
 #include <linux/timer.h>
 #include <linux/cper.h>
 #include <linux/cleanup.h>
-#include <linux/cxl-event.h>
+#include <linux/cxl/event.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..6506dc2a71b1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -3,7 +3,7 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
-#include <linux/einj-cxl.h>
+#include <linux/cxl/einj.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 579d5c647189..838f8f16e7dd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,7 +6,7 @@
 #include <linux/pci.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
-#include <linux/cxl-event.h>
+#include <linux/cxl/event.h>
 #include <linux/node.h>
 #include <linux/cxl/mailbox.h>
 #include "cxl.h"
diff --git a/include/linux/einj-cxl.h b/include/linux/cxl/einj.h
similarity index 100%
rename from include/linux/einj-cxl.h
rename to include/linux/cxl/einj.h
diff --git a/include/linux/cxl-event.h b/include/linux/cxl/event.h
similarity index 100%
rename from include/linux/cxl-event.h
rename to include/linux/cxl/event.h
-- 
2.46.0

