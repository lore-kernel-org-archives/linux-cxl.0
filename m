Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23FC64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 15:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjB0Pbz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Pbb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 10:31:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F6D527
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 07:31:30 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQPVL1jngz6J7n1;
        Mon, 27 Feb 2023 23:26:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 15:31:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
Date:   Mon, 27 Feb 2023 15:31:26 +0000
Message-ID: <20230227153128.8164-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
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

v2:
- Rebase and pick up tags.
- State prereq patche sets more clearly.

Mostly sending out again because some of the precursors have been updated
and to fix a typo in a tag given on v1.

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
postings / kernel CXL region support, Fan Ni ran into it recently reminding
me that we should solve it.

Note that if you enable hdm_for_passthrough and use a configuration that
would otherwise get a passthrough decoder, the linux kernel will currently
fail to set it up correctly.  That's a bug / missing feature in Linux
not an issue with the emulation.

Based on series "[PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream"
Based on series "[PATCH v6 0/8] hw/cxl: RAS error emulation and injection"

Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
Based on: Message-Id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com

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

