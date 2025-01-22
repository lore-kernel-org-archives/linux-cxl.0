Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52411CAA99
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589938; cv=none; b=a4SbzvfPTIbema7KAnKjlnEaP3/YsEOnafSF6Adl574ocHLIW4JJ+3Y2VK5A+d+MCcUYSXkkAaKws5JptiTP4124Dwn7We+OG08FVrLjGTKemThoGmqjpJlyFURFu21mBRBIfKAGeHvt0fejv4jFlTfMMnqxRISSr3QgWC+zymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589938; c=relaxed/simple;
	bh=ggdnxkcsFMWwRKkLCmTBboYzCkMHzOS/V5VB1aA8cNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHBShaXC5b2R3BpQL7a0hE7X2LCmXJFt2jcN3W+ps8b1QqNcV81O6/qypUD/VkJg2olLNzzk9gTG/dAQfbzWSobW6f5s5+zJaTzrs4Ko2USCko9jaxam5xHR3h0NxZ2yBvTSgGk+3gDLgYFYzrenTD68HErsFp/0zhiPJBsNIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB3EC4CED6;
	Wed, 22 Jan 2025 23:52:18 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [PATCH v1 12/19] cxl: Move cxl_mem.h under uapi to cxl exclusive directory
Date: Wed, 22 Jan 2025 16:50:43 -0700
Message-ID: <20250122235159.2716036-13-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation of more cxl headers, create a cxl directory under
uapi.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS                                 | 1 -
 drivers/cxl/cxlmem.h                        | 2 +-
 include/cxl/mailbox.h                       | 2 +-
 include/uapi/{linux/cxl_mem.h => cxl/mem.h} | 0
 4 files changed, 2 insertions(+), 3 deletions(-)
 rename include/uapi/{linux/cxl_mem.h => cxl/mem.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 877eb301b1e5..d5a38bdbf2c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5775,7 +5775,6 @@ S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	drivers/cxl/
 F:	include/cxl/
-F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
 COMPUTE EXPRESS LINK PMU (CPMU)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 55c55685cb39..e82c84b2edb5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -2,7 +2,7 @@
 /* Copyright(c) 2020-2021 Intel Corporation. */
 #ifndef __CXL_MEM_H__
 #define __CXL_MEM_H__
-#include <uapi/linux/cxl_mem.h>
+#include <uapi/cxl/mem.h>
 #include <linux/pci.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 1157b19175a5..9b7bd59f5fa4 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -4,8 +4,8 @@
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
 #include <cxl/features.h>
+#include <uapi/cxl/mem.h>
 #include <uapi/fwctl/cxl.h>
-#include <uapi/linux/cxl_mem.h>
 
 /**
  * struct cxl_mbox_cmd - A command to be submitted to hardware.
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/cxl/mem.h
similarity index 100%
rename from include/uapi/linux/cxl_mem.h
rename to include/uapi/cxl/mem.h
-- 
2.47.1

