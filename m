Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF0277CBE
	for <linux-cxl@vger.kernel.org>; Wed,  2 Jul 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472391; cv=none; b=OcQ/33Yq2sWu1g6JDw6CTJAxDiMfBNqVQOginB4Nzzq0qC8S/SvAFSoJqjGAJ2awQKgWserMb3Jdq3qBoUzb+6EbeIJO7oklxJeK9/SzxcdmAcpakxJjqn7q8D1CQpvwklYPLSp/ovWIqHyptcHo8TB8TpTcOSjuKagwBTK5xQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472391; c=relaxed/simple;
	bh=Rw3xi8VgRuMJHDBU48Ok8sciaNFtbX7yXVDQH2h6fDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgvLrsAbmZexU03kHPD/zhE8rK7xJkbdDANnE+1beAOpKPw/FN2g3Rylj3MUm9GjlG3yKL3veSpQEAJKyqc3UdWG0LBP9cxb/ed9KcsBvoAegbQIcja3nCfB2jJOZ8tdcoF2DxXZy/Fm3epP8SaaJ+/7opUFIAXAUbQkR9Yoifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXPrC6G2Yz6M4fv;
	Thu,  3 Jul 2025 00:05:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AB3CD1402E9;
	Thu,  3 Jul 2025 00:06:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Jul 2025 18:06:27 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 08/11] hw/cxl: mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
Date: Wed, 2 Jul 2025 17:02:14 +0100
Message-ID: <20250702160219.989731-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1fc453f70d..24e4ba0200 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,7 @@ enum {
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
+        #define GET_DC_REGION_EXTENT_LIST   0x3
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3469,6 +3470,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
+static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t start_extent_id;
+        uint32_t extents_returned;
+        uint32_t total_extents;
+        uint32_t list_generation_num;
+        uint8_t rsvd2[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtent *ent;
+    CXLDCExtentRaw *out_rec;
+    uint16_t record_count = 0, record_done = 0, i = 0;
+    uint16_t out_pl_len, max_size;
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.nr_extents_accepted) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.nr_extents_accepted - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            out_rec = &out->records[record_done];
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3594,6 +3668,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0 },
 };
 
 /*
-- 
2.48.1

