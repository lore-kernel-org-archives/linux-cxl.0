Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DD135A53
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029327; cv=none; b=tGtikwNJLSp7DyO05sDlKWwUClsHZtFMV29xeQVw5/n0eW46kiXBIo/vm6RE0Q9qlgJYYqrWRqu+wlAgKHIN0q2fqCQxSyNk6060gpyyjzJ7AAVys9DNpucCDwujTpz1MFFFf2ZxAWU9RfMnYNnOQlIksfawoneRLl+rKPb0BiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029327; c=relaxed/simple;
	bh=YLk3o7igdCexPPJXvBMtCSbHkcTxvaXX3CH43muQN4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=lfnffcZYRLoC46gU1YTGvpNr4LadBGTdiz1gzvQxgi1qrb6i+JKsob7jgXZqhpYhFY47MZnfFZelEZnSj0KDfYrI4Y3A2sAGv6zJQPq7qXDUO+XgW3bF2VXhJQUPse+kzzWmerMkT5tHh0y5lj3S7msBcXxJ/N4IIsAhu3wuhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aUYCafLT; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aUYCafLT"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250220052842epoutp0429655131e602439bcbd3a272baebdb6b~l03Mpp8KE1535615356epoutp04m
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:28:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250220052842epoutp0429655131e602439bcbd3a272baebdb6b~l03Mpp8KE1535615356epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740029322;
	bh=n1y/7rvCq+AbMd5usBXzULQZnDqta6PaD03cEJBUPfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUYCafLT3GgcAMbr/rS/86kzNqGU6znJakkL6fzelMpOL5Tpt9+XyVYL+r7N+4slV
	 GRvS+Lqg1LH8HSBuO/7RNt4DyJ3Q+OA2Ppnzm5+7hc0ZuMCuB6kaA7TcLj62ox8oQw
	 njrbILrXhGXHNpLJ8jcBFboJOiRJwl7VJUABkF1s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250220052842epcas5p40e0665ec91b84d22145600757040941d~l03MT1OIE1079910799epcas5p45;
	Thu, 20 Feb 2025 05:28:42 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yz1yH70Kmz4x9Pr; Thu, 20 Feb
	2025 05:28:39 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.8D.19710.78DB6B76; Thu, 20 Feb 2025 14:28:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250220052734epcas5p2c0e082880350b5fa314c9062294bbc80~l02Nhs-9x2074720747epcas5p2v;
	Thu, 20 Feb 2025 05:27:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220052734epsmtrp1385e02993de9e0ac5d432c202b2a77c8~l02Ng5faI1160311603epsmtrp1J;
	Thu, 20 Feb 2025 05:27:34 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-35-67b6bd871651
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.BA.23488.64DB6B76; Thu, 20 Feb 2025 14:27:34 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220052733epsmtip2ab7287c3d7e346091badd88152e6002e~l02MGR0jj1496914969epsmtip2S;
	Thu, 20 Feb 2025 05:27:33 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
	<vinayak.kh@samsung.com>
Subject: [PATCH v3 1/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands cxl r3.2 (8.2.10.9.5.3)
Date: Thu, 20 Feb 2025 10:57:22 +0530
Message-Id: <20250220052724.1256642-2-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220052724.1256642-1-vinayak.kh@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmhm773m3pBouPmFtMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
	VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
	6Xp5qSVWhgYGRqZAhQnZGZ9+/WQuuGJQcbV9O0sD41KlLkZODgkBE4nbNw+ydzFycQgJ7GaU
	2Pb6GSOE84lR4sKeVSwgVUIC3xglTh/WgOnYPredBaJoL6PEg/5rbBBFDUwSd38lgdhsAgYS
	D5qPs4PYIgKSEr+7TjOD2MwCHxglFj3VBbGFBeol3rd2gC1gEVCV+Hv1LNgcXgFbiVWN3YwQ
	y+Ql9h88C9bLKWAnse/pdHaIGkGJkzOfsEDMlJdo3jqbGeQgCYGf7BJzJ31hgmh2kVh74yYr
	hC0s8er4FnYIW0riZX8blF0sce7iJ6hlNRKvu1YwQ9j2Eq2n+oFsDqAFmhLrd+lDhGUlpp5a
	xwSxl0+i9/cTqFW8EjvmgdgcQLaKxNK3mTCbvjxrhpruIXG/awczJNwmAoPh7B3mCYwKs5C8
	MwvJO7MQNi9gZF7FKJlaUJybnppsWmCYl1oOj+Pk/NxNjOBUquWyg/HG/H96hxiZOBgPMUpw
	MCuJ8LbVb0kX4k1JrKxKLcqPLyrNSS0+xGgKDO+JzFKiyfnAZJ5XEm9oYmlgYmZmZmJpbGao
	JM7bvLMlXUggPbEkNTs1tSC1CKaPiYNTqoFp5+uIHe9Tfsbnnzvs8K8syT7PbeG2w8cnigtV
	6r3bJF/wwPn8/dww1S+HN7mYXop+/m2S+fqbbJy3P/MlsfX2C5pE7rq3ZcOPyXruVebVszkv
	X6td71CgbWCwnUE4+Gpv4CnV8o/rV/pvvx2UpGpqnjNRo9RD0W2tsuUf9YuS0jVf3D9Fq2Vv
	2T4n00BNzkhF20RVoV2pJex36wez2JsFZRmx0fLqxtHr3SfOfh3B80LuKuuy9S9vSDmuarwQ
	fULj9+fre47N5n/W9oxBcXXtjPiE72/NZi89VLcoIu20+sZ1ZxdqXF4w/Q3LYxWeRze9b1lO
	cOfKXm2vLLiqJ/uWuVMLJ9/Fn3fsPfdXM09SYinOSDTUYi4qTgQAxsK14i4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvK7b3m3pBl/m61lMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6MT79+MhdcMai42r6dpYFxqVIXIyeHhICJ
	xPa57SxdjFwcQgK7GSW27Z/MDpGQkji28ycbhC0ssfLfc3aIon+MEg/vdzOCJNgEDCQeNB8H
	axARkJT43XWaGaSIWeAXo8TT3ffBEsICtRILN3xlArFZBFQl/l49CzaVV8BWYlUjxCAJAXmJ
	/QfPMoPYnAJ2EvueTgfrFQKqWdJ/GqpeUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDItIpR
	MrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzjktTR2ML771qR/iJGJg/EQowQHs5IIb1v9
	lnQh3pTEyqrUovz4otKc1OJDjNIcLErivCsNI9KFBNITS1KzU1MLUotgskwcnFINTJrfRFVt
	SisbxPj4Xmw9c/eewu1jeb0PI6edbHyS1XL/mofpywuNvFkGqXwrOt3nRMr90HTsVOuye7vP
	3vXpSstgseV/Em92f37KrvvdqUj7iHp9RTXf0xXtx7gMPpR+4rRLyttRW2cxNTF160TL5GxL
	97N7v4QXPJ7km6C/eF5xWIzHDI6rXAX+TyXO18m/iuVdzxi/wl9a1/L4tevvFyjva79pZjeH
	mSnvyLzFHw9pOhYGpf4Ic3+wjP+Near5i4tFj/v96pTX+R6Qu7BA8eaPg2JzcoJU38z7z9yk
	X6LsOOuune0ThYDGvvL8mRYnSxOPH3d6tql+WSqjQOhP7rnTn5hHH68LS37FwB6kxFKckWio
	xVxUnAgAdDrZpegCAAA=
X-CMS-MailID: 20250220052734epcas5p2c0e082880350b5fa314c9062294bbc80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220052734epcas5p2c0e082880350b5fa314c9062294bbc80
References: <20250220052724.1256642-1-vinayak.kh@samsung.com>
	<CGME20250220052734epcas5p2c0e082880350b5fa314c9062294bbc80@epcas5p2.samsung.com>

CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
CXL devices supports media operations discovery command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 133 +++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..f55a2fe614 100644
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
@@ -1721,6 +1722,134 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
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
+    { MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
+};
+
+static CXLRetCode media_operations_discovery(uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+        struct {
+            uint16_t start_index;
+            uint16_t num_ops;
+        } discovery_osa;
+    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
+    int count = 0;
+    int num_ops = 0;
+    int start_index = 0;
+    int i = 0;
+    uint32_t dpa_range_count = 0;
+    struct media_op_discovery_out_pl *media_out_pl = NULL;
+
+    if (len_in < sizeof(*media_op_in_disc_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    media_out_pl = (struct media_op_discovery_out_pl *)payload_out;
+    num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
+    start_index = media_op_in_disc_pl->discovery_osa.start_index;
+    dpa_range_count = media_op_in_disc_pl->dpa_range_count;
+
+    /*
+     * As per spec CXL 3.2 8.2.10.9.5.3 dpa_range_count
+     * should be zero for discovery sub class command
+     */
+    if (dpa_range_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
+    media_out_pl->total_supported_operations =
+                                     ARRAY_SIZE(media_op_matrix);
+    if (num_ops > 0) {
+        for (i = start_index; i < start_index + num_ops; i++) {
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
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+    uint8_t media_op_cl = 0;
+    uint8_t media_op_subclass = 0;
+
+    if (len_in < sizeof(*media_op_in_common_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    media_op_cl = media_op_in_common_pl->media_operation_class;
+    media_op_subclass = media_op_in_common_pl->media_operation_subclass;
+
+    switch (media_op_cl) {
+    case MEDIA_OP_CLASS_GENERAL:
+        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        return media_operations_discovery(payload_in, len_in, payload_out,
+                                             len_out);
+    default:
+        return CXL_MBOX_UNSUPPORTED;
+    }
+}
+
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -2864,6 +2993,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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

