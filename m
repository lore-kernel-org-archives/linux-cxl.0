Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B871C433E0
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Feb 2021 17:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B26664E85
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Feb 2021 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhBHRxk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:53:40 -0500
Received: from zangief.bwidawsk.net ([107.170.211.233]:35698 "EHLO
        mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbhBHRwo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Feb 2021 12:52:44 -0500
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id E8CF61234A4; Mon,  8 Feb 2021 09:52:02 -0800 (PST)
Received: from mail.bwidawsk.net (c-73-37-61-164.hsd1.or.comcast.net [73.37.61.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id 5F4EA122C69;
        Mon,  8 Feb 2021 09:51:55 -0800 (PST)
Date:   Mon, 8 Feb 2021 09:51:53 -0800
From:   Ben Widawsky <ben@bwidawsk.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Chris Browy <cbrowy@avery-design.com>, david@redhat.com,
        mst@redhat.com, qemu-devel@nongnu.org, vishal.l.verma@intel.com,
        jgroves@micron.com, armbru@redhat.com, linux-cxl@vger.kernel.org,
        f4bug@amsat.org, imammedo@redhat.com, dan.j.williams@intel.com,
        ira.weiny@intel.com
Subject: Re: [RFC PATCH v1 01/01] PCIe DOE for PCIe and CXL 2.0
Message-ID: <20210208175153.o5rtag2diyn4ztqq@mail.bwidawsk.net>
References: <4F370DAB-1EFE-490B-B93F-312AC5081057@avery-design.com>
 <20210205160954.00006728@Huawei.com>
 <20210205171936.nx62hs4z4vr5g2er@intel.com>
 <20210205184942.00002233@Huawei.com>
 <593ADBD3-9A16-4875-AF5B-57E346A3460A@avery-design.com>
 <20210208105551.00005c12@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210208105551.00005c12@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-02-08 10:55:51, Jonathan Cameron wrote:
> ...
> 
> > 
> > >   
> > >>   
> > >>>> 
> > >>>> Just like you we feel what's most important is to have DOE supported so that
> > >>>> UEFI and Linux kernel and drivers can progress.  We're also contributing to
> > >>>> writing compliance tests for the CXL Compliance Software Development WG.    
> > >>> 
> > >>> Great.    
> > >> 
> > >> Is anyone doing the kernel enabling for it?  
> > > 
> > > Planning to look at this but plenty of other things on my todo list if someone
> > > else gets to it first.
> > > 
> > > Generic DOE support should be straight forward (the infrastructure).
> > > Parsing CDAT also straight forward.
> > > Doing something with the results is hard unless we just provide an interface for
> > > userspace to query them for a given device - or dump the table
> > > (I think we do want to be able to that). 
> > > 
> > > What I'm really not sure on is how to handle NUMA domains that are created late
> > > in the kernel boot sequence.  The  ACPI flow is set up with the assumption
> > > that we can get them from SRAT very early in boot. Need to figure out how to
> > > work around that. (e.g. preallocate a bunch of spare nodes for example though that's
> > > ugly).  Note IIRC the kernel doesn't do runtime update of any of the ACPI
> > > performance parameters yet (_SLI, _HMA) so there probably isn't any infrastructure
> > > that we can reuse.
> > > 
> > > There is also the firmware based enumeration and description option (OS not necessarily
> > > aware of CXL) in which this is all up to EDK2 and the kernel gets it all presented
> > > as standard tables.  
> > 
> > Do we know who’s on this as part of the EDK2 development?  It would be great if they could
> > address the SRAT/HMAT generation from reading CDAT.  EDK2 does address CXL 1.1 now.
> 
> No idea who, if anyone, is looking at this currently.  Perhaps ask on the EDK2 list?
> 
> Jonathan
> 

I did ping the folks at #edk2 in OFTC a few months back and got basically no
response. Mailing list might be best though.

> > 
> > > 
> > > As you can perhaps tell from my half done reviews, this week disappeared in
> > > other things so bit of catch up for me to do next week.
> > > 
> > > Thanks,
> > > 
> > > Joanthan
> > > 
> ...
> 
