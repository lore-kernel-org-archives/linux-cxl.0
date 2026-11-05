Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849317;
	b=37Ny+Ejhpn+obTLgL5JgRS/yQ/ijMYyVjNETFZoW49ls86SP8i4qIUoOARvo67yfrPnv
	 uaSUnrv0fq4hNlL1/+27nuyGVGfupe6Zmgt5K+bZ7A4ikxuVUXhdZhJbkmRKygE6QW4Vb
	 LrYd0RyJ+9jKor+FWkJH3I292ZdphEG/Mn/sVfoCMkXE1HQSKo/94K6+mikVoKvHy6rwr
	 dQYDV1fBpM2vCveigk6240JnUr1nE/NxIh7F1OFOjPRXStMjdB4vzrCCv1cUiJMA+nLMy
	 Cc+eYVtxI00uPYv8SNuoStJcBeusNeqUbHJa4S5UWw+6Mdn+qes9qb2Z12dqRefJA7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Z5cuZe31tLlkRA7P+R4KjXcp0iHA1rL3vHTCNA9zcA=;
	b=DpWEILTBx3iQYOFhF3QhtLBkVoOD4M4CTjsT+epinwFitJirxazukMOrEoE3TpYUNqCK
	 Tp7OqOLFNCwKs2e0enRPbgM9Tmas0j/0eFYoMj8amUrvAVmSW3MgkRA4/hIV+QS7SAHfe
	 U8yXc1vlCLqSNkSa9e2TGWhYtCx39v6ImZKDmG4hd7tg9T/pFcvBdotg4JPUcy7n1S/o+
	 U37O2X8nslH98vgHA5drtV/MLPtnl6B7A5WL7W0yRuOski7xKPbH1ILqw+HBGXAa7/zoI
	 KYYkSp09ODjBqD1J+JFHE7EprFr1iEpSCFjkOZ9CKm26GjJKx4Ns2+grHxDWkyqtDiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="RT/QqL3a";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D691606A328
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D691606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RT/QqL3a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793849318; x=1825385318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8WBlq/iXxT6U0oZsuLDc9yxyh0u8AFfcmzyLSpl/vjs=;
  b=RT/QqL3aC9th7ike/gMMee4Rz7t+/XI8C0Z7PNCLGugwJdtne6RL9AK7
   yp5Q73svOzYdIjLB3zux3/u0EFHEOsx9XvBrCx67/SVEy6kZSbVb+Eswa
   1cmwtydsY9h1vpLs+nffk1cCJnCyhTXKGkvLx5e+6me26Nfd44M++I+ao
   pEJ8M9rvPymKpr5qL9tg79j6NqJ98+hXYABN+oQ7i0SuRlRYx5jTDrqcx
   9TKc2QLx2cwCZgxP38dFT+40VBi3eUduuit7topN+ZouP5GYoXvd4Lgh2
   qzZGF5D8nwj4IVKS3lJ8fhfrednPU+w+/p3MmmbmI5xu2IP8sK37C55E1
   g==;
X-CSE-ConnectionGUID: DpbDrRRFQiCetA7ekqsvxA==
X-CSE-MsgGUID: I++2Mm+zTSGxbTLzMX/Vng==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2511484"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2511484"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:37 -0800
X-CSE-ConnectionGUID: bRx9mm19TIGH6fA64RQyRw==
X-CSE-MsgGUID: 766UM0H7RX29ElFi7Mh4vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6913283"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:37 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 1/4] cxl/region: Calculate performance data once all targets are attached
Date: Wed,  4 Nov 2026 19:28:28 -0800
Message-ID: <2d2cd95e7e415c785dbd0cd627141a5a9f0731d6.1793847269.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793847269.git.alison.schofield@intel.com>
References: <cover.1793847269.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region performance data is accumulated as endpoint decoders attempt to
join a region. Failed attachments and subsequently removed targets can
leave stale contributions in the region's performance coordinates.

Latency reflects the worst of all attempted targets, potentially
misreporting the region's access coordinates and affecting NUMA memory
tier placement. Bandwidth is normally recalculated when the region
completes, but if that calculation cannot be performed, the accumulated
bandwidth remains. Rebuilding a region can inflate it further.

Calculate performance data from the attached targets when the region
completes, for both user-created and autodiscovered regions. Reset the
coordinates before each calculation so only current members contribute.
Perform this calculation before the shared-upstream bandwidth update,
preserving the sum of member bandwidths if that update cannot complete.

Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/cdat.c   | 19 +++++++++++++++++--
 drivers/cxl/core/region.c |  4 ++--
 drivers/cxl/cxl.h         |  3 +--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f5f86b69c86d..7acc516ae9fa 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1124,8 +1124,8 @@ void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
 	cxl_region_update_bandwidth(cxlr, usp_xa);
 }
 
-void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
-				    struct cxl_endpoint_decoder *cxled)
+static void cxl_region_perf_data_add(struct cxl_region *cxlr,
+				     struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_dpa_perf *perf;
 
@@ -1147,3 +1147,18 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
 	}
 }
+
+/**
+ * cxl_region_perf_data_update - Recalculate region performance data
+ * @cxlr: region with all targets attached
+ *
+ * Reset the access coordinates and calculate them from the current targets.
+ */
+void cxl_region_perf_data_update(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	memset(cxlr->coord, 0, sizeof(cxlr->coord));
+	for (int i = 0; i < p->nr_targets; i++)
+		cxl_region_perf_data_add(cxlr, p->targets[i]);
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..34d42559e33e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2130,8 +2130,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
-	cxl_region_perf_data_calculate(cxlr, cxled);
-
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		int i;
 
@@ -2171,6 +2169,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		 * then the region is already committed.
 		 */
 		p->state = CXL_CONFIG_COMMIT;
+		cxl_region_perf_data_update(cxlr);
 		cxl_region_shared_upstream_bandwidth_update(cxlr);
 
 		return 0;
@@ -2193,6 +2192,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		if (rc)
 			return rc;
 		p->state = CXL_CONFIG_ACTIVE;
+		cxl_region_perf_data_update(cxlr);
 		cxl_region_shared_upstream_bandwidth_update(cxlr);
 	}
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index baa6df2d362a..2cd1842ce1ad 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -932,8 +932,7 @@ void cxl_switch_parse_cdat(struct cxl_dport *dport);
 
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
-void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
-				    struct cxl_endpoint_decoder *cxled);
+void cxl_region_perf_data_update(struct cxl_region *cxlr);
 void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr);
 
 void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
-- 
2.37.3

