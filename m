Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F0C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Nov 2022 11:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiKKLmI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 06:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiKKLmE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 06:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA2293
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 03:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668166869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9P33Lb0iU84UTybmXZXoPx12qD5/ZrGzTqvAcsTF6pY=;
        b=QwC7vjjHACpu4rM3XkNke1ejR3ARS2RtbCW3siJEg7GcExLHWJX5Auax0UowDGFIQ48iM5
        /1qsvAEtYBwg441nBILi/7MmFQOtb3a9cVn9xPQqqoizwxux/3CF/psI+xihIsEnzxtIGX
        8++NwG3QFGyUaeZXkYj4P7FCnRbfdeg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-qObetTASNCajATkBlEyWKg-1; Fri, 11 Nov 2022 06:41:05 -0500
X-MC-Unique: qObetTASNCajATkBlEyWKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49E26101A52A;
        Fri, 11 Nov 2022 11:41:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A73440CA40C;
        Fri, 11 Nov 2022 11:41:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C9F1B18003BA; Fri, 11 Nov 2022 12:40:59 +0100 (CET)
Date:   Fri, 11 Nov 2022 12:40:59 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Ani Sinha <ani@anisinha.ca>,
        Gregory Price <gourry.memverge@gmail.com>,
        qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
        jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [BUG] hw/i386/pc.c: CXL Fixed Memory Window should not reserve
 e820 in bios
Message-ID: <20221111114059.4eilz452nmfttp3a@sirius.home.kraxel.org>
References: <20221017234001.53297-1-gregory.price@memverge.com>
 <CAARzgwxEO5rr=b_QjiG7RoEdV=9yOgj9gxUxNvuaUnNtUEnhtw@mail.gmail.com>
 <CAD3UvdTWLXf_OecWbtP9wfAvO2+xdWiAUjQHONrgB4AAAjwdHQ@mail.gmail.com>
 <CAARzgwyCTaNoiqtVPS394Nk9LAS05116Dvc2GxifHpO01+ZN4g@mail.gmail.com>
 <20221108112111.czqldmb7wemhqy6f@sirius.home.kraxel.org>
 <20221111115123.2f9bc8b6@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111115123.2f9bc8b6@imammedo.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Nov 11, 2022 at 11:51:23AM +0100, Igor Mammedov wrote:
> On Tue, 8 Nov 2022 12:21:11 +0100
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > > >> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > >> > index 566accf7e6..5bf5465a21 100644
> > > >> > --- a/hw/i386/pc.c
> > > >> > +++ b/hw/i386/pc.c
> > > >> > @@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
> > > >> >          hwaddr cxl_size = MiB;
> > > >> >
> > > >> >          cxl_base = pc_get_cxl_range_start(pcms);
> > > >> > -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);  
> > 
> > Just dropping it doesn't look like a good plan to me.
> > 
> > You can try set etc/reserved-memory-end fw_cfg file instead.  Firmware
> > (both seabios and ovmf) read it and will make sure the 64bit pci mmio
> > window is placed above that address, i.e. this effectively reserves
> > address space.  Right now used by memory hotplug code, but should work
> > for cxl too I think (disclaimer: don't know much about cxl ...).
> 
> As far as I know CXL impl. in QEMU isn't using etc/reserved-memory-end
> at all, it' has its own mapping.

This should be changed.  cxl should make sure the highest address used
is stored in etc/reserved-memory-end to avoid the firmware mapping pci
resources there.

> so dropping reserved entries looks reasonable from ACPI spec point of view.

Yep, I don't want dispute that.

I suspect the reason for these entries to exist in the first place is to
inform the firmware that it should not place stuff there, and if we
remove that to conform with the spec we need some alternative way for
that ...

take care,
  Gerd

