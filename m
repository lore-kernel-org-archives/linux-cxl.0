Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF71D270B
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115944; cv=none; b=qQCQshpoULhoT4b33tZ6d44s09b8x9Pty2NZ8tvM5mwoxqyI7DuzlJz+tJIeDF8aCT+CpEUxNhIzC6GP2llX+CvyYYGpzt2qn38gkH+2y7LjJ6RkvkFUbqOYoxOrSHap7G7MZkz2FBzHe/dapHlvFkIQqdIUiJvoy/8kt+Cay4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115944; c=relaxed/simple;
	bh=VM5AoH77kamG/P8FfHaTplWWh9Ri6fOxL2aXoCutNPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=usO73XM7tji5kTB8vwJvGRaozkbfL/WwwEF1yDiEV+3w5bnVpk0ROS8FLBTlcuTUfT9rONZyRzJW7jy1g0naxHjrD9zmG6ZYx1BNh/LFKRMMx9HPfYCIcgncU0VZAzYYOuCVhrrky5xphBbVhtgcffwjSaNJDjUcX2VsWsBN1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WXPgRGfA; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WXPgRGfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729115942;
	bh=Lm6OJ4ppqsx00EFeKk98+BP9777KWhMrNiTij1ST0DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=WXPgRGfAGSBQ00OKL/S5QnnHalfxPHj6QKQmVCvcPeapY5Lgm1PTEoSJ18eXZWB9Y
	 GI4ox1dbRj505boKls9Koc5HhS9U/rwJgG2DSf/IC3RRAlGGbCai/WV2ysYZOToF0D
	 jgrKMq3twbf4+eXR9HNunIKFU1pwb4oY2u83dZ81pj6jXFMR0y7xe4mcyoo51jOFx2
	 C1WGEkAp6jn70HYnSq96ag+Xt2QMNJsoqUCPfjkZgXQ9o5vIYS6lOeXZqkST0uYZZY
	 feYqqkWjGhjqxHHRhOvkSxAPRrktGwofq0K0Y8vh9YNCQJZK0QU1Q8QPtqelZsR5Em
	 OjDa0WEp8Z3qQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 5E01D800198;
	Wed, 16 Oct 2024 21:58:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 17 Oct 2024 05:57:40 +0800
Subject: [PATCH v6] cxl/region: Fix wrong logic for finding a free switch
 cxl decoder
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-const_dfc_prepare-v6-1-fc842264a1cc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANM2EGcC/33QwU7DMAwG4FeZciYosZMm5cR7IDSlicNyoB3Jq
 EBT3x1vF4pacfx/yZ8tX0WjWqiJp8NVVJpLK9PIoXs4iHgK4xvJkjgLUGCU11rGaWyXY8rxeK5
 0DpUk5gwYO9t7soLnuM/l626+vHI+lXaZ6vd9xaxv7X/arKWSqXMxGt0NmPD547PEMsbHOL2Lm
 zfD2rB7BrDhkee9G3zO/dbAlQFmz0A2EDQ4CgjDELaG+TV6tXuHYcNor0gnG8CYrWFXhnZ7hpX
 8EQKVO4dEKv41lmX5AcF4FVTEAQAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: NTtQUb32VILvAfHfVNv7Kp5Uzly96Dx_
X-Proofpoint-ORIG-GUID: NTtQUb32VILvAfHfVNv7Kp5Uzly96Dx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410160140
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Provided that all child switch cxl decoders are sorted by ID in ascending
order, then it is wrong for current match_free_decoder()'s logic to find
a free cxl decoder as explained below:

Port
 ├── cxld A        <---->  region A
 ├── cxld B        // no region
 ├── cxld C        <---->  region C

Current logic will find cxld B as a free one, but cxld B is not true
free since region C has not been torn down, so current logic is wrong.

Fixed by verifying if cxl decoder with ID (@port->commit_end + 1) can
be returned as finding result.

Link: https://lore.kernel.org/all/670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
This patch is incremental to below patch series with title "cxl: Initialization and shutdown fixes"
http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com

This patch is based on Dan's recommendation shown by below link:
https://lore.kernel.org/all/670af54931b8_964fe29427@dwillia2-xfh.jf.intel.com.notmuch/
---
Changes in v6:
- Use Dan's recommendation that validate clxd with ID (@port->commit_end + 1)
- Correct commit message and update Link tag this commit derive from
- Link to v5: https://lore.kernel.org/r/20240917-const_dfc_prepare-v5-1-0e20f673ee0c@quicinc.com

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
 drivers/cxl/core/region.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e701e4b04032..a7a82da39393 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -796,8 +796,9 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 
 static int match_free_decoder(struct device *dev, void *data)
 {
+	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_decoder *cxld;
-	int *id = data;
+	struct device **target_dev = data;
 
 	if (!is_switch_decoder(dev))
 		return 0;
@@ -805,15 +806,24 @@ static int match_free_decoder(struct device *dev, void *data)
 	cxld = to_cxl_decoder(dev);
 
 	/* enforce ordered allocation */
-	if (cxld->id != *id)
-		return 0;
+	if (cxld->id == port->commit_end + 1) {
+		if (!cxld->region) {
+			*target_dev = dev;
+			return 1;
+		}
 
-	if (!cxld->region)
-		return 1;
+		dev_dbg(dev->parent,
+			"%s: cxld '%s' was reserved by '%s'\n", __func__,
+			dev_name(dev), dev_name(&cxld->region->dev));
+		return -EBUSY;
+	}
 
-	(*id)++;
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		return 0;
 
-	return 0;
+	dev_dbg(dev->parent, "%s: cxld '%s' was out of order shut down\n",
+		__func__, dev_name(dev));
+	return -EINVAL;
 }
 
 static int match_auto_decoder(struct device *dev, void *data)
@@ -839,17 +849,18 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_endpoint_decoder *cxled,
 			struct cxl_region *cxlr)
 {
-	struct device *dev;
-	int id = 0;
+	struct device *dev = NULL;
 
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
 
-	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
-	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+	} else {
+		device_for_each_child(&port->dev, &dev, match_free_decoder);
+		get_device(dev);
+	}
 	if (!dev)
 		return NULL;
 	/*

---
base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
change-id: 20240811-const_dfc_prepare-3ff23c6598e5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>

