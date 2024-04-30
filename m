Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7DA17BB20
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498093; cv=none; b=Np9eDwN9muZNbjNYhucdi97wwfo+43FfCDB+bACls1wNg8AuQxdC4PBD4uvhIDKd7JkRGfjS6pxxRKvMET8KMe+W9xrfcIup8fMRmhceaXsYKaPJhSr5qajKlwCtjHa6C/lYwy/8GLkUXY2SYthqP8p9puv3WB0KoHXxFvR7spU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498093; c=relaxed/simple;
	bh=6bH/0VFrvmnBl2UFVjYaiRjETBfGSmKhbLo4waxGgFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVVZo8SQ6I16mQq1GUmBa8afEc4lk3cMkiXG+Qu9UvrlMsIbslQuyFFuNZQ9XQZxhUNaCFOUvt+p9IteR6IybXuAFoI9U1R1S9udGXZKjDs1TgStA/xF3Zun35vZfB0qy2GNcokwdzzcvtu4wLXFT0zryo8/cs0Wyd6ADsfLHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEd9pHeV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEd9pHeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714498092; x=1746034092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6bH/0VFrvmnBl2UFVjYaiRjETBfGSmKhbLo4waxGgFE=;
  b=WEd9pHeVaqwxaWynerY24RXau4X61TiROR5+y0OJEWsxfcspRDbvr2f4
   mbo+2sZtuHOTXR7p+hzCBkgKVfMqhOjFcve6hL9bBZ14JRfLVn493bCXJ
   v058dzyT88B7xXb8glBJITtJPQTl+8b9cxqoqALksFAJ6K0jmMB/xtTR9
   LSREMjLLlB3CWQhKYYPHNkaj1XooTTu1BVhTFrXTDz2ljprVnVGu41One
   Ul1s/qcPmf0aXnbm1z7qxRWh1D9eb5+3Nld2uEdfZSnti4XKRoKT7RXaF
   wRVESegycreEe6/QY7zO812adY/4akj+Yik0SoO1Hur13jAFy1U+SBwVb
   g==;
X-CSE-ConnectionGUID: HqMhYdFsSp6lsVbVfQP/vA==
X-CSE-MsgGUID: 3IC/1IDDRVm5ULO9XufixA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10069152"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10069152"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:28:09 -0700
X-CSE-ConnectionGUID: SgHktJG8TKiuy0XKCoCCUg==
X-CSE-MsgGUID: jnmC6l9OSpiL6ikArwPLpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26401134"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.17.48])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:28:08 -0700
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
	Shiyang Ruan <ruansy.fnst@fujitsu.com>,
	Jonathan Cameron <Jonathan.CAmeron@huawei.com>
Subject: [PATCH v6 1/4] cxl/trace: Correct DPA field masks for general_media & dram events
Date: Tue, 30 Apr 2024 10:28:03 -0700
Message-Id: <2867fc43c57720a4a15a3179431829b8dbd2dc16.1714496730.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714496730.git.alison.schofield@intel.com>
References: <cover.1714496730.git.alison.schofield@intel.com>
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
upper 32 bits of a DPA address masked off. If users do DPA-to-HPA
translations this could lead to incorrect page retirement decisions.

Use GENMASK_ULL() for CXL_DPA_MASK to get all the DPA address bits.

Tidy up CXL_DPA_FLAGS_MASK by using GENMASK() to only mask the exact
flag bits.

These bits are defined as part of the event record physical address
descriptions of General Media and DRAM events in CXL Spec 3.1
Section 8.2.9.2 Events.

Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
Co-developed-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.CAmeron@huawei.com>
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

