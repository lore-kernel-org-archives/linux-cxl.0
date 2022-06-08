Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44019C43334
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Jun 2022 15:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiFHPKg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbiFHPJx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Jun 2022 11:09:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A843E216
        for <linux-cxl@vger.kernel.org>; Wed,  8 Jun 2022 07:59:09 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ9LX3pN8z67yKf;
        Wed,  8 Jun 2022 22:57:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 16:58:39 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 15:58:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 8/8] hw/machine: Drop cxl_supported flag as no longer useful
Date:   Wed, 8 Jun 2022 15:54:40 +0100
Message-ID: <20220608145440.26106-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608145440.26106-1-Jonathan.Cameron@huawei.com>
References: <20220608145440.26106-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As all the CXL elements have moved to boards that support
CXL, there is no need to maintain a top level flag.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
---
 hw/i386/pc.c        | 1 -
 include/hw/boards.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a0c0d69698..1b6067ff22 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1804,7 +1804,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
-    mc->cxl_supported = true;
     mc->default_ram_id = "pc.ram";
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 031f5f884d..d94edcef28 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -269,7 +269,6 @@ struct MachineClass {
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
-    bool cxl_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
     SMPCompatProps smp_props;
-- 
2.32.0

