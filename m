Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DA5C4321E
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Nov 2022 12:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiK2Mwf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiK2Mwf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Nov 2022 07:52:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6182B3
        for <linux-cxl@vger.kernel.org>; Tue, 29 Nov 2022 04:52:32 -0800 (PST)
Received: from frapeml100005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NM2Kj1zs8z67Wb2;
        Tue, 29 Nov 2022 20:52:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 13:52:30 +0100
Received: from localhost (10.45.149.100) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 12:52:29 +0000
Date:   Tue, 29 Nov 2022 12:52:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <terry.bowman@amd.com>, <bhelgaas@google.com>,
        <dave.jiang@intel.com>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 11/12] tools/testing/cxl: Add an RCH topology
Message-ID: <20221129125226.00004b33@Huawei.com>
In-Reply-To: <6385392d6bd_3cbe02945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <166931487492.2104015.15204324083515120776.stgit@dwillia2-xfh.jf.intel.com>
        <166931493816.2104015.8749844490243672146.stgit@dwillia2-xfh.jf.intel.com>
        <Y4ULS+UsNiEeD97l@aschofie-mobl2>
        <6385392d6bd_3cbe02945b@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.100]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 28 Nov 2022 14:41:49 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Alison Schofield wrote:
> > On Thu, Nov 24, 2022 at 10:35:38AM -0800, Dan Williams wrote:  
> > > In an RCH topology a CXL host-bridge as Root Complex Integrated Endpoint
> > > the represents the memory expander. Unlike a VH topology there is no
> > > CXL/PCIE Root Port that host the endpoint. The CXL subsystem maps this
> > > as the CXL root object (ACPI0017 on ACPI based systems) targeting the
> > > host-bridge as a dport, per usual, but then that dport directly hosts
> > > the endpoint port.
> > > 
> > > Mock up that configuration with a 4th host-bridge that has a 'cxl_rcd'
> > > device instance as its immediate child.
> > >   
> > 
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > How can this host bridge and device be used?  
> 
> Answering the direct question... it's not good for much more than
> testing enumeration. The expectation is that RCH hosts will be
> configured by BIOS and most likely Linux driver only ever needs to read
> the configuration, not change it.  So most of the excitement from a
> cxl_test perspective is in the enumeration. The rest of the RCH enabling
> will be for error handling for errors that impact regions set up by
> BIOS. That testing will need hardware, or QEMU, but I do not expect RCH
> topologies to show up in QEMU any time soon, if ever.

I wasn't planning on QEMU support, but if someone wants to do it I'll be
happy to review!  Patches welcome etc.  As Dan says, it'll be a job for BIOS
configuration and so far we don't have a suitable BIOS to run against
the QEMU emulation - there is code for ARM's own models (FVP) as talked about
at Plumbers CXL UConf, but I don't know of anyone looking at getting that
up and running on top of QEMU yet.  That would be best done first on CXL 2.0+
but once it is place, a full setup for RCH would be possible.

Given there is hardware and new features aren't going to be built on RCH
topologies, I'd guess no one will care enough to write QEMU emulation
any time soon.

Jonathan
