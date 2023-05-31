Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD5C77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 16:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjEaQju (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEaQjt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 12:39:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE39D98
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 09:39:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWZc81r00z6J7Nd;
        Thu,  1 Jun 2023 00:34:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 17:39:46 +0100
Date:   Wed, 31 May 2023 17:39:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/6] cxl/mem: Wire up Sanitation support
Message-ID: <20230531173945.00006acc@Huawei.com>
In-Reply-To: <26ea97ef-f69c-b1a1-8db6-7ed62aed8fc0@intel.com>
References: <20230526033344.17167-1-dave@stgolabs.net>
        <20230526033344.17167-4-dave@stgolabs.net>
        <2rbjiulpjgpl6i4ilwbvndfteciagp72r6fkxlqtcik3t6kr4x@5jka73uukm7w>
        <26ea97ef-f69c-b1a1-8db6-7ed62aed8fc0@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 30 May 2023 16:53:25 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 5/25/23 20:41, Davidlohr Bueso wrote:
> > On Thu, 25 May 2023, Davidlohr Bueso wrote:
> >  
> >> Implement support for CXL 3.0 8.2.9.8.5.1 Sanitize. This is done by
> >> adding a security/sanitize' memdev sysfs file, which is poll(2)-capable
> >> for completion. Unlike all other background commands, this is the
> >> only operation that is special and monopolizes the device for long
> >> periods of time.  
> >
> > As becomes obvious in the code, this paragraph actually should have
> > been updated: the pollable/read file for the status of sanitation
> > is the security/state.  
> 
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com> with above update.
LGTM as well
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> 
> 
> 
> >
> > Thanks,
> > Davidlohr  
> 

