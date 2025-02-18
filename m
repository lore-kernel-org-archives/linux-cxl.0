Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33802182BD;
	Tue, 18 Feb 2025 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843328; cv=none; b=aHHzZkr8qSSiy0FA8tBXNx0Lz5tuMinhg3oG966TGEkuWCDeJ12KTf4D6DOuh6AdqSiM9mD8d05lWU5WwKJd7T/54HoHFcqVMEQfXyVkpW0S0bOKiqOo8HQf3laJGUARwe70Ms8NyukAA/nkuSHbRHU4ARVy9scTM/ue/bIXR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843328; c=relaxed/simple;
	bh=Pvfd3S9t2q3CjPRzH+g+7nauZ/Qv+n12GNPycf6Q0cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbAgtdG+HrVxZnt1b9LSdgoQ1MY5uUYTYyDiK9u0yf3gueUgT8Me6cgANrEff5qkWTRsDut8vGbEyx69Trw87yyNymjsWeTK60Bd3BZchBOkbj44RGadsQUl3O+B5n9cgsHS5MgMVwLVSPn6ZsvaK8ZIFeCN6Y3YmzLa0djxXuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD3eyzw5rNnW+SfAw--.22085S2;
	Tue, 18 Feb 2025 09:48:32 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDX3YnW5rNnzKMqAA--.56977S4;
	Tue, 18 Feb 2025 09:48:16 +0800 (CST)
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
Subject: [PATCH v3 1/1] cxl/pmem: debug invalid serial number data
Date: Tue, 18 Feb 2025 09:47:46 +0800
Message-Id: <20250218014746.166565-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218014746.166565-1-wangyuquan1236@phytium.com.cn>
References: <20250218014746.166565-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDX3YnW5rNnzKMqAA--.56977S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWezlaEAsAAAsV
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tryfXF4rJr47GrW7KF4DJwb_yoW8Aw45pr
	48tayYkrW3JF13Zw47ZFy8ZFyFg3Z7W3y8Gryjqw15urn5tF1IqF4xtayYya43Ca95tw4a
	934j9ryUuF4UX3DanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
 drivers/cxl/pmem.c           | 8 ++++++++
 tools/testing/cxl/test/mem.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index f9c95996e937..73787afe1b9d 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -383,6 +383,14 @@ static int cxl_pmem_region_probe(struct device *dev)
 			.position = i,
 		};
 		info[i].offset = m->start;
+
+		if (cxlds->serial == 0) {
+			/* include missing alongside invalid in this error message. */
+			dev_err(dev, "%s: invalid or missing serial number\n",
+				dev_name(&cxlmd->dev));
+			rc = -ENXIO;
+			goto out_nvd;
+		}
 		info[i].serial = cxlds->serial;
 	}
 	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
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

