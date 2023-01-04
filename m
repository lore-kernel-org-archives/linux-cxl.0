Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41F3C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 18:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjADSHw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 13:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbjADSHg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 13:07:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0823AA8D
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 10:07:32 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NnHWW10zlz67M1h;
        Thu,  5 Jan 2023 02:02:47 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 18:07:30 +0000
Date:   Wed, 4 Jan 2023 18:07:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 5/8] hw/cxl/events: Wire up get/clear event mailbox
 commands
Message-ID: <20230104180729.00002095@huawei.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-5-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
        <20221221-ira-cxl-events-2022-11-17-v2-5-2ce2ecc06219@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 21 Dec 2022 20:24:35 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL testing is benefited from an artificial event log injection
> mechanism.
> 
> Add an event log infrastructure to insert, get, and clear events from
> the various logs available on a device.
> 
> Replace the stubbed out CXL Get/Clear Event mailbox commands with
> commands that operate on the new infrastructure.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Hi Ira,

The ability to see the ret_code definitions relied on a patch that will
go upstream long after this one. I've dragged that down before this in
my tree, but the naming ret_code is neither compliant with QEMU naming
rules, nor specific enough given that definition is in a header.
Hence I'll also rename it as CXLRetCode.

I'll have a new tree up with that in place in a few days.
I'll carry your patches on that tree, with appropriate changes.

Jonathan

