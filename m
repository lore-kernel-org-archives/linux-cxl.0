Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787CCC05027
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 09:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjAWJou (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 04:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjAWJor (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 04:44:47 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8BD3587
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 01:44:45 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0lTP36ZBz6J7dX;
        Mon, 23 Jan 2023 17:40:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 09:44:43 +0000
Date:   Mon, 23 Jan 2023 09:44:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>,
        Lukas Wunner <lukas@wunner.de>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: Re: cxl nvdimm Potential probe ordering issues.
Message-ID: <20230123094444.00006bd3@Huawei.com>
In-Reply-To: <63cb1881b078a_3a36e5294ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230113144026.000001fb@Huawei.com>
        <20230113144511.00001207@Huawei.com>
        <20230113151206.GA20583@wunner.de>
        <Y8hG4OyJL7l9oD2f@memverge.com>
        <Y8hJKcy1993SFLLJ@memverge.com>
        <20230119124244.000015b3@Huawei.com>
        <20230119150449.000037f2@huawei.com>
        <Y8oeYfyqNuSIIxCt@memverge.com>
        <63cad185343a1_c81f029469@dwillia2-xfh.jf.intel.com.notmuch>
        <Y8sNfC1YQVj/DfBU@memverge.com>
        <63cb1881b078a_3a36e5294ab@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 20 Jan 2023 14:41:05 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Gregory Price wrote:
> > On Fri, Jan 20, 2023 at 09:38:13AM -0800, Dan Williams wrote:  
> > > As it stands currently that dax device and the cxl device are not
> > > related since a default dax-device is loaded just based on the presence
> > > of an EFI_MEMORY_SP address range in the address map. With the new ram
> > > enabling that default device will be elided and CXL will register a
> > > dax-device parented by a cxl region.
> > >   
> > > > 	 - The memory *does not* auto-online, instead the dax device can be
> > > > 	   onlined as system-ram *manually* via ndctl and friends  
> > > 
> > > That *manually* part is the problem that needs distro help to solve. It
> > > should be the case that by default all Linux distributions auto-online
> > > all dax-devices. If that happens to online memory that is too slow for
> > > general use, or too high-performance / precious for general purpose use
> > > then the administrator can set policy after the fact. Unfortunately user
> > > policy can not be applied if these memory ranges were onlined by the
> > > kernel at boot , so that's why the kernel policy defaults to not-online.
> > > 
> > > In other words, there is no guarantee that memory that was assigned to
> > > the general purpose pool at boot can be removed. The only guaranteed
> > > behavior is to never give the memory to the core kernel in the first
> > > instance and always let user policy route the memory.
> > >   
> > > > 3) The code creates an nvdimm_bridge IFF a CFMW is defined - regardless
> > > >    of the type-3 device configuration (pmem-only or vmem-only)  
> > > 
> > > Correct, the top-level bus code (cxl_acpi) and the endpoint code
> > > (cxl_mem, cxl_port) need to handshake before establishing regions. For
> > > pmem regions the platform needs to claim the availability of a pmem
> > > capable CXL window.
> > >   
> > > > 4) As you can see above, multiple decoders are registered.  I'm not sure
> > > >    if that's correct or not, but it does seem odd given there's only one
> > > > 	 cxl type-3 device.  Odd that decoder0.0 shows up when CFMW is there,
> > > > 	 but not when it isn't.  
> > > 
> > > CXL windows are modeled as decoders hanging off the the CXL root device
> > > (ACPI0017 on ACPI based platforms). An endpoint decoder can then map a
> > > selection of that window.
> > >   
> > > > Don't know why I haven't thought of this until now, but is the CFMW code
> > > > reporting something odd about what's behind it?  Is it assuming the
> > > > devices are pmem?  
> > > 
> > > No, the cxl_acpi code is just advertising platform decode possibilities
> > > independent of what devices show up. Think of this like the PCI MMIO
> > > space that gets allocated to a root bridge at the beginning of time.
> > > That space may or may not get consumed based on what devices show up
> > > downstream.  
> > 
> > Thank you for the explanation Dan, and thank you for you patience
> > @JCameron.  I'm fairly sure I grok it now.
> > 
> > Summarizing to make sure: the cxl driver is providing what would be the
> > CXL.io (control) path, and the CXL.mem path is basically being simulated
> > by what otherwise would be a traditional PCI memory region. This explains
> > why turning off Legacy mode drops the dax devices, and why the topology
> > looks strange - the devices are basically attached in 2 different ways.
> > 
> > Might there be interest from the QEMU community to implement this
> > legacy-style setup in the short term, in an effort to test the the
> > control path of type-3 devices while we wait for the kernel to catch up?

I'd happily review such code, but it's not on my list of things to work on
otherwise. Too many other things to support!

Jonathan

> > 
> > Or should we forget this mode ever existed and just barrel forward
> > with HDM decoders and writing the kernel code to hook up the underlying
> > devices in drivers/cxl?  
> 
> Which mode are you referring?
> 
> The next steps for the kernel enabling relevant to this thread are:
> 
> * ram region discovery (platform firmware or kexec established)
> * ram region creation
> * pmem region discovery (from labels)

