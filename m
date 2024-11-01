Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7823168DA
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468394; cv=none; b=MGYGnuPCJ7qMTaYbkpOb3bXPpRPm1i7IvcUyTRGiTlMUg2Ix1Ayz/qDRnj/6jCfk9/EZeYVQgDcXlIuxKmXakAJFzVBlLp5hWlvzSR4fnNIgbmbGZGeQ3XLiBJxBt/V8cs9juvpEe162Ptqe6Pcq3yAn2nbiStvuA3wFw8LjrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468394; c=relaxed/simple;
	bh=8phfBryrpv4N4DjmyEevzZ8TMpA5AUvwqBjN1VtpOE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERS/NVHGkJ9gSNjRgi3ZhoNrDS+Y4YCpP89wWgeeD6RKnzcAJpjzjvF/g9c3ycZxf5iVeBTeY281xl2evaorEDR+9sh9V3SIvB8t02T0Yc7iHEb+dJ7WKd2vmNj9TpbfXAh5B8j0AR+N97pUNVtdbC/CX2RAVSVwf2ze14XsLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg23L2VXPz6K6Qk;
	Fri,  1 Nov 2024 21:37:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE5A6140A36;
	Fri,  1 Nov 2024 21:39:49 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:39:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 01/10] hw/cxl: Check size of input data to dynamic capacity mailbox commands
Date: Fri, 1 Nov 2024 13:39:08 +0000
Message-ID: <20241101133917.27634-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

cxl_cmd_dcd_release_dyn_cap() and cmd_dcd_add_dyn_cap_rsp() are missing
input message size checks.  These must be done in the individual
commands when the command has a variable length input payload.

A buggy or malicious guest might send undersized messages via the mailbox.
As that size is used to take a copy of the mailbox content, each command
must check there is sufficient data. In this case the first check is that
there is enough data to read how many extents there are, and the second
that there is enough for those elements to be accessed.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 97cb8bbcec..17924410dd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2465,11 +2465,20 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
     uint64_t dpa, len;
     CXLRetCode ret;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (in->num_entries_updated == 0) {
         cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
         return CXL_MBOX_SUCCESS;
     }
 
+    if (len_in <
+        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     /* Adding extents causes exceeding device's extent tracking ability. */
     if (in->num_entries_updated + ct3d->dc.total_extent_count >
         CXL_NUM_EXTENTS_SUPPORTED) {
@@ -2624,10 +2633,19 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     uint32_t updated_list_size;
     CXLRetCode ret;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     if (in->num_entries_updated == 0) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
+    if (len_in <
+        sizeof(*in) + sizeof(*in->updated_entries) * in->num_entries_updated) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
     ret = cxl_detect_malformed_extent_list(ct3d, in);
     if (ret != CXL_MBOX_SUCCESS) {
         return ret;
-- 
2.43.0

