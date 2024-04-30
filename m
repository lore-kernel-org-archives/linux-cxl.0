Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926964D
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437269; cv=none; b=ogqHwpflDMyHHiSynkzhU2Q0PNEOzUubONGlVOwiMnitEuNb5kvDCirFNedYH8J3ZI+asf630iY25xgy4EnyDnPfVW2q8Ddf8p3BcL7PVPxx8F1a/9T5jnYuftAyItihnoYCldz4rUiyFUmatGAK1SFqt4qENq1fEzPINFWGQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437269; c=relaxed/simple;
	bh=BCVWSvFgG/XGihh3nGaB6lWKZPDgqjNWL9jrth1xS5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6GRSVy5iodN6anil3gNZqKXVGhKg110qRtekjfsXX9ap/ckil4kmqEFvDyxD0QeXtHrwCElC++eE2oVbBDDbZll0Z2D1MiK1JDuZy7Uv8dPRHtWtKImIfM65aZsTz7oO6n8uYFkX7salvF1vuLI9JwmsuF7nr/gJBtiornf3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4RKeEuv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4RKeEuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714437268; x=1745973268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCVWSvFgG/XGihh3nGaB6lWKZPDgqjNWL9jrth1xS5Q=;
  b=g4RKeEuvfjLvRzwvU/JSYjf65LGXm8m1ldkSjMelYUaOB9d2XB2bM/6j
   1hwt/0kp3D4L0GKvHc0ES5QGCRy5F3G5hLlSTTmX22RhX3HbcDzDjWdng
   v+YbfbA4h50qVds3E8gKXJ5b+OcY1fBOuAJIKIzrVlcHNPZNqaMFUqGzj
   baMor6YVoyGq+itcT2YtAu3DlTS6Lx7Ktqb9o/p+/TFwSSozNsRgwBmKi
   diz1JtgnqvACzCMmdsaFP24/3Y28TTWBDHHKkzG6h58hu7Y9XsuuCFOAD
   ItZ8XCIEEoJCw/+Lu6tuzhoIQYsKlnikAmFurSXtDBaFANpAJHSjzS3XG
   A==;
X-CSE-ConnectionGUID: Uf15/tMuSeWeAhFQ2HAWtQ==
X-CSE-MsgGUID: yA10BVZxR3usbLHgvrT/eA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10289552"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10289552"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:34:26 -0700
X-CSE-ConnectionGUID: M8dsMiWSQx+g117RMIs8jQ==
X-CSE-MsgGUID: E+2bIiNnT+GHcLkfzfz8Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="57149085"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.192.110])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:34:26 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: [PATCH v5 1/4] cxl/trace: Correct DPA field masks for general_media & dram events
Date: Mon, 29 Apr 2024 17:34:21 -0700
Message-Id: <23671305ae3cd299aacb3be61d90504d6918a7f8.1714435815.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714435815.git.alison.schofield@intel.com>
References: <cover.1714435815.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The length of Physical Address in General Media and DRAM event
records is 64-bit, so the field mask for extracting the DPA should
be 64-bit also, otherwise the trace event reports DPA's with the
upper 32 bits of a DPA address masked off. If userspace was doing
DPA-to-HPA translations this could lead to incorrect page retirement
decisions, but there is no known consumer (like rasdaemon) of this
event today.

Use GENMASK_ULL() for CXL_DPA_MASK to get all the DPA address bits.

Tidy up CXL_DPA_FLAGS_MASK by using GENMASK() to only mask the exact
flag bits.

These bits are defined as part of the event record physical address
descriptions of General Media and DRAM events in CXL Spec 3.1
Section 8.2.9.2 Events.

Co-developed-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..7c5cd069f10c 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -253,8 +253,8 @@ TRACE_EVENT(cxl_generic_event,
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-#define CXL_DPA_FLAGS_MASK			0x3F
-#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
+#define CXL_DPA_FLAGS_MASK			GENMASK(1, 0)
+#define CXL_DPA_MASK				GENMASK_ULL(63, 6)
 
 #define CXL_DPA_VOLATILE			BIT(0)
 #define CXL_DPA_NOT_REPAIRABLE			BIT(1)
-- 
2.37.3

