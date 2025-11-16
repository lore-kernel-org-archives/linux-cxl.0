Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9431D7E42
	for <linux-cxl@vger.kernel.org>; Sun, 16 Nov 2025 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763257115; cv=none; b=HwecrqNC9biCyus/TQ5jxOTVvjM/mxQ7/bgVLQx6yvURqHE0FNakY9oZof/FxZthiIU1edH2+cZ4U3pq2pKoItlTMYFUEainCAfYmXFO3sLtkW9m2tqFBiJ0q80nB6hGFL5+NHICjrFAQErey2oUhtZrniEbZrPQJfBRoHKWzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763257115; c=relaxed/simple;
	bh=SpxniP4OwMtGS2yuG2u8RnPYYP3nqWaqheCVGJ1TpT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXjaFRF+6shse7QimXY6XchnTlzoxvmnLDoxGpq61nk8PlwhPlA6mfaOaRnpkRJw76voT26lopJylvhmQWadBMoQ3HuRwJOUF+XSfvPrLoIATaOGzlahpJ6m59dTYGmZbvj9JlEH1FSYyCMpOAwJcmTzy96aMmOElDziNt78+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdseoqUM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdseoqUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763257113; x=1794793113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SpxniP4OwMtGS2yuG2u8RnPYYP3nqWaqheCVGJ1TpT0=;
  b=cdseoqUMed8eJTV/dbGSPutB0Glbd7p05a/vLSLvuMc3GVR0hgRZ0+i3
   uR4JgjN8uO8tTU/+yETrF921qN5NEQLKAXUKNm6clRIjPcqeTKFWNmDCV
   KXaxTeiq5/W9fM+vcLt7C8U+9Z9WEWqvvFxrY8MA84imAGFJo4stvwgbo
   l3Vw1YzHLBLUYh0pREn015wVNRY+ByUhEnKQGFNUJ/bpZdaRBIiYKKUpU
   TB+E/Yfr6CfU9FzhJdlBAKX0BN0UzvnFPXOyawoYc+3fuz/z0x/hH2UaF
   cOos/vttfsKShSPDIXxnTjynMINSTBL7PUg1YUcWUQcMM4sSz2+OnkraY
   g==;
X-CSE-ConnectionGUID: zS5atLKOTXiORPJ6WWlU3g==
X-CSE-MsgGUID: jfj6E7jxRzOrQ+iZbgEpCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="69167829"
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="69167829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 17:38:33 -0800
X-CSE-ConnectionGUID: a44uBRr3TzqVoNbhzM1gNg==
X-CSE-MsgGUID: DvKDd3tdSEeTO8Z1K9+lLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,308,1754982000"; 
   d="scan'208";a="220787128"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.132])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 17:38:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH] cxl/test: Remove ret_limit race condition in mock_get_event()
Date: Sat, 15 Nov 2025 17:37:49 -0800
Message-ID: <20251116013819.1713780-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 364ee9f3265e ("cxl/test: Enhance event testing") changed the
loop iterator in mock_get_event() from a static constant,
CXL_TEST_EVENT_CNT, to a dynamic global variable, ret_limit. The
intent was to vary the number of events returned per call to simulate
events occurring while logs are being read.

However, ret_limit is modified without synchronization. When multiple
threads call mock_get_event() concurrently, one thread may read
ret_limit, another thread may increment it, and the first thread's
loop condition and size calculation see and use the updated value.

This is visible during cxl_test module load when all memdevs are
initializing simultaneously, which includes getting event records. It
is not tied to the cxl-events.sh unit test specifically, as that
operates on a single memdev.

While no actual harm results (the buffer is always large enough and
the record count fields correctly reflect what was written), this is
a correctness issue. The race creates an inconsistent state within
mock_get_event() and adding variability based on a race appears
unintended.

Make ret_limit a local variable populated from an atomic counter. Each
call gets a stable value that won't change during execution. That
preserves the intended behavior of varying the return counts across
calls while eliminating the race condition.

This implementation uses "+ 1" to produce the full range of 1 to
CXL_TEST_EVENT_RET_MAX (4) records. Previously only 1, 2, 3 were
produced.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

This was found while chasing a NULL payload_out issue in mock_get_event()
that Itaru reported here [1] and Fabio and I have both seen but not been
able to reliably reproduce. Although the accounting can be wrong wrt
ret_limit, no potential overflow was found.

[1] https://lore.kernel.org/linux-cxl/49A4B521-AB66-4037-A23D-1D0D7AF0F42F@linux.dev/


 tools/testing/cxl/test/mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d533481672b7..6809c4a26f5e 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -250,22 +250,22 @@ static void mes_add_event(struct mock_event_store *mes,
  * Vary the number of events returned to simulate events occuring while the
  * logs are being read.
  */
-static int ret_limit = 0;
+static atomic_t event_counter = ATOMIC_INIT(0);
 
 static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
 	u16 nr_overflow;
+	int ret_limit;
 	u8 log_type;
 	int i;
 
 	if (cmd->size_in != sizeof(log_type))
 		return -EINVAL;
 
-	ret_limit = (ret_limit + 1) % CXL_TEST_EVENT_RET_MAX;
-	if (!ret_limit)
-		ret_limit = 1;
+	/* Vary return limit from 1 to CXL_TEST_EVENT_RET_MAX */
+	ret_limit = (atomic_inc_return(&event_counter) % CXL_TEST_EVENT_RET_MAX) + 1;
 
 	if (cmd->size_out < struct_size(pl, records, ret_limit))
 		return -EINVAL;

base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.37.3

