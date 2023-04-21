Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48097C7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 14:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjDUOGN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjDUOGM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 10:06:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3896E92
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 07:06:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2x7n1GCPz6J6sw;
        Fri, 21 Apr 2023 22:03:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Apr
 2023 15:06:08 +0100
Date:   Fri, 21 Apr 2023 15:06:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud?= =?ISO-8859-1?Q?=E9?= 
        <philmd@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v4 0/7] QEMU CXL Provide mock CXL events and irq support
Message-ID: <20230421150607.00005f95@Huawei.com>
In-Reply-To: <20230421032504-mutt-send-email-mst@kernel.org>
References: <20230303152903.28103-1-Jonathan.Cameron@huawei.com>
        <20230421032504-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 Apr 2023 03:25:45 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Mar 03, 2023 at 03:28:56PM +0000, Jonathan Cameron wrote:
> > Whilst I'm an optimist, I suspect this is now 8.1 material because we have
> > 5 CXL patch sets outstanding before it. Current bottleneck being QAPI review
> > for the RAS error series.  
> 
> RAS thing is in, right?

Absolutely, that one is resolved.

This series was also after some other series that didn't make 8.0.

Volatile memory: You had some feedback on that which I think I've resolved.
I'll send a new version of that out shortly.

Poison list handling. Phillipe had some comments on that one that may take
a little longer so I might shuffle that to after this events series depending on
how bad the rebase is.

I also have a couple of series of things that are fixes rather than
new features.

I've just sent out:
*  https://lore.kernel.org/qemu-devel/20230421132020.7408-1-Jonathan.Cameron@huawei.com/T/#t
   hw/cxl: CDAT file handling fixes
   to cover some issues Peter and others reported around CDAT file loading.
* https://lore.kernel.org/qemu-devel/20230421135906.3515-1-Jonathan.Cameron@huawei.com/T/
  [PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handling
  Which was a low priority fix that surfaced from a bug report during the RCs and some
  clarifications of an unclear bit of the specification.

I've also gathered some docs fixes and sent those out as
* https://lore.kernel.org/qemu-devel/20230421134507.26842-1-Jonathan.Cameron@huawei.com/T/#t

From a quick test I think all 3 of these series are independent so pick up which
ever you think makes sense.

Thanks,

Jonathan





> 
> could you rebase this one? no longer applies cleanly. thanks!
> 
> > v4 changes: Thanks to Ira and to some feedback I received off list.
> > - More endian fixes for a future big endian architecture using it.
> > - Comment typo
> > 
> > One challenge here is striking the right balance between lots of constraints
> > in the injection code to enforce particular reserved bits etc by breaking
> > out all the flags as individual parameters vs having a reasonably concise
> > API.  I think this set strikes the right balance but others may well
> > disagree :)   Note that Ira raised the question of whether we should be
> > automatically establishing the volatile flag based on the Device Physical
> > Address of the injected error. My proposal is to not do so for now, but
> > to possibly revisit tightening the checking of injected errors in future.
> > Whilst the volatile flag is straight forwards, some of the other flags that
> > could be automatically set (or perhaps checked for validiaty) are much more
> > complex. Adding verification at this stage would greatly increase the
> > complexity of the patch + we are missing other elements that would interact
> > with this.  I'm not concerned about potential breaking of backwards compatibility
> > if it only related to the injection of errors that make no sense for a real
> > device.
> > 
> > Based on following series (in order)
> > 1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
> > (in staging currently so fingers crossed that one is fine)
> > 2. [PATCH v6 0/8] hw/cxl: RAS error emulation and injection
> > 3. [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
> > 4. [PATCH v4 0/2] hw/mem: CXL Type-3 Volatile Memory Support
> > 5. [PATCH v4 0/6] hw/cxl: Poison get, inject, clear
> > 
> > Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
> > Based-on: Message-id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com
> > Based-on: Message-id: 20230227153128.8164-1-Jonathan.Cameron@huawei.com
> > Based-on: Message-id: 20230227163157.6621-1-Jonathan.Cameron@huawei.com
> > Based-on: Message-id: 20230303150908.27889-1-Jonathan.Cameron@huawei.com
> > 
> > v2 cover letter.
> > 
> > CXL Event records inform the OS of various CXL device events.  Thus far CXL
> > memory devices are emulated and therefore don't naturally generate events.
> > 
> > Add an event infrastructure and mock event injection.  Previous versions
> > included a bulk insertion of lots of events.  However, this series focuses on
> > providing the ability to inject individual events through QMP.  Only the
> > General Media Event is included in this series as an example.  Other events can
> > be added pretty easily once the infrastructure is acceptable.
> > 
> > In addition, this version updates the code to be in line with the
> > specification based on discussions around the kernel patches.
> > 
> > Injection examples;
> > 
> > { "execute": "cxl-inject-gen-media-event",
> >     "arguments": {
> >         "path": "/machine/peripheral/cxl-mem0",
> >         "log": "informational",
> >         "flags": 1,
> >         "physaddr": 1000,
> >         "descriptor": 3,
> >         "type": 3,
> >         "transaction-type": 192,
> >         "channel": 3,
> >         "device": 5,
> >         "component-id": "iras mem"
> >     }}
> > 
> > 
> > { "execute": "cxl-inject-dram-event",
> >     "arguments": {
> >         "path": "/machine/peripheral/cxl-mem0",
> >         "log": "informational",
> >         "flags": 1,
> >         "physaddr": 1000,
> >         "descriptor": 3,
> >         "type": 3,
> >         "transaction-type": 192,
> >         "channel": 3,
> >         "rank": 17,
> >         "nibble-mask": 37421234,
> >         "bank-group": 7,
> >         "bank": 11,
> >         "row": 2,
> >         "column": 77,
> >         "correction-mask": [33, 44, 55, 66]
> >     }}
> > 
> > { "execute": "cxl-inject-memory-module-event",
> >   "arguments": {
> >     "path": "/machine/peripheral/cxl-mem0",
> >     "log": "informational",
> >     "flags": 1,
> >     "type": 3,
> >     "health-status": 3,
> >     "media-status": 7,
> >     "additional-status": 33,
> >     "life-used": 30,
> >     "temperature": -15,
> >     "dirty-shutdown-count": 4,
> >     "corrected-volatile-error-count": 3233,
> >     "corrected-persistent-error-count": 1300
> >   }}
> > 
> > 
> > Ira Weiny (4):
> >   hw/cxl/events: Add event status register
> >   hw/cxl/events: Wire up get/clear event mailbox commands
> >   hw/cxl/events: Add event interrupt support
> >   hw/cxl/events: Add injection of General Media Events
> > 
> > Jonathan Cameron (3):
> >   hw/cxl: Move CXLRetCode definition to cxl_device.h
> >   hw/cxl/events: Add injection of DRAM events
> >   hw/cxl/events: Add injection of Memory Module Events
> > 
> >  hw/cxl/cxl-device-utils.c   |  43 +++++-
> >  hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++
> >  hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++------
> >  hw/cxl/meson.build          |   1 +
> >  hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3_stubs.c    |  35 +++++
> >  include/hw/cxl/cxl_device.h |  80 +++++++++-
> >  include/hw/cxl/cxl_events.h | 168 +++++++++++++++++++++
> >  qapi/cxl.json               | 120 +++++++++++++++
> >  9 files changed, 1097 insertions(+), 56 deletions(-)
> >  create mode 100644 hw/cxl/cxl-events.c
> >  create mode 100644 include/hw/cxl/cxl_events.h
> > 
> > -- 
> > 2.37.2  
> 

