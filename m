Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B9C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbiETQhg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiETQhg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 12:37:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3BA387B3
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 09:37:32 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L4XSV5S0zz67x4b;
        Sat, 21 May 2022 00:37:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 20 May 2022 18:37:30 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 17:37:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
CC:     "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v11 0/2] hw/arm/virt: CXL 2.0 emulation support
Date:   Fri, 20 May 2022 17:37:30 +0100
Message-ID: <20220520163732.27545-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The initial CXL support including support on x86/pc has now merged
(thanks Michael!).

This is the first of the two remaining parts of that series, unchanged
since v10.  The second is CXL switch support which can be applied
separately to this series and will be sent shortly.

CXL support requires two types of memory regions and this hooks them
up in arm/virt.

1) CXL host bridge control register regions.  This allows for up to
   16 host bridges which should keep anyone happy. The CEDT ACPI table
   is used by system software to find these regions.
2) CXL Fixed Memory Windows. CFMWs are regions of PA space that are
   configured to perform interleaved accesses over multiple host bridges.
   They are fixed, but the OS may select between multiple CFMWs to find
   one suitable for the interleave it desires.  All interleave in the
   host bridges and switches is programmable and discoverable - only
   these top level regions are static and described to system software
   via another structure in CEDT.

A simple test cases is added to existing cxl-test qtest.

Jonathan Cameron (2):
  hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
    pxb-cxl
  qtest/cxl: Add aarch64 virt test for CXL

 hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++
 hw/arm/virt.c            | 40 ++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h    |  1 +
 tests/qtest/cxl-test.c   | 48 ++++++++++++++++++++++++++++++++--------
 tests/qtest/meson.build  |  1 +
 5 files changed, 113 insertions(+), 10 deletions(-)

-- 
2.32.0

