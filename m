Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E0C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Nov 2022 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKNZR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 08:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKNZR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 08:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6B960F3
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 05:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668173058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FN4llIktQruR8o/mA9ahMl88xicscCFTQ41w0NbxnSI=;
        b=RfHajMZMXOeQA8fQxHh/y0ad4JC/DPm7GvfRkqq9Gd7/RGQFDUnhsddAlJ4RU5Iol/lQPu
        eFDEk8Uxg/brl5XPtBcfkgyccmC803NQE+jWntga5SehYK23ijldTe0pvWFjbCsdIya8bx
        GtZbchvM6k9P8ooBSFrp+2jMyT3LFoc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-fNkWNGwZOk-ziP38wcjvgA-1; Fri, 11 Nov 2022 08:24:17 -0500
X-MC-Unique: fNkWNGwZOk-ziP38wcjvgA-1
Received: by mail-qv1-f72.google.com with SMTP id mi12-20020a056214558c00b004bb63393567so3674041qvb.21
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 05:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN4llIktQruR8o/mA9ahMl88xicscCFTQ41w0NbxnSI=;
        b=MXHUo4RsMSVOLQ8sk0mle42EE66f+jkALdAGZcxOKi3afxek6o2/lLNAN12OTPE2hB
         qRjIkkeotDkEd6DTf/W4SZy99N11GFCXEzbCMoSOX2bl2PntJZSnu3CIJClAY9JRDWGa
         +l0rfiQsGDOx6q6jf5DdD/sEAvp0CPOvpNg5uKg0N35XsNKWb1TqU/hYSAjHUkb2qtpC
         5E21qtYFVz9/zH8sBeMlRmTNah7N+oyXaFfBOqjrKVblA7uPNrhkXRrmkstyupXq0MQ+
         aRnd+c1Q5hoVEm3cll5y50munBYUgRLT4YTtEV46HIBKDfzOHL9qbWeYP+H1U1G7mu1J
         s/9w==
X-Gm-Message-State: ANoB5pmSIVrgSh0BJUbnbAJSWF7oy1JA/FhSkaI0ajHQD4evv0bSJh0Z
        AZR8Vf5swoykf8miL9kLcqbhCyilQcT3der/nxBRFs6T+FEBPrZR/6ImECGmIiy8ZaCPQk4G3Nw
        TWg75aeAMpALNhSH/ZeSt
X-Received: by 2002:a05:622a:114b:b0:3a5:8185:5b1b with SMTP id f11-20020a05622a114b00b003a581855b1bmr1182823qty.319.1668173057019;
        Fri, 11 Nov 2022 05:24:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4VzuAFrUl814CjbaS2CvkYSRC10AyorTm5jDhZus4p9FTIuTBecIKjL75sptJ4lREPts/a6A==
X-Received: by 2002:a05:622a:114b:b0:3a5:8185:5b1b with SMTP id f11-20020a05622a114b00b003a581855b1bmr1182809qty.319.1668173056800;
        Fri, 11 Nov 2022 05:24:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b006f3e6933bacsm1345238qkb.113.2022.11.11.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 05:24:15 -0800 (PST)
Date:   Fri, 11 Nov 2022 14:24:11 +0100
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
Message-ID: <20221111142411.41220086@imammedo.users.ipa.redhat.com>
In-Reply-To: <20221111114059.4eilz452nmfttp3a@sirius.home.kraxel.org>
References: <20221017234001.53297-1-gregory.price@memverge.com>
        <CAARzgwxEO5rr=b_QjiG7RoEdV=9yOgj9gxUxNvuaUnNtUEnhtw@mail.gmail.com>
        <CAD3UvdTWLXf_OecWbtP9wfAvO2+xdWiAUjQHONrgB4AAAjwdHQ@mail.gmail.com>
        <CAARzgwyCTaNoiqtVPS394Nk9LAS05116Dvc2GxifHpO01+ZN4g@mail.gmail.com>
        <20221108112111.czqldmb7wemhqy6f@sirius.home.kraxel.org>
        <20221111115123.2f9bc8b6@imammedo.users.ipa.redhat.com>
        <20221111114059.4eilz452nmfttp3a@sirius.home.kraxel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 11 Nov 2022 12:40:59 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Fri, Nov 11, 2022 at 11:51:23AM +0100, Igor Mammedov wrote:
> > On Tue, 8 Nov 2022 12:21:11 +0100
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   
> > > > >> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > >> > index 566accf7e6..5bf5465a21 100644
> > > > >> > --- a/hw/i386/pc.c
> > > > >> > +++ b/hw/i386/pc.c
> > > > >> > @@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
> > > > >> >          hwaddr cxl_size = MiB;
> > > > >> >
> > > > >> >          cxl_base = pc_get_cxl_range_start(pcms);
> > > > >> > -        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);    
> > > 
> > > Just dropping it doesn't look like a good plan to me.
> > > 
> > > You can try set etc/reserved-memory-end fw_cfg file instead.  Firmware
> > > (both seabios and ovmf) read it and will make sure the 64bit pci mmio
> > > window is placed above that address, i.e. this effectively reserves
> > > address space.  Right now used by memory hotplug code, but should work
> > > for cxl too I think (disclaimer: don't know much about cxl ...).  
> > 
> > As far as I know CXL impl. in QEMU isn't using etc/reserved-memory-end
> > at all, it' has its own mapping.  
> 
> This should be changed.  cxl should make sure the highest address used
> is stored in etc/reserved-memory-end to avoid the firmware mapping pci
> resources there.

    if (pcmc->has_reserved_memory && machine->device_memory->base) {             
[...]
                                                             
        if (pcms->cxl_devices_state.is_enabled) {                                
            res_mem_end = cxl_resv_end;

that should be handled by this line

        }                                   
                                     
        *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));                      
        fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));   
    }  

so SeaBIOS shouldn't intrude into CXL address space
(I assume EDK2 behave similarly here)
 
> > so dropping reserved entries looks reasonable from ACPI spec point of view.  
> 
> Yep, I don't want dispute that.
> 
> I suspect the reason for these entries to exist in the first place is to
> inform the firmware that it should not place stuff there, and if we
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
just to educate me, can you point out what SeaBIOS code does with reservations.

> remove that to conform with the spec we need some alternative way for
> that ...

with etc/reserved-memory-end set as above,
is E820_RESERVED really needed here?

(my understanding was that E820_RESERVED weren't accounted for when
initializing PCI devices)

> 
> take care,
>   Gerd
> 

