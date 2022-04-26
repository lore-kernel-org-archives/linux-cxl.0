Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7FC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Apr 2022 17:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiDZRPZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354041AbiDZRMJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 26 Apr 2022 13:12:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111A33343
        for <linux-cxl@vger.kernel.org>; Tue, 26 Apr 2022 10:08:44 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KnpDq1p7Nz67NMW;
        Wed, 27 Apr 2022 01:06:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 26 Apr 2022 19:08:34 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 18:08:33 +0100
Date:   Tue, 26 Apr 2022 18:08:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: CXL type 3 which doesn't have cxl mem enabled.
Message-ID: <20220426180832.00005f0b@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi All,

I ran into this whilst debugging why on the current QEMU code
we now get a probe failure for CXL mem due to the range 1 size being
non 0. 

The conditions for whether we have legacy ranges programmed don't
take into account if Mem_Enable = 1.  That is if the
DVSEC CXL Control Mem_Enable bit is set on the type 3 device.
If it's not then there is no existing user of the CXL memory
setup by firmware or similar so we can switch over to HDM
decoders and it doesn't matter what is in the range registers.

Unfortunately the QEMU code was bringing the device up with
Mem_Enabled already set.  So I fixed that.  After all default
value of that bit should be 0.

A few problems then showed up.

1. Nothing in the Linux code actually sets Mem_Enabled to 1.
2. Probing fails in mem.c as wait_for_media() checks for
   info->mem_enabled (cached value of this bit).

So, dirty hack was to 
* drop that check in wait_for_media() as media being enabled doesn't
  have much to do with CXL.mem protocol being enabled.
* Make the check in cxl_hdm_decode_init()
   if (info->mem_enabled && !global_enable && info->ranges)
* Immediately after enabling the hdm decoder global enable,
  also set the Mem_Enable bit also update info->mem_enabled.

This seems to work, but I can't help thinking I'm missing something.

Jonathan
