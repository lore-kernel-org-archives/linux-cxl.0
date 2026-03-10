Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5838D6BA;
	Tue, 10 Mar 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158411; cv=pass; b=RHcgYl9HrrgWGsmUJXgTzel5geHf935VNhdrIUCQt+G+EMEyxPPjZzhjRTFKd9bAeukf7OXAAWaUN0Bamw3eDlrTFDrl+482HtQ4nEUOdBKaww24PAcT0kIffZ1lgv+g/hCZZEKMkqL4C66OrfGlHOCnN7/Dkc1aLCFJJh9CaL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158411; c=relaxed/simple;
	bh=B69MXGhvDuVx2QdO2KWxE7ethA7YE2X4K6HHkzXzeDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZok8noH/4zlUib0JpxT1iq/7nk7xOVq7e9j5unHhUcWL3kw+2wF46IEri8y5WgR4ZCVXbEoQVISnC5WtlYOWw8C3PnN86Otwt6VA/rx4zVTVIZqUQu67th5tXbVoeuYbYOThkbn4X2Gk9kKYQHJyqn+zzId31t8rKceNi1MGEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AkMAwTbF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AkMAwTbF"
ARC-Seal: i=1; a=rsa-sha256; t=1773158317; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SrlYqapn7+Hn/ymGzhTot5+Lqn4XQ22ld3HWEkfRd6x5y/sbCBF1R80Fl87aWwY0d4PZoumN6yDmsOCtdSZdWfM/a33Tg1FcDcymNNhdpfMi5XgC+tx3NWiHkfRfUonzCyAkNHVJLzKEL6oQiTc7FXDRmXHiqNAzl16gveo+CVg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158317; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ABwn0NX1NC5NAWUdwU1PCbWnVWctUN2DSjptBI98gAI=; 
	b=mhfrkv3IMJsLvwFgbGmBCnS2gB73v0LY2XJyp/ZgcqdtH2QeaV1PTB7zMLo7c+Pxb6t+hvbWgclC8+6UDKwzNwE0pwwWdtn3MJDy3NhRlHH2+6bIOlRTVXX6aTPNx3tm9vcsOebuQ+ZsF4byPuppNcsPk5vfv0OUWkfTPrdPn6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158317;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=ABwn0NX1NC5NAWUdwU1PCbWnVWctUN2DSjptBI98gAI=;
	b=AkMAwTbFgz69aAUIGsrgnX24zZbcVkqkSWpy4bTuoCLqxtKLCtm53hHHp36iPOo0
	satO7f9jMhUljcbsPTSvuiDnGT2H0bBp8qii4xOzoGipJ+pM3L9gLshbqFR+kJuDnQp
	18dg6WLcIX4YMb9dmK8SKMwKT4CsB0Um4pT6AA9o=
Received: by mx.zohomail.com with SMTPS id 1773158316399469.1017203729534;
	Tue, 10 Mar 2026 08:58:36 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Mar 2026 23:57:56 +0800
Subject: [PATCH 4/7] cxl/pci: Hold memdev lock in cxl_event_trace_record()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-4-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=2496;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=B69MXGhvDuVx2QdO2KWxE7ethA7YE2X4K6HHkzXzeDk=;
 b=9Oaf8Zeq6n9zIX9Mz4oJc64SpbAOLIWmnujeZCf8tPEMsASzasSbTPfZB58DPdXN2gCqsikcG
 PcdsbVPzMsqCtWwYb6HzC5ddPJ3VOClSTZVhTxPHeAWEWOPCTKRSngA
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112287f67c2effa747dbf4922dc7e0000fba9dd2d0d84fe57357c7a82ab048c63d3a73973f06ca29dccf5:zu080112271dd6beed9fd716b19781ada30000ad318f754e7c3bf55d799c6721cb623d758f341fe889415b9c:rf0801122da949286e68b8b5149f7f4e700000c87dfeb6bddfe4884cf120ed08bb83742f86d8ed438a252e1967d14a552072:ZohoMail
X-ZohoMailClient: External

This is a preparatory patch for the following changes.

To enable endpoint validity checks in cxl_dpa_to_region().
cxl_dpa_to_region() has to require caller to hold CXL memdev lock to
ensure the CXL memdev probing is completed.

So holding the given CXL memdev lock before invoking cxl_dpa_to_region()
in cxl_event_trace_record().

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/mbox.c | 5 +++--
 drivers/cxl/cxlmem.h    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e7a6452bf544..3f34bbabf4d3 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -893,7 +893,7 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
 
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt)
@@ -920,6 +920,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		 * translations. Take topology mutation locks and lookup
 		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
 		 */
+		guard(device)(&cxlmd->dev);
 		guard(rwsem_read)(&cxl_rwsem.region);
 		guard(rwsem_read)(&cxl_rwsem.dpa);
 
@@ -968,7 +969,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, "CXL");
 
-static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
 				     enum cxl_event_log_type type,
 				     struct cxl_event_record_raw *record)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e21d744d639b..7a34a19c02c8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -864,7 +864,7 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
-void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);

-- 
2.43.0

