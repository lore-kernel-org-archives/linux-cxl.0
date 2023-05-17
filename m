Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E93C77B7A
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 03:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjEQDYB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 23:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjEQDYA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 23:24:00 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDBC1FCD
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 20:23:58 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230517032356epoutp03447bafb9f15f22c8e9aaf6366439e9bf~f0FIos0Au1321113211epoutp03c
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 03:23:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230517032356epoutp03447bafb9f15f22c8e9aaf6366439e9bf~f0FIos0Au1321113211epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684293836;
        bh=8Zzb02ZjSAu/dJG89FoPovJc75d06VRpaBJeAo0Fgd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKNX5vQ9RO64TdpqvqizXAXAYkRLwiEBMkRqy3MKwl5QVXeahqgPBuDXRroHF1A7E
         SBKzMJzZAl0jeBZ6INW2UkG+dSCPZYDWmEEbEKlKa79UXE24tIBzaSOhUtKw5mlgID
         2ft+xhW0K201wL87D0UiALKzioRpWBbXJc98ifIs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230517032355epcas2p37cf22a7ab0ffcf5bf614e099d4c1e95c~f0FHU2Gsq0983209832epcas2p33;
        Wed, 17 May 2023 03:23:55 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QLdk271hSz4x9Pt; Wed, 17 May
        2023 03:23:54 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.9A.03265.AC844646; Wed, 17 May 2023 12:23:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230517032354epcas2p402be25cecb758d5a3d8e477fa5efac99~f0FGgebGw1792117921epcas2p43;
        Wed, 17 May 2023 03:23:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230517032354epsmtrp22064cdc194bf17fe88b0f7fadd7ef9f0~f0FGf322w0097500975epsmtrp2X;
        Wed, 17 May 2023 03:23:54 +0000 (GMT)
X-AuditID: b6c32a45-6d1fd70000020cc1-1e-646448ca3384
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.16.27706.AC844646; Wed, 17 May 2023 12:23:54 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230517032354epsmtip2ad7f986ba790d098606c34a57681b3a9~f0FGSLFf81034810348epsmtip2Q;
        Wed, 17 May 2023 03:23:54 +0000 (GMT)
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        ira.weiny@intel.com, ks0204.kim@samsung.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl PATCH v2 1/2] libcxl: Add memdev inject & clear poison
 support
Date:   Wed, 17 May 2023 12:23:10 +0900
Message-Id: <20230517032311.19923-2-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517032311.19923-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTTPeUR0qKwdpn5hZ3H19gs2ievJjR
        YvrUC4wW+58+Z7FYfHQGs8XRPRwW52edYrG4NeEYkwOHx+I9L5k8Nq3qZPPo27KK0ePzJrkA
        lqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
        2RnHJzSxF8xXqzi98xdbA+Np+S5GTg4JAROJ43u7mLsYuTiEBHYwSvS8+cAG4XxilNj79hQL
        hPONUeL/l5NMMC1LZ81lgkjsZZRYf/E2VFUjk0TDqr8sIFVsAtoSf/unM4LYIgKyEs3rHoB1
        MAvsZ5RYsXMLG0hCWCBA4v7ZM0BFHBwsAqoSh/55goR5BWwk5p28yQixTV5i/8GzzCA2p4Ct
        xNHdrWwQNYISJ2c+AdvFDFTTvHU22BMSAj/ZJRZO2sUM0ewiseLHHDYIW1ji1fEt7BC2lMTn
        d3uh4vkSUw9OhIqXSLSdOQBlG0u8u/mcFeQ2ZgFNifW79EFMCQFliSO3oNbySXQc/ssOEeaV
        6GgTgmhUldiy4QXUEGmJoxM3sUDYHhKrV75ihwTVBEaJe0/fsUxgVJiF5JtZSL6ZhbB4ASPz
        Kkax1ILi3PTUYqMCQ3gMJ+fnbmIEp0ot1x2Mk99+0DvEyMTBeIhRgoNZSYQ3sC85RYg3JbGy
        KrUoP76oNCe1+BCjKTCoJzJLiSbnA5N1Xkm8oYmlgYmZmaG5kamBuZI4r7TtyWQhgfTEktTs
        1NSC1CKYPiYOTqkGphOa7KYxWbz2u3yiNza7zXhUp8TEslTISEXiw+7XOr4zNyzYe9N1z0XH
        Ca9VPqvuDw01+Fts7Oqg/MLpZapQuI/vw56oDNGYjjPpuYrpe9/rrexQO7ftmNRSm5uG582C
        3FjZE5n+vlOtPV/aI5d7YtvroAXx148qCsyV+Bz6spEp/OkLxZ0l5/jmTbs29+KKXmNdUxE1
        Rquup2ciuxbdDN1yo+WEzxGzb7t/SHyxsUy49/nDrQ8BGvyCcx9PuiR1uyd/kZDOsisJ0sUp
        at9a97lVbf6muF3axvBIrPKViUJ8/4/HpOeG/W9xn2Au+drh6T1fIQfGhh+Sog7TCqZHvtdb
        pHAq0mf71h2762+YK7EUZyQaajEXFScCAAEttDceBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvO4pj5QUg8f/FC3uPr7AZtE8eTGj
        xfSpFxgt9j99zmKx+OgMZoujezgszs86xWJxa8IxJgcOj8V7XjJ5bFrVyebRt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGccnNLEXzFerOL3zF1sD42n5LkZODgkBE4mls+YydTFycQgJ7GaU
        WDDrAgtEQlrixqMuNghbWOJ+yxFWiKL/jBItfy8ygyTYBLQl/vZPZwSxRQRkJZrXPQCbxCxw
        nFHixv5dQAkODmEBP4mvd/lBTBYBVYlD/zxBynkFbCTmnbzJCDFfXmL/wbNgIzkFbCWO7m4F
        2ysEVPPi4UVGiHpBiZMzn7CAjGEWUJdYP08IJMwM1Nq8dTbzBEbBWUiqZiFUzUJStYCReRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnD4a2nuYNy+6oPeIUYmDsZDjBIczEoivIF9
        ySlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MJWcEX/D
        vG2tht75W2q1XU5hSerxJW+3iy/oZcxoCl0ZuqZ0ieo6B2t9lQoW5iMbV6eciN1vPU1pzqej
        R743MjyWDDZ4zLBkpuDyV2+vSBmG3mfv2fxro9Vlc7Ybn+xrzWPqvi5aEv3dfovEmavc6zpn
        /ojUtMw0uBvs8zXlatT71svtzK/WTg6aPL0irf+nardAyAxBdtu0Z7es2Y/zLjj0eHMGY1zw
        TM/nR+f1G9bcUtqoLH8vqH3n0TkrN1ekrmVR/D/RwkrUmycyQsCY4TbP5rZnKQnba7/1mtv/
        ncZybPN/NTaJBOcYXrF355PXhW3M6PpqLSAg7XwvyGZT/L8ZZSJJnIXB4pVHH+8tVWIpzkg0
        1GIuKk4EAHwPRyruAgAA
X-CMS-MailID: 20230517032354epcas2p402be25cecb758d5a3d8e477fa5efac99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230517032354epcas2p402be25cecb758d5a3d8e477fa5efac99
References: <20230517032311.19923-1-junhyeok.im@samsung.com>
        <CGME20230517032354epcas2p402be25cecb758d5a3d8e477fa5efac99@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add abilities to inject and clear poison to memdev based on the debugfs
(/sys/kernel/debug/cxl/memX/{inject_/clear_}poison) interfaces that target
kernel v6.4[1].

These interfaces trigger inject/clear poison function by writing DPA to the
memory device debugfs attributes.

In order to write the DPA in the debugfs attribute, 'sysfs_write_attr' macro
is used which already defined.

Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>

[1] https://lore.kernel.org/linux-cxl/cover.1681874357.git.alison.schofield@intel.com/
---
 Documentation/cxl/lib/libcxl.txt |  5 +++
 cxl/lib/libcxl.c                 | 53 ++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  6 ++++
 cxl/libcxl.h                     |  2 ++
 4 files changed, 66 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 31bc855..24a2535 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -132,6 +132,8 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			  size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			   size_t offset);
+int cxl_memdev_inject_poison(struct cxl_memdev *memdev, const char *address);
+int cxl_memdev_clear_poison(struct cxl_memdev *memdev, const char *address);
 struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 					  unsigned long long volatile_size);
@@ -172,6 +174,9 @@ cxl_memdev{read,write,zero}_label() are helpers for marshaling multiple
 label access commands over an arbitrary extent of the device's label
 area.
 
+cxl_memdev_{inject,clear}_poison() support injecting/clearing poison
+into/from a physical address on a specified CXL memory device.
+
 cxl_cmd_partition_set_mode() supports selecting NEXTBOOT or IMMEDIATE
 mode. When CXL_SETPART_IMMEDIATE mode is set, it is the caller’s
 responsibility to avoid immediate changes to partitioning when the
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 769cd8a..b2d0642 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1458,6 +1458,59 @@ CXL_EXPORT int cxl_memdev_enable(struct cxl_memdev *memdev)
 	return 0;
 }
 
+#define PATH_DEBUG_FS "/sys/kernel/debug/cxl"
+CXL_EXPORT int cxl_memdev_inject_poison(struct cxl_memdev *memdev,
+					const char *address)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len, rc;
+
+	if (snprintf(path, len, "%s/%s/inject_poison", PATH_DEBUG_FS,
+		     cxl_memdev_get_devname(memdev)) >= len) {
+		err(ctx, "%s: buffer too small\n",
+		    cxl_memdev_get_devname(memdev));
+		return -ENXIO;
+	}
+	rc = sysfs_write_attr(ctx, path, address);
+	if (rc < 0) {
+		err(ctx, "%s: failed to inject poison\n",
+		    cxl_memdev_get_devname(memdev));
+		return rc;
+	}
+
+	dbg(ctx, "%s: poison injected at %s\n", cxl_memdev_get_devname(memdev),
+	    address);
+
+	return 0;
+}
+
+CXL_EXPORT int cxl_memdev_clear_poison(struct cxl_memdev *memdev,
+				       const char *address)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len, rc;
+
+	if (snprintf(path, len, "%s/%s/clear_poison", PATH_DEBUG_FS,
+		     cxl_memdev_get_devname(memdev)) >= len) {
+		err(ctx, "%s: buffer too small\n",
+		    cxl_memdev_get_devname(memdev));
+		return -ENXIO;
+	}
+	rc = sysfs_write_attr(ctx, path, address);
+	if (rc < 0) {
+		err(ctx, "%s: failed to clear poison\n",
+		    cxl_memdev_get_devname(memdev));
+		return rc;
+	}
+
+	dbg(ctx, "%s: poison cleared at %s\n", cxl_memdev_get_devname(memdev),
+	    address);
+
+	return 0;
+}
+
 static struct cxl_endpoint *
 cxl_port_recurse_endpoint(struct cxl_port *parent_port,
 			  struct cxl_memdev *memdev)
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index c6545c7..0f312a5 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -250,3 +250,9 @@ global:
 	cxl_region_get_daxctl_region;
 	cxl_port_get_parent_dport;
 } LIBCXL_4;
+
+LIBCXL_6 {
+global:
+	cxl_memdev_inject_poison;
+	cxl_memdev_clear_poison;
+} LIBCXL_5;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0218d73..e3b2524 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -68,6 +68,8 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 		size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 		size_t offset);
+int cxl_memdev_inject_poison(struct cxl_memdev *memdev, const char *address);
+int cxl_memdev_clear_poison(struct cxl_memdev *memdev, const char *address);
 
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev = cxl_memdev_get_first(ctx); \
-- 
2.34.1

