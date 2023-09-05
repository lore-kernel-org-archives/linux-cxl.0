Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F03FCA0FE2
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjIEQYJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354544AbjIEMax (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 08:30:53 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189D91AE
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 05:30:49 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230905123046epoutp0333b92d7d644ef38cc75d1ac04565e9cd~CAJQuHeoz0886408864epoutp03O
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 12:30:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230905123046epoutp0333b92d7d644ef38cc75d1ac04565e9cd~CAJQuHeoz0886408864epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693917046;
        bh=rLqwM4Ej3f3oZhrWdjzzrSXsgGVEz9lmXWNgeSgKxcE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ORkKzUFk1pBSEJKWktv5bn8LiKXl+KWIpSqi1mCq12Wd3MM5nDMXzx7HVLXasJAVy
         dA0ElUsve4U9puvivBS8XLMHn+vCmU93RBNqw6nWsxWn7OJ3C+htuWbpaI8Prc8ne2
         6+s855GhxHeYjgPFsII8zTJU2mgU+JTEhQAB0M58=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230905123045epcas2p2df9bc77971365fa77dd1951bb88cbd3f~CAJQC9xE92365023650epcas2p2N;
        Tue,  5 Sep 2023 12:30:45 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rg4bn03vPz4x9Ps; Tue,  5 Sep
        2023 12:30:45 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.F7.09660.47F17F46; Tue,  5 Sep 2023 21:30:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1~CAJPLwH7_0040000400epcas2p2Z;
        Tue,  5 Sep 2023 12:30:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230905123044epsmtrp2af65b649972140a11aaa80b5581b8aea~CAJPK3tKB2288222882epsmtrp2r;
        Tue,  5 Sep 2023 12:30:44 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-6e-64f71f74fa11
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.8A.08649.47F17F46; Tue,  5 Sep 2023 21:30:44 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230905123044epsmtip2d1c7615346598e5da35cb6d0a1e04879~CAJO530-z1816718167epsmtip2c;
        Tue,  5 Sep 2023 12:30:44 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [PATCH] perf: CXL: fix mismatched number of counters mask
Date:   Tue,  5 Sep 2023 21:33:09 +0900
Message-Id: <20230905123309.775854-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmuW6J/PcUg10zrSw+vPnHYnHgdQO7
        xaqF19gsjqy9ymSx+OgMZoujezgsNj2+xmpxftYpFovLu+awWSy9fpHJouWOqcXG++/YHHg8
        1sxbw+jRcuQtq8emVZ1sHpuX1Hv0bVnF6PF5k1wAW1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8
        c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QhUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OIS
        W6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyOzrMsBXPYKzY9OszawNjG1sXIySEh
        YCIxY10vYxcjF4eQwA5Gie/bm1ggnE+MEp/WNzFDON8YJWYu/swC09Jw8RITRGIvo0TjmWlQ
        LX8YJdb9+coEUsUmoCUxfWYDaxcjB4eIgL/EpEtFIGFmgU9MEkuviYHYwgJOEm1Pn7GD2CwC
        qhIzty4Ha+UVsJJoPbkXapm8xP6DZ5kh4oISJ2c+YYGYIy/RvHU22HUSAl/ZJX4uf8kO0eAi
        cepxN1SzsMSr41ug4lISn9/tZYNoaGaUeP38CguE0wJ09e0dUFXGEu9uPge7mllAU2L9Ln0Q
        U0JAWeLILajFfBIdh/+yQ4R5JTrahCAalSTmLZ3HDGFLSFyauwXK9pDYtH8a2HAhgViJ8wuP
        MU9glJ+F5J1ZSN6ZhbB3ASPzKkax1ILi3PTUYqMCY3isJufnbmIEp1It9x2MM95+0DvEyMTB
        eIhRgoNZSYT3nfy3FCHelMTKqtSi/Pii0pzU4kOMpsAAnsgsJZqcD0zmeSXxhiaWBiZmZobm
        RqYG5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1ME24p2h2/e+pBW6318xbviZCS8VB7qTV
        Tw0p5l9sP7RuLLAsu3DSt2F/+rR/L5+cNPC9nqO3+RfnOa9K74tTTgoJnZ9k4rDG02S62fs4
        zfYp6iHuvxezXfky9/jE7Zwn/vx3OGYlofjZdduSxOZ94dNcfA7ozJ1yNEn/l6fJLok4bpmL
        y4w2bN7Q3ume13fDwPCP+fQzd2ZkqB83Eiv0NWzxn37stJTPfAGfQ32fXM/v41wip7xysTCj
        47ToP9PXS/o3vpvLcLT7TbnACosagdAz4fwBsqkV3xx1Q95lZ5RvlOtj4YqTS/V9fe98SOzR
        zA0v5Y2/dW7wb7ZW1C5RevixWfhD+au65/3f2aeXnVRiKc5INNRiLipOBABZk7uhLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvG6J/PcUg21bZS0+vPnHYnHgdQO7
        xaqF19gsjqy9ymSx+OgMZoujezgsNj2+xmpxftYpFovLu+awWSy9fpHJouWOqcXG++/YHHg8
        1sxbw+jRcuQtq8emVZ1sHpuX1Hv0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXRkfnWZaCOewV
        mx4dZm1gbGPrYuTkkBAwkWi4eImpi5GLQ0hgN6PE11mtrBAJCYnlG14wQdjCEvdbjrBCFP1i
        lNj19zQ7SIJNQEti+swGsAYRAX+J+a8PgDUwC/xhkvjVqAtiCws4SbQ9fQZWzyKgKjFz63Kw
        Gl4BK4nWk3tZIBbIS+w/eJYZIi4ocXLmExaIOfISzVtnM09g5JuFJDULSWoBI9MqRsnUguLc
        9NxkwwLDvNRyveLE3OLSvHS95PzcTYzg4NbS2MF4b/4/vUOMTByMhxglOJiVRHjfyX9LEeJN
        SaysSi3Kjy8qzUktPsQozcGiJM5rOGN2ipBAemJJanZqakFqEUyWiYNTqoFJoEtg5aTjjrd2
        X2ixFv0UsSku2Uxh2maRZc1n1+/b1aUr22KQdVT6hE1t0c4gU/Vvt96yOFqGlRZpX/qtc7g7
        2iWjzdnGhvl/vs3hKn+Ro2qvGbn2TjwxcUEf67fQO1nz3cpmSvu/PNWs+1dl0a167wwheTu3
        gBtRQv3nvhbdOr+mcm6RuXeC53x96e/fA1QsAnPf/MytSRed7n41xv4lR4TlrnnRfHFTNghz
        rboQcHCR+NTvKZOYvCadn/U+4djd3mie9wv+MjAY/OUJV9uRwCvMtspq45OOX3PidI/zrI7r
        0Obd/urFwg2felPa7whPNblcsysjfpb6R/FN2/Qy1hQwPF01PbpM0F86crsSS3FGoqEWc1Fx
        IgA7IND73QIAAA==
X-CMS-MailID: 20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1
References: <CGME20230905123044epcas2p2b1052956527cf63a03e2895d4b93e7e1@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The number of Count Units field is described as 6 bits long
in the CXL 3.0 specification. However, its mask value was
only declared as 5 bits long.

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 0a8f597e695b..365d964b0f6a 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -25,7 +25,7 @@
 #include "../cxl/pmu.h"
 
 #define CXL_PMU_CAP_REG			0x0
-#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(4, 0)
+#define   CXL_PMU_CAP_NUM_COUNTERS_MSK			GENMASK_ULL(5, 0)
 #define   CXL_PMU_CAP_COUNTER_WIDTH_MSK			GENMASK_ULL(15, 8)
 #define   CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK		GENMASK_ULL(24, 20)
 #define   CXL_PMU_CAP_FILTERS_SUP_MSK			GENMASK_ULL(39, 32)

base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.34.1

