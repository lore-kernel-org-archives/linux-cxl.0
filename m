Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B19DC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 22:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJKWVe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJKWVP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 18:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FCD3678C
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665526831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NEFORJdOwYlR2zzBzKEPwjPd7DSRD0p52+NJISxyoI=;
        b=V8dd/CHuiV2y/YuLR/g5jIofE+PBwR6ySBrP5k6BKMfGiirEwjojuoi0PX9IlkRi5tp+Z6
        t/mIVctnhcZzFAiBXiqFv7eFeMlnc28aUDNpqxK/GMchD2kSvrnwIApWRQJCDUXhqWYu02
        0NuFCw/IqJEMa59zxZDk5QIArz5KbHI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-Gc7iPdsAOgiAY_aasg9AHg-1; Tue, 11 Oct 2022 18:20:23 -0400
X-MC-Unique: Gc7iPdsAOgiAY_aasg9AHg-1
Received: by mail-wm1-f72.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso9092251wme.3
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 15:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NEFORJdOwYlR2zzBzKEPwjPd7DSRD0p52+NJISxyoI=;
        b=Z7igdRle7yGmQWeJdDaYYsZ7hwaf9WzSyPF9zevN+CwVE5BffahXeTSlRcNmRSGNM1
         I7V78AZraCo+Bo91qIEjXDqcWviydDnHNWkhaLI2EtK6ChfI00e+K7HQGorTGEwCZVXy
         Ii+atk1KM2rKT+gefAA6oYitMRz6bLFbOqTNM4UEXH2/RnbXIcXg0SZcfzhbmMxWqjzd
         X0VmBarwQI7KHBUk0f73aEuJE94K2gcMIrdOLF6xcCk541wkYC3Mn06bdtOHfcBxUDZF
         i26H0/PLUEf8T/NcnKBZPrQ8HCMPYXdNYzRyZqLAfU7GiC6TtoQN2rPE7LDby4j/c20a
         d5XQ==
X-Gm-Message-State: ACrzQf2s1ZMbNvfJ9YFJPRS8p/TqhJI9YDHNv+euVRuGFs7jM11AsnKM
        6LxzkeuPpB2kuzGUljcV6be0+Ulabps74cIw9x54qLAp3iZpylSHKxlJyZFEPCWevzq9Us1IhES
        e7/G8yll05aXSmX6pBvK5
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id hg24-20020a05600c539800b003c3dccf2362mr772373wmb.89.1665526822113;
        Tue, 11 Oct 2022 15:20:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54wOj//MiQEisE+SI5/Y98QnLVSoW7tEMuslXUPLCXY2FWlK9Zeu8jC5mn494gW6g8lMP4ZA==
X-Received: by 2002:a05:600c:5398:b0:3c3:dccf:2362 with SMTP id hg24-20020a05600c539800b003c3dccf2362mr772362wmb.89.1665526821881;
        Tue, 11 Oct 2022 15:20:21 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id s13-20020adfdb0d000000b002302dc43d77sm6770490wri.115.2022.10.11.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:20:21 -0700 (PDT)
Date:   Tue, 11 Oct 2022 18:20:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: Re: [PATCH 0/5] Multi-Region and Volatile Memory support for CXL
 Type-3 Devices
Message-ID: <20221011181936-mutt-send-email-mst@kernel.org>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
 <20221011211916.117552-1-gregory.price@memverge.com>
MIME-Version: 1.0
In-Reply-To: <20221011211916.117552-1-gregory.price@memverge.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 11, 2022 at 05:19:11PM -0400, Gregory Price wrote:
> Summary of Changes:
> 1) Correction of PCI_CLASS from STORAGE_EXPRESS to MEMORY_CXL on init
> 2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
> 3) Refactor CDAT DSMAS Initialization for multi-region initialization
> 4) Multi-Region and Volatile Memory support for CXL Type-3 Devices
> 5) Test and Documentation updates
> 
> Developed with input from Jonathan Cameron and Davidloh Bueso.
> 
> This series brings 2 features to CXL Type-3 Devices:
>     1) Volatile Memory Region support
>     2) Multi-Region support (1 Volatile, 1 Persistent)
> 
> In this series we implement multi-region and volatile region support
> through 6 major changes to CXL devices
>     1) The HostMemoryBackend [hostmem] has been replaced by two
>        [hostvmem] and [hostpmem] to store volatile and persistent memory
>        respectively
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
> 
> CXL Spec (3.0) Section 8.2.9.8.2.0 - Get Partition Info
>   Active Volatile Memory
>     The device shall provide this volatile capacity starting at DPA 0
>   Active Persistent Memory
>     The device shall provide this persistent capacity starting at the
>     DPA immediately following the volatile capacity
> 
> Partitioning of Persistent Memory regions may be supported on following
> patch sets.
> 
> Submitted as an extention to the CDAT emulation because the CDAT DSMAS
> entry concerns memory mapping and is required to successfully map memory
> regions correctly in bios/efi.

As there will be v8 of CDAT patches I expect there will be a rebase
of this patchset too.

> Gregory Price (5):
>   hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
>   hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
>   hw/mem/cxl_type: Generalize CDATDsmas initialization for Memory
>     Regions
>   hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
>   cxl: update tests and documentation for new cxl properties
> 
>  docs/system/devices/cxl.rst |  53 ++++-
>  hw/cxl/cxl-mailbox-utils.c  |  23 +-
>  hw/mem/cxl_type3.c          | 449 +++++++++++++++++++++++-------------
>  include/hw/cxl/cxl_device.h |  11 +-
>  tests/qtest/cxl-test.c      |  81 ++++++-
>  5 files changed, 416 insertions(+), 201 deletions(-)
> 
> -- 
> 2.37.3

