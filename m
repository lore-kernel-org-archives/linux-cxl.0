Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7195C636D6
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 04:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBTE4O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 23:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBTE4N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 23:56:13 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33895AD0F
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 20:56:09 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220045607epoutp01111046d5cfc73c28aa3e40a1f868a9e1~Fb3EHjZ771209212092epoutp01G
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 04:56:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220045607epoutp01111046d5cfc73c28aa3e40a1f868a9e1~Fb3EHjZ771209212092epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676868967;
        bh=/8XRzUPFIKumR9G+4LJhDJ/dkk6vfqbQvHO37lsNtbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLDm+j+5GLD8xwHOvqR7OEJYz6wkoVjzHUEbXvCTWz/MfU9vX8mzMEfFidRsNPEMb
         KxOTHF9MgTk3h+cWHFTGzDvU4PsKBzbzKrGQiJDnZTQ/YsSpD9H0DQLsz3XhVuNdyd
         uhDsF/KuEF2kWHPN8+9qXe2zla/9AsoQrRkfNkwE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230220045607epcas2p16a8f22e5e832d54e28ddbb0eefaba260~Fb3D1uSTZ1866718667epcas2p14;
        Mon, 20 Feb 2023 04:56:07 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PKqr64HS5z4x9Q0; Mon, 20 Feb
        2023 04:56:06 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.07.57412.66DF2F36; Mon, 20 Feb 2023 13:56:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230220045606epcas2p15419bab5979bcaa9cf5bd6ecdb84cac5~Fb3C_2Zal2440924409epcas2p1B;
        Mon, 20 Feb 2023 04:56:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220045606epsmtrp2be50aaf3872aa076b6d1a4b23bdfcadc~Fb3C7gvDX0918909189epsmtrp2S;
        Mon, 20 Feb 2023 04:56:06 +0000 (GMT)
X-AuditID: b6c32a47-d47fe7000000e044-90-63f2fd66885c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.50.17995.66DF2F36; Mon, 20 Feb 2023 13:56:06 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220045605epsmtip23620bc75f8994d234b00b9fbfad873f6~Fb3CsKAoJ2961229612epsmtip2o;
        Mon, 20 Feb 2023 04:56:05 +0000 (GMT)
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl 1/3] libcxl: add memdev inject poison support
Date:   Mon, 20 Feb 2023 13:57:07 +0900
Message-Id: <20230220045709.94027-2-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220045709.94027-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTTDft76dkg6fzFC3uPr7AZtE8eTGj
        xfSpFxgtFh+dwWxxftYpFotbE44xObB5LN7zkslj06pONo++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIznh7dQVTwWLh
        igmNx5gbGF/xdzFyckgImEh8nbmVvYuRi0NIYAejxN0zy1kgnE+MEvf3HWWEcD4zSnSeuckK
        07LnUyMTRGIXo8SxbxfZIJxGJomjJz+DVbEJaEv87Z/OCGKLCMhKNK97ANbBLDCBUWLp3IPM
        IAlhAVuJ1s8z2UBsFgFViYU/GoGWc3DwCthIfNzDDbFNXmL/wbNg5ZxA5bueLwGbzysgKHFy
        5hMWEJsZqKZ562xmkPkSArfYJSa8X8wI0ewisfLQViYIW1ji1fEt7BC2lMTnd3vZIOx8iakH
        J0LFSyTazhyAso0l3t18zgpyD7OApsT6XfogpoSAssSRW1Br+SQ6Dv9lhwjzSnS0CUE0qkps
        2fACaoi0xNGJm1ggbA+JS4uaoOEGDIV/f2ezT2BUmIXkm1lIvpmFsHgBI/MqRrHUguLc9NRi
        owJjeAwn5+duYgQnRi33HYwz3n7QO8TIxMF4iFGCg1lJhFf60IdkId6UxMqq1KL8+KLSnNTi
        Q4ymwKCeyCwlmpwPTM15JfGGJpYGJmZmhuZGpgbmSuK80rYnk4UE0hNLUrNTUwtSi2D6mDg4
        pRqYXNkv1p7straL6hep3TA/4GJqC6fOmvPFr8JC1Sd9dfHRX7Rz3cws9Z3X3lVPLM34GWvs
        nPbvNDfP3QcPj7+c5FZl8fE1B39LdWTWx0mna2a9OKVxWoC7N91j8+UtNT6/F1d0ubZ2/DYp
        fed59ujJf65xqktPalztX5qpPrkrxje/4dx2D59Yj73/OdyDlnmL8P3vNfy/nXeva+qLyHp5
        +xV7P1/UU301L/lMpL7SH/2bmnHBwXdX51swzdu9UH/rNnaXajeX1sJtb1fetDt3+V/Nhdxj
        dR8ev5WbuNFp/6wD8d/N6160PL/G+sipX1d917rtjnvea/J4/97eFnb8/fYDx8JyF7Gdyy1o
        8sxbpsRSnJFoqMVcVJwIAK9CVx8VBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvG7a30/JBhM72CzuPr7AZtE8eTGj
        xfSpFxgtFh+dwWxxftYpFotbE44xObB5LN7zkslj06pONo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKeHt1BVPBYuGKCY3HmBsYX/F3MXJySAiYSOz51MjUxcjFISSwg1HiXtcZJoiEtMSN
        R11sELawxP2WI6wQRf8ZJWb3rmMBSbAJaEv87Z/OCGKLCMhKNK97ANbMLDCNUWL73kQQW1jA
        VqL180ywQSwCqhILfzQC9XJw8ArYSHzcww0xX15i/8GzzCA2J1D5rudLWEFsIaCSn7MesoPY
        vAKCEidnPmGBGC8v0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvX
        S87P3cQIDmAtrR2Me1Z90DvEyMTBeIhRgoNZSYRX+tCHZCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYMirXNyv+ar3qv/mrb0jJhAfcX80/bBXLn6hs
        8mnZ5z1L7osefiV6+Wy4x8TUlwHXb/7M5X3bffJk6O2ms64hDLMFapd9EZrl/+ac7AwlOzv1
        bt3fU9+bivkuFXsxNap6x6d/X6PeFn//xpzjHTq1OHmSlqT64daPk88bfMs6/uFZYugu+5vR
        eQtF9nfK1F8xMzoqxMz8+l3K7fZz2sELBM9vCf6fpnfiVeacFRxRCW+7/RVyBI+Xn5i6I1qC
        x8ez4I2zRcmx4PKk/5cmv/4aWlivvGTp8/DFOU+rS+PTv2w8uINb9PsNc6Hm2/uDCvboT/r5
        qGKx8Qrt+MezmbPWM28rnKfxZKrYnML8o/UMb5VYijMSDbWYi4oTAQG3cyXPAgAA
X-CMS-MailID: 20230220045606epcas2p15419bab5979bcaa9cf5bd6ecdb84cac5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045606epcas2p15419bab5979bcaa9cf5bd6ecdb84cac5
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
        <CGME20230220045606epcas2p15419bab5979bcaa9cf5bd6ecdb84cac5@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

