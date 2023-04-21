Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9615C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 07:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDUH0i (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjDUH0g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 03:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D2132
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682061953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwA/y38H4TEHxfUTp5EeXYTvs30OcUAWsMcXRLuq6kM=;
        b=APnJjDh4BUgw+mxTB00ciFg5Z9k5TjDe9IUsfP0xFUuK2cOMYM9lzfD/z+RRSTq12cgg+1
        zUcKoLe+gJ3OnDBwfOZZkuNsUQRvKWsudaVHCRnM3hSNo9qjpMBe+jO3MEMv5RQmdW6C4v
        Rt/goX5JEVjK/piwIG60yfjxxXvonY4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-AUgjVlZnNrm30gX3KgPKMg-1; Fri, 21 Apr 2023 03:25:52 -0400
X-MC-Unique: AUgjVlZnNrm30gX3KgPKMg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f18c2b2110so4283275e9.3
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 00:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682061951; x=1684653951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwA/y38H4TEHxfUTp5EeXYTvs30OcUAWsMcXRLuq6kM=;
        b=GZcoVKNqrXWk5jw3R7DFULOQ1IU4QMv/L2avEUAQmR8lWEhWEGqlVLYn1FDbc83kV9
         mtUFL4qnkwjldIO4QhEOSvvTw0H7KVHOW59MRQ0qu9zzb10SuJ40TD97fvHMFiflcX76
         JT0Tvp9fTfPc/HhE+JJlJfmf1VSJDJJ5pqL7LIgL6Sz+yYg6alK09B5eqweKYRBSB1KE
         eLKMYeLwvfGBUHbgnGXi7okw+8Jk9rr5/nE+2XOeK3N/6GBYDZy8jXrW/uB+ej/I7gqy
         njnZX5+bO1fB/GoNR7++yrES1btroxSouJdGS/7PqjS3qICEOhB7nV8Yla22KpN5KpUr
         +iHQ==
X-Gm-Message-State: AAQBX9ftBx2Fs9P1g6BbOLsMcurLW1zypg2Zh4ZyoEt2emY8K6tVSB8c
        YzJCECtS+OxsOGDSAhon6lam5IeYNceNcHTNoX4reZl5aRhwYgKm5YoPFbFpBe99F+gqOOAjHj1
        Pfroj0hfuZe7WBLTQqZBR
X-Received: by 2002:a05:6000:10f:b0:2f9:3641:3f61 with SMTP id o15-20020a056000010f00b002f936413f61mr3083890wrx.48.1682061951021;
        Fri, 21 Apr 2023 00:25:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z62Iu/+aqG78TJOiD99skzOpBIXxtG2Ra16IF4fZXjz0gYDzBicxXi8qDmfZG8W83iFihE8A==
X-Received: by 2002:a05:6000:10f:b0:2f9:3641:3f61 with SMTP id o15-20020a056000010f00b002f936413f61mr3083877wrx.48.1682061950683;
        Fri, 21 Apr 2023 00:25:50 -0700 (PDT)
Received: from redhat.com ([2.55.62.70])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b002f27dd92643sm3723676wro.99.2023.04.21.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 00:25:49 -0700 (PDT)
Date:   Fri, 21 Apr 2023 03:25:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 0/7] QEMU CXL Provide mock CXL events and irq support
Message-ID: <20230421032504-mutt-send-email-mst@kernel.org>
References: <20230303152903.28103-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230303152903.28103-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 03, 2023 at 03:28:56PM +0000, Jonathan Cameron wrote:
> Whilst I'm an optimist, I suspect this is now 8.1 material because we have
> 5 CXL patch sets outstanding before it. Current bottleneck being QAPI review
> for the RAS error series.

RAS thing is in, right?

could you rebase this one? no longer applies cleanly. thanks!

> v4 changes: Thanks to Ira and to some feedback I received off list.
> - More endian fixes for a future big endian architecture using it.
> - Comment typo
> 
> One challenge here is striking the right balance between lots of constraints
> in the injection code to enforce particular reserved bits etc by breaking
> out all the flags as individual parameters vs having a reasonably concise
> API.  I think this set strikes the right balance but others may well
> disagree :)   Note that Ira raised the question of whether we should be
> automatically establishing the volatile flag based on the Device Physical
> Address of the injected error. My proposal is to not do so for now, but
> to possibly revisit tightening the checking of injected errors in future.
> Whilst the volatile flag is straight forwards, some of the other flags that
> could be automatically set (or perhaps checked for validiaty) are much more
> complex. Adding verification at this stage would greatly increase the
> complexity of the patch + we are missing other elements that would interact
> with this.  I'm not concerned about potential breaking of backwards compatibility
> if it only related to the injection of errors that make no sense for a real
> device.
> 
> Based on following series (in order)
> 1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
> (in staging currently so fingers crossed that one is fine)
> 2. [PATCH v6 0/8] hw/cxl: RAS error emulation and injection
> 3. [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
> 4. [PATCH v4 0/2] hw/mem: CXL Type-3 Volatile Memory Support
> 5. [PATCH v4 0/6] hw/cxl: Poison get, inject, clear
> 
> Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230227153128.8164-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230227163157.6621-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230303150908.27889-1-Jonathan.Cameron@huawei.com
> 
> v2 cover letter.
> 
> CXL Event records inform the OS of various CXL device events.  Thus far CXL
> memory devices are emulated and therefore don't naturally generate events.
> 
> Add an event infrastructure and mock event injection.  Previous versions
> included a bulk insertion of lots of events.  However, this series focuses on
> providing the ability to inject individual events through QMP.  Only the
> General Media Event is included in this series as an example.  Other events can
> be added pretty easily once the infrastructure is acceptable.
> 
> In addition, this version updates the code to be in line with the
> specification based on discussions around the kernel patches.
> 
> Injection examples;
> 
> { "execute": "cxl-inject-gen-media-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "physaddr": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "device": 5,
>         "component-id": "iras mem"
>     }}
> 
> 
> { "execute": "cxl-inject-dram-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "physaddr": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "rank": 17,
>         "nibble-mask": 37421234,
>         "bank-group": 7,
>         "bank": 11,
>         "row": 2,
>         "column": 77,
>         "correction-mask": [33, 44, 55, 66]
>     }}
> 
> { "execute": "cxl-inject-memory-module-event",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-mem0",
>     "log": "informational",
>     "flags": 1,
>     "type": 3,
>     "health-status": 3,
>     "media-status": 7,
>     "additional-status": 33,
>     "life-used": 30,
>     "temperature": -15,
>     "dirty-shutdown-count": 4,
>     "corrected-volatile-error-count": 3233,
>     "corrected-persistent-error-count": 1300
>   }}
> 
> 
> Ira Weiny (4):
>   hw/cxl/events: Add event status register
>   hw/cxl/events: Wire up get/clear event mailbox commands
>   hw/cxl/events: Add event interrupt support
>   hw/cxl/events: Add injection of General Media Events
> 
> Jonathan Cameron (3):
>   hw/cxl: Move CXLRetCode definition to cxl_device.h
>   hw/cxl/events: Add injection of DRAM events
>   hw/cxl/events: Add injection of Memory Module Events
> 
>  hw/cxl/cxl-device-utils.c   |  43 +++++-
>  hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++------
>  hw/cxl/meson.build          |   1 +
>  hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3_stubs.c    |  35 +++++
>  include/hw/cxl/cxl_device.h |  80 +++++++++-
>  include/hw/cxl/cxl_events.h | 168 +++++++++++++++++++++
>  qapi/cxl.json               | 120 +++++++++++++++
>  9 files changed, 1097 insertions(+), 56 deletions(-)
>  create mode 100644 hw/cxl/cxl-events.c
>  create mode 100644 include/hw/cxl/cxl_events.h
> 
> -- 
> 2.37.2

