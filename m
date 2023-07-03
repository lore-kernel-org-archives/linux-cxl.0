Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F288EB64DA
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Jul 2023 02:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjGCCaI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 2 Jul 2023 22:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGCCaH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 2 Jul 2023 22:30:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CD1BB
        for <linux-cxl@vger.kernel.org>; Sun,  2 Jul 2023 19:30:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QvVDr6k83z6D8WZ;
        Mon,  3 Jul 2023 10:27:08 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 3 Jul
 2023 03:30:01 +0100
Date:   Mon, 3 Jul 2023 10:29:57 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <20230703102957.00000660@Huawei.com>
In-Reply-To: <6496eab44738f_633d62946f@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
        <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
        <20230622165817.0000220e@Huawei.com>
        <6496eab44738f_633d62946f@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

#> > > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > > +{
> > > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > > +	struct device *dev = cxlds->dev;
> > > +	struct cxl_mbox_dynamic_capacity *dc;  
> > 
> > Calling it dc is confusing.  I'd make it clear this is the mailbox
> > response. config_resp or dc_config_res.  
> 
> How about dc_resp?

That works for me as well.

...

> > 
> > 
> > But fun corner.... Mailbox is allowed to be smaller than that (256 bytes min
> > I think) so need to handle multiple reads with different start regions.  
> 
> Oh bother.  :-/
> 
> What are the chances a device is going to only support 256B and DC?  I think
> you are correct though.  I'll add a loop to handle this possibility.
> 
> Anyway I've adjusted the algorithm...  Hopefully it will just loop 1 time.
> 
> > Which reminds me that we need to add support for running out of space
> > in the mailbox to qemu... So far we've just made sure everything fitted :)  
> 
> Might be nice to test stuff.
>

Hmm. I'll try not to forget about it this time, unlike the previous 10 times
I've thought we should fix that :)
 
