Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BDBC71153
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbjIDN2Q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjIDN2N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 09:28:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2749619B
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 06:28:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfTwM4Jmxz6K6hj;
        Mon,  4 Sep 2023 21:28:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 14:28:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Date:   Mon, 4 Sep 2023 14:28:02 +0100
Message-ID: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A small set gathering patches that have been posted and reviewed on list
over the last few months. Looking to get these upstream before making
any significant changes to the CXL emulation for this cycle.

More wide spread cleanup will follow later this cycle (reference
updates to available spec and line length improvements).

Dave Jiang (1):
  hw/pci-bridge/cxl_upstream: Fix bandwidth entry base unit for SSLBIS

Fan Ni (1):
  hw/cxl/cxl_device: Replace magic number in CXLError definition

Li Zhijian (2):
  hw/cxl: Fix CFMW config memory leak
  docs/cxl: Change to lowercase as others

 docs/system/devices/cxl.rst  |  8 ++++----
 include/hw/cxl/cxl_device.h  |  2 +-
 hw/cxl/cxl-host.c            | 12 ++++++------
 hw/pci-bridge/cxl_upstream.c |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.39.2

