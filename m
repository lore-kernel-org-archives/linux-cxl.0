Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB513C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 11:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjESLIH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjESLIG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 07:08:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B0BB
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 04:08:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN3tB2dD1z6D94r;
        Fri, 19 May 2023 19:05:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 12:07:45 +0100
Date:   Fri, 19 May 2023 12:07:44 +0100
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
Subject: Re: [PATCH v5 0/6] hw/cxl: Poison get, inject, clear
Message-ID: <20230519120744.00005063@Huawei.com>
In-Reply-To: <20230519030942-mutt-send-email-mst@kernel.org>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
        <20230519030942-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 04:49:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sun, Apr 23, 2023 at 05:20:07PM +0100, Jonathan Cameron wrote:
> > v5: More details in each patch.
> >  - Simpler algorithm to find entry when clearing.
> >  - Improvements to debugability and docs for 24 bit endian functions.
> >  - Use of ROUND_DOWN() to simplify the various alignment questions.
> >  - Use CXL_CACHELINE_SIZE define to explain the mysterious 64 byte
> >    granularity
> >  - Use memory_region_size() instead of direct accesses.  
> 
> 
> picked first 3 but dropped the rest for now due to build errors.
Drop the bswap one as well for now.
s390 is trying to call __builtin_bswap24 which clearly doesn't exist
- though you won't see that without the rest of this patch set.

Might be a case of crossing with a patch set reworking this stuff
to use the compiler more, but I'm not quite sure.

I'll see if I can figure out a fix or indeed exactly how this is
being triggered.

Hindsight says we should have kept definition local to CXL and
done the 'generic' version afterwards. 

For reference

/builds/jic23/qemu/include/qemu/bswap.h:42:32: error: implicit declaration of function ‘__builtin_bswap24’; did you mean ‘__builtin_bswap64’? [-Werror=implicit-function-declaration]
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                                ^~~~~~~~~~~~~~~
/builds/jic23/qemu/include/qemu/compiler.h:34:21: note: in definition of macro ‘xglue’
   34 | #define xglue(x, y) x ## y
      |                     ^
/builds/jic23/qemu/include/qemu/bswap.h:42:27: note: in expansion of macro ‘glue’
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                           ^~~~
/builds/jic23/qemu/include/qemu/bswap.h:322:20: note: in expansion of macro ‘le_bswap’
  322 |     st24_he_p(ptr, le_bswap(v, 24));
      |                    ^~~~~~~~
/builds/jic23/qemu/include/qemu/bswap.h:42:32: error: nested extern declaration of ‘__builtin_bswap24’ [-Werror=nested-externs]
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                                ^~~~~~~~~~~~~~~
/builds/jic23/qemu/include/qemu/compiler.h:34:21: note: in definition of macro ‘xglue’
   34 | #define xglue(x, y) x ## y
      |                     ^
/builds/jic23/qemu/include/qemu/bswap.h:42:27: note: in expansion of macro ‘glue’
   42 | #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
      |                           ^~~~
/builds/jic23/qemu/include/qemu/bswap.h:322:20: note: in expansion of macro ‘le_bswap’
  322 |     st24_he_p(ptr, le_bswap(v, 24));
      |                    ^~~~~~~~

Jonathan
 
> 
> > Many of the precursors listed for v4 have now been applied, but
> > a few minor fixes have come up in the meantime so there are still
> > a few precursors including the volatile support left from v4
> > precursors.
> > 
> > Depends on 
> > [PATCH 0/2] hw/cxl: CDAT file handling fixes.
> > [PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handling
> > [PATCH 0/3] docs/cxl: Gathering of fixes for 8.0 CXL docs.
> > [PATCH v5 0/3] hw/mem: CXL Type-3 Volatile Memory Support
> >  
> > Based on: Message-ID: 20230421132020.7408-1-Jonathan.Cameron@huawei.com
> > Based on: Message-ID: 20230421135906.3515-1-Jonathan.Cameron@huawei.com
> > Based on: Message-ID: 20230421134507.26842-1-Jonathan.Cameron@huawei.com
> > Based on: Message-ID: 20230421160827.2227-1-Jonathan.Cameron@huawei.com
> > 
> > The kernel support for Poison handling is currently in the cxl/pending
> > branch and hopefully should be in the CXL pull request next week.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=pending
> > 
> > This code has been very useful for testing and helped identify various
> > corner cases.
> > 
> > Updated cover letter.
> > 
> > The series supports:
> > 1) Injection of variable length poison regions via QMP (to fake real
> >    memory corruption and ensure we deal with odd overflow corner cases
> >    such as clearing the middle of a large region making the list overflow
> >    as we go from one long entry to two smaller entries.
> > 2) Read of poison list via the CXL mailbox.
> > 3) Injection via the poison injection mailbox command (limited to 64 byte
> >    entries - spec constraint)
> > 4) Clearing of poison injected via either method.
> > 
> > The implementation is meant to be a valid combination of impdef choices
> > based on what the spec allowed. There are a number of places where it could
> > be made more sophisticated that we might consider in future:
> > * Fusing adjacent poison entries if the types match.
> > * Separate injection list and main poison list, to test out limits on
> >   injected poison list being smaller than the main list.
> > * Poison list overflow event (needs event log support in general)
> > * Connecting up to the poison list error record generation (rather complex
> >   and not needed for currently kernel handling testing).
> > * Triggering the synchronous and asynchronous errors that occur on reads
> >   and writes of the memory when the host receives poison.
> > 
> > As the kernel code is currently fairly simple, it is likely that the above
> > does not yet matter but who knows what will turn up in future!
> > 
> > 
> > Ira Weiny (2):
> >   hw/cxl: Introduce cxl_device_get_timestamp() utility function
> >   bswap: Add the ability to store to an unaligned 24 bit field
> > 
> > Jonathan Cameron (4):
> >   hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
> >   hw/cxl: QMP based poison injection support
> >   hw/cxl: Add poison injection via the mailbox.
> >   hw/cxl: Add clear poison mailbox command support.
> > 
> >  docs/devel/loads-stores.rst |   1 +
> >  hw/cxl/cxl-device-utils.c   |  15 ++
> >  hw/cxl/cxl-mailbox-utils.c  | 289 ++++++++++++++++++++++++++++++------
> >  hw/mem/cxl_type3.c          |  93 ++++++++++++
> >  hw/mem/cxl_type3_stubs.c    |   6 +
> >  include/hw/cxl/cxl.h        |   1 +
> >  include/hw/cxl/cxl_device.h |  23 +++
> >  include/qemu/bswap.h        |  25 ++++
> >  qapi/cxl.json               |  18 +++
> >  9 files changed, 429 insertions(+), 42 deletions(-)
> > 
> > -- 
> > 2.37.2  
> 

