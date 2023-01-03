Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C200C46467
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 16:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjACQhE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 11:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjACQhD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 11:37:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486BE032
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 08:37:02 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NmdcV0gKCz6J6Xx;
        Wed,  4 Jan 2023 00:34:50 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:37:00 +0000
Date:   Tue, 3 Jan 2023 16:36:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 4/8] hw/cxl/events: Add event status register
Message-ID: <20230103163659.00003444@huawei.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-4-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
        <20221221-ira-cxl-events-2022-11-17-v2-4-2ce2ecc06219@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Dec 2022 20:24:34 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> The device status register block was defined.  However, there were no
> individual registers nor any data wired up.
> 
> Define the event status register [CXL 3.0; 8.2.8.3.1] as part of the
> device status register block.  Wire up the register and initialize the
> event status for each log.
> 
> To support CXL 3.0 the version of the device status register block needs
> to be 2.  Change the macro to allow for setting the version.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Superficial comment from rebasing (I'll review once I have it all in place).
You haven't included cxl_events.h anywhere until the next patch.
As the enum is used in this patch we have a build problem.

I dragged the include in cxl_device.h forwards to this patch.

Jonathan
