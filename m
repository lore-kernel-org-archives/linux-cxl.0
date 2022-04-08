Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAE9C433FE
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Apr 2022 11:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiDHLvM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiDHLvL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Apr 2022 07:51:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80298217C63
        for <linux-cxl@vger.kernel.org>; Fri,  8 Apr 2022 04:49:07 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KZc1D2xCJz67bMc;
        Fri,  8 Apr 2022 19:47:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 13:49:04 +0200
Received: from localhost (10.81.210.4) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:49:03 +0100
Date:   Fri, 8 Apr 2022 12:49:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tong Zhang <t.zhang2@samsung.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-D?= =?ISO-8859-1?Q?aud=E9?= 
        <f4bug@amsat.org>, "Peter Xu" <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "ztong0001@gmail.com" <ztong0001@gmail.com>
Subject: Re: [PATCH v9 33/45] cxl/cxl-host: Add memops for CFMWS region.
Message-ID: <20220408124901.00007ced@Huawei.com>
In-Reply-To: <7a17a19d-dcd4-61d5-b699-7ba06c9600bd@samsung.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
 <CGME20220404153138uscas1p2e261ac1dab4f0b2904e9d877acf77510@uscas1p2.samsung.com>
 <20220404151445.10955-34-Jonathan.Cameron@huawei.com>
 <7a17a19d-dcd4-61d5-b699-7ba06c9600bd@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.4]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 7 Apr 2022 21:07:06 +0000
Tong Zhang <t.zhang2@samsung.com> wrote:

> On 4/4/22 08:14, Jonathan Cameron wrote:
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> >
> >
> > +static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
> > +                                  unsigned size, MemTxAttrs attrs)
> > +{
> > +    CXLFixedWindow *fw = opaque;
> > +    PCIDevice *d;
> > +
> > +    d = cxl_cfmws_find_device(fw, addr);
> > +    if (d == NULL) {
> > +        *data = 0;  
> 
> I'm looking at this code and comparing it to CXL2.0 spec 8.2.5.12.2 CXL HDM
> 
> Decoder Global Control Register (Offset 04h) table. It seems that we should
> 
> check POSION_ON_ERR_EN bit, if this bit is set, we return poison, otherwise
> 
> should return all 1's data.

Good point.  Takes a bit of searching to find the statements on that, but
it should indeed by all 1s not all 0s. I'll fix that up.

> 
> Also, from the spec, this bit is implementation specific and hard 
> wired(RO) to either 1 or 0,

My temptation is to set that to 0 and not return poison, because the handling
of that in the host is horribly implementation specific.

> 
> but for type3 device looks like we are currently allowing it to be 
> overwritten in ct3d_reg_write()
> 
> function. We probably also need more sanitation in ct3d_reg_write. (Also 
> for HDM
> 
> range/interleaving settings.)

Absolutely agree. Generally my plan was to tighten up write restrictions
as a follow on series because it tends to require quite a lot of code and
makes it much harder to see the overall flow.

So far I've done most of the PCI config space santization (see the gitlab
tree) but not much yet on the memory mapped register space.

I'll add it to the todo list. If it turns out this particular case is
reasonably clean I might add it within this series.

Jonathan

> 
> > +        /* Reads to invalid address return poison */
> > +        return MEMTX_ERROR;
> > +    }
> > +
> > +    return cxl_type3_read(d, addr + fw->base, data, size, attrs);
> > +}
> > +  
> 
> - Tong
> 

