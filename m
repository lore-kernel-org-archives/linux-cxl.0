Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55178C05027
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 01:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBTBgP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 20:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBTBgO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 20:36:14 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674BACDF0
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 17:36:11 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220013607epoutp01effa0613b70de033a74b3ed5b78f6e43~FZIbzeFRf0859508595epoutp014
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 01:36:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220013607epoutp01effa0613b70de033a74b3ed5b78f6e43~FZIbzeFRf0859508595epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676856967;
        bh=r+xFE5aTgSzJ+99XOc1TcIc6SBBlpEr+tRMCUosjHTU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=apAzYB+7ozmywNJk4DZz1ZD1NM+DvMwTwVkGvto5WUyVZTjjK0vc3keLtpNtfBWx6
         HSzDMkjQMSKov9if0WYUQDgLKBT6WkkixaXz7iWYsxqaBJsPvBRNVmo8nJZ4CngWu8
         Atq8YBIItNlXfo8+TLwqlTpIiX1sL8mcMUrQBvoE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230220013606epcas2p4adca5794d60a03ea8a33bb0038c183f5~FZIbbgn062821128211epcas2p4U;
        Mon, 20 Feb 2023 01:36:06 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PKlPL06Jhz4x9Pq; Mon, 20 Feb
        2023 01:36:06 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.81.57412.58EC2F36; Mon, 20 Feb 2023 10:36:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230220013605epcas2p414e4f0c0c3c82bc5a004d19f4f02f15f~FZIaev-Nx2821128211epcas2p4O;
        Mon, 20 Feb 2023 01:36:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220013605epsmtrp1bead02619b7bb064e85e85dc2fab27e9~FZIaeGhsJ1322213222epsmtrp1g;
        Mon, 20 Feb 2023 01:36:05 +0000 (GMT)
X-AuditID: b6c32a47-ab7ff7000000e044-78-63f2ce8513ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.BF.05839.58EC2F36; Mon, 20 Feb 2023 10:36:05 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220013605epsmtip1afa060ec95c58d0ad61e0432e9c74a82~FZIaT26qB1780917809epsmtip1g;
        Mon, 20 Feb 2023 01:36:05 +0000 (GMT)
From:   junhyeok.im@samsung.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl 1/3] libcxl: add memdev inject poison support
Date:   Mon, 20 Feb 2023 10:37:12 +0900
Message-Id: <20230220013714.22277-1-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmqW7ruU/JBu0fzCzuPr7AZtE8eTGj
        xfSpFxgtFh+dwWxxftYpFotbE44xObB5LN7zkslj06pONo++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztjc9Iit4JJw
        xYlFX5gbGCcJdDFyckgImEgsb9rH3MXIxSEksINR4ubkOUwgCSGBT4wSP7uzIRLfGCUe7vjN
        2sXIAdax9qMzRHwvUE3jE3YIp5FJ4t+yU6wg3WwCshJXD99gB7FFgOzmdQ+YQIqYBSYwSiyd
        e5AZJCEsYCvR+nkmG4jNIqAqMW37QbDVvAI2Eos+HWaFuE9eYv/Bs8wQcUGJkzOfsIDYzEDx
        5q2zwe6WEDjELtG1/AJUg4vElhcTWSBsYYlXx7ewQ9hSEi/726DsfImpBydC2SUSbWcOQNnG
        Eu9uPgd7k1lAU2L9Ln2Ij5UljtyCWssn0XH4LztEmFeio00IolFVYsuGF1BDpCWOTtwEdYCH
        xM+re9hAyoUEYiUub4mbwCg/C8kvs5D8Mgth7QJG5lWMYqkFxbnpqcVGBcbwKE3Oz93ECE59
        Wu47GGe8/aB3iJGJg/EQowQHs5IIr/ShD8lCvCmJlVWpRfnxRaU5qcWHGE2BoTuRWUo0OR+Y
        fPNK4g1NLA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqemFqQWwfQxcXBKNTDNYLhwPyOMZ8ne
        QyeuxxUdFOC99zfVqX2f98672tlGr3s2R6j/27dj5j39Ndb82xND1mQVfH4e0JFj4Ovs77bT
        a5FqzfKuif4PZ3z733zx8gI+aUehf0wx0lt32zhNePuVZ9avjt6gQ/ziH+96ykkV5yZY/Nn9
        /fdt1oxt6RN0M242HJb6U2bq832tNfepnzPvNm3vSnE8pPkqfIfn1sLoMr8FPHpXdrmb7DPd
        sHlJ2O/oQLM3k17uvtfnZN4UGHLWmSPpxi92i7wA8+v3Dy6exj9jtkT0x5VHdff5Ve2MnBJ8
        6rtwVHKm9iWx/N7scxPtJ9xbcbhqT7/qhDyV7KRplyd2ycRaSN89/+eiJdsuJZbijERDLeai
        4kQAGNBLPwYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnG7ruU/JBmfPKljcfXyBzaJ58mJG
        i+lTLzBaLD46g9ni/KxTLBa3JhxjcmDzWLznJZPHplWdbB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsbnpEVvBJeGKE4u+MDcwThLoYuTgkBAwkVj70bmLkYtDSGA3o8SOK0sYuxg5geLS
        EjcedbFB2MIS91uOsEIU/WeUWHF8MTNIgk1AVuLq4RvsILYIkN287gETiM0sMI1RYvveRBBb
        WMBWovXzTLBBLAKqEtO2HwSr4RWwkVj06TArxAJ5if0HzzJDxAUlTs58wgIxR16ieets5gmM
        fLOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREckFqaOxi3r/qgd4iR
        iYPxEKMEB7OSCK/0oQ/JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgt
        gskycXBKNTCtFDwb0TOhPqRP01GN98p3o0i9JR8Ui4XOFdbp/LoT5CVxNeaF+973tlM7twmd
        PZZyXemfS3n7Yqed9UbKk5TVz+5e84JJZfrqjyHae2QstrRLzPvukaGR5CW488KDhU2BRq93
        3J7f1PiqmTnB7vrFi3b5Cz8vNHX98/p7iI5vV3Jf1Us2t/VWod8TWlfuWeVSv/zU/gJnhn2T
        NkT7fn9UOb08P/eiaP/1uKTYRolk/oxZ+maXPsVp37Pr/jZju7i7yIJa87fXKnY9bvpzwnWD
        b3Kc546rFsvePMm7POnO/PCfFX5Hw/knid7fbhXv+14hvrqBeef+2dYu/mrlIRJR6aIOy37s
        SQ3P/2/zS0yJpTgj0VCLuag4EQB88HNAtwIAAA==
X-CMS-MailID: 20230220013605epcas2p414e4f0c0c3c82bc5a004d19f4f02f15f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220013605epcas2p414e4f0c0c3c82bc5a004d19f4f02f15f
References: <CGME20230220013605epcas2p414e4f0c0c3c82bc5a004d19f4f02f15f@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Junhyeok Im <junhyeok.im@samsung.com>

Add ability to inject poison based on the kernel inject poison sysfs interface.

This interface trigger inject poison function by writing DPA to the memory device
sysfs attribute ('inject_poison').

Link to corresponding kernel patchset:
  https://lore.kernel.org/linux-cxl/cover.1674101475.git.alison.schofield@intel.com/

Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>
---
 cxl/lib/libcxl.c   | 26 ++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  5 +++++
 cxl/libcxl.h       |  1 +
 3 files changed, 32 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 4859bd5..d2b8e19 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1407,6 +1407,32 @@ CXL_EXPORT int cxl_memdev_enable(struct cxl_memdev *memdev)
 	return 0;
 }
 
+CXL_EXPORT int cxl_memdev_inject_poison(struct cxl_memdev *memdev,
+					const char *address)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len, rc;
+
+	if (snprintf(path, len, "%s/inject_poison",
+		     memdev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small\n",
+		    cxl_memdev_get_devname(memdev));
+		return -ENXIO;
+	}
+	rc = sysfs_write_attr(ctx, path, address);
+	if (rc < 0) {
+		fprintf(stderr, "%s: Failed write sysfs attr inject_poison\n",
+			cxl_memdev_get_devname(memdev));
+		return rc;
+	}
+
+	dbg(ctx, "%s: poison injected at %s\n", cxl_memdev_get_devname(memdev),
+	    address);
+
+	return 0;
+}
+
 static struct cxl_endpoint *cxl_port_find_endpoint(struct cxl_port *parent_port,
 						   struct cxl_memdev *memdev)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 6bc0810..c6ba248 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -242,3 +242,8 @@ global:
 	cxl_target_get_firmware_node;
 	cxl_dport_get_firmware_node;
 } LIBCXL_3;
+
+LIBCXL_5 {
+global:
+        cxl_memdev_inject_poison;
+} LIBCXL_4;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index d699af8..7a2cc5f 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -68,6 +68,7 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 		size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 		size_t offset);
+int cxl_memdev_inject_poison(struct cxl_memdev *memdev, const char *address);
 
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev = cxl_memdev_get_first(ctx); \
-- 
2.34.1

