Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBEECAAD1
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Aug 2022 15:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiHaPdo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiHaPdj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 Aug 2022 11:33:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE72CBD751
        for <linux-cxl@vger.kernel.org>; Wed, 31 Aug 2022 08:33:35 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHp591g8xz6813w;
        Wed, 31 Aug 2022 23:29:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 31 Aug 2022 17:33:33 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 16:33:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 0/3] CXL Performance Monitoring Unit QEMU emulation.
Date:   Wed, 31 Aug 2022 16:33:33 +0100
Message-ID: <20220831153336.16165-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL 3.0 introduces a CXL Performance Monitoring Unit.
(13.2 Performance Monitoring)
These unit may be present in any CXL component but for now the kernel
code only supports them in Type 3 Memory devices.

Add basic emulation of such units and instantiate 2 in each CXL Type 3 device.

Kernel driver was developed against this fairly minimal emulation.
https://lore.kernel.org/linux-cxl/20220824103617.21781-1-Jonathan.Cameron@huawei.com/T/#t

For now, this RFC is both to seek general feedback on the approach used and to
provide a platform for testing the kernel driver against.

Note that the CPMU definition is extremely flexible and configuring the
available options via the QEMU command line may be impractical.
To avoid that complexity, this configuration is currently fixed.
This code provides a pair of identical CPMU instances on each CXL type 3
device which were constructed to hit some of the corner cases in the
enumeration code.

The counters themselves just get bigger in a fashion designed to overflow
fairly quickly. Actual values are meaningless.  For now there is no
control over the existence of CPMU instances.  Likely we will add at least
an option to enable them or not.

Precursor patch to add MSI/MSIX support may well merge as part of a
different series, but is needed to apply this to 7.1.

Jonathan Cameron (3):
  hw/mem/cxl-type3: Add MSI/MSIX support
  hw/cxl: Switch to using an array for CXLRegisterLocator base
    addresses.
  hw/cxl: CXL Performance Monitoring Unit (CPMU) Emulation

 hw/cxl/cxl-cpmu.c              | 295 +++++++++++++++++++++++++++++++++
 hw/cxl/meson.build             |   1 +
 hw/mem/cxl_type3.c             |  31 +++-
 hw/pci-bridge/cxl_downstream.c |   4 +-
 hw/pci-bridge/cxl_root_port.c  |   4 +-
 hw/pci-bridge/cxl_upstream.c   |   4 +-
 include/hw/cxl/cxl.h           |   1 +
 include/hw/cxl/cxl_cpmu.h      |  99 +++++++++++
 include/hw/cxl/cxl_device.h    |  31 +++-
 include/hw/cxl/cxl_pci.h       |  15 +-
 10 files changed, 463 insertions(+), 22 deletions(-)
 create mode 100644 hw/cxl/cxl-cpmu.c
 create mode 100644 include/hw/cxl/cxl_cpmu.h

-- 
2.32.0

