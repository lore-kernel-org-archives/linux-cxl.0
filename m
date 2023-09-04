Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F9C71153
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 16:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjIDQrN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 12:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbjIDQrN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 12:47:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12E199
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 09:47:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfZKw4V4fz6K6ms;
        Tue,  5 Sep 2023 00:47:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 17:47:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH 0/2] hw/cxl: Support emulating 4 HDM decoders throughout topology
Date:   Mon, 4 Sep 2023 17:47:02 +0100
Message-ID: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For initial CXL emulation / kernel driver bring up a single Host-managed
Device Memory (HDM) decoder instance was sufficient as it let us test the
basic region creation code etc. More complex testing appropriate today
requires a more realistic configuration with multiple decoders.

The Linux kernel will use separate decoders for each memory type (and
shortly per DCD region) and for each interleave set within a memory type
or DCD region. 4 decoders are sufficient for most test cases today but
we may need to grow these further in future.

This patch set already allowed us to identify one kernel bug which is
now fixed.
https://lore.kernel.org/linux-cxl/168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com/

Note that, whilst I'm proposing this series for upstream (based on
priorities of what we have out of tree) it hasn't previously been posted
so needs review. (I failed to send it out previously)

Based on: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM

Based on: Message ID: 20230904132806.6094-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com

Jonathan Cameron (2):
  hw/cxl: Add utility functions decoder interleave ways and target
    count.
  hw/cxl: Support 4 HDM decoders at all levels of topology

 include/hw/cxl/cxl_component.h | 21 ++++++++
 hw/cxl/cxl-component-utils.c   | 43 +++++++++++----
 hw/cxl/cxl-host.c              | 65 +++++++++++++++--------
 hw/mem/cxl_type3.c             | 97 +++++++++++++++++++++++-----------
 4 files changed, 164 insertions(+), 62 deletions(-)

-- 
2.39.2

