Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C2FA373F
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 20:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJXU0z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiJXUYz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 16:24:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B813F5E
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 11:39:40 -0700 (PDT)
Received: from frapeml100004.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mx08J5Dhxz67Cxd;
        Mon, 24 Oct 2022 23:57:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 18:01:04 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 17:01:04 +0100
Date:   Mon, 24 Oct 2022 17:01:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Message-ID: <20221024170102.00000c4b@huawei.com>
In-Reply-To: <ae8330db-ab77-7952-e846-de7dc527890c@intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <20221011151744.00005278@huawei.com>
        <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
        <20221011181915.000031a1@huawei.com>
        <20221019183012.00007201@huawei.com>
        <ae8330db-ab77-7952-e846-de7dc527890c@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 19 Oct 2022 10:38:13 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/19/2022 10:30 AM, Jonathan Cameron wrote:
> > On Tue, 11 Oct 2022 18:19:15 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >  
> >> On Tue, 11 Oct 2022 08:18:34 -0700
> >> Dave Jiang <dave.jiang@intel.com> wrote:
> >>  
> >>> On 10/11/2022 7:17 AM, Jonathan Cameron wrote:  
> >>>> On Fri, 16 Sep 2022 16:10:53 -0700
> >>>> Dave Jiang <dave.jiang@intel.com> wrote:
> >>>>       
> >>>>> Series set to RFC since there's no means to test. Would like to get opinion
> >>>>> on whether going with using trace events as reporting mechanism is ok.
> >>>>>
> >>>>> Jonathan,
> >>>>> We currently don't have any ways to test AER events. Do you have any plans
> >>>>> to support AER events via QEMU emulation?  
> >>>> Sorry - missed this entirely as gotten a bit behind reading CXL emails.  
> > Hi Dave,
> >
> > Quick update.
> >
> > Working QEMU emulation - but needs some/lots of cleanup. Particularly fun was
> > figuring out why I wasn't getting messages past the upstream switch port.
> > Turned out the serial number ECAP was on top of the AER ECAP. Oops - thankfully
> > that patch isn't upstream yet.
> > Also QEMU AER rooting seems to be based on some older PCIE spec
> > so needed some tweaks to get the device to actually issue ERR_FATAL etc.
> >
> > Anyhow, should have something you can play with in a day or two.  
> 
> Awesome! Thanks! :)

Took a little longer than expected..

Anyhow, now at
https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-24

That tree is carrying far too many things right now for it make much sense
to me to email this to qemu-devel - though I may pull
hw/pci/aer: Add missing routing for AER errors
out in advance as that's closing a spec different between QEMU emulation of AER
and what the PCI spec says.

Hopefully set of out of tree patches will start to shrink soon - v9 of the DOE
patches have been on list for a week or so.

Top patch includes a very short 'how to' in patch description.  Basically fire
up QMP: Add something like -qmp tcp:localhost:444,server=on,wait=off to your
qemu commandline and use commands like:

{ "execute": "qmp_capabilities" }
...
{ "execute": "cxl-inject-uncorrectable-error",
    "arguments": {
        "path": "/machine/peripheral/cxl-pmem0",
        "type": "cache-address-parity",
        "header": [ 3, 4]
    } }
...
{ "execute": "cxl-inject-correctable-error",
    "arguments": {
        "path": "/machine/peripheral/cxl-pmem0",
        "type": "physical",
        "header": [ 3, 4]
    } }



> 
> 
> > In meantime an example dump (not writing the header log yet!)
> >
> > pcieport 0000:0c:00.0: AER: Uncorrected (Non-Fatal) error received: 0000:0f:00.0
> > cxl_pci 0000:0f:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/00000000
> > cxl_pci 0000:0f:00.0:    [14] CmpltTO                (First)
> > cxl_ras_uc: mem3: status: 'Cache Data Parity Error' first_error: 'Cache Data Parity Error' header log: {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0}
> > cxl_pci 0000:0f:00.0: mem3: restart CXL.mem after slot reset
> > cxl_port endpoint6: No CMA mailbox
> > cxl_pci 0000:0f:00.0: mem3: error resume successful
> > pcieport 0000:0e:00.0: AER: device recovery successful
> >
> > Jonathan  
> 

