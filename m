Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E0A1B4241
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229848; cv=none; b=lxhZb+MnQxLDBCDKydS7sbQm1zWGGxraavqY97qXj5vme7/IzCWToobgbr61WSaRwpWZQySgU9VZKySiK6Jf3cit4XFBHS/50OUR+otKvoI3bvvLAfaHusd6sctO+xWBB5bo851KoXBeXR6JANeRMbGMCUJC1lRQcqZBh6O+80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229848; c=relaxed/simple;
	bh=uiOkQtBtG1wRsyqvL930vj0iD5TQXkDk4xDrMxNZuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2HJGA6BNPNHgqRRDiEDR8B621ytxOsNsSC7KCxGaEY6qZKjgNyJdKw/WpMv21U/acapUQs7BfGAG5cS6YHf+aOnoQmRtoox7X1sQ+idujgA0B4qFtxiU8VFNdePUzpnb6XUbSTGZL9s03BmASuA5t8EqX+R0mfOJZBq2/G1pTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUhKRBMg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUhKRBMg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224341bbc1dso85900495ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229846; x=1742834646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=353TAKo8VnbJ8QqIp//xm5+02cW4+3eAhYTJE+s11Po=;
        b=YUhKRBMguAyonPpAXmXopMnDVQNdfqE4kxVHePP6R8r+mrqotZP+trq+IRzYa35fP7
         n0u3vgslRFze/vjajDjNJgdSNMUo5omOokaNUt+QjdGvek0qa1oL+4f2n8V4vdBbJo4c
         mkN4ppFP8c6d1mJne4OMogp57aAKq6QWrlEv3LBSI0kw7uKComCcT3dkj0EnJt5Do23c
         IFq6DRwvfeVGUnL+D8MiTdOjHZVOSGOqzrRiwVJkEhnrBi5ALxU9QU9RjNWg3NBHDEM5
         oHxdjtwfeTKhjpC5hslUB+2YrKDntuG6T2Hufd+8WDIL4nCvwYSvZJphh95bfr+kNqUj
         aRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229846; x=1742834646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=353TAKo8VnbJ8QqIp//xm5+02cW4+3eAhYTJE+s11Po=;
        b=vT+db6OE+uINPecqH/yEGl3hbMxZ5irjMHDvV+YqJ92OtlZ2lOpyvVf9A7o5tuBnfr
         FtQoZddEBk4AQVCrNVmyEaRWHUgfbD0MpcHRYNs4NQAgz2CShcS/SSjz4PlNlP19vyIY
         cELWeQb6XlgrWUv8VRVfqYNvmcl7DPkIHi3JEIma6czwNelOxNS4nhLFB3uRMLQgqsAZ
         AKoxyXCYH10vWlFS70jjfo8u6PYZ0jiBxg3kHZ0khEwta09TnAtpRLydePj0i0GTBxVb
         5m/Q8t4XdAc4niYQuiONgxCmfAkwTz6z9IcY2YxLhXr4gx4CuTdFILS/7F526gA+JrjI
         fmlA==
X-Forwarded-Encrypted: i=1; AJvYcCUN4G9oChPdWazf5h+khJ9VCtHw0NExYwWVoVFrd6MkyzS08kMml+pR+7TKSoKQdFmw3T7tp4Ij0Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EBl41hEDD5IjDbQi5ic4U8goGKs5HNa8i9ci8aqDn4m6gH+Z
	f+tj0qoy3f+RUYdY7Cb9uN6BMSGTeVw8GO7K9059LR+X/PDXo/jtyG43CQ==
X-Gm-Gg: ASbGncug8JECpliMG9LjYCdArYZF6hnOpNxZKZify1I7MsMPsumx7W3aTZN5ZCc6N92
	vCYIPDCVvEVAx2Ujz6fVIory8uOCQnfRZNjrTbNJvFhFGh9grYuJgWvFQkd3fx5npEWvI5TvMR2
	znz7HYEUd8qIXNLj4A4EWJzjV+lhifwAUW7t2Zs+fculGijJzITPAhTT+C+3LXYw9Sbywb7Mcil
	hXqtH0AxjbuJX82v2CCBZq0+J14hkZTIOBTeF5j0XBe6O141/l9mhjBlq27B1vJgFD4AeYarunw
	Bi24WYy/NV8IdwrK5vvMSoSlmVOkv1cWAYwQLu8amOMSH1XnQfgoONFR8qY9leNz9g==
X-Google-Smtp-Source: AGHT+IH2UQVAMxqKvpv3asrn5zmBcvf0OAu7rzB4rOpB6x7Pz7Oqydnwl9BwCTj1jDJg3+oVjydsTw==
X-Received: by 2002:a17:902:ec81:b0:220:fe50:5b44 with SMTP id d9443c01a7336-2262c583a37mr3222255ad.31.1742229846058;
        Mon, 17 Mar 2025 09:44:06 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:44:05 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 7/9] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
Date: Mon, 17 Mar 2025 16:31:34 +0000
Message-ID: <20250317164204.2299371-8-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 51ead2b152..77cf0fdb15 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -126,6 +126,7 @@ enum {
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
+        #define GET_DC_REGION_EXTENT_LIST 0x3
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3587,6 +3588,87 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h)
+ */
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
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        out_rec = &out->records[record_done];
+
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
+            record_done++;
+            out_rec++;
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
@@ -3720,6 +3802,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0},
 };
 
 /*
-- 
2.47.2

