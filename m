Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E5EDEC50
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 13:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbjIMNZa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjIMNZa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 09:25:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5527B19B1
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 06:25:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm1Kn0Z7bz6D9BZ;
        Wed, 13 Sep 2023 21:20:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 14:25:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v4 0/4] hw/cxl: Support emulating 4 HDM decoders throughout topology
Date:   Wed, 13 Sep 2023 14:25:19 +0100
Message-ID: <20230913132523.29780-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v4: Thanks to Fan and Philippe for reviews.
 - Add specification reference for interleave ways encodings
 - Gathered tags.

Note I'm sending this out quicker than I normally would because I want
to post another series on top of it and the additional comment will add
some fuzz for that.

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

Jonathan Cameron (4):
  hw/cxl: Push cxl_decoder_count_enc() and cxl_decode_ig() into .c
  hw/cxl: Add utility functions decoder interleave ways and target
    count.
  hw/cxl: Fix and use same calculation for HDM decoder block size
    everywhere
  hw/cxl: Support 4 HDM decoders at all levels of topology

 include/hw/cxl/cxl_component.h |  30 +++++-----
 hw/cxl/cxl-component-utils.c   |  92 +++++++++++++++++++++++++----
 hw/cxl/cxl-host.c              |  67 +++++++++++++++-------
 hw/mem/cxl_type3.c             | 102 +++++++++++++++++++++++----------
 4 files changed, 213 insertions(+), 78 deletions(-)

-- 
2.39.2

