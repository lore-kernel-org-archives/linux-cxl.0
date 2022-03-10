Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD73C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 08:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiCJIDv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiCJIDu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Mar 2022 03:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC8431A3AA
        for <linux-cxl@vger.kernel.org>; Thu, 10 Mar 2022 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646899367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHQkqG/wIvnaIy8dlKbpuqxJgIHBOIGbwn82iQdOzb8=;
        b=h7Rx5fO2HD6Is19Cq1ZDADELk44EBGREd35cUiVDF79lMqnkQc6BIVMum+2IqPhYZs+12m
        Az8MLMyxIkCI5Qfc5kmA8U4ortOSuFwLRzaiS8a84nDVgtZXMFgfr4bwyy7S338dA/B9gX
        l65obGa0e+KSma0Ws6yQHWJaPOYc0Hk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-uR3Lg_lyMgKRLwy5STCWyw-1; Thu, 10 Mar 2022 03:02:44 -0500
X-MC-Unique: uR3Lg_lyMgKRLwy5STCWyw-1
Received: by mail-pl1-f200.google.com with SMTP id z14-20020a170902ccce00b0014d7a559635so2329388ple.16
        for <linux-cxl@vger.kernel.org>; Thu, 10 Mar 2022 00:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHQkqG/wIvnaIy8dlKbpuqxJgIHBOIGbwn82iQdOzb8=;
        b=jL8uBn6Bipay5zpmPytCdQhA6VHSnf7oxp4G68zlafo/h6fQUGQVqGhKY5Ubqq+rbs
         R5IzWKpFBQIaRRYsJEbtLtAvPfBDtZMUGt3TxP6QYMD4KaTspXrGQKQwVuYWOFJ2Qjj/
         4JTDg90x+TgHpdqITOZPiEV+V8WMNU2X643VCc7+ZiFGRC7wKTGtL3dDe012irrR33Zm
         U29qnZEGswUnWrvgwzz8USXCMmqggMG4StBB3PCyjNzpJrUj/yW/jU3oIGPx1MzOBbGw
         ihIHvcsxbbL3g5i+jJoIc8Fxz2YBMtQZJrRVRAOV5rxg82nY3BLmBVjZcsAFnX8XSyDU
         dORQ==
X-Gm-Message-State: AOAM533yzlSQtjuQoSNfH4pcLFkBbgyWOtcsCPUyRchmlYPRaBcMIHgM
        gaKdINf9JvIz9qiQR4DHR/CUKk9X8QTdEr3ny8EfUvbgB3ASxyNechl9Ehetr29x1WKIPuCSmuk
        1W7o4wHta5ZQL4igv8ry6
X-Received: by 2002:a17:90b:e08:b0:1bc:2b0c:65aa with SMTP id ge8-20020a17090b0e0800b001bc2b0c65aamr3642992pjb.102.1646899363619;
        Thu, 10 Mar 2022 00:02:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhhS321NKRuTFxhcxzOnDLZveD8Q4iJYqDwwJ5O9pXPAIgl1NZVq8I0EtqZHO413E5Z/ihVg==
X-Received: by 2002:a17:90b:e08:b0:1bc:2b0c:65aa with SMTP id ge8-20020a17090b0e0800b001bc2b0c65aamr3642958pjb.102.1646899363195;
        Thu, 10 Mar 2022 00:02:43 -0800 (PST)
Received: from xz-m1.local ([64.64.123.101])
        by smtp.gmail.com with ESMTPSA id 9-20020a621909000000b004f6f40195f8sm5486470pfz.133.2022.03.10.00.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 00:02:42 -0800 (PST)
Date:   Thu, 10 Mar 2022 16:02:22 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Ben Widawsky <ben.widawsky@intel.com>, qemu-devel@nongnu.org,
        Samarth Saxena <samarths@cadence.com>,
        Chris Browy <cbrowy@avery-design.com>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v7 00/46] CXl 2.0 emulation Support
Message-ID: <Yimwjtd8SsVLOU5e@xz-m1.local>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
 <20220306163119-mutt-send-email-mst@kernel.org>
 <20220307093918.00002f20@Huawei.com>
 <YihiHNxVjDFI0Z8r@xz-m1.local>
 <20220309112827.00002c73@Huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220309112827.00002c73@Huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 09, 2022 at 11:28:27AM +0000, Jonathan Cameron wrote:
> Hi Peter,

Hi, Jonathan,

> 
> > 
> > https://lore.kernel.org/qemu-devel/20220306174137.5707-35-Jonathan.Cameron@huawei.com/
> > 
> > Having mr->ops set but with memory_access_is_direct() returning true sounds
> > weird to me.
> > 
> > Sorry to have no understanding of the whole picture, but.. could you share
> > more on what's the interleaving requirement on the proxying, and why it
> > can't be done with adding some IO memory regions as sub-regions upon the
> > file one?
> 
> The proxying requirement is simply a means to read/write to a computed address
> within a memory region. There may well be a better way to do that.
> 
> If I understand your suggestion correctly you would need a very high
> number of IO memory regions to be created dynamically when particular sets of
> registers across multiple devices in the topology are all programmed.
> 
> The interleave can be 256 bytes across up to 16x, many terabyte, devices.
> So assuming a simple set of 16 1TB devices I think you'd need about 4x10^9
> IO regions.  Even for a minimal useful test case of largest interleave
> set of 16x 256MB devices (256MB is minimum size the specification allows per
> decoded region at the device) and 16 way interleave we'd need 10^6 IO regions.
> Any idea if that approach would scale sensibly to this number of regions?
> 
> There are also complexities to getting all the information in one place to
> work out which IO memory regions maps where in PA space. Current solution is
> to do that mapping in the same way the hardware does which is hierarchical,
> so we walk the path to the device, picking directions based on each interleave
> decoder that we meet.
> Obviously this is a bit slow but I only really care about correctness at the
> moment.  I can think of various approaches to speeding it up but I'm not sure
> if we will ever care about performance.
> 
> https://gitlab.com/jic23/qemu/-/blob/cxl-v7-draft-2-for-test/hw/cxl/cxl-host.c#L131
> has the logic for that and as you can see it's fairly simple because we are always
> going down the topology following the decoders.
> 
> Below I have mapped out an algorithm I think would work for doing it with
> IO memory regions as subregions.
> 
> We could fake the whole thing by limiting ourselves to small host
> memory windows which are always directly backed, but then I wouldn't
> achieve the main aim of this which is to provide a test base for the OS code.
> To do that I need real interleave so I can seed the files with test patterns
> and verify the accesses hit the correct locations. Emulating what the hardware
> is actually doing on a device by device basis is the easiest way I have
> come up with to do that.
> 
> Let me try to provide some more background so you hopefully don't have
> to have read the specs to follow what is going on!
> There are an example for directly connected (no switches) topology in the
> docs
> 
> https://gitlab.com/jic23/qemu/-/blob/cxl-v7-draft-2-for-test/docs/system/devices/cxl.rst
> 
> The overall picture is we have a large number of CXL Type 3 memory devices,
> which at runtime (by OS at boot/on hotplug) are configured into various
> interleaving sets with hierarchical decoding at the host + host bridge
> + switch levels. For test setups I probably need to go to around 32 devices
> so I can hit various configurations simultaneously.
> No individual device has visibility of the full interleave setup - hence
> the walk in the existing code through the various decoders to find the
> final Device Physical address.
> 
> At the host level the host provides a set of Physical Address windows with
> a fixed interleave decoding across the different host bridges in the system
> (CXL Fixed Memory windows, CFMWs)
> On a real system these have to be large enough to allow for any memory
> devices that might be hotplugged and all possible configurations (so
> with 2 host bridges you need at least 3 windows in the many TB range,
> much worse as the number of host bridges goes up). It'll be worse than
> this when we have QoS groups, but the current Qemu code just puts all
> the windows in group 0.  Hence my first thought of just putting memory
> behind those doesn't scale (a similar approach to this was in the
> earliest versions of this patch set - though the full access path
> wasn't wired up).
> 
> The granularity can be in powers of 2 from 256 bytes to 16 kbytes
> 
> Next each host bridge has programmable address decoders which take the
> incoming (often already interleaved) memory access and direct them to
> appropriate root ports.  The root ports can be connected to a switch
> which has additional address decoders in the upstream port to decide
> which downstream port to route to.  Note we currently only support 1 level
> of switches but it's easy to make this algorithm recursive to support
> multiple switch levels (currently the kernel proposals only support 1 level)
> 
> Finally the End Point with the actual memory receives the interleaved request and
> takes the full address and (for power of 2 decoding - we don't yet support
> 3,6 and 12 way which is more complex and there is no kernel support yet)
> it drops a few address bits and adds an offset for the decoder used to
> calculate it's own device physical address.  Note device will support
> multiple interleave sets for different parts of it's file once we add
> multiple decoder support (on the todo list).
> 
> So the current solution is straight forward (with the exception of that
> proxying) because it follows the same decoding as used in real hardware
> to route the memory accesses. As a result we get a read/write to a
> device physical address and hence proxy that.  If any of the decoders
> along the path are not configured then we error out at that stage.
> 
> To create the equivalent as IO subregions I think we'd have to do the
> following from (this might be mediated by some central entity that
> doesn't currently exist, or done on demand from which ever CXL device
> happens to have it's decoder set up last)
> 
> 1) Wait for a decoder commit (enable) on any component. Goto 2.
> 2) Walk the topology (up to host decoder, down to memory device)
> If a complete interleaving path has been configured -
>    i.e. we have committed decoders all the way to the memory
>    device goto step 3, otherwise return to step 1 to wait for
>    more decoders to be committed.
> 3) For the memory region being supplied by the memory device,
>    add subregions to map the device physical address (address
>    in the file) for each interleave stride to the appropriate
>    host Physical Address.
> 4) Return to step 1 to wait for more decoders to commit.
> 
> So summary is we can do it with IO regions, but there are a lot of them
> and the setup is somewhat complex as we don't have one single point in
> time where we know all the necessary information is available to compute
> the right addresses.
> 
> Looking forward to your suggestions if I haven't caused more confusion!

Thanks for the write up - I must confess they're a lot! :)

I merely only learned what is CXL today, and I'm not very experienced on
device modeling either, so please bare with me with stupid questions..

IIUC so far CXL traps these memory accesses using CXLFixedWindow.mr.
That's a normal IO region, which looks very reasonable.

However I'm confused why patch "RFC: softmmu/memory: Add ops to
memory_region_ram_init_from_file" helped.

Per my knowledge, all the memory accesses upon this CFMW window trapped
using this IO region already.  There can be multiple memory file objects
underneath, and when read/write happens the object will be decoded from
cxl_cfmws_find_device() as you referenced.

However I see nowhere that these memory objects got mapped as sub-regions
into parent (CXLFixedWindow.mr).  Then I don't understand why they cannot
be trapped.

To ask in another way: what will happen if you simply revert this RFC
patch?  What will go wrong?

Thanks,

-- 
Peter Xu

