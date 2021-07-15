Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B7C636C8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 22:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886C3613D2
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 22:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhGOWrt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jul 2021 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGOWrt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jul 2021 18:47:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C954C06175F
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jul 2021 15:44:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bt15so5221497pjb.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jul 2021 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfFL6qc4GbM1BPRXpR1F9kxfvv9NXgjn7OOYDQC5iW4=;
        b=iieXWK+TEASutntror0rH512c8g/V6mALw2749KnTAORsk36ZajH3YzqCMICjIwYIG
         AhvBeaWWBazIuRXVu7Vo6PBUx9DHgyAVK2IZTJ7f8kTWQD/GuCyPUW4qGrVNTpcemJut
         YJZqNO4/eSYeec62a64B3WLoD8KeKnPDsTzH9PxBe/tAuh2KHlPy15VFxEXX/Q4ZR0OS
         t/nd4dN40sC/+hSR77sNVrWeg2Z2kyFupIiWEDfnmahdg+2oqW0sfnA6+qKSg7hcvtWd
         XFcSsIc7H/Iq9xkZcM9vkF790iXADCCHHEA/EYce7/fsWUMJS90v0anofMca5Pfol2vt
         AR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfFL6qc4GbM1BPRXpR1F9kxfvv9NXgjn7OOYDQC5iW4=;
        b=qjsQjcqPlgc4GS1BYOCUPPq1z6Eb+NN1eQSDvxT5TNLb9w/7vzRHz/U2vBMyDxVFDG
         lbar2TW4xKSu+ruiqJxrEvpdKE38usdSO4KHqEnrBHjZ0KJsc5m5en6RZ5mM7LDukEr1
         1TSxSBydpn9pZlBvOdQxtVPvWuYJWMuecBCLSK11WlZmzlz9PAmf6BQtbl0uGv6YTGjw
         R+oLSFI9KSOEEthczMKpJnjZ8H/lJH8gej7GyYxpheqftlDRJHlWyP01BGOmQ8ui7oit
         PJ+pQYi11yS1qzw7uCZL5PLGs7vFkYnyeJc7Yef9ngOYtGZz4RNmqSRx5RDIH69i2mLj
         hlNA==
X-Gm-Message-State: AOAM533J8gHAqkXLLZIw2wFpEsOjBtB+rvBjF0mVhWczGcNWSrYdi76H
        eLfZIMLywbubFtsZIRikdhkqwYO4IhRUldwhkeXMwA==
X-Google-Smtp-Source: ABdhPJz0xGyQIzifUXGO78vRX0QlZ+d8gHaCnj3j8mZjEGb5Yb+a2G2xKVPNpdXGCV3XX8ss2aUhPG2g+aQ8kBBg2mw=
X-Received: by 2002:a17:902:7d91:b029:12b:45b0:736b with SMTP id
 a17-20020a1709027d91b029012b45b0736bmr5161061plm.79.1626389094984; Thu, 15
 Jul 2021 15:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210715194125.898305-1-ben.widawsky@intel.com> <20210715194125.898305-2-ben.widawsky@intel.com>
In-Reply-To: <20210715194125.898305-2-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Jul 2021 15:44:42 -0700
Message-ID: <CAPcyv4gbiNyKtzKkp2FgM5+k=FuodP0wKdNgh4ohH=E8fxQXwA@mail.gmail.com>
Subject: Re: [PATCH 1/6] cxl: Move cxl_core to new directory
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 15, 2021 at 12:41 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> CXL core is growing, and it's already arguably unmanageable. To support
> future growth, move core functionality to a new directory and rename the
> file to represent just bus support. Future work will remove non-bus
> functionality.
>

I think this effort wants a drivers/cxl/core/Makefile, more below:

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/driver-api/cxl/memory-devices.rst | 2 +-
>  drivers/cxl/Makefile                            | 2 +-
>  drivers/cxl/{core.c => core/bus.c}              | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename drivers/cxl/{core.c => core/bus.c} (99%)
>
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 487ce4f41d77..a86e2c7c551a 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -36,7 +36,7 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/cxl.h
>     :internal:
>
> -.. kernel-doc:: drivers/cxl/core.c
> +.. kernel-doc:: drivers/cxl/core/bus.c
>     :doc: cxl core
>
>  External Interfaces
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 32954059b37b..ad5a4f8f4511 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -5,7 +5,7 @@ obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL

Only the core has exports so this is not relevant for the drivers
(pci, acpi, pmem...)

> -cxl_core-y := core.o
> +cxl_core-y := core/bus.o

Not typical to include directory names in Makefiles.

>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core/bus.c
> similarity index 99%
> rename from drivers/cxl/core.c
> rename to drivers/cxl/core/bus.c
> index a2e4d54fc7bc..00b759ff92d3 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core/bus.c
> @@ -6,8 +6,8 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> -#include "cxl.h"
> -#include "mem.h"
> +#include "../cxl.h"
> +#include "../mem.h"

I'd prefer <cxl.h> and <mem.h>.

Proposed changes to fold:

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index ad5a4f8f4511..d1aaabc940f3 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,11 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CXL_BUS) += cxl_core.o
+obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_MEM) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o

-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
-cxl_core-y := core/bus.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
new file mode 100644
index 000000000000..c65e9f61abe9
--- /dev/null
+++ b/drivers/cxl/core/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_BUS) += cxl_core.o
+
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I./drivers/cxl
+cxl_core-y := bus.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 00b759ff92d3..6ce04e3976d2 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -6,8 +6,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
-#include "../cxl.h"
-#include "../mem.h"
+#include <cxl.h>
+#include <mem.h>

 /**
  * DOC: cxl core
