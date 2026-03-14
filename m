Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29627AC4C;
	Sat, 14 Mar 2026 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773472221; cv=pass; b=bxNwtauOdoO/sPV35B5vcDSm7K//hVpn0Ux2c3wDiJRglbISK0e816sZz9N4W9yvPtMQ4QIjignHaUVp1nKGjgYPA7rwQELQ/7HZ4/nAIEPma4x2NQoDf7XyQKtIznzttf94SZ4f+m0m/nJqTMiUlSIxzax52gMo0U0LjTG9g50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773472221; c=relaxed/simple;
	bh=Z9AoVa/h8h7mEpKevRNaNyayhAMnLDu5CA/Xf5omY1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e58ixCubxBzes6yUX5J6INPjgDhodFkROhQFDaohKVsXHWSuEUQMd/xKZtQN7e5hdJ+8yhLy2BT6W6QoNZnFYRsPv/8ORsRgyiFA1WDoyjjEYW5WBRhdwQSRgnGaADwb+Cum5cUZ4m5d3jt+GhSS5ff74gpqTFb7ZCadcis+a0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WZiE6n44; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WZiE6n44"
ARC-Seal: i=1; a=rsa-sha256; t=1773472027; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HoaZ/KfRJDwLuiELA96LmHKVElyovpd6udQTgn2ui+v5ZJ1d8L1l1A14+6bHigFrFrPhBTn9DNzPF9QSMgcCVy+5YYS0cc2pHUwORpxPzvzOlacbvIC/6enUZ9T5BlMae8bPUWoy7D0TudF/seZvPQT18QGvsPfBZbl1B9VdZ1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773472027; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HMKYJ7GlGpyQ2UFGTyxInLDKVN0gYwiyclPrjq+4Hjo=; 
	b=jF25QPZ1nTWJnNaWOHHNDYh85JaOwl3atRkgrZtZfenfZ9QCMUN85WgfC8RUc5xHJ0+umxBygoxiZOE8U60yRJkn/1K2W2fiqAc6pL9SNbZlQug8ih+RAiENoWd5ZkiadukGXPsjAZXS47T7TUbpPNwgCAxah4rUnOAj9m3UYr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773472027;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=HMKYJ7GlGpyQ2UFGTyxInLDKVN0gYwiyclPrjq+4Hjo=;
	b=WZiE6n44dQiops4nGb0UHm9wEGrWaGmrgT0xaHRJMes3VcT0g1H2aqDG+gU8CeWS
	SMEGEn1YGhxjDdxuzLpy+b8Yk9fmsn63uYAIzdB8TYF0v0InoInvWZRdzqhTlFYxKOm
	AWrXacFZOu5mx5u2WiMR7s7BnFCKF0vBWhev0rWc=
Received: by mx.zohomail.com with SMTPS id 177347202489093.21518536480016;
	Sat, 14 Mar 2026 00:07:04 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 14 Mar 2026 15:06:32 +0800
Subject: [PATCH v2 3/4] cxl/pci: Hold memdev lock in
 cxl_event_trace_record()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-fix_access_endpoint_without_drv_check-v2-3-4c09edf2e1db@zohomail.com>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
In-Reply-To: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773472001; l=3729;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=Z9AoVa/h8h7mEpKevRNaNyayhAMnLDu5CA/Xf5omY1I=;
 b=hM8Ces57Juk2/7XCJf7PLF1+uME6Opoe2ANGZ/OGlR0IAN7xN+X3G7k4U12Mll9tCXdS/yw+o
 uPp3XCoSY5ADqStKyPGhq8CSQ19Bzm00qwc2aBIGtp97+Taibj0cpv0
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228404d7638850ef7de5a9891c20000585065127f78d3c1ac1c76ed1c3c1c9ffc9d25c37a31e0ba49b4:zu08011227b4eb7c5ad8008c988a37193100004963bbeff4891357b8170713d808c1689b1de58a10569b51da:rf0801122d49e0be2fbe1635d2caab17ed00007cc5e8e904e54f6aca65949aab16ed4fb0d230c2fa39c455dd0a977af7bbcc:ZohoMail
X-ZohoMailClient: External

cxl_event_config() invokes cxl_mem_get_event_record() to get remain
event logs from CXL device during cxl_pci_probe(). If CXL memdev probing
failed before that, it is possible to access an invalid endpoint. So
adding a cxlmd->driver binding status checking inside
cxl_dpa_to_region() to ensure the corresponding endpoint is valid.

Besides, cxl_event_trace_record() needs to hold memdev lock to invoke
cxl_dpa_to_region() to ensure the memdev probing completed. It is
possible that cxl_event_trace_record() is invoked during the CXL memdev
probing, especially user or cxl_acpi triggers CXL memdev re-probing.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/mbox.c   | 5 +++--
 drivers/cxl/core/region.c | 8 +++++---
 drivers/cxl/cxlmem.h      | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

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
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 42874948b589..840d52a52c4e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2950,13 +2950,15 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_dpa_to_region_context ctx;
-	struct cxl_port *port;
+	struct cxl_port *port = cxlmd->endpoint;
+
+	if (!cxlmd->dev.driver)
+		return NULL;
 
 	ctx = (struct cxl_dpa_to_region_context) {
 		.dpa = dpa,
 	};
-	port = cxlmd->endpoint;
-	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
+	if (cxl_num_decoders_committed(port))
 		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
 
 	return ctx.cxlr;
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

