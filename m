Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC65E6FE22
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 13:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjIVNDY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjIVNDX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 09:03:23 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4935B180
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 06:03:17 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230922130314epoutp018b1fe8e6e4ce9691298dda7f00b14f3b~HOjd3GIon1688716887epoutp01M
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 13:03:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230922130314epoutp018b1fe8e6e4ce9691298dda7f00b14f3b~HOjd3GIon1688716887epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695387794;
        bh=sXnICAZzbwBeu6cGhlbscfT82TuFcSoq+DcuINfYYu0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tZyK7oSfuSWCzys6eC4lnTZUp0oSL2uNW24YyRi5FcPtyFy1ch09gzhwvhQPPIW4F
         HJmdHefMIrUwKxdVo1PUBf8bwxv5CEc1rDCwW0I4bcB5p0garwgutFcd60UjuGkoXP
         s+OdNlWYx9aCI8gE1xhaMW6yIQDWUUTDhGb+J6ME=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230922130314epcas2p396869699df5e497b7e72533c004c6496~HOjdSFy5Y0783307833epcas2p3R;
        Fri, 22 Sep 2023 13:03:14 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RsXWP1qrvz4x9Pq; Fri, 22 Sep
        2023 13:03:13 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.65.09693.1909D056; Fri, 22 Sep 2023 22:03:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230922130311epcas2p1ef59a510027060360e98e5c6a31a1198~HOjbVuvbK0857408574epcas2p1R;
        Fri, 22 Sep 2023 13:03:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230922130311epsmtrp2e867fedf727deb829afed1210a1a3a26~HOjbU1P2o1524315243epsmtrp2F;
        Fri, 22 Sep 2023 13:03:11 +0000 (GMT)
X-AuditID: b6c32a45-abbfd700000025dd-60-650d909126f8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.69.08788.F809D056; Fri, 22 Sep 2023 22:03:11 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230922130311epsmtip1826dd7f3ea786c28e58dcfaf6c106c49~HOjbCrQnY2258922589epsmtip19;
        Fri, 22 Sep 2023 13:03:11 +0000 (GMT)
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
Subject: [RFC PATCH 2/3] cxl/mbox: Update sanitize opcode support
Date:   Fri, 22 Sep 2023 22:05:57 +0900
Message-Id: <20230922130557.3476469-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxzO2yvXg6zLrTr2hmQUb5ubJIWWAT1UNjaFNGGLEJh/OBie7QmE
        cr20xShxoaw40UXGR7BYAmMgcRStrgNXGSKUVoaDDVyBAKEqQ/wa2AhsEx1b28PN/57f83ue
        38f7gSGiTjQMy2f0tJah1AQawr/YvyVOUlUppKWt3QJy5rcRlDTWtADSVDsCyB8nS1GyffIs
        ID9rnwkivb+v8cneBwYBOTR8L4i0fD2Oks5zYzyyxVWHkK5ujPzFfI1PTlVe5ZHf3lhEk3DF
        JfOMQFHmXAhStHTf4ylslmOooqLDAhS19SWKJVt4mmBPwfY8mlLR2giaUWpU+UxuIpGakbMj
        Jy5eKpPIEkg5EcFQhXQisfODNElKvto3OxFxgFIX+ag0Sqcjot/ZrtUU6emIPI1On0jQrErN
        ytkoHVWoK2Jyoxhav1UmlcbE+YR7C/JsQ0dR1iQ4uLpSDgzgz6DjIBiDeCxcmS314RBMhNsB
        nK9wIVzwCEDLie9QLvgDwH9MD8EzS89Ao4BLXAbw6PzAuv8pgH1DTahfheKR0HTKEGiyEX8V
        Gq03eX4Rgo/xYfW1UZ4/sQF/D7rHVn0iDOPjb8Dyp5v8tBDfBi88buJx3cTwSt8wwvEvwcFT
        c3w/Rny8sbM+MCvEGzDonpgI1IH4Trjqiea8G+D9gQ4Bh8Pg0uJllNMbAXxwx83ngjIArdP2
        ddXbcHHyTqAQgm+B57uiuZqvQefUet8XYXn/3wKOFsLyz0WckYCNrY0IhyG83tCxjhVwpK8u
        YBXh2XB54jpSCcTm57YxP7eN+f++TQCxgFCa1RXm0roYVvbfrSo1hTYQeL+RyXZQs+CNcgAe
        BhwAYgixUah8FEKLhCrqUDGt1eRoi9S0zgHifMdbhYS9rNT4PgCjz5HFJkhj4+Nl8pg4qZx4
        Reg50qAS4bmUni6gaZbWPvPxsOAwAy8JX35TYZ1u2qXl97XHpHsGa993ZEi/j8082XW87GFx
        8OAL1vsVV27uv7Av9WxPxlzaSFurhlzzji872bapqsMrns2v14VkziUvaWqEzn4mv2uaendS
        6X2S2PyNfqIlebQA+9R0yS4OD68yZv68dUUEXYhKMn8LKbVcNZXsHj8x2yY+Jg+/FVrsPXn4
        45n9ooMZO5CEvV9ltaV7bjeOLsTsrqPY2ZTNd9eY3icVd4d73S6r5qOfqJJsG/ZDcXrhtmYx
        s3rx9BdR9TeSunreag79S5K658tDs/bkxYKB6gOPDd6sTdlIZ9aHll9px/iubFYdffv8mSPV
        nqVP3NMp+yTnCL4uj5JFIlod9S/d/MbNSAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnG7/BN5Ug8/z9S3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFh/e/GOxOPC6gd3izNmXrBarFl5jsziy9iqTxeKjM5gt
        ju7hsDg/6xSLxa0Jx5gsNt5/x+Yg4LFz1l12j5Yjb1k9Fu95yeSxaVUnm0ffllWMHlNn13t8
        3iQXwB7FZZOSmpNZllqkb5fAlbHpTDtbwXT2il9fOxgbGL+zdjFyckgImEjsOz6PvYuRi0NI
        YDejxIHLp1ggEhISyze8YIKwhSXutxxhhSj6xShx6k0LG0iCTUBLYvrMBrBJIgKyEs3rHjCB
        FDELPGSR2Hb7AyNIQljAUeLK1V9ARRwcLAKqEh1/FEHCvALWEht+LoBaIC+x/+BZZoi4oMTJ
        mU/AjmAGijdvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcx
        giNCS2sH455VH/QOMTJxMB5ilOBgVhLhTf7ElSrEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr
        3hQhgfTEktTs1NSC1CKYLBMHp1QDU5vt5dKHbQ3Na93eZLuG5yRufnbX5M3m1acXG647NuFa
        yRKDnl2dotcWGfqVFQg83r6accKUrz0mdY1TP1fxPHbaGXDkxANWhYCi+7/Ewx8FSOhP9DJr
        XZ9bs1426axvyjONXf8Dj03Pdubo53jL91vZqffWVeXZd9gvaW1RLrewclwq3KrXvvYhj7Tx
        lSzFlTMer31SYzB/2ZvvRU9um/POWP4xY593V7vWsa69HkkPr4rqzpdqYfJ8pneu2ND/yvVY
        7c3/mdhaQrRtLpzqzL9k8OJZQkdickmneg/H6aYD9tsfWR1xipC5+PdJqXZm/B/1r0LzH7rq
        ySst3iSZL5xvlypnMD/+T+pDjp3KSizFGYmGWsxFxYkAmgoas/cCAAA=
X-CMS-MailID: 20230922130311epcas2p1ef59a510027060360e98e5c6a31a1198
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922130311epcas2p1ef59a510027060360e98e5c6a31a1198
References: <CGME20230922130311epcas2p1ef59a510027060360e98e5c6a31a1198@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch adds bgmode to the existing sanitize command.
By adding it, the sanitize operation will work the same as before.

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---
 drivers/cxl/core/mbox.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..2a7c12950a1e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1106,7 +1106,10 @@ int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 		.payload_out = &out,
 		.size_out = sizeof(out),
 	};
-	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
+	struct cxl_mbox_cmd mbox_cmd = {
+		.opcode = cmd,
+		.bg_mode = CXL_BG_CMD_ASYNC_INT,
+	};
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 
 	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
-- 
2.34.1

