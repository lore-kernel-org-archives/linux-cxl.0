Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2929BC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiJZUPZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiJZUPY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436A727B24
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666815318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6aKXfqD6s0UoSz0vncXrx2wqKFOtcB92mD1GSABeGg=;
        b=QN+Xi2sPxNGPbs8owdaINdQ1icMYVZRBF3NBAgwSkCa7+u+gkVAzCmaEWE0215fYvwMEDU
        XYaZXsdjCkO5QfhOJUIyJhMFMDfN9/w+gevb5rFcsfCJiorp+GN3/3R5YyAnmZCvK+3Aiv
        84vWAAE3VnM/gPm2CpzrBUTnYBuDHGU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-R-2s77T4MiG8KRwMSoul1Q-1; Wed, 26 Oct 2022 16:15:17 -0400
X-MC-Unique: R-2s77T4MiG8KRwMSoul1Q-1
Received: by mail-wm1-f72.google.com with SMTP id az35-20020a05600c602300b003c5273b79fdso1583518wmb.3
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6aKXfqD6s0UoSz0vncXrx2wqKFOtcB92mD1GSABeGg=;
        b=vFTSctBQbBSEGxBguInugknfNSEmS/rEndbMVFBcRtKSRoFUdEqmzrhKF4e0l71K5d
         KDL5lzw9phf7udKTp/0JYbtG+PlqneLMAI64IrtVzaNx6fLoaWs7Rxndyj4KD9VGp/Gk
         5RcC6FqwiVMr8mv5HdeEvRMhxpFMycIoOmVp8GKiTcnmMm27kQZPyhika9vv/QaQEdA9
         G2jG6itfx7mkCqvqxJHFOUtLaOzx9WLwQGuq2hoNSw0K4waeEtMy4pJWh13GAVDEYXfr
         cPQLj4ddLkoVQdXdSUU/3IqtmxntNhw4MqCBSV4lMCNPRlcPXTZmV+dpsuQi2CWmUakS
         Cbqw==
X-Gm-Message-State: ACrzQf3rbXoDXHY/JW/pw1f4gtetkrc3bvCvXeOBWvnhwcL5FpilHP4s
        HdLxy64N06qsKn2+bKTYsTGEK8yBSw8gApReot/94+1zyvJqp3rcUub54VeBAPfPfkRt7gTwn+w
        /GclaQKfZG5m9ybdnicaz
X-Received: by 2002:a05:600c:1d02:b0:3c3:e6f0:6e4b with SMTP id l2-20020a05600c1d0200b003c3e6f06e4bmr3657693wms.202.1666815316053;
        Wed, 26 Oct 2022 13:15:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6n9g7K37AGF98D05l1F42OXiQ/kJtsIJIccSH0DJYN2bOLugg65OdIRFynLqVZq0PJWSCffw==
X-Received: by 2002:a05:600c:1d02:b0:3c3:e6f0:6e4b with SMTP id l2-20020a05600c1d0200b003c3e6f06e4bmr3657684wms.202.1666815315809;
        Wed, 26 Oct 2022 13:15:15 -0700 (PDT)
Received: from redhat.com ([2.52.15.7])
        by smtp.gmail.com with ESMTPSA id s26-20020a05600c319a00b003a6a3595edasm2572130wmp.27.2022.10.26.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:15:15 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:15:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
        imammedo@redhat.com, ani@anisinha.ca, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Message-ID: <20221026161412-mutt-send-email-mst@kernel.org>
References: <20221026004737.3646-1-gregory.price@memverge.com>
MIME-Version: 1.0
In-Reply-To: <20221026004737.3646-1-gregory.price@memverge.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 25, 2022 at 08:47:33PM -0400, Gregory Price wrote:
> Submitted as an extention to the multi-feature branch maintained
> by Jonathan Cameron at:
> https://gitlab.com/jic23/qemu/-/tree/cxl-2022-10-24 

BTW pls set subject prefix for all patches, and put it before the patch #.
-v parameter to format-patch will do this for you.

> 
> Summary of Changes:
> 1) E820 CFMW Bug fix.  
> 2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
> 3) Multi-Region and Volatile Memory support for CXL Type-3 Devices
> 4) CXL Type-3 SRAT Generation when NUMA node is attached to memdev
> 
> 
> Regarding the E820 fix
>   * This bugfix is required for memory regions to work on x86
>   * input from Dan Williams and others suggest that E820 entry for
>     the CFMW should not exist, as it is expected to be dynamically
>     assigned at runtime.  If this entry exists, it instead blocks
>     region creation by nature of the memory region being marked as
>     reserved.
> 
> Regarding Multi-Region and Volatile Memory
>   * Developed with input from Jonathan Cameron and Davidlohr Bueso.
> 
> Regarding SRAT Generation for Type-3 Devices
>   * Co-Developed by Davidlohr Bueso.  Built from his base patch and
>     extended to work with both volatile and persistent regions.
>   * This can be used to demonstrate static type-3 device mapping and
>     testing numa-access to type-3 device memory regions.
> 
> 
> This series brings 3 features to CXL Type-3 Devices:
>     1) Volatile Memory Region support
>     2) Multi-Region support (1 Volatile, 1 Persistent)
>     3) (optional) SRAT Entry generation for type-3 device regions
> 
> In this series we implement multi-region and volatile region support
> through 7 major changes to CXL devices
>     1) The HostMemoryBackend [hostmem] has been replaced by two
>        [hostvmem] and [hostpmem] to store volatile and persistent
>        memory respectively
>     2) The single AddressSpace has been replaced by two AddressSpaces
>        [hostvmem_as] and [hostpmem_as] to map respective memdevs.
>     3) Each memory region size and total region are stored separately
>     4) The CDAT and DVSEC memory map entries have been updated:
>        a) if vmem is present, vmem is mapped at DPA(0)
>        b) if pmem is present
>           i)  and vmem is present, pmem is mapped at DPA(vmem->size)
>           ii) else, pmem is mapped at DPA(0)
>        c) partitioning of pmem is not supported in this patch set but
>           has been discussed and this design should suffice.
>     5) Read/Write functions have been updated to access AddressSpaces
>        according to the mapping described in #4
>     6) cxl-mailbox has been updated to report the respective size of
>        volatile and persistent memory regions
>     7) SRAT entries may optionally be generated by manually assigning
>        memdevs to a cpuless numa node
> 
> To support the Device Physical Address (DPA) Mapping decisions, see
> CXL Spec (3.0) Section 8.2.9.8.2.0 - Get Partition Info:
>   Active Volatile Memory
>     The device shall provide this volatile capacity starting at DPA 0
>   Active Persistent Memory
>     The device shall provide this persistent capacity starting at the
>     DPA immediately following the volatile capacity
> 
> Partitioning of Persistent Memory regions may be supported on
> following patch sets.
> 
> 
> Gregory Price (4):
>   hw/i386/pc.c: CXL Fixed Memory Window should not reserve e820 in bios
>   hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
>   hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
>   hw/acpi/cxl.c: Fill in SRAT for vmem/pmem if NUMA node is assigned
> 
>  docs/system/devices/cxl.rst |  74 ++++++++--
>  hw/acpi/cxl.c               |  67 +++++++++
>  hw/cxl/cxl-mailbox-utils.c  |  23 +--
>  hw/i386/acpi-build.c        |   4 +
>  hw/i386/pc.c                |   2 -
>  hw/mem/cxl_type3.c          | 274 +++++++++++++++++++++++++++---------
>  include/hw/acpi/cxl.h       |   1 +
>  include/hw/cxl/cxl_device.h |  11 +-
>  tests/qtest/cxl-test.c      | 111 +++++++++++----
>  9 files changed, 443 insertions(+), 124 deletions(-)
> 
> -- 
> 2.37.3

