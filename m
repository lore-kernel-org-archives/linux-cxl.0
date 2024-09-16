Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415F14B95F
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529356; cv=none; b=E4qDCvpTkmf5IMWUpn7A8Cm4qaaf1Wq3CdsoRrfJjMzLxKzVPpmMltZYosjDQXJrPHO2WwdSPzfuXbaxVosslL8M9PCUNtgjCQx7xWW8bnFj0HI3rI+JxgaBVBunJVmymizHTnPsBCZAVm6zONZpKZNnsvtgOCzLKWxOr2CK6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529356; c=relaxed/simple;
	bh=NCtio64jejV7b59x/XmGNVFttG4fAHjRxL4DO9od/4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MthSQMBH0Xf3Ok29B2pBmkw8h7y2iYyeKultjDt3XgPY783bPWMGJlO78R1dl7HkklPGoXtlo/qW1A09fne+N1bwhLuLd2m5JDBFQj9p3FUBKfCEWToowOzxpvnp8ipMnZ9T6Un5Kh5Jxylj6HKYtu8gufe4HdfgqAg6PQPDEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nikTtLEz; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nikTtLEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726529354;
	bh=LwiQREwQlmnQqXBZiOVeyVLwle93P4gHNSIcarqldck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=nikTtLEzQ6WSWrmmNcgtE6w760sPeH0GIAR1grGcVPv8CnvwwwExo3mtLiWzwZdTd
	 TToUL4W5/Emz84k3FhBSn975RihA6Z9HYamHosjHKIgojJKMwCgH8TgsfecfGatsUp
	 VBmwF8ELJmZ156wTMg1Vj35PMtq4BI5LbBUKKs6//ETGPdjuMRXYVrc7U+lMFnnI/a
	 7tvRItrYJt+hKXYFhcsaCqNxhrIkduFqDp9KX6Dy8suV40YoAKXNZ5Vka6eT0WSg7O
	 +kvIfopiguaACJ3sT1TzbiY4t9aZFM1Y/4HkSr1zP4GaWB/+Wy2KoizMoU/ODYYkmy
	 ZE1diuTp2kVKQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 43F83680316;
	Mon, 16 Sep 2024 23:29:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Sep 2024 07:27:49 +0800
Subject: [PATCH v5] cxl/region: Fix wrong logic for finding a free switch
 cxl decoder
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240917-const_dfc_prepare-v5-1-0e20f673ee0c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPS+6GYC/33OQU7DMBAF0KtUXmNkz9iJw4p7IFQ54zH1gqTYJ
 QJVuTvTbihqxPJ/6b+Zs2pcCzf1tDuryktpZZ4k+IedokOc3liXJFmBAWeCtZrmqZ32KdP+WPk
 YK2vMGZA6PwT2SnbS5/J1NV9eJR9KO831+3pisZf2P22x2ujU9UTOdiMmfP74LFQmeqT5XV28B
 W4Nv2WAGAFlH/ox5DzcG3hjgNsyUAwECz1HhHGM94b7NQaz+YcTw9lg2CYfwbm/xrquP9VSUAG
 AAQAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Provided that all child switch decoders are sorted by ID in ascending
order, then it is wrong for current match_free_decoder()'s logic to
find a free cxl decoder as explained below:

Port
 ├── cxld A        <---->  region A
 ├── cxld B        // no region
 ├── cxld C        <---->  region C

Current logic will find cxld B as a free cxld, that is wrong since
region C has not been torn down, so can not regard cxld B as free.

Fixed by finding a real free clxd by ID instead of region state.

Link: https://lore.kernel.org/all/66e08f9beb6a2_326462945d@dwillia2-xfh.jf.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v5:
- Use changes suggested by Dan Williams for cxl/region patch
- Correct title and commit message for cxl/region change
- Seperate qcom/emac change for patch series
- Link to v4: https://lore.kernel.org/r/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com

Changes in v4:
- Drop driver core patch
- Correct commit message for cxl/region patch
- Correct title and commit message for qcom/emac patch
- Link to v3: https://lore.kernel.org/r/20240824-const_dfc_prepare-v3-0-32127ea32bba@quicinc.com

Changes in v3:
- Git rebase
- Correct commit message for the driver core patch
- Use changes suggested by Ira Weiny cxl/region
- Drop firewire core patch
- Make qcom/emac follow cxl/region solution suggested by Greg
- Link to v2: https://lore.kernel.org/r/20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com

Changes in v2:
- Give up introducing the API constify_device_find_child_helper()
- Correct commit message and inline comments
- Implement a driver specific and equivalent one instead of device_find_child()
- Link to v1: https://lore.kernel.org/r/20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com
---
 drivers/cxl/core/port.c   |  3 ++-
 drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++++-----------------
 drivers/cxl/cxl.h         |  5 +++++
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..749a281819b4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1750,7 +1750,8 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	struct device *dev;
 	int rc;
 
-	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
+	rc = ida_alloc_max(&port->decoder_ida, CXL_DECODER_NR_MAX - 1,
+			   GFP_KERNEL);
 	if (rc < 0)
 		return rc;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..d3e191ae3c20 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -794,26 +794,16 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
-static int match_free_decoder(struct device *dev, void *data)
+static int match_decoder_id(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld;
-	int *id = data;
+	int id = *(int *)data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
-
-	/* enforce ordered allocation */
-	if (cxld->id != *id)
-		return 0;
-
-	if (!cxld->region)
-		return 1;
-
-	(*id)++;
-
-	return 0;
+	return cxld->id == id;
 }
 
 static int match_auto_decoder(struct device *dev, void *data)
@@ -840,16 +830,31 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_region *cxlr)
 {
 	struct device *dev;
-	int id = 0;
 
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
 
-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
-	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+	} else {
+		int id, last;
+
+		/*
+		 * Find next available decoder, but fail new decoder
+		 * allocations if out-of-order region destruction has
+		 * occurred
+		 */
+		last = find_last_bit(port->decoder_alloc, CXL_DECODER_NR_MAX);
+		if (last >= CXL_DECODER_NR_MAX)
+			id = 0;
+		else if (last + 1 < CXL_DECODER_NR_MAX)
+			id = last + 1;
+		else
+			return NULL;
+
+		dev = device_find_child(&port->dev, &id, match_decoder_id);
+	}
 	if (!dev)
 		return NULL;
 	/*
@@ -943,6 +948,9 @@ static void cxl_rr_free_decoder(struct cxl_region_ref *cxl_rr)
 
 	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
 	if (cxld->region == cxlr) {
+		struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+		clear_bit(cxld->id, port->decoder_alloc);
 		cxld->region = NULL;
 		put_device(&cxlr->dev);
 	}
@@ -977,6 +985,7 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	cxl_rr->nr_eps++;
 
 	if (!cxld->region) {
+		set_bit(cxld->id, port->decoder_alloc);
 		cxld->region = cxlr;
 		get_device(&cxlr->dev);
 	}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..750cd027d0b0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -578,6 +578,9 @@ struct cxl_dax_region {
 	struct range hpa_range;
 };
 
+/* Max as of CXL 3.1 (8.2.4.20.1 CXL HDM Decoder Capability Register) */
+#define CXL_DECODER_NR_MAX 32
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -591,6 +594,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
+ * @decoder_alloc: decoder busy/free (@cxld->region set) bitmap
  * @reg_map: component and ras register mapping parameters
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
@@ -611,6 +615,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
+	DECLARE_BITMAP(decoder_alloc, CXL_DECODER_NR_MAX);
 	struct cxl_register_map reg_map;
 	int nr_dports;
 	int hdm_end;

---
base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
change-id: 20240811-const_dfc_prepare-3ff23c6598e5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

