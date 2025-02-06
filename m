Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FD19B5B1;
	Thu,  6 Feb 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870453; cv=none; b=Q3kl6jrctArdyzsX6PzjkmNXhGBMcUBuiXr5dbeBCzHfQYBIQdKChBNFwH+iTjWX0DY2xdUWqDmOBBgdEPt7EXcHxI5LwxYGt3DRZtKyl/+FC6h6W6iV7P5UIcaNnpWANbt7MdayY2hghqR3QH96sA2FH/tTwSmjvO99SfUOmc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870453; c=relaxed/simple;
	bh=5pwfBiktGa+U6uOm0fJhsuGUw45LvkiAIpC/OCXJmDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tuaMOXD3boHQIm5Pc8kWszseMPZtljBK60qDzu+dnWyH4x5omJE4TFCUJK+p1nsOzicbPPwu0iuB1u8UTlkPSI5ZmM7saqYxg84Yqk2bmc56+YbJco+oj4l8ZokuPkVpT0vp58DcxYFCVWmb7pHvwh/pnTmH5oXHoZWwsq69pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Htv/fzuN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Htv/fzuN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738870452; x=1770406452;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=5pwfBiktGa+U6uOm0fJhsuGUw45LvkiAIpC/OCXJmDU=;
  b=Htv/fzuNwkTHoZnIjWnKJ67LT24SD3sdsdA4RqJLzy+ydulLHZxGsRk8
   H+tVrJJWKKDGvZMigYVUZV+oi0l7/zMvrGOTAu1yQbfvjhxMzppeUwUIe
   tdtVllAXIJABJvES2zGZIEoz3YeJf+6PJX16XoNvMa/RMP8wXNjiDhwhi
   oi9oGKgsx+ekSZgrV+ooO0h7pZe8BujBxWUif11kPSt7L/W72Elpf5Xk7
   qym/Yc4EwM8nC2i23mFQIAkcTMVKqlpHUdc6eEhbvoC5JP/LpZtr+FbM0
   edvB6Hjupo/JrLyCVZuCInjIHY/Husv4cPWMqP9sNuMszPaNmkgVv20KF
   Q==;
X-CSE-ConnectionGUID: /FpZsjp+Sa+ROJos2CVoqQ==
X-CSE-MsgGUID: 2gModmOtQV+o49/u7cFa4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39388145"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="39388145"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:34:11 -0800
X-CSE-ConnectionGUID: XH0qffm3So+GEaX7Fw67Qw==
X-CSE-MsgGUID: 8tG26UcdQO2JA/sEFSj4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116493683"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.241])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:34:09 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 06 Feb 2025 13:34:00 -0600
Subject: [PATCH] cxl/memdev: Remove unused partition values
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-cxl-cleanup-v1-1-9ddf26dd8433@intel.com>
X-B4-Tracking: v=1; b=H4sIAKcOpWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwMz3eSKHN3knNTEvNICXQtDi0QzMwsLE8OUJCWgjoKi1LTMCrBp0bG
 1tQDwMUlCXQAAAA==
X-Change-ID: 20250206-cxl-cleanup-818a668841db
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738870441; l=2437;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=5pwfBiktGa+U6uOm0fJhsuGUw45LvkiAIpC/OCXJmDU=;
 b=zPJcs7jhjijNjxh0jA0cvP7eboSCMSdDYNWnnYdjvIRUcaiQOJEaI7MAVWOMofhNSOq0zO+We
 wBCaNtPeLA1CPnZWneszV6puR9HgutFJvBJJm2f1xdqVo05onjuo/Pn
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The next volatile and next persistent values are unused and are
cluttering the cxl_memdev_state.

Remove these values.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 4 ----
 drivers/cxl/cxlmem.h    | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8d95281c52d4368cd28dcf48b6cdd13b95901429..c5eedcae3b022cfee8166eb13a1529ccf6200196 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1092,10 +1092,6 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
 	mds->active_persistent_bytes =
 		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
-	mds->next_volatile_bytes =
-		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
-	mds->next_persistent_bytes =
-		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
 
 	return 0;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c0d2a8b6aaf694587ae321d257e74d5e92a20cd5..8e1e46c348f5a10f4fa15dce8ac57a3480c8c509 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -468,8 +468,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @partition_align_bytes: alignment size for partition-able capacity
  * @active_volatile_bytes: sum of hard + soft volatile
  * @active_persistent_bytes: sum of hard + soft persistent
- * @next_volatile_bytes: volatile capacity change pending device reset
- * @next_persistent_bytes: persistent capacity change pending device reset
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -488,8 +486,6 @@ struct cxl_memdev_state {
 	u64 partition_align_bytes;
 	u64 active_volatile_bytes;
 	u64 active_persistent_bytes;
-	u64 next_volatile_bytes;
-	u64 next_persistent_bytes;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;

---
base-commit: 861e232e15c278d6cfc5a675efe393b4838b1773
change-id: 20250206-cxl-cleanup-818a668841db

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

