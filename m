Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14D77F11;
	Fri, 14 Feb 2025 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502648; cv=none; b=T4n1C4DgHe4j2bs8SRtNOF+mUSC5RiPctXdvRfgVszQH7SYhSm4um6V5e42JjJiQNtDCyCErvq1ANNPSQyPqu69WKzMMdiUFI3n64SIpA6dgC7cy9v0jYY5vZxYu/jHKfgtFSCHGSmu+rQeZmbAngqJYP28VlzBQBBlJOxk0cdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502648; c=relaxed/simple;
	bh=UPsU2fwceXEeyqYpbVC8GWYctW1Q2dnHUuLzGyuLWzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADYvkoOgWUp18J9h4SNFl17gcD36RiBkYWn+2VE0YPQ+z56zvE5TtdfEdF+VD9JW4wgp/kkOGWo3P1eA0GqEg0GTGXs/LfbjEVBKMx7iMMkg0r2ukD2gOCUgwL8J/tWEtmTjTSkexdkEcmiljIItL1dD1FYBwKeh2DtJgkG7CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHzWkZtK5nxWbnAg--.29056S2;
	Fri, 14 Feb 2025 11:10:17 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwA3PYkTtK5n+U4mAA--.10696S4;
	Fri, 14 Feb 2025 11:10:15 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v2 1/1] cxl/pmem: debug invalid serial number data
Date: Fri, 14 Feb 2025 11:09:52 +0800
Message-Id: <20250214030952.4047438-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214030952.4047438-1-wangyuquan1236@phytium.com.cn>
References: <20250214030952.4047438-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3PYkTtK5n+U4mAA--.10696S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWeuT6cBawAAsK
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tryfXF4rJr47GrWxWrykXwb_yoW8AF1rpr
	48tayYkrW3CF13Zw4xZFy8ZFyYg3Z7W3yxGryjvwn8urn5tF1IqFWxta1jya43Ca95tw4a
	934j9ryUuFWUW3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

In a nvdimm interleave-set each device with an invalid or zero
serial number may cause pmem region initialization to fail, but in
cxl case such device could still set cookies of nd_interleave_set
and create a nvdimm pmem region.

This adds the validation of serial number in cxl pmem region creation.
The event of no serial number would cause to fail to set the cookie
and pmem region.

For cxl-test to work properly, always +1 on mock device's serial
number.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/cxl/pmem.c           | 7 +++++++
 tools/testing/cxl/test/mem.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index f9c95996e937..cc854169e50b 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -384,6 +384,13 @@ static int cxl_pmem_region_probe(struct device *dev)
 		};
 		info[i].offset = m->start;
 		info[i].serial = cxlds->serial;
+
+		if (info[i].serial == 0) {
+			dev_err(dev, "%s: invalid serial number\n",
+				dev_name(&cxlmd->dev));
+			rc = -ENXIO;
+			goto out_nvd;
+		}
 	}
 	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
 	ndr_desc.mapping = mappings;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 8d731bd63988..9e098cf06603 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1533,7 +1533,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
-	cxlds->serial = pdev->id;
+	cxlds->serial = pdev->id + 1;
 	if (is_rcd(pdev))
 		cxlds->rcd = true;
 
-- 
2.34.1

