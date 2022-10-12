Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94233C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 12:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJLMp5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLMp4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Oct 2022 08:45:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B3972B6B
        for <linux-cxl@vger.kernel.org>; Wed, 12 Oct 2022 05:45:54 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MnXQn6PVwz6H7Gp;
        Wed, 12 Oct 2022 20:44:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 14:45:52 +0200
Received: from localhost (10.45.159.48) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 13:45:51 +0100
Date:   Wed, 12 Oct 2022 13:45:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl: update var names for interleave ways conversion
 macros
Message-ID: <20221012134550.00006e9b@huawei.com>
In-Reply-To: <Y0YV5G0TSG3zwKnB@aschofie-mobl2>
References: <166552461397.1940763.17766745890158322847.stgit@djiang5-desk3.ch.intel.com>
        <Y0YV5G0TSG3zwKnB@aschofie-mobl2>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.159.48]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Oct 2022 18:18:28 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Tue, Oct 11, 2022 at 02:43:33PM -0700, Dave Jiang wrote:
> > Change var names for interleave ways macros to clearly indicate which
> > variable is encoded and which is the actual ways value.
> > 
> > iw == interleave ways
> > eniw == encoded interleave ways
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/cxl.h |   22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 7a4f740d710c..c0d826084465 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -78,14 +78,14 @@ static inline int cxl_to_granularity(u16 enig, unsigned int *ig)
> >  }
> >  
> >  /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */  
> 
> Above comment can be updated:
> CXL 8.2.4.19.7 CXL HDM Decoder n Control Register

Needs spec revision number.

CXL rev 3.0 8.2.4.....

J
