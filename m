Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A6CE7AA5
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjIYQvC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYQvB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:51:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A939F
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:50:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvTN2241sz6DBDW;
        Tue, 26 Sep 2023 00:48:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 17:50:51 +0100
Date:   Mon, 25 Sep 2023 17:50:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>, <linuxarm@huawei.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        "Corey Minyard" <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 00/19] QEMU: CXL mailbox rework and features
Message-ID: <20230925173615.0000262d@huawei.com>
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 25 Sep 2023 17:11:05 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Based on: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
> Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Missed one. 
Based on: [PATCH v4 0/4] hw/cxl: Support emulating 4 HDM decoders throughout topology

> Based on: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended capability support
> Based on: [PATCH v3 0/4] hw/cxl: Line length reduction and related
> Based on: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management interface model
> 
> I'm assuming this last dependency will go via a different tree though there
> is an outstanding request for tests. That equally applies to the CXL setup,
> but there are lot of moving parts. I'll experiment with basic testing
> of the MCTP I2C device whilst this is being reviewed.
> 
> Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913132523.29780-1-Jonathan.Cameron@huawei.com
> Based on: Message ID: 20230913133615.29876-1-Jonathan.Cameron@huawei.com
> Based on: Message ID: 20230919093434.1194-1-Jonathan.Cameron@huawei.com
> Based on: Message ID: 20230925152258.5444-1-Jonathan.Cameron@huawei.com
And to match above, the above should have been first.

> Based on: Message ID: 20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com

So should be
Based on: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Based on: [PATCH v4 0/4] hw/cxl: Support emulating 4 HDM decoders throughout topology
Based on: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended capability support
Based on: [PATCH v3 0/4] hw/cxl: Line length reduction and related
Based on: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management interface model

Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913132523.29780-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913133615.29876-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230919093434.1194-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com

Sorry about that.

Jonathan
