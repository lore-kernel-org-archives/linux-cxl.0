Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D92424D75
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285003; cv=none; b=ra+yIG2mFrEb9gEXCyhRCts7Bx7FRNTPfXf2fDtVaRESc7YB9cmwnNzzo3W8awAJ8PiYuT+5jSECWStWvM1o7AVPFbO4AKd3H3uYpyKzjeNV5LDj0Xo4aayLEbwbk4cPvc1vATEnYh3SKWm3mCRd2XRcjHmQVWBlVVwgJs+JUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285003; c=relaxed/simple;
	bh=THwvvT6z/bO0cPUYHoOJ8TbQBXdyhCWIgrs0rmYt1Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCI/DynubAu4gTgQbcmBMeADfEqbOsMslmw9AHdQR4UBvo405w4/ZN21B4nSRZ4HcDdmv/Fj6gVdw1n4YeMOmznaE5Wpt5MqKbhiRxS0YfffPwxIZgxmp01sPvBhGXe1SVgknMFpYwTwb94QovTBwuG4n2SlrlpSUPuitHc2AFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A5A1F000FF;
	Thu, 24 Sep 2026 21:23:21 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com
Subject: [PATCH] cxl/mbox: Store event records for EDAC repair regardless of tracing
Date: Thu, 24 Sep 2026 14:23:20 -0700
Message-ID: <20260924212320.56573-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver throws away media error records unless a tracepoint is enabled.

cxl_event_trace_record() stores general media and DRAM records for EDAC
repair, but both calls sit inside a block gated on the cxl_general_media
and cxl_dram tracepoints. That gate only exists to skip the DPA-to-HPA
lookup used to annotate those tracepoints. Storing a record does not need
the lookup.

With both tracepoints off, two things break. The kernel clears the device
event log either way, so the records are destroyed in hardware and kept
nowhere else. And live repair stops working altogether: sPPR and memory
sparing require the target DPA to have reported an error, no DPA ever has
a record, so every request fails with -EINVAL.

Move the two stores ahead of the tracepoint check. Keep them under the
memdev lock, which is what stops err_rec_free() from freeing
cxlmd->err_rec_array while the CPER callback runs. Leave the region and
DPA rwsems with the lookup.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
---
Found by reviewing the gate, not from a failure report.

The documented flow is unaffected, which is why this has gone unnoticed:
rasdaemon watches the tracepoints, so they are on and the records exist
(Documentation/edac/memory_repair.rst:94-97). Offline repair is unaffected
too, since both checks sit under cxl_is_memdev_memory_online():

  edac.c:1807  sPPR     -EINVAL when neither cxl_find_rec_dram() nor
                        cxl_find_rec_gen_media() finds a record
  edac.c:1357  sparing  -EINVAL when cxl_mem_get_rec_dram() finds none

The unconditional log clear is at mbox.c:1115, after the record loop.

The memdev lock has to cover the store. err_rec_free() is a devm action on
&cxlmd->dev (edac.c:2021) that NULLs err_rec_array and frees it, and the
CPER path (cxl/pci.c:1053) can run while cxl_mem unbinds. Hoisting the
stores out from under guard(device) would trade the gating bug for a
use-after-free.

The casts on cxlmd go away because the parameter has not been const since
dc372e5f429c ("cxl/pci: Hold memdev lock in cxl_event_trace_record()").

Tested in QEMU with cxl_test. kprobe entry counts over the same 220 mock
event records, using cxl_event_trace_record() as the control:

  tracepoints off      control   store_gen_media   store_dram
    before                 220                 0            0
    after                  220                22           33

  tracepoints on       control   store_gen_media   store_dram
    before                 220                22           33
    after                  220                22           33

Records are kept with tracing off, and the tracing-on path is unchanged -
the hoist neither drops nor duplicates a store. The guest log shows
cxl_clear_event_record() draining the device log in both cases, so the
records really are gone from hardware whether or not the kernel kept them.
Builds warning-free with CONFIG_CXL_EDAC_MEM_FEATURES=y and disabled.

Not covered: the -EINVAL itself. cxl_test mocks no sPPR or sparing feature,
so the repair path cannot be driven end to end.

Left alone to keep this minimal: the WARN_ON_ONCE checks on the AP/CME
counter-expire descriptor (mbox.c:952-964) stay inside the gate, and are
arguably mis-gated for the same reason.
---
 drivers/cxl/core/mbox.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836c01..89fb2f569e4b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -913,6 +913,22 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		return;
 	}
 
+	/*
+	 * EDAC memory repair looks these records up from the current boot, so
+	 * store them whether or not tracing is enabled. Hold the memdev lock
+	 * across the store to keep cxlmd->err_rec_array alive against a
+	 * concurrent cxl_mem unbind.
+	 */
+	guard(device)(&cxlmd->dev);
+
+	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
+		if (cxl_store_rec_gen_media(cxlmd, evt))
+			dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
+	} else if (event_type == CXL_CPER_EVENT_DRAM) {
+		if (cxl_store_rec_dram(cxlmd, evt))
+			dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
+	}
+
 	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
 		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
 		struct cxl_region *cxlr;
@@ -922,7 +938,6 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		 * translations. Take topology mutation locks and lookup
 		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
 		 */
-		guard(device)(&cxlmd->dev);
 		guard(rwsem_read)(&cxl_rwsem.region);
 		guard(rwsem_read)(&cxl_rwsem.dpa);
 
@@ -937,9 +952,6 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 		}
 
 		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
-			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
-				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
-
 			if (evt->gen_media.media_hdr.descriptor &
 			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
 				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
@@ -952,9 +964,6 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
 						hpa_alias, &evt->gen_media);
 		} else if (event_type == CXL_CPER_EVENT_DRAM) {
-			if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
-				dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
-
 			if (evt->dram.media_hdr.descriptor &
 			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
 				WARN_ON_ONCE((evt->dram.media_hdr.type &

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.54.0

