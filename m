Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A03C636D4
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Feb 2023 12:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBMMUW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Feb 2023 07:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBMMUV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Feb 2023 07:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9CCDEE
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 04:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676290773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6v0ooLyeNfzQ7xBgMjxn5omUuyxiJes4sQHKrDWMfg=;
        b=NxmerED6xy4w1xAeAaB0Bm3C9pywqOilK3Xj3hG6NNIn0to3S/mBNaK7i1euonfMQZBsTD
        v+YF/Qwhg2J6r1p+h95g5Ky1r781uAgX8aoYQqH7U1dtcV7rMnc7nVv5KCEfrTNK48CxJ+
        e41GWERvh8QbnSvHUYEoeJYf95A6rNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-6O5f9FzFO1ap5EZbg5_3IA-1; Mon, 13 Feb 2023 07:13:30 -0500
X-MC-Unique: 6O5f9FzFO1ap5EZbg5_3IA-1
Received: by mail-wr1-f69.google.com with SMTP id l15-20020adff48f000000b002c55dbddb59so358342wro.6
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 04:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6v0ooLyeNfzQ7xBgMjxn5omUuyxiJes4sQHKrDWMfg=;
        b=pQdYTd6vSV9O8rnfaASBBMA9mtsELNs58gpD2ndpHUDy3Z6z1SpS/MFk0nFRMXMMR2
         IoMp2Fq3gPwMTybJdaJSwYtKC2mDTJn67fzBE3FEuW5HenrH8Ixyam64+fkjnqnbB2yd
         e7WYK9amerMtlWUmRJiJww5/4mWAoswPOF1dJC7OEdE2Buc+QlDWiswCdUn9qiYXS/Eh
         NI6V69lA7TytwBKGjzB1GNQBDwmqf15S5aGe3kvrK9sGlMzI1ajwXg72hY5+YHlSsmt6
         0RS3Pzx+IA8Xygp4GalGPy5iHGARBdrbhCTC71Q/Y2K2dIMlsAfNhwhKsP9DyFp4FU1v
         EFoQ==
X-Gm-Message-State: AO0yUKUsaXVtWuh3FnzazE5mFBnJO3KrB0Bp/wItFAi62BjMpCT7RjLJ
        WFPtBT2+N16KSrC4r787vaeGomMXdz0MahACNawKnX/9X/0BVxmE+j/Y7WQHKgMwHyvfiFb1WtN
        sXk6MKUqH4YftXRmmFn0O
X-Received: by 2002:a05:600c:807:b0:3e0:47:66cc with SMTP id k7-20020a05600c080700b003e0004766ccmr19097470wmp.23.1676290409319;
        Mon, 13 Feb 2023 04:13:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9UKPGUs5FOatxbxbL/MB4NwZDNS48v4t9kXrFWtKl/EbrfjKpJI1CK4NzxGM8p+c9u9Ic45g==
X-Received: by 2002:a05:600c:807:b0:3e0:47:66cc with SMTP id k7-20020a05600c080700b003e0004766ccmr19097458wmp.23.1676290409076;
        Mon, 13 Feb 2023 04:13:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003e1e8d794e1sm4939993wmo.13.2023.02.13.04.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:13:28 -0800 (PST)
Message-ID: <ed85ee75-1507-3f72-2af7-40ba452402f4@redhat.com>
Date:   Mon, 13 Feb 2023 13:13:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 00/18] CXL RAM and the 'Soft Reserved' => 'System RAM'
 default
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 06.02.23 02:02, Dan Williams wrote:
> Summary:
> --------
> 
> CXL RAM support allows for the dynamic provisioning of new CXL RAM
> regions, and more routinely, assembling a region from an existing
> configuration established by platform-firmware. The latter is motivated
> by CXL memory RAS (Reliability, Availability and Serviceability)
> support, that requires associating device events with System Physical
> Address ranges and vice versa.
> 
> The 'Soft Reserved' policy rework arranges for performance
> differentiated memory like CXL attached DRAM, or high-bandwidth memory,
> to be designated for 'System RAM' by default, rather than the device-dax
> dedicated access mode. That current device-dax default is confusing and
> surprising for the Pareto of users that do not expect memory to be
> quarantined for dedicated access by default. Most users expect all
> 'System RAM'-capable memory to show up in FREE(1).
> 
> 
> Details:
> --------
> 
> Recall that the Linux 'Soft Reserved' designation for memory is a
> reaction to platform-firmware, like EFI EDK2, delineating memory with
> the EFI Specific Purpose Memory attribute (EFI_MEMORY_SP). An
> alternative way to think of that attribute is that it specifies the
> *not* general-purpose memory pool. It is memory that may be too precious
> for general usage or not performant enough for some hot data structures.
> However, in the absence of explicit policy it should just be 'System
> RAM' by default.
> 
> Rather than require every distribution to ship a udev policy to assign
> dax devices to dax_kmem (the device-memory hotplug driver) just make
> that the kernel default. This is similar to the rationale in:
> 
> commit 8604d9e534a3 ("memory_hotplug: introduce CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE")
> 
> With this change the relatively niche use case of accessing this memory
> via mapping a device-dax instance can be achieved by building with
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n, or specifying
> memhp_default_state=offline at boot, and then use:
> 
>      daxctl reconfigure-device $device -m devdax --force
> 
> ...to shift the corresponding address range to device-dax access.
> 
> The process of assembling a device-dax instance for a given CXL region
> device configuration is similar to the process of assembling a
> Device-Mapper or MDRAID storage-device array. Specifically, asynchronous
> probing by the PCI and driver core enumerates all CXL endpoints and
> their decoders. Then, once enough decoders have arrived to a describe a
> given region, that region is passed to the device-dax subsystem where it
> is subject to the above 'dax_kmem' policy. This assignment and policy
> choice is only possible if memory is set aside by the 'Soft Reserved'
> designation. Otherwise, CXL that is mapped as 'System RAM' becomes
> immutable by CXL driver mechanisms, but is still enumerated for RAS
> purposes.
> 
> This series is also available via:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/cxl-ram-region
> 
> ...and has gone through some preview testing in various forms.
> 

My concern would be that in setups with a lot of CXL memory 
(soft-reserved), having that much offline memory during boot might make 
the kernel run out of memory. After all, offline memory consumes memory 
for the memmap.

Is the assumption that something like that cannot happen because we'll 
never ever have that much soft-reserved memory? :)

Note that this is a concern only applies when not using auto-onlining in 
the kernel during boot, which (IMHO) is or will be the default in the 
future.

-- 
Thanks,

David / dhildenb

