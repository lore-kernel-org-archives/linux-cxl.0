Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57BFEDEC50
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 13:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjIMNag (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 09:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIMNaf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 09:30:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E519B6
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 06:30:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm1W32D7hz6HJcl;
        Wed, 13 Sep 2023 21:28:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 14:30:29 +0100
Date:   Wed, 13 Sep 2023 14:30:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <fan.ni@samsung.com>, <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <ayush.m55@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Message-ID: <20230913143028.00003fec@Huawei.com>
In-Reply-To: <kbznhylcg6qqltagnwrsidsvyetsdvmg4dftbsm2btjlwhqx2c@yy245lt2z6zd>
References: <20230908073152.4386-1-dave@stgolabs.net>
        <20230908073152.4386-5-dave@stgolabs.net>
        <20230912130425.0000569b@Huawei.com>
        <kbznhylcg6qqltagnwrsidsvyetsdvmg4dftbsm2btjlwhqx2c@yy245lt2z6zd>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 12 Sep 2023 20:33:52 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 12 Sep 2023, Jonathan Cameron wrote:
> 
> >On Fri,  8 Sep 2023 00:31:52 -0700
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> Iterate over the list keeping the output payload size into account,
> >> returning the results from a previous scan media operation. The
> >> scan media operation does not fail prematurely due to device being
> >> out of storage, so this implementation does not deal with the
> >> retry/restart functionality.
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> >A few comments inline but nothing to stop me carrying this on my
> >staging tree. (gitlab.com/jic23/qemu cxl-*latestdate*
> >
> >So I'll apply it there.  Updates welcome or I'll act on comments when
> >this gets to the top of our queue for upstreaming.  
> 
> I'll send follow up patches for this series once your new latest
> branch is published.
> 
> Thanks,
> Davidlohr

https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13

Fresh and tasty.  Includes 3 series that I've posted with the hope
of them merging soon and another one I'll post in a few mins to
deal with over long lines...

Jonathan
