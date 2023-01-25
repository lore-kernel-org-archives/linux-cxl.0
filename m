Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C79C54E94
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 15:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjAYP1K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 10:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjAYP1J (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 10:27:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C96E49556
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 07:27:05 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P273H0LCkz6J9b0;
        Wed, 25 Jan 2023 23:26:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 25 Jan 2023 15:27:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 0/2] hw/cxl: Passthrough HDM decoder emulation
Date:   Wed, 25 Jan 2023 15:27:01 +0000
Message-ID: <20230125152703.9928-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since RFC: (Thanks to Fan Ni)
- Fix trivial whitespace and long line issues.

Until now, testing using CXL has relied up always using two root ports
below a host bridge, to work around a current assumption in the Linux
kernel support that, in the single root port case, the implementation will
use the allowed passthrough decoder implementation choice. If that choice
is made all accesses are routed from the host bridge to the single
root port that is present. Effectively we have a pass through decoder
(it is called that in the kernel driver).

This patch series implements that functionality and makes it the default
See patch 2 for a discussion of why I think we can make this change
without backwards compatibility issues (basically if it didn't work before
who are we breaking by making it work?)

Whilst this limitation has been known since the initial QEMU patch
postings / kernel CXL region support, Fan Ni Ran into it recently reminding
me that we should solve it.

Based on top of:
https://lore.kernel.org/linux-cxl/20230120142450.16089-1-Jonathan.Cameron@huawei.com/
[PATCH v2 0/7] hw/cxl: RAS error emulation and injection
which is in turn on top of:
https://lore.kernel.org/all/20230112102644.27830-1-Jonathan.Cameron@huawei.com/
[PATCH v2 0/8] hw/cxl: CXL emulation cleanups and minor fixes for upstream

Jonathan Cameron (2):
  hw/pci: Add pcie_count_ds_port() and pcie_find_port_first() helpers
  hw/pxb-cxl: Support passthrough HDM Decoders unless overridden

 hw/cxl/cxl-host.c                   | 31 ++++++++++++--------
 hw/pci-bridge/pci_expander_bridge.c | 44 +++++++++++++++++++++++++----
 hw/pci/pcie_port.c                  | 38 +++++++++++++++++++++++++
 include/hw/cxl/cxl.h                |  1 +
 include/hw/cxl/cxl_component.h      |  1 +
 include/hw/pci/pci_bridge.h         |  1 +
 include/hw/pci/pcie_port.h          |  2 ++
 7 files changed, 101 insertions(+), 17 deletions(-)

-- 
2.37.2

