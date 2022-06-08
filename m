Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5261C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Jun 2022 12:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiFHMOM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Jun 2022 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiFHMOL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Jun 2022 08:14:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E238D87
        for <linux-cxl@vger.kernel.org>; Wed,  8 Jun 2022 05:14:06 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ5dz4Rlhz67jfG;
        Wed,  8 Jun 2022 20:10:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 8 Jun 2022 14:14:03 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 13:14:03 +0100
Date:   Wed, 8 Jun 2022 13:14:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH v2 1/8] hw/cxl: Make the CXL fixed memory window setup a
 machine parameter.
Message-ID: <20220608131401.00004364@huawei.com>
In-Reply-To: <20220607223702.lpq34pq6wqnvr7ej@offworld>
References: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
        <20220601164235.2117-2-Jonathan.Cameron@huawei.com>
        <20220607223702.lpq34pq6wqnvr7ej@offworld>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 7 Jun 2022 15:37:02 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 01 Jun 2022, Jonathan Cameron wrote:
> 
> >Paolo Bonzini requested this change to simplify the ongoing
> >effort to allow machine setup entirely via RPC.
> >
> >Includes shortening the command line form cxl-fixed-memory-window
> >to cxl-fmw as the command lines are extremely long even with this
> >change.
> >
> >The json change is needed to ensure that there is
> >a CXLFixedMemoryWindowOptionsList even though the actual
> >element in the json is never used. Similar to existing
> >SgxEpcProperties.
> >
> >Update cxl-test and bios-tables-test to reflect new parameters.
> >
> >Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Thanks.

> 
> One thing missing however is updating qemu-options.hx - maybe fold
> in the below?

Excellent point. 

The original patch set has been rolling so long I'd forgotten we had
documentation in qemu-options.hx.

One comment inline though...
> 
> Thanks!
> 
> ----8<-------
> o
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 60cf188da429..3bcf1247b88a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -127,10 +127,43 @@ SRST
>   ERST
>   
>   DEF("M", HAS_ARG, QEMU_OPTION_M,
> +    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"

This _M entry is odd, given it's just short hand for _machine.  So I'm thinking
it makes more sense to document this lot in the "machine" block further up the doc.
That particular entry has a different style to this one, so I'll modify this inline
with existing entries there.

Possibly someone should move the sgx entry over to machine as well.
+Cc Sean Chistopherson and Yan Zhong as that sgx-epc entry is from their patch set.
A quick glance through discussion of that patch didn't throw up a
reason for doing it as a separate entry, but I haven't dug deep.



>       "                sgx-epc.0.memdev=memid,sgx-epc.0.node=numaid\n",
>       QEMU_ARCH_ALL)
>   
>   SRST
> +``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
> +    Define a CXL Fixed Memory Window (CFMW).
> +
> +    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
> +
> +    They are regions of Host Physical Addresses (HPA) on a system which
> +    may be interleaved across one or more CXL host bridges.  The system
> +    software will assign particular devices into these windows and
> +    configure the downstream Host-managed Device Memory (HDM) decoders
> +    in root ports, switch ports and devices appropriately to meet the
> +    interleave requirements before enabling the memory devices.
> +
> +    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
> +    which may be identified by the id provied in the -device entry.
> +    Multiple entries are needed to specify all the targets when
> +    the fixed memory window represents interleaved memory. X is the
> +    target index from 0.
> +
> +    ``size=size`` sets the size of the CFMW. This must be a multiple of
> +    256MiB. The region will be aligned to 256MiB but the location is
> +    platform and configuration dependent.
> +
> +    ``interleave-granularity=granularity`` sets the granularity of
> +    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
> +    4096KiB, 8192KiB and 16384KiB granularities supported.
> +
> +    Example:
> +
> +    ::
> +
> +	-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512k
> +
>   ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
>       Define an SGX EPC section.
>   ERST
> @@ -467,44 +500,6 @@ SRST
>           -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
>   ERST
>   
> -DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
> -    "-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]\n",
> -    QEMU_ARCH_ALL)
> -SRST
> -``-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]``
> -    Define a CXL Fixed Memory Window (CFMW).
> -
> -    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
> -
> -    They are regions of Host Physical Addresses (HPA) on a system which
> -    may be interleaved across one or more CXL host bridges.  The system
> -    software will assign particular devices into these windows and
> -    configure the downstream Host-managed Device Memory (HDM) decoders
> -    in root ports, switch ports and devices appropriately to meet the
> -    interleave requirements before enabling the memory devices.
> -
> -    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
> -    which may be identified by the id provied in the -device entry.
> -    Multiple entries are needed to specify all the targets when
> -    the fixed memory window represents interleaved memory. X is the
> -    target index from 0.
> -
> -    ``size=size`` sets the size of the CFMW. This must be a multiple of
> -    256MiB. The region will be aligned to 256MiB but the location is
> -    platform and configuration dependent.
> -
> -    ``interleave-granularity=granularity`` sets the granularity of
> -    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
> -    4096KiB, 8192KiB and 16384KiB granularities supported.
> -
> -    Example:
> -
> -    ::
> -
> -        -cxl-fixed-memory-window targets.0=cxl.0,targets.1=cxl.1,size=128G,interleave-granularity=512k
> -
> -ERST
> -
>   DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
>       "-add-fd fd=fd,set=set[,opaque=opaque]\n"
>       "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)

