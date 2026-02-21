Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F331ED86
	for <linux-cxl@vger.kernel.org>; Sat, 21 Feb 2026 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771640297; cv=none; b=YTq16tHUCoslOvR1/vGKdJ0/JyM2gGD46Jx8nPZNvZN3x/nUH4S4+x5Om1E/HCOFRAcu0ND8Or//Y9WnMMkFO9eHnMabfEcbwP42r4vy9O20ETxwuOzcB2urM3zNKmVf5MkRAJ7t+UASTO/plC/QTxCco9FwHNmTROIHU8fiKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771640297; c=relaxed/simple;
	bh=Sqb/asAMbhSRZWB7GQc/6Bty2AQhF3CVn5hsPOZrdGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDZixJ3I1IiEQonWME/Z7xSfy6vnDXJfp5DWNOcdh6T4YESculCJuU/lIr33ndxgFFwuGisAgfnCSsYqUGkJKj9uNtlvXYowDUDPIFrfMPfEZNGX6QUEm/OF1gH2s1T+VYIQdzD7Aw4hmvQzb2SwaEJE0ie6mNoy94A6n9MJHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l+9qpp5Y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l+9qpp5Y"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8954ae375efso31474026d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 18:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771640295; x=1772245095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TN/Qem4uDJq0+sZtDcRn3RixwcqOTbW5UgRyD976tVI=;
        b=l+9qpp5Y32qmTHQwSDXJN55P/7LkcjEAayE03D0J5gKk0h4BzInXguj3FLKZCNZmjV
         zZrOM+YhPhRvx/LWRN6rYjsLNnPBKi2EGcZdQlSlB1uYUe68YqE5mRc5REBhF9req8c3
         jUV3514Bw1g1mn1a0M2DBBD1zjLvTF4xE1lkk7ERk+ErZhZKnnB/7fcpDwniCvFwk1nI
         UjkEtI/N88knwF1oAsqUQ9ltTFkkK6KE5IJUj1j5OH3D75XdoLWZB5tW3bvBfRG226mJ
         XVx06NDC50EPCaTCHcn4N3LsXuhevy1+jByW40wP6ev5ekT8jHUsI1XLn2pKGw+mNfUm
         2HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771640295; x=1772245095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN/Qem4uDJq0+sZtDcRn3RixwcqOTbW5UgRyD976tVI=;
        b=GihBaxnsGSuVEt5JEpnvEFueXOZt0Kt/62xKmLIMWZfdlt5JR3TbTsVzS7sM0988d4
         0mw3ayXyXlk5YLTy0bx1C7Kf/4RtPQC6ZrTsHq3kWDu9cg1YEUT/Kw/2cuD0t1tPv1Br
         bqOfyKCBQ84yG1i8F6P6p/dp4m1K4yxMLgyR853V1rrEQP+alPfO+XZRwYHlUSd4QLNm
         0J+aGn7k+PtT9f6+u+SZs2DW0dzD/fr5XCRv2Uv+wRsrmLPQ53Vcz3E+iHoMWnF1o+jV
         0ZDQ/lGNUxV05TzRiYeu2dpjb21RNh9pGPbDc7R5qRLNYCPjNEl4fuP7TP7xbBHnr5tH
         dCBQ==
X-Gm-Message-State: AOJu0Yx/IIbJfDPMZRCkjMIlWH8y1gmaRmzKUM+9tmfe2KUQUryHERcs
	xvrmRUGT5qAy9/AjC24yw0aMPLQ5qOJ7co3cqPMUujmWcwi01jNbA/IuhG4IrFM7aoD5RtGIl42
	qjG1G
X-Gm-Gg: AZuq6aINS4vldnX55EfzCmz2Fd+M2guTLVHDk16yIUdY1TWbnWbZVzthBtBIMt5Dn5o
	6O3M9rKh1v93Dlfq+cAej2iygZLvSd/1jDaqe9cIVtBX9lSDzqq2tDSY5UaKEnD9tFxwRODWiV6
	ARs1dvAmiDFQO3aEFLgHpty6jhvQgi56MeNI9Kt1/DOp+4L1PYuekyzP9N12Ax61TmRr00lXcOH
	371uFDswucxQNnA9qa21xFWS7Q0qu9fBqQUIZ9YyS7jPGtyp2gdSgqFoGH6JwANX8/hX4HVvIUV
	88wT1FdP/whLGbvK9LeoStrTW+suINaFs8EEiDK0uGTktNc5URDSkayz6BdOxWLRNd9atdU1Y7b
	6y/TsWMVY9WbKZhGwxEbTp8TIFo3YeQke0rxejNL1WU5jKsoRvmDpMR13fG42aamaM/4k9Y9oTy
	YZ1m9xrNKoImGK6VNKnG05gB5atsmZTf4aIjmG97YUSTT5orSNgi937qLkpwNo/bJFRwebPT6Dw
	cx4V3VZLgwfGnE=
X-Received: by 2002:a05:6214:2a45:b0:894:6f00:82e2 with SMTP id 6a1803df08f44-89965c94fe1mr110186876d6.36.1771640294810;
        Fri, 20 Feb 2026 18:18:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6bb2cfsm7315746d6.18.2026.02.20.18.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 18:18:14 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl/core: fix test_bit misuse with CXL_DECODER_F_ bitmask flags
Date: Fri, 20 Feb 2026 21:18:10 -0500
Message-ID: <20260221021810.1390342-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL_DECODER_F_LOCK (BIT(4) = 16) and CXL_DECODER_F_NORMALIZED_ADDRESSING
(BIT(6) = 64) are bit masks, but three call sites pass them to test_bit()
which expects a bit number.

Replace test_bit() with direct bitmask tests, consistent with every other
use of these flags.

Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/hdm.c    | 2 +-
 drivers/cxl/core/region.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b2db5967f5c0..c8fcb9d9aa3d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -904,7 +904,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
 		return;
 
-	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
+	if (cxld->flags & CXL_DECODER_F_LOCK)
 		return;
 
 	if (port->commit_end == id)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bd4c4a4a27da..385be9cb44cd 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1100,12 +1100,12 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 static void cxl_region_setup_flags(struct cxl_region *cxlr,
 				   struct cxl_decoder *cxld)
 {
-	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
+	if (cxld->flags & CXL_DECODER_F_LOCK) {
 		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
 		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
-	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
+	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
 		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
 }
 
-- 
2.53.0

