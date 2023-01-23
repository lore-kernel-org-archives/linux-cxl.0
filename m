Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2640C54E94
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 12:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjAWMRR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 07:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjAWMRQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 07:17:16 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1648023873
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 04:17:14 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0pxG4ZF7z67tG2;
        Mon, 23 Jan 2023 20:16:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 23 Jan 2023 12:17:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: [RFC PATCH 0/2] hw/cxl: Passthrough HDM decoder emulation
Date:   Mon, 23 Jan 2023 12:17:10 +0000
Message-ID: <20230123121712.29892-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

https://lore.kernel.org/linux-cxl/20230113171044.GA24788@bgt-140510-bm03/

Tree with a large set of patches before this at:
https://gitlab.com/jic23/qemu/-/tree/cxl-2023-01-20

I've done some basic testing, though I did hit what appears to be
a kernel race on region bring up of existing region / namespace in a
1HB 2RP 2EP test case. That is proving hard to replicate consistently
but doesn't seem to have anything to do with the emulation other than
perhaps we are opening up a race by responding slowly to something.

Jonathan Cameron (2):
  hw/pci: Add pcie_count_ds_port() and pcie_find_port_first() helpers
  hw/pxb-cxl: Support passthrough HDM Decoders unless overridden

 hw/cxl/cxl-host.c                   | 31 +++++++++++++--------
 hw/pci-bridge/pci_expander_bridge.c | 43 +++++++++++++++++++++++++----
 hw/pci/pcie_port.c                  | 38 +++++++++++++++++++++++++
 include/hw/cxl/cxl.h                |  1 +
 include/hw/cxl/cxl_component.h      |  1 +
 include/hw/pci/pci_bridge.h         |  1 +
 include/hw/pci/pcie_port.h          |  2 ++
 7 files changed, 100 insertions(+), 17 deletions(-)

-- 
2.37.2

