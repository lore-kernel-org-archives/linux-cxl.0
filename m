Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8779FC433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 08:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJMI55 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJMI5z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 04:57:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC611BD85
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 01:57:53 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp3Hj6dH3z689q0;
        Thu, 13 Oct 2022 16:54:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 10:57:50 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 09:57:50 +0100
Date:   Thu, 13 Oct 2022 09:57:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <mst@redhat.com>,
        <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH v7 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <20221013095749.0000052d@huawei.com>
In-Reply-To: <20221012182120.174142-1-gregory.price@memverge.com>
References: <20221007152156.24883-5-Jonathan.Cameron@huawei.com>
        <20221012182120.174142-1-gregory.price@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 12 Oct 2022 14:21:15 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Included in this response is a recommended patch set on top of this
> patch that resolves a number of issues, including style and a heap
> corruption bug.
> 
> The purpose of this patch set is to refactor the CDAT initialization
> code to support future patch sets that will introduce multi-region
> support in CXL Type3 devices.
> 
> 1) Checkpatch errors in the immediately prior patch
> 2) Flatting of code in cdat initialization
> 3) Changes in allocation and error checking for cleanliness
> 4) Change in the allocation/free strategy of CDAT sub-tables to simplify
>    multi-region allocation in the future.  Also resolves a heap
>    corruption bug
> 5) Refactor of CDAT initialization code into a function that initializes
>    sub-tables per memory-region.
> 
> Gregory Price (5):
>   hw/mem/cxl_type3: fix checkpatch errors
>   hw/mem/cxl_type3: Pull validation checks ahead of functional code
>   hw/mem/cxl_type3: CDAT pre-allocate and check resources prior to work
>   hw/mem/cxl_type3: Change the CDAT allocation/free strategy
>   hw/mem/cxl_type3: Refactor CDAT sub-table entry initialization into a
>     function
> 
>  hw/mem/cxl_type3.c | 240 +++++++++++++++++++++++----------------------
>  1 file changed, 122 insertions(+), 118 deletions(-)
> 

Thanks, I'm going to roll this stuff into the original patch set for v8.
Some of this I already have (like the check patch stuff).
Some I may disagree with in which case  I'll reply to the patches - note
I haven't looked at them in detail yet!

Jonathan
