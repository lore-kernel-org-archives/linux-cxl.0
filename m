Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F334C43219
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Nov 2022 14:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiKKOip (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 09:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiKKOik (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 09:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147155BD65
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 06:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668177454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tw7WXiynU+Ey4ACbtr/TnLshynxlREc4cADZXwl+AQ8=;
        b=Fbn7NHn0L8/dP3Sv0h7SB6mpTrR8SW0DPDnFaLQvygrUvHwOLjOdv8pfNMYl9z+xyt4OBP
        GN7xi05/NOg4Y6gfNyafrh+mR9PlYlD9bcNaZFUschurVFjXa3NRKQ3ZXpI9g0K8BAM+PF
        O59QYvObPNTOCZUB3KyloITAGbiHM50=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-cPeDr061OZS3HH3aHtypnw-1; Fri, 11 Nov 2022 09:37:31 -0500
X-MC-Unique: cPeDr061OZS3HH3aHtypnw-1
Received: by mail-wm1-f69.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso2642565wms.5
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 06:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw7WXiynU+Ey4ACbtr/TnLshynxlREc4cADZXwl+AQ8=;
        b=sYo+pT5F+p4okmYXJ/hDWjhWlC+1RKYmn/yV7WMkxvR+Pki06fhsEm1gXQC8SmGx3E
         7DOVm/7UvrMBtQLYDQZcHb1cGMwtv/Yu4FFEpM3MMm2iRAJ3LT9ie6SfBsOy2OkB5gTp
         zwLYBSO/hqjDiZK3zgJX/jbbVMEX4fxPCdcpbSV6k8mHeFcPculQUhL8ita5WcL4m2yy
         P1F2uSCyrRmuKCs1g9MkdXGn+g8XEbHqo6vO6L+Ra0nP+8uJzGZr0yWHDNRFGE2MKw8w
         Qv5w+1V1bWjqWvU/3KNTMJ1MlHt9H02jPzNMKXVzBTfqvzQVvA5kuEkl/Mh42yIFTfBq
         1zDA==
X-Gm-Message-State: ANoB5pmi65ByApfX3TdX7ehkpIYcaTO1eyxRsx6TA8GexXH/ol2yas6R
        ygHOrW/ZhO+UGLoc/mwcwxd8OHo3nGiiwkJZ4T5zt1N2/xqI6hoK6lmXmhKKyoE5U+aTQYc/Hom
        aDJWE1w9vQsYDNRdNHssw
X-Received: by 2002:a05:600c:2306:b0:3cf:6a83:c7a3 with SMTP id 6-20020a05600c230600b003cf6a83c7a3mr1391621wmo.21.1668177449932;
        Fri, 11 Nov 2022 06:37:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6JcU8GAHalNdLwNufHYrKG7VEnJSyZcKpQH47nBRm7uGkbhRhYG18oyNMWzGusRboh9xrh0g==
X-Received: by 2002:a05:600c:2306:b0:3cf:6a83:c7a3 with SMTP id 6-20020a05600c230600b003cf6a83c7a3mr1391608wmo.21.1668177449669;
        Fri, 11 Nov 2022 06:37:29 -0800 (PST)
Received: from redhat.com ([2.52.3.250])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm11673796wmo.27.2022.11.11.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:37:29 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:37:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
        Gregory Price <gourry.memverge@gmail.com>,
        qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com,
        jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [BUG] hw/i386/pc.c: CXL Fixed Memory Window should not reserve
 e820 in bios
Message-ID: <20221111093704-mutt-send-email-mst@kernel.org>
References: <20221017234001.53297-1-gregory.price@memverge.com>
 <CAARzgwxEO5rr=b_QjiG7RoEdV=9yOgj9gxUxNvuaUnNtUEnhtw@mail.gmail.com>
 <CAD3UvdTWLXf_OecWbtP9wfAvO2+xdWiAUjQHONrgB4AAAjwdHQ@mail.gmail.com>
 <CAARzgwyCTaNoiqtVPS394Nk9LAS05116Dvc2GxifHpO01+ZN4g@mail.gmail.com>
 <20221108112111.czqldmb7wemhqy6f@sirius.home.kraxel.org>
 <20221111115123.2f9bc8b6@imammedo.users.ipa.redhat.com>
 <20221111114059.4eilz452nmfttp3a@sirius.home.kraxel.org>
 <20221111142411.41220086@imammedo.users.ipa.redhat.com>
 <20221111133602.6ixmvy7tu3whg422@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20221111133602.6ixmvy7tu3whg422@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Nov 11, 2022 at 02:36:02PM +0100, Gerd Hoffmann wrote:
> >     if (pcmc->has_reserved_memory && machine->device_memory->base) {             
> > [...]
> >                                                              
> >         if (pcms->cxl_devices_state.is_enabled) {                                
> >             res_mem_end = cxl_resv_end;
> > 
> > that should be handled by this line
> > 
> >         }                                   
> >                                      
> >         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));                      
> >         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));   
> >     }  
> > 
> > so SeaBIOS shouldn't intrude into CXL address space
> 
> Yes, looks good, so with this in place already everyting should be fine.
> 
> > (I assume EDK2 behave similarly here)
> 
> Correct, ovmf reads that fw_cfg file too.
> 
> > > I suspect the reason for these entries to exist in the first place is to
> > > inform the firmware that it should not place stuff there, and if we
> >        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > just to educate me, can you point out what SeaBIOS code does with reservations.
> 
> They are added to the e820 map which gets passed on to the OS.  seabios
> uses (and updateas) the e820 map too, when allocating memory for
> example.  While thinking about it I'm not fully sure it actually looks
> at reservations, maybe it only uses (and updates) ram entries when
> allocating memory.
> 
> > > remove that to conform with the spec we need some alternative way for
> > > that ...
> > 
> > with etc/reserved-memory-end set as above,
> > is E820_RESERVED really needed here?
> 
> No.  Setting etc/reserved-memory-end is enough.
> 
> So for the original patch:
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> take care,
>   Gerd

It's upstream already, sorry I can't add your tag.

-- 
MST

