Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911EFC6FD1F
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Mar 2023 17:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCPROq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCPROq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Mar 2023 13:14:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10DE049
        for <linux-cxl@vger.kernel.org>; Thu, 16 Mar 2023 10:14:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pcv4v1Nrqz67Ntg;
        Fri, 17 Mar 2023 01:14:23 +0800 (CST)
Received: from localhost (10.48.145.133) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 16 Mar
 2023 17:14:41 +0000
Date:   Thu, 16 Mar 2023 17:14:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: CXL/region :  commit reset of out of order region appears to
 succeed.
Message-ID: <20230316171441.0000205b@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.133]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ran into this whilst testing fix for QEMU uncommit handling.

To replicate.
1) Setup two regions on a direct connected Type 3 and commit them both.
2) Uncommit the first region once. (it fails with an out of order message)
   Note that from here on the sysfs commit attribute reads as 0.
3) Uncommit that first region again.  It appears to succeed.

Reason is easy to track down:
https://elixir.bootlin.com/linux/v6.3-rc2/source/drivers/cxl/core/region.c#L257

commit_store() of 0 unconditionally sets the state to CXL_CONFIG_RESET_PENDING

When the decoder reset fails, that is left set.
Hence next call drops straight through.

Whilst it's easy to 'fix' the superficial issue by reseting the state to the previous
value on error, I'm not sure that's sufficient or race free.

Hence report rather than a patch.  I can look into this in more depth, but
a few other things come before it in my list.

Thanks,

Jonathan

p.s. I hope to send the qemu fix for uncommit fairly soon.
