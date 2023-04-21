Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0BFC77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 17:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjDURdU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDURdT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 13:33:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5055251
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 10:33:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q31mh462yz67FD1;
        Sat, 22 Apr 2023 01:32:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Apr
 2023 18:33:15 +0100
Date:   Fri, 21 Apr 2023 18:33:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, "Ira Weiny" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang?= =?ISO-8859-1?Q?=E9?=" 
        <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH v4 5/6] hw/cxl: Add poison injection via the mailbox.
Message-ID: <20230421183314.000011d9@Huawei.com>
In-Reply-To: <c5332793-f062-e4e7-9579-8eeb416e57ab@linaro.org>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
        <20230303150908.27889-6-Jonathan.Cameron@huawei.com>
        <c5332793-f062-e4e7-9579-8eeb416e57ab@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 14 Mar 2023 07:27:52 +0100
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> On 3/3/23 16:09, Jonathan Cameron wrote:
> > Very simple implementation to allow testing of corresponding
> > kernel code. Note that for now we track each 64 byte section
> > independently.  Whilst a valid implementation choice, it may
> > make sense to fuse entries so as to prove out more complex
> > corners of the kernel code.
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v4: No change
> > ---
> >   hw/cxl/cxl-mailbox-utils.c | 41 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 41 insertions(+)  
> 
> 
> > +static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
> > +                                          CXLDeviceState *cxl_dstate,
> > +                                          uint16_t *len)
> > +{
> > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);  
> 
> This makes me wonder why CXLDeviceState isn't QDev based.

Interesting question that I'll look into, but I hope you don't mind if
I separate that question from this series.

Logically it's a one of a couple of different subsets of functionality and
different CXL components have a different mix of those. I'm not sure
that will map to a QDev based approach. I'll need to take more time to look into
this.

> 
> (Also, why include/hw/cxl/cxl_device.h is under GPL-2.0-only license?)

Not a clue.   Ben, any comment?



