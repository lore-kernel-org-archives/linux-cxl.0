Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB2C4332B
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Feb 2021 11:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003BE64E99
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Feb 2021 11:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhBHK7x convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Feb 2021 05:59:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2521 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhBHK50 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Feb 2021 05:57:26 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DZ2rz6gNRz67lTf;
        Mon,  8 Feb 2021 18:51:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 11:56:38 +0100
Received: from localhost (10.47.30.32) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Feb 2021
 10:56:37 +0000
Date:   Mon, 8 Feb 2021 10:55:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>, <david@redhat.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <armbru@redhat.com>,
        <dan.j.williams@intel.com>, <f4bug@amsat.org>,
        <imammedo@redhat.com>, <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
        <qemu-devel@nongnu.org>, <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v1 01/01] PCIe DOE for PCIe and CXL 2.0
Message-ID: <20210208105551.00005c12@Huawei.com>
In-Reply-To: <593ADBD3-9A16-4875-AF5B-57E346A3460A@avery-design.com>
References: <4F370DAB-1EFE-490B-B93F-312AC5081057@avery-design.com>
        <20210205160954.00006728@Huawei.com>
        <20210205171936.nx62hs4z4vr5g2er@intel.com>
        <20210205184942.00002233@Huawei.com>
        <593ADBD3-9A16-4875-AF5B-57E346A3460A@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.30.32]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

...

> 
> >   
> >>   
> >>>> 
> >>>> Just like you we feel what's most important is to have DOE supported so that
> >>>> UEFI and Linux kernel and drivers can progress.  We're also contributing to
> >>>> writing compliance tests for the CXL Compliance Software Development WG.    
> >>> 
> >>> Great.    
> >> 
> >> Is anyone doing the kernel enabling for it?  
> > 
> > Planning to look at this but plenty of other things on my todo list if someone
> > else gets to it first.
> > 
> > Generic DOE support should be straight forward (the infrastructure).
> > Parsing CDAT also straight forward.
> > Doing something with the results is hard unless we just provide an interface for
> > userspace to query them for a given device - or dump the table
> > (I think we do want to be able to that). 
> > 
> > What I'm really not sure on is how to handle NUMA domains that are created late
> > in the kernel boot sequence.  The  ACPI flow is set up with the assumption
> > that we can get them from SRAT very early in boot. Need to figure out how to
> > work around that. (e.g. preallocate a bunch of spare nodes for example though that's
> > ugly).  Note IIRC the kernel doesn't do runtime update of any of the ACPI
> > performance parameters yet (_SLI, _HMA) so there probably isn't any infrastructure
> > that we can reuse.
> > 
> > There is also the firmware based enumeration and description option (OS not necessarily
> > aware of CXL) in which this is all up to EDK2 and the kernel gets it all presented
> > as standard tables.  
> 
> Do we know who’s on this as part of the EDK2 development?  It would be great if they could
> address the SRAT/HMAT generation from reading CDAT.  EDK2 does address CXL 1.1 now.

No idea who, if anyone, is looking at this currently.  Perhaps ask on the EDK2 list?

Jonathan

> 
> > 
> > As you can perhaps tell from my half done reviews, this week disappeared in
> > other things so bit of catch up for me to do next week.
> > 
> > Thanks,
> > 
> > Joanthan
> > 
...
