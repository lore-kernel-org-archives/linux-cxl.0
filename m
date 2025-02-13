Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC020B20B
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525754; cv=none; b=aH4i6YVkqJB0if9mw0nafddipyhoErNUCGw3FuwZ+6ywvJPcNX3AXH2FVGLVON60d2RnvXTLfCkWpgUhGFVZkB496brk2+ProAlpCrZ3ZU9Ho9kTDZniXzl1cUrO2gv55pz4qwFTO4tF6RfiI0V2o/zp20u7DupDlX0CtfrJYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525754; c=relaxed/simple;
	bh=zWsgH4IlLukEDKnrwuUBb3S8OoWX1UM+XloEimG7Aq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=UoURT43kSFQOAoauYfrG35/pkLFLsvFRTUJRnB4Z+v4MffFaeHMPwksAhuEapNVxrn+LbLgeuOjPR/WRok0MWsapnasLedq0XlRrGVAAszen6hbK4RyIOmcPG5iATFuHQDsogYrccSrG2OnX7SqRDd1ZnmObIi/l5Ex5ZYkq49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pfZ16XPf; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pfZ16XPf"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250214093550epoutp01656cb06f44206205eec87b1ddf41a805~kCXQhcvqR0452804528epoutp01X
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 09:35:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250214093550epoutp01656cb06f44206205eec87b1ddf41a805~kCXQhcvqR0452804528epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739525750;
	bh=xi+eGfXc7CLAVfVWod9Ofd5IXXxIwEbBieUdsw5O5V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfZ16XPf5rBChLjUvqCLIr8lKci8BAXWuMvfg/HKd3nWT8wP1RPrCHnyZ1IORQmEU
	 4u8cBaOgfjvhuxG8X8UmPZunMOY7pTAc9fVNlVJbnsixT0+a2tFU8dqVVNYmrtssTH
	 PJm4zv4yLJ07z48DxSE4zBBRdlK1BRfR57MK86zU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250214093550epcas5p4fb494e959e5ddaa570d9f030c3226726~kCXQPvoeW2149321493epcas5p47;
	Fri, 14 Feb 2025 09:35:50 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YvRkC5y9Kz4x9Px; Fri, 14 Feb
	2025 09:35:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.DC.19710.37E0FA76; Fri, 14 Feb 2025 18:35:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250213091629epcas5p1e5435929f701840a7e13f22a83edff22~judFPpdAG1560415604epcas5p1w;
	Thu, 13 Feb 2025 09:16:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213091629epsmtrp1eec0b2d90dbf156b348d2221abf7f0fc~judFO89rm2265722657epsmtrp1U;
	Thu, 13 Feb 2025 09:16:29 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-b7-67af0e73e3fa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.74.18949.D68BDA76; Thu, 13 Feb 2025 18:16:29 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213091628epsmtip11de8558fbcbb9a3079f8c4bcd48226c8~judDu8c6R2263522635epsmtip1h;
	Thu, 13 Feb 2025 09:16:27 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
	<vinayak.kh@samsung.com>
Subject: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands (8.2.9.9.5.3)
Date: Thu, 13 Feb 2025 14:45:56 +0530
Message-Id: <20250213091558.2294806-2-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213091558.2294806-1-vinayak.kh@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmum4x3/p0g1mv9CymH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFw4zImi/OzTrFY/N22l9HieO8OFosTJ7ezA8XmsDtweeycdZfd48m1zUwe
	fVtWMXpMnV3v8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
	qq2Si0+ArltmDtBNSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
	dL281BIrQwMDI1OgwoTsjC8t/SwFvw0r1rc8ZG5gvKjUxcjJISFgInGz+R5LFyMXh5DAbkaJ
	jQ+bGSGcT4wSE7Y+ZYNwvjFKXL6yCqiMA6zlw6UMkG4hgb2MEm8nukDUNDBJLJ//jgkkwSZg
	IPGg+Tg7iC0iICnxu+s0M4jNLPCBUWLRU12QOcICpRKnL7CBmCwCqhJ/7ieDVPAK2Eqs/vmI
	DeI4eYn9B88yg5RwCthJTHuZDVEiKHFy5hMWiIHyEs1bZzNDlP9llzg1xRHiSBeJQ0crIcLC
	Eq+Ob2GHsKUkXva3QdnFEucufmKEsGskXnetgBpjL9F6qh9sK7OApsT6XfoQYVmJqafWMUFs
	5ZPo/f2ECSLOK7FjHogNslVFYunbTJhNX541Q033kGh9s5oZEkwTGSW+T13LNIFRYRaSZ2Yh
	eWYWwuYFjMyrGCVTC4pz01OTTQsM81LL4dGbnJ+7iRGcQLVcdjDemP9P7xAjEwfjIUYJDmYl
	EV6JaWvShXhTEiurUovy44tKc1KLDzGaAsN6IrOUaHI+MIXnlcQbmlgamJiZmZlYGpsZKonz
	Nu9sSRcSSE8sSc1OTS1ILYLpY+LglGpgemZpv/xf6DR1LeslGlcj9iz9N/3sJV6BSdxSorKV
	fzMKkyaG5stlX0hbsGitl17QpUkinBsbp4qGiPQK2t8uEZ8d7xOn+TV70Z5ixklnvZulZhxW
	7mQJqP0TqO2/4Wqg7sMcqRXyWVpzqn/1u+TPFvJj6zns9qziSenUprPqrRkrZbexz013vLJx
	lZRAfGWUw4+kxyHii95Pqfl7c3Lnckf51cujHZOfqC97trTKq2qJ86Jju80l8o4n89VpM3w5
	9I7hxKoo1dL3RwX3PGx4VNC9QOUEl2ZOrHvPnnsZxt0T97e02tfM/rpCR2rnR7WSiJrqCzvf
	V9hPONSZrneN+UvoXc5/vxexPxQRC1RTYinOSDTUYi4qTgQAS4OyYCkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnG7ujrXpBnsnKFlMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6MLy39LAW/DSvWtzxkbmC8qNTFyMEhIWAi
	8eFSRhcjF4eQwG5GiclPf7N0MXICxaUkju38yQZhC0us/PecHaLoH6PE0sevmEASbAIGEg+a
	j7OD2CICkhK/u04zgxQxC/xilHi6+z5YQligWGLChudsINtYBFQl/txPBgnzCthKrP75CGqB
	vMT+g2eZQUo4Bewkpr3MBgkLAZXs7rzGBFEuKHFy5hOw25iBypu3zmaewCgwC0lqFpLUAkam
	VYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwcGupbWDcc+qD3qHGJk4GA8xSnAwK4nw
	Skxbky7Em5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QDk9/R
	Ex6y/nN+PvwtdUflyZGb7Z8a3x0x3/M80LI9RC/Sfl9p2cwlb55+CjV29WS5tHlS1PTjZyQ9
	I+5zFq21zrXIerzX6Jrf+oOX7A05RNr7a5ZcP/nT89NXIY855y/s+HDLf3bBJfML3CUCOqtt
	yie18jRzPzl/fSUzy4uSrz9nVdv/M4wRVmSaVzK/9WLv122R+78wrY1rffDzjOjtRRlddvx/
	jy1Zmxj2zz5kUWKvryK/rN1C8XSpSCPBy2K7fQ8udVSLOl+pFV+87sLv76+fuTs86nt0rzXk
	jZedlyJv6JS95xn9lcIzZgv1++Ykh0Sy3OjTSFyYeuj5A9envDNbmI5ynw3MOrOgJTkzW4ml
	OCPRUIu5qDgRAMLGJ/zlAgAA
X-CMS-MailID: 20250213091629epcas5p1e5435929f701840a7e13f22a83edff22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213091629epcas5p1e5435929f701840a7e13f22a83edff22
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
	<CGME20250213091629epcas5p1e5435929f701840a7e13f22a83edff22@epcas5p1.samsung.com>

CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
CXL devices supports media operations discovery command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 136 +++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..fa38ecf507 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -89,6 +89,7 @@ enum {
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
+        #define MEDIA_OPERATIONS 0x2
     PERSISTENT_MEM = 0x45,
         #define GET_SECURITY_STATE     0x0
     MEDIA_AND_POISON = 0x43,
@@ -1721,6 +1722,137 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+#define CXL_CACHELINE_SIZE 64
+enum {
+    MEDIA_OP_CLASS_GENERAL  = 0x0,
+        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
+    MEDIA_OP_CLASS_SANITIZE = 0x1,
+        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
+        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
+    MEDIA_OP_CLASS_MAX
+};
+
+struct media_op_supported_list_entry {
+    uint8_t media_op_class;
+    uint8_t media_op_subclass;
+};
+
+struct media_op_discovery_out_pl {
+    uint64_t dpa_range_granularity;
+    uint16_t total_supported_operations;
+    uint16_t num_of_supported_operations;
+    struct media_op_supported_list_entry entry[];
+} QEMU_PACKED;
+
+static const struct media_op_supported_list_entry media_op_matrix[] = {
+    {MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY},
+    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE},
+    {MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO}
+};
+
+static CXLRetCode media_operations_discovery(uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+        struct {
+            uint16_t start_index;
+            uint16_t num_supported_ops;
+        } discovery_osa;
+    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
+    int count = 0;
+
+    if (len_in < sizeof(*media_op_in_disc_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    struct media_op_discovery_out_pl *media_out_pl =
+                                                  (void *)payload_out;
+    int num_ops = media_op_in_disc_pl->discovery_osa.num_supported_ops;
+    int start_index = media_op_in_disc_pl->discovery_osa.start_index;
+
+    if (start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    media_out_pl->dpa_range_granularity = CXL_CACHELINE_SIZE;
+    media_out_pl->total_supported_operations =
+                                     ARRAY_SIZE(media_op_matrix);
+    if (num_ops > 0) {
+        for (int i = start_index; i < ARRAY_SIZE(media_op_matrix); i++) {
+            media_out_pl->entry[count].media_op_class =
+                    media_op_matrix[i].media_op_class;
+            media_out_pl->entry[count].media_op_subclass =
+                        media_op_matrix[i].media_op_subclass;
+            count++;
+            if (count == num_ops) {
+                break;
+            }
+        }
+    }
+
+    media_out_pl->num_of_supported_operations = count;
+    *len_out = sizeof(struct media_op_discovery_out_pl) +
+        (sizeof(struct media_op_supported_list_entry) * count);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+
+    if (len_in < sizeof(*media_op_in_common_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    uint8_t media_op_cl = media_op_in_common_pl->media_operation_class;
+    uint8_t media_op_subclass =
+                      media_op_in_common_pl->media_operation_subclass;
+    uint32_t dpa_range_count = media_op_in_common_pl->dpa_range_count;
+
+    switch (media_op_cl) {
+    case MEDIA_OP_CLASS_GENERAL:
+        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        /*
+         * As per spec CXL 3.1 8.2.9.9.5.3 dpa_range_count
+         * should be zero for discovery sub class command
+         */
+        if (dpa_range_count) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        return media_operations_discovery(payload_in, len_in, payload_out,
+                                             len_out);
+    case MEDIA_OP_CLASS_SANITIZE:
+        switch (media_op_subclass) {
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
+    default:
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -2864,6 +2996,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
          CXL_MBOX_SECURITY_STATE_CHANGE |
          CXL_MBOX_BACKGROUND_OPERATION |
          CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
+    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
+        ~0,
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
-- 
2.34.1

