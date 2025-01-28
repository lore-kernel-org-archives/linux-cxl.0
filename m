Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB141C3BFE;
	Tue, 28 Jan 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090275; cv=none; b=pDJA9Z7C7o811oS9opLQh/deSMFVz10gqlj+KcwELEUuZQ8LT7whbJNXog0ACIX6NjNKc7GdsDj8puSqwBMQrmAbvhOFrVyXQlI0J7wLeRChuEDBFY6NLVsiX7nKpHQRBzFjACKxgoZBSNyhbjoCqBxkhpkRt/vPIw6OTGrP9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090275; c=relaxed/simple;
	bh=7qdpJ5zKp8yL7UOyRvar/6bL8J7Blngq6ONjuORg+gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CzVSgaCxHWHRFwVqmBqOz/X7cRo2D+l1U5Lj1kuXIbpFFgl+yE/mF9C427An+4SInSjowuvGPL/EnlD2R7PpSD0F3lu/kFkfSQWmwY60GXPCBbE3SRrKe+Xb+17OtA4EJ1+wsgLJEMkOywX05WKSSIiuXguW+IhotKR+COVyjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EW2d+uRS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EW2d+uRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738090273; x=1769626273;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7qdpJ5zKp8yL7UOyRvar/6bL8J7Blngq6ONjuORg+gM=;
  b=EW2d+uRSGS1EKeOSrdcLC7tZHVma/1mNdkQbz9UkRZU+PDgBeLwXKwh1
   ynGK6QQuof7y+hAntSq0Lj9nK4e0bHvBOZo79cB8rV53cUC+0ndP4YeJ/
   MkJ7PD39bpTxOTpgL0rxLuAGANSLZqB5WlvUKOottiJXOBwKxP1ZQFsLp
   vbB+RaOZmUr0rkbRlNrraB7WkQ1cLKGPffZEFxzimepSiWri0Q5Q4fCmJ
   QEEnK6UhvqdMVqh2O5GfPQbeHDHuodJxRvZrDnKV8LHXG8CxHH0tz14n+
   ZVxjpa6xBz02w7cAG6h9I7UQoGUWw9AppKVEHe/xfoEo5Ys/lmZYCaRSb
   A==;
X-CSE-ConnectionGUID: TkmTcCqeRhOvA/S4RilPBg==
X-CSE-MsgGUID: K1y7/SLoRfKJrG3I8hJP8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49177334"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="49177334"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:51:12 -0800
X-CSE-ConnectionGUID: URsLrgZyTY+304DYXAiwWw==
X-CSE-MsgGUID: xDxCMx6XTliTmZ/lreQ5vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108676681"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost) ([10.125.108.40])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:51:12 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 28 Jan 2025 12:51:07 -0600
Subject: [PATCH RFC 1/2] cxl/memdev: Remove unused partition values
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738090268; l=2034;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=7qdpJ5zKp8yL7UOyRvar/6bL8J7Blngq6ONjuORg+gM=;
 b=FmXpIGA5++PQRH7JNc5bHAmDAYE/dYvbACemZ35piKSDbvNJ6zMgJUzzrq86wT4UCDST/cOnE
 dUbqRjfiEZPCze7XAh6aOE9hL8K1MctsGeJ76zRkvq3pEmvbC3SXPV0
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The next volatile and next persistent values are unused and are
cluttering the cxl_memdev_state.

Remove these values.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 4 ----
 drivers/cxl/cxlmem.h    | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 62bb3653362f5325cfdab7812633328eac50ab30..998e1df36db673c47c4e87b957df9c29bf3f291a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1097,10 +1097,6 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
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
index f218d43dec9fd89f950af667ff033d0802084345..29817f533e5e408243d361c46ddbf0c295b4fda4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -548,8 +548,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @partition_align_bytes: alignment size for partition-able capacity
  * @active_volatile_bytes: sum of hard + soft volatile
  * @active_persistent_bytes: sum of hard + soft persistent
- * @next_volatile_bytes: volatile capacity change pending device reset
- * @next_persistent_bytes: persistent capacity change pending device reset
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -570,8 +568,6 @@ struct cxl_memdev_state {
 	u64 partition_align_bytes;
 	u64 active_volatile_bytes;
 	u64 active_persistent_bytes;
-	u64 next_volatile_bytes;
-	u64 next_persistent_bytes;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;

-- 
2.48.1

