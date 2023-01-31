Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6155C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 14:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjAaO4Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjAaO4V (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 09:56:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FCECD
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 06:56:20 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5p1g5QHfz6J65D;
        Tue, 31 Jan 2023 22:52:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 14:56:17 +0000
Date:   Tue, 31 Jan 2023 14:56:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <20230131145616.00006c9c@Huawei.com>
In-Reply-To: <Y9fS+vJft+P0FYWQ@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
        <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
        <20230126185025.000016a0@huawei.com>
        <20230126193424.00005034@huawei.com>
        <Y9fS+vJft+P0FYWQ@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 30 Jan 2023 09:23:54 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Jan 26, 2023 at 07:34:24PM +0000, Jonathan Cameron wrote:
> > Looks like decoders are programmed correctly as I can read and write from
> > the HPA using devmem2.
> > 
> > This is against http://gitlab.com/jic23/qemu cxl-2023-01-26 which has been
> >   
> 
> Johnathan, can you explain how you're accessing the memory? I don't
> quite follow.

Command sequence is pretty similar to yours (not checked it's identical)
and once commit is done, using a version of devmem2 (not sure it was this one)
https://github.com/hackndev/tools/blob/master/devmem2.c 
(if you want 64 bit read / write add the obvious additional parameter ;)

with appropriately loose kernel configuration that /dev/mem works

Then run that against addresses starting at the bottom of the CFMWS
HPA range to read and write.  It's a hack but proves the routing etc
is all setup correctly.

I had this lying around from testing the region setup code when it
was in a similar partial state to this support.

Jonathan


> 
> Extra Notes
> 1) Tested against Jonathan's QEMU 01-26 branch above
> 2) Tested w/ the Linux preview branch rebased on top of the DOE fixes
>    that were causing other bugs.

