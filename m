Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461A3BAD9D;
	Tue, 10 Mar 2026 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158429; cv=pass; b=IxQa5dUu1nA8ss5Y7TuWXuQEOaXLxtNd2QaXNLccyfyzbDowCBuzXbfecgnwFpkftDtrn+5W0nhQY3EIVr9FNeSicIrwavYYfYmymMI2KFhoz68aQX5z+gj4ms8HZQ5J81hNcqFQ6FlQ5dUk+/++iU9BeQ2/aDogHAtZcVeTO9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158429; c=relaxed/simple;
	bh=ENrMXJhDkBtkxWOCe7WzES9mf0opa1WZobtvS83lPHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5r4AZsKKqRmL2yT7O+kxN3mshRgc1c8iMLVkpg/M4cqPjQ2/Zpg2wYO9mpZL7myDiygU8UuTl1Da6kTFg0SOMJLZ1NxPXcOQAZHjRpbzdv4iarFdMfaRqPFHHT3O4h9cNJTQehvue6JzgDfjw7MA7rPGnQca8KB+XhYphnTvZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=e9qX/7qo; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="e9qX/7qo"
ARC-Seal: i=1; a=rsa-sha256; t=1773158321; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=go+xrsTKq5Rmbj2wOYV6QDY0UcEQYEIjL9HydqwoF1ugYxgdyVeQm2GnIx0yXLUGVpp9GE5ku8wISZE9SbcX+uA7u/TLomw28rrvYYgUxnIO4srOciFcPLx6fx7lTWU3/ivd1yMNUWN15xjLWGIesmqSeDNEevbHYHuccjCFG1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158321; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g/6G297wu4AB+PoDj1KHKQ9lVhY2UMABCIj6fshRpm0=; 
	b=TT1Yg6rrLtV5kjqQ/yZvL8ds8K32ZLkmLKZJ9BvvxBQwuoUein9BB67TqfJJsn4G0fFSVxtE1asfzrW9AQoLUuQOWbpo2BC8FP3tKyg9jZAQWMDEaWoiClxfHIRREu9vIIPuda3cn7tiln69K5JPdGsRfLetEF9LObAGYowAxc8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158321;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=g/6G297wu4AB+PoDj1KHKQ9lVhY2UMABCIj6fshRpm0=;
	b=e9qX/7qo3BxPBVtzcO5ZXH9GDN2CjB+mnMgvXUHYnh2zuuowDDhoV06APD4SsW9a
	dRhQZcjyJKjFrPNBbOgDCCH0FFI6otKx8shZtX9C/93s82mZ5Aqv2vAyNbs5FCWXwdV
	6VUjodeyHho1oCnJUij6JHVXbDeAFGK+4m+GW3aY=
Received: by mx.zohomail.com with SMTPS id 1773158320012551.5054323166485;
	Tue, 10 Mar 2026 08:58:40 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Mar 2026 23:57:57 +0800
Subject: [PATCH 5/7] cxl/region: Ensure endpoint is valid in
 cxl_dpa_to_region()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-5-94fe919a0b87@zohomail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=2777;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=ENrMXJhDkBtkxWOCe7WzES9mf0opa1WZobtvS83lPHQ=;
 b=Ly3iLYWpu8d0ZgXTqBt/7LHCa28uYFAsKP/78fB91Z7nyjdyAeMgH5p/otUJHHVo/biyQt3nH
 zGpStkAwbJgAnuxuvX12BkU4x39yegciJ/xHl0eXJcM4Fphi96FZhPo
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112285349850d3ae57fbdd47f5a5900002f047a659bc7bc239898fc4a7fb3e75e9528f8701a7d0be3c8ce:zu08011227df2c56caa742594e4f6ca00f00005d68f34df780e8f1ae03a404861fd0257791dbbe34ffdbd7bd:rf0801122d947b1e73def65f7241dfac920000c2ec091a182fdfe9f193c24dc9285aeb2aa0868684b71b5eb940bd043cc38f:ZohoMail
X-ZohoMailClient: External

cxl_dpa_to_region() needs to access the endpoint of the given CXL memdev
to confirm whether the CXL memdev has memory range attached to a CXL
region. But it is possible to be called before endpoint allocation or
after the CXL memdev probing failure.  In these two cases,
cxlmd->endpoint is invalid.

To solve the problem, cxl_dpa_to_region() requires that callers have to
hold the given CXL memdev lock, it guarantees the CXL memdev probing has
completed. And cxl_dpa_to_region() will check the given CXL memdev
driver binding status, if the memdev has bound to the driver, the
endpoint is guaranteed to be valid. This checking also requires the CXL
memdev lock held.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/core.h   |  4 ++--
 drivers/cxl/core/region.c | 11 +++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5b0570df0fd9..fa8402be860f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -47,7 +47,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 int cxl_region_init(void);
 void cxl_region_exit(void);
 int cxl_get_poison_by_endpoint(struct cxl_port *port);
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
+struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa);
 u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 		   u64 dpa);
 
@@ -58,7 +58,7 @@ static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
 	return ULLONG_MAX;
 }
 static inline
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	return NULL;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 806512dfab07..c555e3ae8b62 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2947,16 +2947,19 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
 	return 1;
 }
 
-struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
+struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_dpa_to_region_context ctx;
-	struct cxl_port *port;
+	struct cxl_port *port = cxlmd->endpoint;
+
+	device_lock_assert(&cxlmd->dev);
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

-- 
2.43.0

