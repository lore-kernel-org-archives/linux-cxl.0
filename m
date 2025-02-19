Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D716EB7C;
	Wed, 19 Feb 2025 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934726; cv=none; b=NsGUK2NUwSczfAMm7C8WIg9t4T3Dvh4ooEbFsNfpt3Hx32vlkO+B/2i0uG9tHBru3v8uvHOPobI2ue2l/uprYQdI9do936lZqj4V5L0y2u9tgAfhHXkDpCuLX1LiyNYeZne6u3H8mFM6x5gSaRhY5BD5GHYIBLsHsDpACKAdavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934726; c=relaxed/simple;
	bh=ToExm74XIUY5qY+maEbyqxkCs5rFcdiEtext8UG1LmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AhLWzwIhK+CiIRW4lucNloMzAuIy8+5HBEG85kscph4CszXDwMvP2toJMTkoQ7ZF5qO0UdbQoSSZup41n6JkoV6p++Ie7pOamJqZ8ylLFJ9hfNd2ByAwZOhunC6Tlw9YvqU12PygF2mltnt/6AgIJgrItB/K42xfWtz8xd9GokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnrCz2S7Vn8_zdAw--.43545S2;
	Wed, 19 Feb 2025 11:11:50 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnaobyS7VnB7QrAA--.6774S4;
	Wed, 19 Feb 2025 11:11:49 +0800 (CST)
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
Subject: [PATCH v4 1/1] cxl/pmem: debug invalid serial number data
Date: Wed, 19 Feb 2025 11:11:13 +0800
Message-Id: <20250219031113.407526-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219031113.407526-1-wangyuquan1236@phytium.com.cn>
References: <20250219031113.407526-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBnaobyS7VnB7QrAA--.6774S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWe0524BFwAAsK
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tryfXF4rJr47GrWxJF1xGrg_yoW8uF1rpr
	48tayY9rW3AF13Zw4xZa48XFyFg3Z7G3y8Cryjqw15urn5tFn2qF4xta1jya4fCa95tw4a
	9a4j9FyUuF4DX3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
 drivers/cxl/pmem.c           | 12 ++++++++++--
 tools/testing/cxl/test/mem.c |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index f9c95996e937..0bbd9ca32e39 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -375,6 +375,16 @@ static int cxl_pmem_region_probe(struct device *dev)
 			goto out_nvd;
 		}
 
+		info[i].offset = m->start;
+		if (cxlds->serial == 0) {
+			/* include missing alongside invalid in this error message. */
+			dev_err(dev, "%s: invalid or missing serial number\n",
+				dev_name(&cxlmd->dev));
+			rc = -ENXIO;
+			goto out_nvd;
+		}
+		info[i].serial = cxlds->serial;
+
 		m->cxl_nvd = cxl_nvd;
 		mappings[i] = (struct nd_mapping_desc) {
 			.nvdimm = nvdimm,
@@ -382,8 +392,6 @@ static int cxl_pmem_region_probe(struct device *dev)
 			.size = m->size,
 			.position = i,
 		};
-		info[i].offset = m->start;
-		info[i].serial = cxlds->serial;
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

