Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B1EC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJJQct (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJJQcr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 12:32:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1346BCEB
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 09:32:45 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmPZX1t35z682sD;
        Tue, 11 Oct 2022 00:32:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 10 Oct 2022 18:32:43 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 10 Oct
 2022 17:32:43 +0100
Date:   Mon, 10 Oct 2022 17:32:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221010173242.000032a8@huawei.com>
In-Reply-To: <20221010154343.00007afd@huawei.com>
References: <20221006000103.49542-1-gregory.price@memverge.com>
        <20221006094557.000035ab@huawei.com>
        <20221006095007.00001271@huawei.com>
        <Yz75ppPOwYCvNamy@fedora>
        <20221006174214.000059c7@huawei.com>
        <Yz8QlQ9yLFrWxWsN@fedora>
        <20221010154343.00007afd@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


> > but i'm not sure of what to do with this info.  We have some proof
> > that real hardware works with this no problem, and the only difference
> > is that the EFI/bios/firmware is setting the memory regions as `usable`
> > or `soft reserved`, which would imply the EDK2 is the blocker here
> > regardless of the OS driver status.
> > 
> > But I'd seen elsewhere you had gotten some of this working, and I'm
> > failing to get anything working at the moment.  If you have any input i
> > would greatly appreciate the help.
> > 
> > QEMU config:
> > 
> > /opt/qemu-cxl2/bin/qemu-system-x86_64 \
> > -drive file=/var/lib/libvirt/images/cxl.qcow2,format=qcow2,index=0,media=d\
> > -m 2G,slots=4,maxmem=4G \
> > -smp 4 \
> > -machine type=q35,accel=kvm,cxl=on \
> > -enable-kvm \
> > -nographic \
> > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 \
> > -object memory-backend-file,id=cxl-mem0,mem-path=/tmp/cxl-mem0,size=256M \
> > -object memory-backend-file,id=lsa0,mem-path=/tmp/cxl-lsa0,size=256M \
> > -device cxl-type3,bus=rp0,pmem=true,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 \
> > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=256M
> > 
> > I'd seen on the lists that you had seen issues with single-rp setups,
> > but no combination of configuration I've tried (including all the ones
> > in the docs and tests) lead to a successful region creation with
> > `cxl create-region`  
> 
> Hmm. Let me have a play.  I've not run x86 tests for a while so
> perhaps something is missing there.
> 
> I'm carrying a patch to override check_last_peer() in
> cxl_port_setup_targets() as that is wrong for some combinations,
> but that doesn't look like it's related to what you are seeing.

I'm not sure if it's relevant, but turned out I'd forgotten I'm carrying 3
patches that aren't upstream (and one is a horrible hack).

Hack: https://lore.kernel.org/linux-cxl/20220819094655.000005ed@huawei.com/
Shouldn't affect a simple case like this...

https://lore.kernel.org/linux-cxl/20220819093133.00006c22@huawei.com/T/#t
(Dan's version)

https://lore.kernel.org/linux-cxl/20220815154044.24733-1-Jonathan.Cameron@huawei.com/T/#t

For writes to work you will currently need two rps (nothing on the second is fine)
as we still haven't resolved if the kernel should support an HDM decoder on
a host bridge with one port.  I think it should (Spec allows it), others unconvinced.

Note I haven't shifted over to x86 yet so may still be something different from
arm64.

Jonathan


> 
> >   
> > > > 
> > > > 3) Upstream linux drivers haven't touched ram configurations yet.  I
> > > > just configured this with Dan Williams yesterday on IRC.  My
> > > > understanding is that it's been worked on but nothing has been
> > > > upstreamed, in part because there are only a very small set of devices
> > > > available to developers at the moment.    
> > > 
> > > There was an offer of similar volatile memory QEMU emulation in the
> > > session on QEMU CXL at Linux Plumbers.  That will look something like you have
> > > here and maybe reflects that someone has hardware as well...
> > >     
> > 
> > I saw that, and I figured I'd start the conversation by pushing
> > something :].  
> 
> 

