Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39BCC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Oct 2022 17:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJSRaZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Oct 2022 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJSRaT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Oct 2022 13:30:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0010D682
        for <linux-cxl@vger.kernel.org>; Wed, 19 Oct 2022 10:30:16 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsyQD5QCGz6HJKS;
        Thu, 20 Oct 2022 01:29:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 19:30:13 +0200
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 18:30:13 +0100
Date:   Wed, 19 Oct 2022 18:30:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Message-ID: <20221019183012.00007201@huawei.com>
In-Reply-To: <20221011181915.000031a1@huawei.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <20221011151744.00005278@huawei.com>
        <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
        <20221011181915.000031a1@huawei.com>
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

On Tue, 11 Oct 2022 18:19:15 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 11 Oct 2022 08:18:34 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > On 10/11/2022 7:17 AM, Jonathan Cameron wrote:  
> > > On Fri, 16 Sep 2022 16:10:53 -0700
> > > Dave Jiang <dave.jiang@intel.com> wrote:
> > >    
> > >> Series set to RFC since there's no means to test. Would like to get opinion
> > >> on whether going with using trace events as reporting mechanism is ok.
> > >>
> > >> Jonathan,
> > >> We currently don't have any ways to test AER events. Do you have any plans
> > >> to support AER events via QEMU emulation?    
> > > Sorry - missed this entirely as gotten a bit behind reading CXL emails.

Hi Dave,

Quick update.

Working QEMU emulation - but needs some/lots of cleanup. Particularly fun was
figuring out why I wasn't getting messages past the upstream switch port.
Turned out the serial number ECAP was on top of the AER ECAP. Oops - thankfully
that patch isn't upstream yet.
Also QEMU AER rooting seems to be based on some older PCIE spec
so needed some tweaks to get the device to actually issue ERR_FATAL etc.

Anyhow, should have something you can play with in a day or two.
In meantime an example dump (not writing the header log yet!)

pcieport 0000:0c:00.0: AER: Uncorrected (Non-Fatal) error received: 0000:0f:00.0
cxl_pci 0000:0f:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
cxl_pci 0000:0f:00.0:    [14] CmpltTO                (First)
cxl_ras_uc: mem3: status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error' header log: {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
cxl_pci 0000:0f:00.0: mem3: restart CXL.mem after slot reset
cxl_port endpoint6: No CMA mailbox
cxl_pci 0000:0f:00.0: mem3: error resume successful
pcieport 0000:0e:00.0: AER: device recovery successful

Jonathan
