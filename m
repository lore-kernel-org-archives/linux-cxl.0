Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83843C678D5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 17:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjCGRom (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjCGRoV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 12:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4409CBF0
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678210684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N07NOrmF/af/LqknqhXDPQaetqT+tlSQy0zbCBgdmFI=;
        b=ZE+Ag2P+8MYTRBNco2rFMbOxIDXY5EXOkrTops3DzgdXgmnsY+ePKhTBOi+dz25mbJjpFL
        gQJwW7wT5iUAuBwmSnVm+gdLXaL/g3DMQ3jnEWf/fZyuiFpGjb7dJwHdnvv4WQJuMpjXIX
        1HurixvG1mt2P3xAlzJPRL360JRuZkI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Z31a-2epOd-g8fjMX1q5QA-1; Tue, 07 Mar 2023 12:38:02 -0500
X-MC-Unique: Z31a-2epOd-g8fjMX1q5QA-1
Received: by mail-wm1-f69.google.com with SMTP id p22-20020a7bcc96000000b003e2036a1516so8555021wma.7
        for <linux-cxl@vger.kernel.org>; Tue, 07 Mar 2023 09:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N07NOrmF/af/LqknqhXDPQaetqT+tlSQy0zbCBgdmFI=;
        b=o+sDD6fXQDcvhov/cjnpeuhjeeZwmaKSQe9/aBp7NgJjcaMWSACjSyl6TqTsfGuc7R
         tw6Xe3LQwBG306Y6nPIZ6w1D3VZHjipXqMOt/8D4tRxJhASYqfgwqhy2+4xepVcoQK1C
         1dVnmq0CebYRlFxJGL1KpybqxBaSu8hA9Je32GR6/xz8U+K0S5+ZN7f2X7OHZzpeZliY
         fAh1q1rM+/00TSFrhcAhf6ZLDoopFfTt3U9uKd9xNiMBxz6SsJUaYIFFd/yV9me3R+ol
         ludDD6FpPHIidy8nkTaGtdiwphRJsI+eAJ/4tBYA48Uy90KUHPDi+IrzgGhwpwIjt1HQ
         70Yw==
X-Gm-Message-State: AO0yUKXT9gxxvmm6849Y3mn1jOQRMM21SKYJd/HAmq7Bxwcct+RsxdK9
        uUePp+p/y0A2HaNhe1iCNr33Q/GtcOFQHlhAYIHgbU6aSGEAJuDAMai4wTWvExWbcwK1JynCMyk
        2SKBeKZV0Rt02WQeQq9E7
X-Received: by 2002:a5d:4046:0:b0:2cb:85ba:24f9 with SMTP id w6-20020a5d4046000000b002cb85ba24f9mr9265898wrp.66.1678210681541;
        Tue, 07 Mar 2023 09:38:01 -0800 (PST)
X-Google-Smtp-Source: AK7set98h4Sg9ghY8klQxwoN4EpphqmJ8WtQ6ClxKz5MkJt8YpUCenP3IGXj2Z6mFPfTd4ix2ITq/A==
X-Received: by 2002:a5d:4046:0:b0:2cb:85ba:24f9 with SMTP id w6-20020a5d4046000000b002cb85ba24f9mr9265888wrp.66.1678210681242;
        Tue, 07 Mar 2023 09:38:01 -0800 (PST)
Received: from redhat.com ([2.52.138.216])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d49c1000000b002c563b124basm12901446wrs.103.2023.03.07.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:38:00 -0800 (PST)
Date:   Tue, 7 Mar 2023 12:37:56 -0500
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
Message-ID: <20230307123733-mutt-send-email-mst@kernel.org>
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
> 5 CXL patch sets outstanding before it.

Yea let's not. I merged what I felt is safe.

> Current bottleneck being QAPI review
> for the RAS error series.
> 
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

