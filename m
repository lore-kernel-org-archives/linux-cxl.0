Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9833EB64D9
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jul 2023 01:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjGCBdw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 2 Jul 2023 21:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGCBdv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 2 Jul 2023 21:33:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA712E
        for <linux-cxl@vger.kernel.org>; Sun,  2 Jul 2023 18:33:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QvSzw3S8yz688Z4;
        Mon,  3 Jul 2023 09:30:52 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 3 Jul
 2023 02:33:43 +0100
Date:   Mon, 3 Jul 2023 09:33:39 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "nifan@outlook.com" <nifan@outlook.com>
CC:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [RFC 7/7] hw/mem/cxl_type3: add read/write support to dynamic
 capacity
Message-ID: <20230703093339.00002fb2@Huawei.com>
In-Reply-To: <SG2PR06MB33973100A036493C2A644C6BB224A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175642uscas1p2c037608a1dd26b19cf970f97ce434c6d@uscas1p2.samsung.com>
        <20230511175609.2091136-8-fan.ni@samsung.com>
        <20230515162212.0000275c@Huawei.com>
        <SG2PR06MB33973100A036493C2A644C6BB224A@SG2PR06MB3397.apcprd06.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 28 Jun 2023 10:09:47 -0700
"nifan@outlook.com" <nifan@outlook.com> wrote:

> The 05/15/2023 16:22, Jonathan Cameron wrote:
> > On Thu, 11 May 2023 17:56:40 +0000
> > Fan Ni <fan.ni@samsung.com> wrote:
> >   
> > > From: Fan Ni <nifan@outlook.com>
> > > 
> > > Before the change, read from or write to dynamic capacity of the memory
> > > device is not support as 1) no host backed file/memory is provided for
> > > it; 2) no address space is created for the dynamic capacity.  
> > 
> > Ah nice. I should have read ahead.  Probably makes sense to reorder things
> > so that when we present DCD region it will work.  
> 
> We can back dynamic capacity with host memory/file and create address
> space for dc regions, but until extents can be added we should not expect
> any read/write can happen to the dynamic capacity, right?

True.  Seems logically 'unusual' though to set up the routing etc, but
not plumb the actual memory access i until later.  I guess it all comes
together in the end and doing it this way lets you handle the extent mapping
later.  So fine to leave it as you have it.

Jonathan
