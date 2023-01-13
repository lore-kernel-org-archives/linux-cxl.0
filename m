Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A179C67871
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 14:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjAMO6q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjAMO5w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 09:57:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784093C12
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 06:45:16 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtkjD3tYYz6J9bw;
        Fri, 13 Jan 2023 22:45:04 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 14:45:13 +0000
Date:   Fri, 13 Jan 2023 14:45:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for
 upstream
Message-ID: <20230113144511.00001207@Huawei.com>
In-Reply-To: <20230113144026.000001fb@Huawei.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
        <Y8AppXP+eP9cEz+i@memverge.com>
        <20230112172130.0000391b@Huawei.com>
        <Y8CNw/fZT5fZJZcK@memverge.com>
        <20230113091213.00002146@Huawei.com>
        <Y8Foj/12QNl0C96o@memverge.com>
        <20230113144026.000001fb@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 13 Jan 2023 14:40:26 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 13 Jan 2023 09:19:59 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > On Fri, Jan 13, 2023 at 09:12:13AM +0000, Jonathan Cameron wrote:  
> > > 
> > > Just to check, are these different from the on stack problem you reported
> > > previously?  Doesn't look like the fix for that has made it upstream yet.
> > > 
> > > What kernel are you running?
> > > 
> > >     
> > 
> > The prior issue I saw was related to the CXL Fixed Memory Window having
> > an e820 region registered during machine initialization.  That fix is
> > upstream.
> > 
> > On 2023-1-11 branch it is commit 2486dd045794d65598fbca9fd1224c27b9732dce
> > 
> > This one appears when registering any kind of type-3 device, during
> > boot.  
> 
> I meant this one
> 
> https://lore.kernel.org/all/20221118000524.1477383-1-ira.weiny@intel.com/
> 
> Sorry, should have dug out a link in earlier reply and save a round trip.

Ah I'd forgotten we were going round the houses somewhat on the right fix...
https://lore.kernel.org/all/20221128040338.1936529-3-ira.weiny@intel.com/
was another proposal and Lukas had yet another.
https://lore.kernel.org/all/cover.1669608950.git.lukas@wunner.de/

> 
> Jonathan

