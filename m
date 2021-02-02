Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271AC433DB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A5964F5E
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 15:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhBBPR2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:17:28 -0500
Received: from zangief.bwidawsk.net ([107.170.211.233]:44504 "EHLO
        mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhBBPP2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 Feb 2021 10:15:28 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 10:15:28 EST
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id 9B00B1234A7; Tue,  2 Feb 2021 07:06:29 -0800 (PST)
Received: from mail.bwidawsk.net (c-73-37-61-164.hsd1.or.comcast.net [73.37.61.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id D9FAF122C69;
        Tue,  2 Feb 2021 07:06:17 -0800 (PST)
Date:   Tue, 2 Feb 2021 07:06:16 -0800
From:   Ben Widawsky <ben@bwidawsk.net>
To:     Eric Blake <eblake@redhat.com>
Cc:     qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Markus Armbruster <armbru@redhat.com>,
        linux-cxl@vger.kernel.org,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3 21/31] hw/cxl/device: Add a memory device (8.2.8.5)
Message-ID: <20210202150616.s6nvpbmozsosewgm@mail.bwidawsk.net>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
 <20210202005948.241655-22-ben.widawsky@intel.com>
 <ec610f0d-4719-43fd-9293-e5a18e00a7d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec610f0d-4719-43fd-9293-e5a18e00a7d3@redhat.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-02-02 08:26:14, Eric Blake wrote:
> On 2/1/21 6:59 PM, Ben Widawsky wrote:
> > A CXL memory device (AKA Type 3) is a CXL component that contains some
> > combination of volatile and persistent memory. It also implements the
> > previously defined mailbox interface as well as the memory device
> > firmware interface.
> > 
> > Although the memory device is configured like a normal PCIe device, the
> > memory traffic is on an entirely separate bus conceptually (using the
> > same physical wires as PCIe, but different protocol).
> > 
> > The guest physical address for the memory device is part of a larger
> > window which is owned by the platform. Currently, this is hardcoded as
> > an object property on host bridge (PXB) creation, but that will need to
> > change for interleaving.
> > 
> > The following example will create a 256M device in a 512M window:
> > -object "memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M"
> > -device "cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M"
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> 
> > +++ b/qapi/machine.json
> > @@ -1394,6 +1394,7 @@
> >  { 'union': 'MemoryDeviceInfo',
> >    'data': { 'dimm': 'PCDIMMDeviceInfo',
> >              'nvdimm': 'PCDIMMDeviceInfo',
> > +            'cxl': 'PCDIMMDeviceInfo',
> >              'virtio-pmem': 'VirtioPMEMDeviceInfo',
> >              'virtio-mem': 'VirtioMEMDeviceInfo'
> >            }
> 
> Missing documentation that 'cxl' was introduced in 6.0.  Also, is it
> worth keeping the branches of this union in lexicographic order?
> 

Sure.

As discussed on the list previously, I think more thought needs to be put in
here, and I could really use some input.

A CXL type3 memory device can have both persistent and volatile capacity. As
such a single PCDIMMDeviceInfo I believe is insufficient. The current code
supports persistent memory only, so this is fine for now.

I'd guess my best bet is to create a new CXLType3DeviceInfo, but I'm not
entirely sure of all the implications that has.

Any advice?

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 
> 
