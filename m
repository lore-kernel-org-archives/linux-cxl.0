Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0DEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Jul 2023 01:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGFBqa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jul 2023 21:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjGFBqa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 5 Jul 2023 21:46:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2147C122
        for <linux-cxl@vger.kernel.org>; Wed,  5 Jul 2023 18:46:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QxK736fT2z67cDq;
        Thu,  6 Jul 2023 09:43:27 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 02:46:24 +0100
Date:   Thu, 6 Jul 2023 09:46:20 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <nifan@outlook.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
        <fan.ni@samsung.com>
Subject: Re: [Question] How to set up DVSEC CXL Range Registers for DCD
 devices
Message-ID: <20230706094620.000035d2@Huawei.com>
In-Reply-To: <SG2PR06MB339718DD083E76EEA06008F2B225A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <SG2PR06MB339718DD083E76EEA06008F2B225A@SG2PR06MB3397.apcprd06.prod.outlook.com>
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

On Thu, 29 Jun 2023 10:10:48 -0700
Fan Ni <nifan@outlook.com> wrote:

> Hi,
> 
> When preparing the DCD patches for QEMU emulation and testing, I hit an issue
> when trying to load the cxl modules. The issue happens when the kernel tries
> to do cxl pci probe where it checks whether the media is ready
> through cxl_await_media_ready. The function will check dvsec mem range.
> 
> In current QEMU code, the dvsec range registers for type3 memdev is set
> only for static ram and pmem in function build_dvsecs, which will cause
> the kernel fails the check of media ready of DCD devices without static
> capacity.
> 
> About the issue, I have following questions that want to ask and
> clarify,
> 
> 1. do we allow DCD device have no static (RAM/PMEM) capacity at all and
> only dynamic capacity?

Yes.  That will probably be a reasonably common configuration so definitely
want that to work.

> 
> 2. Do we need to set dvsec range registers for dynamic capacity? And how
> if needed?

hmm.  I think we should.  Given a DCD device is not an eRCD (though it may
be operating in RCD mode) the memory types are all from CDAT - so I think
we 'could' use either one or two ranges to cover the DCD range.

Desired interleave is messy but it's only a hint anyway so meh.
Memory active timeout might potentially be different for say a PMEM region
between a volatile range and DCD range but I guess it just needs to be
the biggest of anything covered.

The writeable registers are fine as we should be using HDM decoders anyway
if DCD is involved so they are ignored.

Whilst QEMU doesn't support it (as no RCH support yet) I can't see a general
reason why you can't have DCD on an RCH host as long as the BIOS knows how
to deal with HDM decoders so that the routing is set up to the DCD address
range as well as the other two.  Probably easier if the device doesn't have
all of static volatile region, static PMEM region, DCD region... though might
be able to make that work on some RCH hosts.

Jonathan

> 
> In current Qemu code, we assume at least one of ram or pmem static capacity
> exists. The code logic of build_dvsec looks like below,
> if (vmem){
> 	set rang1 base and size with vmem info;
> 	if (pmem)
> 		set range2 base and size with pmem info;
> } else {
> 	set range1 base and size with pmem info;
> }
> 
> To fix the issue above and make kernel works for DCD (with no static ram/pmem),
> I updated the logic as below and it seems to pass the modprobe.
> 
> if (vmem) {
> 	set rang1 base and size with vmem info;
> 	if (pmem)
> 		set range2 base and size with pmem info;
> 	else if (dc){
> 		set range2 base and size with dc info;
> 	}
> } else if (pmem){
> 	set rang1 base and size with pmem info;
> 	if (dc)
> 		set range2 base and size with dc info;
> } else 
> 	set rang1 base and size with dc info;
> 
> Is the above logic reasonable? If not, what is the right way?

Seems like it covers the devices I'd expect people to build, but
we do want to poke the corners with the QEMU emulation so
should probably allow for all 3 being described...  Maybe not
to start with though.  So for now, perhaps print a warning if you
hit all 3 at once?


> 
> 
> Thanks,
> Fan
> 
> 

