Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E39C83F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 16:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjIDQSz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjIDQSz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 12:18:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD780E8
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 09:18:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfYgt6jXfz67Nsw;
        Tue,  5 Sep 2023 00:17:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 17:18:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Date:   Mon, 4 Sep 2023 17:18:44 +0100
Message-ID: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v2 updates:
- Edit of patch description to not confuse matters by mentioning
  switches.
- Associated ACPI test updates.

CXL platforms may support the concept of QoS Thottling groups (QTG).

Typically you want to associate devices with similar performance
with the same QTG. As there is no standard way of understanding the
relationship between expected performance and appropriate QTG
the platform firmware provides a query mechanism via ACPI Device
Specific Method (DSM) with parameters of the performance numbers
that returns the appropriate QTG ID.

This support is basically stubbing out that function so that it always
returns 0. For now that is sufficient for current CXL emulation usecases.

Based on: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Based on: Message ID: 20230904132806.6094-1-Jonathan.Cameron@huawei.com

Dave Jiang (1):
  hw/cxl: Add QTG _DSM support for ACPI0017 device

Jonathan Cameron (2):
  tests/acpi: Allow update of DSDT.cxl
  tests/acpi: Update DSDT.cxl with QTG DSM

 include/hw/acpi/cxl.h        |   1 +
 hw/acpi/cxl.c                |  57 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c         |   1 +
 tests/data/acpi/q35/DSDT.cxl | Bin 9655 -> 9723 bytes
 4 files changed, 59 insertions(+)

-- 
2.39.2

