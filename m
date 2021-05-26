Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CDEC47088
	for <linux-cxl@archiver.kernel.org>; Wed, 26 May 2021 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDD9611C2
	for <linux-cxl@archiver.kernel.org>; Wed, 26 May 2021 18:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhEZSDX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 May 2021 14:03:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:49288 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235429AbhEZSDR (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 26 May 2021 14:03:17 -0400
IronPort-SDR: /6piuKlZGOLbY7SdAafAlokXk7usvTkHkmWLh3f565c8vD3ARWlC2yok3ZyCAA96NPjSX+vrfh
 bIJSkPpviEpA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="199480477"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="199480477"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 11:01:44 -0700
IronPort-SDR: JpJxsRdfmOk+ZdneFKfO7/jMyGD8yv7JcsXHuVeeN5Sltr4+/Y0gapOYvV9tPuAgym+uXhGjbL
 +p8+KGAwKXVA==
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="477057592"
Received: from kkomeyli-mobl4.amr.corp.intel.com (HELO intel.com) ([10.252.135.245])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 11:01:44 -0700
Date:   Wed, 26 May 2021 11:01:43 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v3] cxl: Rename mem to pci
Message-ID: <20210526180143.ndu4rs5lnxgfeg6c@intel.com>
References: <CAPcyv4iUE7OyGmWJUnO-ONdNHB+i36m4OnkL0KQCO_Q2Ssz29g@mail.gmail.com>
 <20210526174413.802913-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526174413.802913-1-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-05-26 10:44:13, Ben Widawsky wrote:
> As the driver has undergone development, it's become clear that the
> majority [entirety?] of the current functionality in mem.c is actually a
> layer encapsulating functionality exposed through PCI based
> interactions. This layer can be used either in isolation or to provide
> functionality for higher level functionality.
> 
> CXL capabilities exist in a parallel domain to PCIe. CXL devices are
> enumerable and controllable via "legacy" PCIe mechanisms; however, their
> CXL capabilities are a superset of PCIe. For example, a CXL device may
> be connected to a non-CXL capable PCIe root port, and therefore will not
> be able to participate in CXL.mem or CXL.cache operations, but can still
> be accessed through PCIe mechanisms for CXL.io operations.
> 
> To properly represent the PCI nature of this driver, and in preparation for
> introducing a new driver for the CXL.mem / HDM decoder (Host-managed Device
> Memory) capabilities of a CXL memory expander, rename mem.c to pci.c so that
> mem.c is available for this new driver.
> 
> The result of the change is that there is a clear layering distinction
> in the driver, and a systems administrator may load only the cxl_pci
> module and gain access to such operations as, firmware update, offline
> provisioning of devices, and error collection. In addition to freeing up
> the file name for another purpose, there are two primary reasons this is
> useful,
>     1. Acting upon devices which don't have full CXL capabilities. This
>        may happen for instance if the CXL device is connected in a CXL
>        unaware part of the platform topology.
>     2. Userspace-first provisioning for devices without kernel driver
>        interference. This may be useful when provisioning a new device
>        in a specific manner that might otherwise be blocked or prevented
>        by the real CXL mem driver.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]

I forgot to put the reasoning for v3...

I accidentally left acpi.o in the Makefile. The only diff from v2 is acpi.o is
dropped.

Ben
