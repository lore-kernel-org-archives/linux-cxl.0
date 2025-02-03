Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899D2046BA
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649592; cv=none; b=GKgZ9p/WKcTvf34qIiXC/CnogJT8pe7z+8m36Ksuq/rHCpJNznzTaVMf3A6zmJWJkXFXTA1ZByPZNAqUeql8DeCfSwi0DJh0ATGja6QsLlFUIVta5TbkWRxrVrlPstMrcPwSoLv/xI1O6/8/UE0UuM1w2/X4VJ3/xPYCqOlipxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649592; c=relaxed/simple;
	bh=X96+hjbVmDjEUIoPMdwpaZtB6onnxkD1cVuhx4OY0oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=FtB8CqUFWXZ50/kMMZcJnhwQrJTVezjYEv7F+oN+YbSR5xiC7BwFVzVcERQk4hk+LC0HymGzCK0cs/3NX6xF+8dnYaZYe6hJw0PmMw16e/YpnaAwUecH0oYsfV1oUB8Grt4IvtFu91tKQNxz8XgL84aZwIjFhLTDYlKk6RzzFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Br37YQ0W; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Br37YQ0W"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250204061305epoutp049afcefa47a64b9523ed47a9b0eaf181d~g7JYKAdTF0169201692epoutp04i
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 06:13:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250204061305epoutp049afcefa47a64b9523ed47a9b0eaf181d~g7JYKAdTF0169201692epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738649585;
	bh=aaIOgdg3KaYLAgArba1Iytpk/jlai0hkq0kWenR5qik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Br37YQ0WrW7DnJ/8rVqXxrbRz09i7Nh4clDhxJ52cw1RrcWo49b5I6X2ruejeifbU
	 FLnK9kVR4YoPvjq6ri1bzowBUUtLyWkmUMAmDSKnR/pFATNU1g3/amcR5AbCfa4VSZ
	 Hjs3FCzc3ZcYt3q7orMxsoiIbxva4CzW+BFzkJwg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250204061304epcas5p252a2390135e9b3f6cfc86e31fec46f91~g7JXnOi4y0463804638epcas5p2D;
	Tue,  4 Feb 2025 06:13:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YnChv3MSsz4x9Px; Tue,  4 Feb
	2025 06:13:03 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.1E.19956.DEFA1A76; Tue,  4 Feb 2025 15:13:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9~gnVcMhXk01242612426epcas5p1Z;
	Mon,  3 Feb 2025 06:00:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203060053epsmtrp156739bb88a34cf16dd64483c36252757~gnVcKu75s2494724947epsmtrp15;
	Mon,  3 Feb 2025 06:00:53 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-6c-67a1afed8ce3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.EE.23488.59B50A76; Mon,  3 Feb 2025 15:00:53 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250203060051epsmtip2705fb526d7f55303c237de7f953dd9e1~gnVawSwzL2702127021epsmtip22;
	Mon,  3 Feb 2025 06:00:51 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH 2/3] hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log
 (Opcode 0403h)
Date: Mon,  3 Feb 2025 11:29:49 +0530
Message-Id: <20250203055950.2126627-3-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmhu7b9QvTDb5/YbGYfljR4svpPWwW
	vYuXsFqsvrmG0eLmgZ1MFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfd48m1zUwe
	fVtWMXpMnV3v8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
	qq2Si0+ArltmDtBNSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
	dL281BIrQwMDI1OgwoTsjF9tUgWTRSv+PbzM3MB4mq+LkZNDQsBE4tPev4xdjFwcQgK7GSUu
	d3ZAOZ8YJVbOOMwG4XxjlJj1dCMbTMuzlrnMEIm9jBL3vxxiAkkICTQwSXyb6gliswnoSJy/
	PResQURAUuJ312mwBmaBN4wSD64uAHI4OIQFYiXOLlcFqWERUJV4OnMqWD2vgL3E8Tt9TBDL
	5CX2HzzLDGJzCjhI/Nh8kxWiRlDi5MwnLCA2M1BN89bZYPMlBL6yS9x9NIEdotlFYmPHVEYI
	W1ji1fEtUHEpiZf9bVB2tsSf+e1QnxVILPo5EypuL9F6qh/sTmYBTYn1u/QhwrISU0+tY4LY
	yyfR+/sJ1J28EjvmwdhqEu075kONkZF482sx1HgPiWPr/0ODdzKjxJVr+xknMCrMQvLPLCT/
	zEJYvYCReRWjZGpBcW56arFpgXFeajk8kpPzczcxgpOplvcOxkcPPugdYmTiYDzEKMHBrCTC
	e3r7gnQh3pTEyqrUovz4otKc1OJDjKbAAJ/ILCWanA9M53kl8YYmlgYmZmZmJpbGZoZK4rzN
	O1vShQTSE0tSs1NTC1KLYPqYODilGpiixbgZT53w/5RU6hB494NR4YJtqjdbLFlqM3x+rX1w
	QSlawSxnYpxM4KRH3zLfCC2rOLvRb52Ixv/Py7oqHas8NxZstzWTcmx2L4vZvvrgimucLKvD
	/hUaHT11q1wtdMMEM9UfBm6l0ckxL1bvkUrXyqm/3nrk5zLDn2krt6QLK0YZNIkWbf0dtWbH
	0v329r/PrhE+92WCbkhQd8Kz/m7mrprZxmdmHWp9erz14hXOCY9KAnJWzViyMv9v6lqLgJKe
	HZzq19LZZ627O8f4Brdptr4+U65/564ft7X+Vy9SKLT2qLbUOe/HWSueeuvIBI7TnFt+rFvr
	7Fp2Yf/tu6vYKww/Ta1g9amRvC9hMUeJpTgj0VCLuag4EQAsk+uYLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO7U6AXpBhOPC1hMP6xo8eX0HjaL
	3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
	vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugSvjV5tUwWTRin8PLzM3MJ7m62Lk5JAQMJF4
	1jKXuYuRi0NIYDejxP4tu9ggEjISF2c+ZoGwhSVW/nvODlH0j1Fi9pstYEVsAjoS52/PBbNF
	BCQlfnedBpvELPCNUWLOrResIAlhgWiJ20c6mEFsFgFViaczp4I18ArYSxy/08cEsUFeYv/B
	s2A1nAIOEj823wTrFQKqOd9+hAmiXlDi5MwnYBcxA9U3b53NPIFRYBaS1CwkqQWMTKsYJVML
	inPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYIDXktjB+O7b036hxiZOBgPMUpwMCuJ8HIcnpMu
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnHelYUS6kEB6YklqdmpqQWoRTJaJg1OqgYkhJ3/Gxv3e
	dycsYbpi1fD78p3Xh7p775i2cRnkz17YaNQtHtWV8m+eUbV/QDVP5ayL79sMkpguTtnDfeag
	UKpfoKvdp55W27ve2wwEY1e47ebd6pfbZNGne/H222naU+e9ffixt9d+X8FOHQvjoBnr83z/
	HQm5HPDOlX+24WcBn12fr+9yCvmxfX0Gi5ti3LmZy1WlChtuLs/2F0vTVNO2aTyr8JLl5PVF
	ZQHhjcGLNn2LWvKZv9P8wsvmB/vrjxz9cGJVmmTuDm62/odHjHqt+25Mk5m57JjIBJGNX419
	73kfO9gi5NTrufG6SrLj5byrU8J22xtltKxzrGKq2L1mhk+CbtySCr45RvMY5ZRYijMSDbWY
	i4oTAZA0euznAgAA
X-CMS-MailID: 20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
	<CGME20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9@epcas5p1.samsung.com>

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3d66a425a9..5fd7f850c4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -77,6 +77,7 @@ enum {
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
         #define GET_LOG_CAPABILITIES   0x2
+        #define CLEAR_LOG     0x3
     FEATURES    = 0x05,
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
@@ -1115,6 +1116,39 @@ static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.5.4: Clear Log (Opcode 0403h) */
+static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
+                                     uint8_t *payload_in,
+                                     size_t len_in,
+                                     uint8_t *payload_out,
+                                     size_t *len_out,
+                                     CXLCCI *cci)
+{
+    int32_t cap_id;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) * clear_log = (void *)payload_in;
+
+    cap_id = valid_log_check(&clear_log->uuid, cci);
+    if (cap_id == -1) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    if (cci->supported_log_cap[cap_id].param_flags.clear_log_supported) {
+        switch (cap_id) {
+        case CEL:
+            memset(cci->cel_log, 0, (1 << 16) * sizeof(struct cel_log));
+            cci->cel_size = 0;
+            break;
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -2882,6 +2916,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
     [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
                                      cmd_logs_get_log_capabilities, 0x10, 0 },
+    [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
+                          CXL_MBOX_IMMEDIATE_LOG_CHANGE},
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
-- 
2.34.1

