Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22ECC4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 18:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKCSMU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKCSMT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 14:12:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC8DBD0
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 11:12:18 -0700 (PDT)
Received: from frapeml100006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N3Bd06Z3Qz6887q;
        Fri,  4 Nov 2022 02:10:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:12:16 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 18:12:16 +0000
Date:   Thu, 3 Nov 2022 18:12:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Message-ID: <20221103181215.00004d71@Huawei.com>
In-Reply-To: <Y1mhqcCirwpQU5lH@memverge.com>
References: <20221006233702.18532-1-gregory.price@memverge.com>
        <20221026160545-mutt-send-email-mst@kernel.org>
        <BN6PR17MB312197C4CA958ED267BB576683309@BN6PR17MB3121.namprd17.prod.outlook.com>
        <20221026161044-mutt-send-email-mst@kernel.org>
        <Y1mhqcCirwpQU5lH@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 26 Oct 2022 17:07:53 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, Oct 26, 2022 at 04:11:29PM -0400, Michael S. Tsirkin wrote:
> > He does but in the end he sends patches not pull requests.
> > I don't care really as long as someone will send it up.
> >   
> 
> Jonathan will submit this, it's not a critical issue so it can wait for
> the larger feature set.

Sure, I'll roll it with a few other similarly minor fixes in a few days as
a patch set.

Jonathan
