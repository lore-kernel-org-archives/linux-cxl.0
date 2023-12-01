Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCjptvyx"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FA1BC8;
	Fri,  1 Dec 2023 08:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701448742; x=1732984742;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uaghSnyamW9Et5PGriXmjcF9jtUAO3k+dTZ4UETXamc=;
  b=WCjptvyxwVZLx1rMfuIbqLjMVaXcbnohEiba1pTuQSoftOdNjDq9Aq5B
   SWo5HSgegHOprPZmcxPJw3jg3AXH2iOwuvvDABZ7mutcbn3C1qCLR/IAY
   d3oWt7v8T6NH0i0l8CEyoqI3cATB6Uh9elZ+XW7yyEkBXgeYqf5oKivLV
   m5ISk5ZWptzZzVK4fQSWBq3ohcSwmQfKXHwbsOnsLNsTN31komCIKMEyA
   wFNz+qG22Dv9/804rmhgzGphyWjsA1KRqLmAimhvwPKNtv4ecPibg0TIS
   0JoX4BiDWtyR9tZ0xDWcPJd5lfcsfIkNrXo1n9SBDH0gJ3HogTvabToiN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="397409109"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="397409109"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 08:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="11204510"
Received: from ixc04.bj.intel.com ([10.238.153.181])
  by orviesa002.jf.intel.com with ESMTP; 01 Dec 2023 08:39:01 -0800
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: dan.j.williams@intel.com,
	ira.weiny@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH] cxl/core/mbox: get next_persistent_bytes by next_persistent_cap
Date: Sat,  2 Dec 2023 00:40:05 +0800
Message-Id: <20231201164005.135912-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to CXL 2.0 8.2.9.5.2.1 table 176, the next Persistent
Bytes should be calculated by next Persistent Capacity.

Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 36270dcfb42e..7b8ec73ca37f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1069,7 +1069,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 	mds->next_volatile_bytes =
 		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
 	mds->next_persistent_bytes =
-		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
+		le64_to_cpu(pi.next_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
 
 	return 0;
 }
-- 
2.39.0

