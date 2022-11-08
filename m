Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B8C38A02
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 11:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiKHLWu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 06:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiKHLWW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 06:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A069A2AC71
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 03:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667906478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdG8gVIkeKrggwlBGyvY9bH0G2bxhUPyGAtUdi5JNiA=;
        b=ZciVMsYBaQ968UvfcPBBjJMbZrlj9q8SKLCQhH8EWXHzebM1JpcE+vMkjy2cuYvCighi7T
        kgv7xhu/4AKlBa6n0eGbfHHLohhXKpvVOK7E18MMDDQciZqjbO2JxHxy14P68CazelaflQ
        8OuXxUj37ikIFl8e2ACsV2rgfn4o6Vs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-l28ZxOxnNj6ef5QmPxcqZg-1; Tue, 08 Nov 2022 06:21:15 -0500
X-MC-Unique: l28ZxOxnNj6ef5QmPxcqZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52429381078B;
        Tue,  8 Nov 2022 11:21:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 058EC40C2064;
        Tue,  8 Nov 2022 11:21:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2AE02180039D; Tue,  8 Nov 2022 12:21:11 +0100 (CET)
Date:   Tue, 8 Nov 2022 12:21:11 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org,
        mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
        jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [BUG] hw/i386/pc.c: CXL Fixed Memory Window should not reserve
 e820 in bios
Message-ID: <20221108112111.czqldmb7wemhqy6f@sirius.home.kraxel.org>
References: <20221017234001.53297-1-gregory.price@memverge.com>
 <CAARzgwxEO5rr=b_QjiG7RoEdV=9yOgj9gxUxNvuaUnNtUEnhtw@mail.gmail.com>
 <CAD3UvdTWLXf_OecWbtP9wfAvO2+xdWiAUjQHONrgB4AAAjwdHQ@mail.gmail.com>
 <CAARzgwyCTaNoiqtVPS394Nk9LAS05116Dvc2GxifHpO01+ZN4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARzgwyCTaNoiqtVPS394Nk9LAS05116Dvc2GxifHpO01+ZN4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

> >> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> > index 566accf7e6..5bf5465a21 100644
> >> > --- a/hw/i386/pc.c
> >> > +++ b/hw/i386/pc.c
> >> > @@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
> >> >          hwaddr cxl_size = MiB;
> >> >
> >> >          cxl_base = pc_get_cxl_range_start(pcms);
> >> > -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);

Just dropping it doesn't look like a good plan to me.

You can try set etc/reserved-memory-end fw_cfg file instead.  Firmware
(both seabios and ovmf) read it and will make sure the 64bit pci mmio
window is placed above that address, i.e. this effectively reserves
address space.  Right now used by memory hotplug code, but should work
for cxl too I think (disclaimer: don't know much about cxl ...).

take care & HTH,
  Gerd

