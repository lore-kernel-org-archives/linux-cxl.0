Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A6C6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 11:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCNLx3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjCNLx0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 07:53:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99C9BA68
        for <linux-cxl@vger.kernel.org>; Tue, 14 Mar 2023 04:53:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PbWzj3Nk6z6JB2g;
        Tue, 14 Mar 2023 19:50:09 +0800 (CST)
Received: from localhost (10.48.148.120) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 14 Mar
 2023 11:53:08 +0000
Date:   Tue, 14 Mar 2023 11:53:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud?= =?ISO-8859-1?Q?=E9?= 
        <philmd@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error
 Injection Support.
Message-ID: <20230314115307.000038d6@Huawei.com>
In-Reply-To: <20230307192641.GH1489326@bgt-140510-bm03>
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
        <20230302133709.30373-9-Jonathan.Cameron@huawei.com>
        <CGME20230307192642uscas1p15caa7ff372247e96544265fbd031d83e@uscas1p1.samsung.com>
        <20230307192641.GH1489326@bgt-140510-bm03>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.148.120]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 7e5ad65c1d..d589f78202 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -232,6 +232,14 @@ REG64(CXL_MEM_DEV_STS, 0)
> >      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
> >      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
> >  
> > +typedef struct CXLError {
> > +    QTAILQ_ENTRY(CXLError) node;
> > +    int type; /* Error code as per FE definition */
> > +    uint32_t header[32];  
> Instead of using 32 here, would it be better to use
> CXL_RAS_ERR_HEADER_NUM?

Yes, that would be better.  Please send a patch.

> > +} CXLError;
