Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D6FC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Mar 2022 15:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbiCWP7Q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbiCWP7Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 11:59:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE77B113
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 08:57:45 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNtH51cCDz67MK3;
        Wed, 23 Mar 2022 23:55:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 23 Mar 2022 16:57:43 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 15:57:42 +0000
Date:   Wed, 23 Mar 2022 15:57:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn?= =?ISO-8859-1?Q?=E9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v8 19/46] hw/cxl/device: Add some trivial commands
Message-ID: <20220323155741.00005f1e@huawei.com>
In-Reply-To: <20220318165622.GA1119244@alison-desk>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-20-Jonathan.Cameron@huawei.com>
        <20220318165622.GA1119244@alison-desk>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 18 Mar 2022 09:56:22 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Mar 18, 2022 at 03:06:08PM +0000, Jonathan Cameron wrote:
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > GET_FW_INFO and GET_PARTITION_INFO, for this emulation, is equivalent to
> > info already returned in the IDENTIFY command. To have a more robust
> > implementation, add those.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 69 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >   
> 
> snip
> 
> >  
> > +static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> > +                                           CXLDeviceState *cxl_dstate,
> > +                                           uint16_t *len)
> > +{
> > +    struct {
> > +        uint64_t active_vmem;
> > +        uint64_t active_pmem;
> > +        uint64_t next_vmem;
> > +        uint64_t next_pmem;
> > +    } QEMU_PACKED *part_info = (void *)cmd->payload;
> > +    QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> > +    uint64_t size = cxl_dstate->pmem_size;
> > +
> > +    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> > +        return CXL_MBOX_INTERNAL_ERROR;
> > +    }
> > +
> > +    /* PMEM only */
> > +    part_info->active_vmem = 0;
> > +    part_info->next_vmem = 0;
> > +    part_info->active_pmem = size / (256 << 20);
> > +    part_info->next_pmem = part_info->active_pmem;  
> 
> Setting next like this is logical, but it's not per the CXL spec:
> 
> 8.2.9.5.2.1
> "Next Persistent Capacity: If non-zero, this value shall become the
> Active Persistent Capacity on the next cold reset. If both this field and the
> Next Volatile Capacity field are zero, there is no pending change to the
> partitioning."
> 
> next_(vmem|pmem) should start as zero and only change as the result
> of a successful set_partition_info command.

Ah.  Good point and now fixed up.

> 
> From your cover letter:
> * Volatile memory devices (easy but it's more code so left for now).
> Wondering if this is something I could do, and follow that with
> set_partition support. Does that sound reasonable?

Sure, that would be great.

It raises an interesting question for what the volatile / non volatile
backend will look like.  So what is the command line?

So far I'd been assuming we'd do it as separate memdev devices
for volatile from those for non volatile because chances are
someone testing would back the volatile with RAM the non volatile with
a file.  If we enable the partitioning control that approach won't
make much sense.  Various options come to mind.
1) Just back with one memdev and present that as persistent or not
   but actually always have it persistent under the hood.
2) Allow backing with 2 memdevs and don't support the set_partition
   command. Lazy approach I was planing on doing eventualy.
3) Support 3 memdevs.  The middle one of which is the part we
   allow to be repartitioned if it is provided

Also, to actually enable this we'd probably want more HDM decoders
than currently supported and flags for CFMWS which aren't there
yet (Ben asked for them but I've left it for a future patch set).

Lots still to do once the initial patch set is moving forwards.
I don't mind queuing stuff up it gitlab though and then we can
send suitable series to the list once the earlier part has been
applied.  In the meantime we would have a moderately stable
based to build on top of.

Thanks,

Jonathan



 
> 
> Alison
> 
> > +
> > +    *len = sizeof(*part_info);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +  
> 
> snip
> 
> 

