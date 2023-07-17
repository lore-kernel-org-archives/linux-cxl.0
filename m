Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674A3EB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGQRVX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGQRVX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:21:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEBD8
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:21:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TKb5xw2z67YXJ;
        Tue, 18 Jul 2023 01:17:23 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:21:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 09/17] i2c/mctp: Allow receiving messages to dest eid 0
Date:   Mon, 17 Jul 2023 18:16:38 +0100
Message-ID: <20230717171646.8972-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Matt Johnston <matt@codeconstruct.com.au>

The Null Destination ID, 0, is used for MCTP control messages when
addressing by physical ID. That is used for Get Endpoint ID and
Set Endpoint ID when querying/assigning an EID to an endpoint.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/i2c/mctp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
index 0f4045d0d6..db42dc7226 100644
--- a/hw/i2c/mctp.c
+++ b/hw/i2c/mctp.c
@@ -242,7 +242,8 @@ static int i2c_mctp_event_cb(I2CSlave *i2c, enum i2c_event event)
             goto drop;
         }
 
-        if (pkt->mctp.hdr.eid.dest != mctp->my_eid) {
+        if (!(pkt->mctp.hdr.eid.dest == mctp->my_eid ||
+              pkt->mctp.hdr.eid.dest == 0)) {
             trace_i2c_mctp_drop_invalid_eid(pkt->mctp.hdr.eid.dest,
                                             mctp->my_eid);
             goto drop;
-- 
2.39.2

