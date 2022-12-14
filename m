Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD2EC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 14:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLNOBv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 09:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbiLNOBn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 09:01:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149120BC4
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 06:01:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NXH4h0Zj4z6HJYk;
        Wed, 14 Dec 2022 21:57:56 +0800 (CST)
Received: from localhost (10.81.204.207) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:01:39 +0000
Date:   Wed, 14 Dec 2022 14:01:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] hw/cxl/device: Add Flex Bus Port DVSEC
Message-ID: <20221214140135.00005a15@Huawei.com>
In-Reply-To: <20221214123945.00007a33@Huawei.com>
References: <20221213-ira-flexbus-port-v1-1-86afd4f30be6@intel.com>
        <20221214123945.00007a33@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.204.207]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Dec 2022 12:39:45 +0000
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Tue, 13 Dec 2022 16:34:52 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The Flex Bus Port DVSEC was missing on type 3 devices which was blocking
> > RAS checks.[1]
> > 
> > Add the Flex Bus Port DVSEC to type 3 devices as per CXL 3.0 8.2.1.3.
> > 
> > [1] https://lore.kernel.org/linux-cxl/167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com/
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Ben Widawsky <bwidawsk@kernel.org>
> > Cc: qemu-devel@nongnu.org
> > Cc: linux-cxl@vger.kernel.org
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> 
> Not sure how we missed this one given the whole fun a while back with Mem Enable not
> being set by the kernel code.  Ah well - I'm not going to go digging in the history
> for that.
Ah. I forgot the difference between the 'control' in here which isn't really a control
in this case and the one in PCIe DVSEC for CXL devices which is the one were we enable it.

I guess this calls for a more thorough check on what else we are missing
in the way of DVSEC - including this stuff which is all about link training but does
provide some useful info the stuff that results from the training.

> 
> Minor thing inline - unlike root ports, switches etc, type 3 device should not
> report CXL.cache support.
> 
> Jonathan
> 
> 
> > ---
> >  hw/mem/cxl_type3.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 0317bd96a6fb..27f6ac0cb3c1 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -416,6 +416,17 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> >                                 GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
> >                                 GPF_DEVICE_DVSEC_REVID, dvsec);
> > +
> > +    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> > +        .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */  
> 
> Type 3 typically wouldn't support cache.  Probably want the comment to include
> bit 5 (68B Flit and VH capable) That should probably true in the other instances
> of this as well.
> 
> 
> > +        .ctrl                    = 0x02, /* IO always enabled */
> > +        .status                  = 0x27, /* same as capabilities */  
> Again, not cache.
> 
> > +        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> > +    };
> > +    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> > +                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
> > +                               PCIE_FLEXBUS_PORT_DVSEC,
> > +                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
> >  }
> >  
> >  static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
> > 
> > ---
> > base-commit: e11b57108b0cb746bb9f3887054f34a2f818ed79
> > change-id: 20221213-ira-flexbus-port-ce526de8111d
> > 
> > Best regards,  
> 
> 

