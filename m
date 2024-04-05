Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D1217BAA
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354419; cv=none; b=W0RnjXN7+CHWPIDIYK5m+Jb+y+bCVQT7cm9cbIwsm9b3h//vPll9QQ5y/NSYAAGvzhNMGXVmhTw61wLeAOIRWREb6hJu+2CGDPj+oQmZCswEJMPMcvYE7ssPfn70AbgLqapE8qMc3+ehzgspENQRxihSKpFOWmU0PEIa+KC9DNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354419; c=relaxed/simple;
	bh=7rVzBTylSiOijY19Ieo8i9C/KE/SIDCO/n+AicgrxZI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=S6enHvnqbGT88SPNefs/8ER96/ktYxGLVLk016p0gL+KeEGpGvE837YWXwtoikC7/1IjRc4LnJW/KQkZBjJAT0rtUgjr7inG6vBFAn6bAXG1YcjGY0nTscCMkgVIZLr9dQfS8l1oTmhhALZkGL4DnnSOLFVg6k4DPE5kWk4z9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duAHEeFQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duAHEeFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712354417; x=1743890417;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7rVzBTylSiOijY19Ieo8i9C/KE/SIDCO/n+AicgrxZI=;
  b=duAHEeFQVmlsgtRwt/45Hke2ON4fwoQs+Sh7WSwChlbuEHkY5P9cZaju
   +sliRvx+ys643/FuFNTEI053Xu6iCDFyF52T+hKrI0kuVd94VUbay+5aO
   5OnjjH1qpNRp2VWK2YkeR7wqhkcHIrrLB757RVBJZ9ljTaGBLnzasOHIt
   pi9OVk8MiUvecGXB/9uN+jmo8AbGUxSR8uiz43/dUBuViA06dIykjM2Xy
   TmYeyX8DTwohM22LTUMVx39111jeaOV3Y+HTzHsxLjw2L8U/7NWfobhoe
   fRS+k8Y+r4cpIIB3vDVIk4vpHJBh7bCnNN6X5KLkJmENcsAoyNf0uIlTk
   g==;
X-CSE-ConnectionGUID: ckfFio4KTuSezBmMFra3AA==
X-CSE-MsgGUID: QEmdze1AQLOAkxC0INUC3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19136417"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19136417"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:00:17 -0700
X-CSE-ConnectionGUID: 7SNFnKlmTWWzFpqnPr31Uw==
X-CSE-MsgGUID: xKYIfyfRRjG4gGt78rB5ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19824861"
Received: from brownjac-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.180.254])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:00:17 -0700
Subject: [PATCH] cxl/core: Fix potential payload size confusion in
 cxl_mem_get_poison()
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: Kwangjin Ko <kwangjin.ko@sk.com>,
 Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org
Date: Fri, 05 Apr 2024 15:00:16 -0700
Message-ID: <171235441633.2716581.12330082428680958635.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A recent change to cxl_mem_get_records_log() [1] highlighted a subtle
nuance of looping calls to cxl_internal_send_cmd(), i.e. that
cxl_internal_send_cmd() modifies the 'size_out' member of the @mbox_cmd
argument. That mechanism is useful for communicating underflow, but it
is unwanted when reusing @mbox_cmd for a subsequent submission. It turns
out that cxl_xfer_log() avoids this scenario by always redefining
@mbox_cmd each iteration.

Update cxl_mem_get_records_log() and cxl_mem_get_poison() to follow the
same style as cxl_xfer_log(), i.e. re-define @mbox_cmd each iteration.
The cxl_mem_get_records_log() change is just a style fixup, but the
cxl_mem_get_poison() change is a potential fix, per Alison [2]:

    Poison list retrieval can hit this case if the MORE flag is set and
    a follow on read of the list delivers more records than the previous
    read.  ie. device gives one record, sets the _MORE flag, then gives 5.

Not an urgent fix since this behavior has not been seen in the wild,
but worth tracking as a fix.

Cc: Kwangjin Ko <kwangjin.ko@sk.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Fixes: ed83f7ca398b ("cxl/mbox: Add GET_POISON_LIST mailbox command")
Link: http://lore.kernel.org/r/20240402081404.1106-2-kwangjin.ko@sk.com [1]
Link: http://lore.kernel.org/r/ZhAhAL/GOaWFrauw@aschofie-mobl2 [2]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c |   38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f0f54aeccc87..65185c9fa001 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -946,25 +946,22 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_get_event_payload *payload;
-	struct cxl_mbox_cmd mbox_cmd;
 	u8 log_type = type;
 	u16 nr_rec;
 
 	mutex_lock(&mds->event.log_lock);
 	payload = mds->event.buf;
 
-	mbox_cmd = (struct cxl_mbox_cmd) {
-		.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
-		.payload_in = &log_type,
-		.size_in = sizeof(log_type),
-		.payload_out = payload,
-		.min_out = struct_size(payload, records, 0),
-	};
-
 	do {
 		int rc, i;
-
-		mbox_cmd.size_out = mds->payload_size;
+		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
+			.payload_in = &log_type,
+			.size_in = sizeof(log_type),
+			.payload_out = payload,
+			.size_out = mds->payload_size,
+			.min_out = struct_size(payload, records, 0),
+		};
 
 		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 		if (rc) {
@@ -1297,7 +1294,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_mbox_poison_out *po;
 	struct cxl_mbox_poison_in pi;
-	struct cxl_mbox_cmd mbox_cmd;
 	int nr_records = 0;
 	int rc;
 
@@ -1309,16 +1305,16 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	pi.offset = cpu_to_le64(offset);
 	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
 
-	mbox_cmd = (struct cxl_mbox_cmd) {
-		.opcode = CXL_MBOX_OP_GET_POISON,
-		.size_in = sizeof(pi),
-		.payload_in = &pi,
-		.size_out = mds->payload_size,
-		.payload_out = po,
-		.min_out = struct_size(po, record, 0),
-	};
-
 	do {
+		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd){
+			.opcode = CXL_MBOX_OP_GET_POISON,
+			.size_in = sizeof(pi),
+			.payload_in = &pi,
+			.size_out = mds->payload_size,
+			.payload_out = po,
+			.min_out = struct_size(po, record, 0),
+		};
+
 		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 		if (rc)
 			break;

