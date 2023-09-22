Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492EE6FE22
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 13:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjIVNDc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 09:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjIVNDc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 09:03:32 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4BCE
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 06:03:25 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230922130323epoutp045a3d4a1235cb9ae13a852c286b923761~HOjmbzPMl1726017260epoutp04q
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 13:03:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230922130323epoutp045a3d4a1235cb9ae13a852c286b923761~HOjmbzPMl1726017260epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695387803;
        bh=EL5l6JcR8uz02ZxFBoH5zh+xdym7MBRL+lVUs5ih56U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AmkYpTMgo9XNFyjqbpYy6ie1qVZwI/Ya8eboU3T1InLNRNfFz3P1TEAMHha8eu3GQ
         WEsp5sSC7OL3LuuKAN/S+NKImuicY2n7rr/eUoyX6k4YDaobEh1SPphi5mCMaLHP8u
         zlzxOuyZPk46DY+SmkecTPQ7zJUEJxIk1UByJwRU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230922130322epcas2p4c8967cdd4d899eff396b672b7333d615~HOjlRSHf10828508285epcas2p4O;
        Fri, 22 Sep 2023 13:03:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RsXWZ0991z4x9Pr; Fri, 22 Sep
        2023 13:03:22 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.5E.09660.9909D056; Fri, 22 Sep 2023 22:03:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230922130321epcas2p1e3041a8a284e8aa3a3b203ca3380d1db~HOjj7o6Zz0857408574epcas2p1e;
        Fri, 22 Sep 2023 13:03:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922130321epsmtrp12ab3a154baca50fac543402f21abcc6a~HOjj6vgNI3218332183epsmtrp1N;
        Fri, 22 Sep 2023 13:03:21 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-19-650d90994bdf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.49.08742.8909D056; Fri, 22 Sep 2023 22:03:21 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230922130320epsmtip166f855430e449cdd68995e44b1c28f38~HOjjpyw5f2684526845epsmtip1d;
        Fri, 22 Sep 2023 13:03:20 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [RFC PATCH 3/3] cxl/memdev: Add background command sysfs file
Date:   Fri, 22 Sep 2023 22:06:07 +0900
Message-Id: <20230922130607.3476828-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmue7MCbypBm+umlncfXyBzaJ58mJG
        i+lTLzBanLjZyGax+uYaRoum1XdZLT68+cdiceB1A7vFmbMvWS1WLbzGZnFk7VUmi8VHZzBb
        HN3DYXF+1ikWi1sTjjFZbLz/js1BwGPnrLvsHi1H3rJ6LN7zkslj06pONo++LasYPabOrvf4
        vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
        6HYlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGR
        KVBhQnbGu13TmAvmqFT0919haWDcJ9fFyMkhIWAice3xXZYuRi4OIYEdjBIr/pyCcj4xSrRu
        ncsI4XxjlGjZe50VpuX9tpvMEIm9jBILdkxiBEkICfxhlJh4zA7EZhPQkpg+swGsQURAVqJ5
        3QMmkAZmgassEpNOXWQCSQgLuEn8mvWPDcRmEVCVaL52CyzOK2At8bBpNQvENnmJ/QfPMkPE
        BSVOznwCFmcGijdvnQ12hYTATA6Jk5POA13BAeS4SCxs5oPoFZZ4dXwLO4QtJfGyv40dor6Z
        UeL18yssEE4Lo8S62zugqowl3t18zgoyiFlAU2L9Ln2ImcoSR25B7eWT6Dj8lx0izCvR0SYE
        0agkMW/pPGYIW0Li0twtULaHxIO3F9kh4RMrsebyVaYJjPKzkHwzC8k3sxD2LmBkXsUollpQ
        nJueWmxUYAyP1eT83E2M4PSr5b6DccbbD3qHGJk4GA8xSnAwK4nwJn/iShXiTUmsrEotyo8v
        Ks1JLT7EaAoM34nMUqLJ+cAMkFcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoR
        TB8TB6dUA9O0iPQdogrbt5b+td+97Oqjdg2RY66Xl3p/t7L9adW9vCi+vHK2lEEY097XRSwX
        vr/f5ug223SDHgeXhVxEdeql5z721msKtaYsPs8nqH3z7MplRVK/Pk99eFg4c+XXonNJdRq6
        S98WMMv82B389LNM0JcKAev7e3LWJs0wV7Njjf/cVSHcvO6srJLsheQXy+3DU8syrrfdaDbb
        6an3+lJgjknT9mT+2q/e7xvUjrVv/WWc5Gtxa7LvsYq8whnHO/atPFxw5vWq7okxW1havN+o
        tN6wXqZRkcGv/63XzPNFjeyta/uCLix0v6d8etLBl48d04uO6bSy5ct56ey793vvU9uQ2Bk7
        CqZpp8ofuKPEUpyRaKjFXFScCACKnY6ISAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnO7MCbypBusXM1rcfXyBzaJ5MpA1
        feoFRosTNxvZLFbfXMNo0bT6LqvFhzf/WCwOvG5gtzhz9iWrxaqF19gsjqy9ymSx+OgMZouj
        ezgszs86xWJxa8IxJouN99+xOQh47Jx1l92j5chbVo/Fe14yeWxa1cnm0bdlFaPH1Nn1Hp83
        yQWwR3HZpKTmZJalFunbJXBlvNs1jblgjkpFf/8VlgbGfXJdjJwcEgImEu+33WTuYuTiEBLY
        zShx6t4pJoiEhMTyDS+gbGGJ+y1HWCGKfjFKfD62igUkwSagJTF9ZgMriC0iICvRvO4BE0gR
        s8BDFolttz8wgiSEBdwkfs36xwZiswioSjRfuwU2lVfAWuJh02oWiA3yEvsPnmWGiAtKnJz5
        BCzODBRv3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTH
        hJbmDsbtqz7oHWJk4mA8xCjBwawkwpv8iStViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/4i94U
        IYH0xJLU7NTUgtQimCwTB6dUA9OCiipP3cLXF3PKV9kdX2HBsnbfhp+5V7RjLW+kC3ZZXjU1
        jvf+e8OvzHMHL+PZfn+RoldJLg12VqtSZfccWTJjlVTLhAP9D+7f/ty9QfzLEYvdCz5s83VS
        4uL/NknW+vKCb5pBV0OF5x3Y1iJ8uT/1crdXnf2x1NVfdhxuCfxzhEHuT3MNL8tzoYCw14e/
        lRiZmar/lJlWf/dH/Tb28iu2zwLc3kasP/rkv+Wqm1bFfzXDTZ/OSO+cotahJH/7lIZrsYO9
        rSDn7bPcK2Tn90R1dFtlmoR+5Sz5pihuf9s52DbDyCj0fK9Gf/jFfbfY1CKMU8OW7klivbF8
        QevOs3vmTTqheKH0cvfCHZkKukosxRmJhlrMRcWJACj1UTz4AgAA
X-CMS-MailID: 20230922130321epcas2p1e3041a8a284e8aa3a3b203ca3380d1db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922130321epcas2p1e3041a8a284e8aa3a3b203ca3380d1db
References: <CGME20230922130321epcas2p1e3041a8a284e8aa3a3b203ca3380d1db@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a read-only sysfs file to notify the background
command state of a device:

    /sys/bus/cxl/devices/memX/bgcmd/complete

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++
 drivers/cxl/core/memdev.c               | 63 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6350dd82b9a9..e9773f20deac 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -477,3 +477,13 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		events when cxl_poison event tracing is enabled.
+
+What:		/sys/bus/cxl/devices/memX/bgcmd/complete
+Date:		September, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) This file can be used to read the processing status of
+		background commands. When a background command starts successfully,
+		it represents the progress as a percentage, and when it finishes,
+		userspace can read the opcode of a completed background operations.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 8d1692231767..ba23ef6b6278 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -201,6 +201,24 @@ static ssize_t security_erase_store(struct device *dev,
 static struct device_attribute dev_attr_security_erase =
 	__ATTR(erase, 0200, NULL, security_erase_store);
 
+static ssize_t bgcmd_complete_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
+	u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
+
+	if (pct == 100)
+		return sysfs_emit(buf, "0x%04x\n", cmd);
+	else
+		return sysfs_emit(buf, "%3u\n", pct);
+}
+static struct device_attribute dev_attr_bgcmd_complete =
+	__ATTR(complete, 0444, bgcmd_complete_show, NULL);
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -454,6 +472,11 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	NULL,
 };
 
+static struct attribute *cxl_memdev_bgcmd_attributes[] = {
+	&dev_attr_bgcmd_complete.attr,
+	NULL,
+};
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -482,11 +505,17 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
 	.attrs = cxl_memdev_security_attributes,
 };
 
+static struct attribute_group cxl_memdev_bgcmd_attribute_group = {
+	.name = "bgcmd",
+	.attrs = cxl_memdev_bgcmd_attributes,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
 	&cxl_memdev_security_attribute_group,
+	&cxl_memdev_bgcmd_attribute_group,
 	NULL,
 };
 
@@ -1012,6 +1041,36 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
  }
 
+static void put_bgcmd(void *data)
+{
+	struct cxl_memdev_state *mds = data;
+
+	sysfs_put(mds->bgcmd.complete_node);
+}
+
+static int cxl_memdev_bgcmd_init(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = &cxlmd->dev;
+	struct kernfs_node *bg;
+
+	bg = sysfs_get_dirent(dev->kobj.sd, "bgcmd");
+	if (!bg) {
+		dev_err(dev, "sysfs_get_dirent 'bgcmd' failed\n");
+		return -ENODEV;
+	}
+
+	mds->bgcmd.complete_node = sysfs_get_dirent(bg, "complete");
+	sysfs_put(bg);
+	if (!mds->bgcmd.complete_node) {
+		dev_err(dev, "sysfs_get_dirent 'complete' failed\n");
+		return -ENODEV;
+	}
+
+	return devm_add_action_or_reset(cxlds->dev, put_bgcmd, mds);
+}
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
@@ -1044,6 +1103,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
+	rc = cxl_memdev_bgcmd_init(cxlmd);
+	if (rc)
+		goto err;
+
 	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
-- 
2.34.1

