Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A336C05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 14:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBAOqL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBAOpm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 09:45:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD86A71A
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 06:45:16 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P6PnQ38BMz6J9NZ;
        Wed,  1 Feb 2023 22:44:10 +0800 (CST)
Received: from localhost (10.45.150.75) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 14:45:13 +0000
Date:   Wed, 1 Feb 2023 14:45:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC PATCH v2 1/3] hw/cxl: QMP based poison injection support
Message-ID: <20230201144512.00007b64@Huawei.com>
In-Reply-To: <87k011y44x.fsf@pond.sub.org>
References: <20230201100350.23263-1-Jonathan.Cameron@huawei.com>
        <20230201100350.23263-2-Jonathan.Cameron@huawei.com>
        <87k011y44x.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.150.75]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 01 Feb 2023 13:14:06 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron via <qemu-devel@nongnu.org> writes:
> 
> > Inject poison using qmp command cxl-inject-poison to add an entry to the
> > poison list.
> >
> > For now, the poison is not returned CXL.mem reads, but only via the
> > mailbox command Get Poison List.
> >
> > See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
> >
> > Kernel patches to use this interface here:
> > https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
> >
> > To inject poison using qmp (telnet to the qmp port)
> > { "execute": "qmp_capabilities" }
> >
> > { "execute": "cxl-inject-poison",
> >     "arguments": {
> >          "path": "/machine/peripheral/cxl-pmem0",
> >          "start": 2048,
> >          "length": 256
> >     }
> > }
> >
> > Adjusted to select a device on your machine.
> >
> > Note that the poison list supported is kept short enough to avoid the
> > complexity of state machine that is needed to handle the MORE flag.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 3c18556ee8..5b995db255 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json  
> 
> There is no qapi/cxl.json in current master.  So this must be based on
> some other patch(es).  Please point to it in the cover letter.  I like
> to point both in human-readable and machine-readable form, e.g. like
> this:
> 
>     Based on my "[PATCH 00/22] qapi: Remove simple unions from the schema
>     language".
> 
>     Based-on: Message-Id: <20210913123932.3306639-1-armbru@redhat.com>

Good point. I missed it in this series beyond a general reference to 'lots'.
Based on "[PATCH 0/2] hw/mem: CXL Type-3 Volatile Memory Support"
(which isn't mine)
Based-on: Message-ID: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>

(and all the things that series does say it's based on)
What matters here is mostly in final patch of.
b) https://lore.kernel.org/linux-cxl/20230130155251.3430-1-Jonathan.Cameron@huawei.com/
   [PATCH v3 0/8] hw/cxl: RAS error emulation and injection
If you have time to look at that it would be appreciated as it's more
complex QMP usage than in here.

Sorry about that - I'll also start using your suggested format.

> 
> > @@ -5,6 +5,17 @@
> >  # = CXL devices
> >  ##
> >  
> > +##
> > +# @cxl-inject-poison:
> > +#
> > +# @path: CXL type 3 device canonical QOM path
> > +#
> > +# @start: Start address
> > +# @length: Length of poison to inject  
> 
> Either separate all the arguments with blank lines, or none.
> 
> > +##
> > +{ 'command': 'cxl-inject-poison',
> > +  'data': { 'path': 'str', 'start': 'uint64', 'length': 'uint64' }}
> > +
> >  ##
> >  # @CxlUncorErrorType:
> >  #  
> 
> Both commit message and doc comment are rather terse.
> 
> The commit message should make the case for the feature: why do we want
> it?  This typically involves explaining the problem(s) it solves.
> 
> The doc comment ideally explains intended use.

OK. I'll expand on this. It'll be a bit of fuzzy text that
boils down to we emulate so we can test the OS does the right thing
when it gets poison related events. I can add some generic fluff on
why a real device might implement this in the first place though
I'm not sure that will even matter to anyone reading these docs.

> 
> 

