Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D886C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Nov 2022 10:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiKKKwn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 05:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiKKKw1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 05:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451263174
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668163889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6qOicsVWEFuMRUDI3g87ppm3RRuKfipWDoA7+vDt8k=;
        b=SoMFreVyB/tYyeY3zasmE8HdamktfodxL/zMdjAScAcHV6lNX++upSohApt+02kwWycoyE
        59hfyqtwqvGN6Qf1MrIovtCQIVBIVYdPnlu5FTyfGIXorHvGvkHERckiW7YBUlCUjWNOVO
        Jtk4n9DSdWvmqTm/10ulHVMk1yCJO6o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-KmDL1okKOPGkoIH9AMvwjQ-1; Fri, 11 Nov 2022 05:51:28 -0500
X-MC-Unique: KmDL1okKOPGkoIH9AMvwjQ-1
Received: by mail-qv1-f70.google.com with SMTP id do17-20020a056214097100b004c6183e6ce4so1651969qvb.11
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 02:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6qOicsVWEFuMRUDI3g87ppm3RRuKfipWDoA7+vDt8k=;
        b=2znvxxsGEM2SYpuzDCRj+SRmPo7iq0WoShesn9SiTX354yu8mPHok+NPg3LPcDHzmW
         cdOOoB4+a5WZN8h2wuTchx4wrSTtVTvBo2toG4fwgcFCZFjJ4jDOTVvJlZiKlxVxAlpl
         Ydzp4dad/pQphXNE/DAL8q079JPMKTpK5sqvl95fSahH2TEEO+nILhpJoi4Ey1IM+Acc
         MJWplWMS9JLLIiC+knpuQnbt///rL5khZo74vDFRsgK5/YT0Otl7cwfxOzz/oGFyBQWF
         YB9Z7zLtcnRlDCf7RIm0hEi+cB+OnU+AwWO6i9C2zRbsJw81qu1m1BLFKhz2EZ5yvaS8
         SKJA==
X-Gm-Message-State: ANoB5pn4MeHBFKemjw6lRF85SnHW/2WZ+AjTe3kRTdKJOtQbae26mrt3
        wU5lxOI2dDS0CETEs5ItobniylaVQY8q2BVf/53pF1YKRIW8asC3oc6oK8u2WlFJtMmEqNdBF8B
        i55wlUgylS7fm7AN9bP7W
X-Received: by 2002:a05:6214:5c83:b0:4bb:781e:6231 with SMTP id lj3-20020a0562145c8300b004bb781e6231mr1297930qvb.106.1668163887498;
        Fri, 11 Nov 2022 02:51:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7JtwSKvEgmfA00qHUBJi5YLLzr+MU/yo/aCIkxuuCIwJv8syhvMKtrnG8vgid+Cmdz0jMaxw==
X-Received: by 2002:a05:6214:5c83:b0:4bb:781e:6231 with SMTP id lj3-20020a0562145c8300b004bb781e6231mr1297920qvb.106.1668163887120;
        Fri, 11 Nov 2022 02:51:27 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a14-20020ac8108e000000b003a57004313fsm1097259qtj.3.2022.11.11.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:51:26 -0800 (PST)
Date:   Fri, 11 Nov 2022 11:51:23 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
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
Message-ID: <20221111115123.2f9bc8b6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20221108112111.czqldmb7wemhqy6f@sirius.home.kraxel.org>
References: <20221017234001.53297-1-gregory.price@memverge.com>
        <CAARzgwxEO5rr=b_QjiG7RoEdV=9yOgj9gxUxNvuaUnNtUEnhtw@mail.gmail.com>
        <CAD3UvdTWLXf_OecWbtP9wfAvO2+xdWiAUjQHONrgB4AAAjwdHQ@mail.gmail.com>
        <CAARzgwyCTaNoiqtVPS394Nk9LAS05116Dvc2GxifHpO01+ZN4g@mail.gmail.com>
        <20221108112111.czqldmb7wemhqy6f@sirius.home.kraxel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 8 Nov 2022 12:21:11 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> > >> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > >> > index 566accf7e6..5bf5465a21 100644
> > >> > --- a/hw/i386/pc.c
> > >> > +++ b/hw/i386/pc.c
> > >> > @@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
> > >> >          hwaddr cxl_size = MiB;
> > >> >
> > >> >          cxl_base = pc_get_cxl_range_start(pcms);
> > >> > -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);  
> 
> Just dropping it doesn't look like a good plan to me.
> 
> You can try set etc/reserved-memory-end fw_cfg file instead.  Firmware
> (both seabios and ovmf) read it and will make sure the 64bit pci mmio
> window is placed above that address, i.e. this effectively reserves
> address space.  Right now used by memory hotplug code, but should work
> for cxl too I think (disclaimer: don't know much about cxl ...).

As far as I know CXL impl. in QEMU isn't using etc/reserved-memory-end
at all, it' has its own mapping.

Regardless of that, reserved E820 entries look wrong, and looking at
commit message OS is right to bailout on them (expected according
to ACPI spec).
Also spec says 

"
E820 Assumptions and Limitations
 [...]
 The platform boot firmware does not return a range description for the memory mapping of
 PCI devices, ISA Option ROMs, and ISA Plug and Play cards because the OS has mechanisms
 available to detect them.
"

so dropping reserved entries looks reasonable from ACPI spec point of view.
(disclaimer: don't know much about cxl ... either)
> 
> take care & HTH,
>   Gerd
> 

