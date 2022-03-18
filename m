Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5212FC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 16:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiCRQzj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiCRQzj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 12:55:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069C27F4C6
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647622458; x=1679158458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zYAJa5HkG7GrDnP4R6bnn+zO0ZSqQjs9KIygYP5gJfE=;
  b=UYqM7vLX2sDCvEKbOhX9rEO4jLOGJRIILmV5A/Nl9qJEO11pCjfISiMJ
   ZzRHRVegtfDJpgkq2PsTwJ8O0zVPo2b0llYLLuJTQyv4O1Ep/5XeLSKbg
   zYVpOTFsKb5emXpFGlAUMrQF6K5kvGDvCABYptSZnYS25z581S3bCfIFG
   iTlY1sE2lZRDTEfMwVNGLZQL7qjpLV8tciOZoXnPiJDv++7JTgbqMa7aI
   LfdGGt4iz3udgBJUaqMv6jV+PrLrYUnQtppmNbYSrh6nbcKU7eo3/0eRj
   QwSP/BQwv0xSj6YDnegruuW6jQjm8B02BIqali8ijMcvB7d0XBLuOB7ff
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="254739005"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="254739005"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:53:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558535450"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:53:33 -0700
Date:   Fri, 18 Mar 2022 09:56:22 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linuxarm@huawei.com, qemu-devel@nongnu.org,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v8 19/46] hw/cxl/device: Add some trivial commands
Message-ID: <20220318165622.GA1119244@alison-desk>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
 <20220318150635.24600-20-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318150635.24600-20-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 18, 2022 at 03:06:08PM +0000, Jonathan Cameron wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> GET_FW_INFO and GET_PARTITION_INFO, for this emulation, is equivalent to
> info already returned in the IDENTIFY command. To have a more robust
> implementation, add those.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 

snip

>  
> +static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> +                                           CXLDeviceState *cxl_dstate,
> +                                           uint16_t *len)
> +{
> +    struct {
> +        uint64_t active_vmem;
> +        uint64_t active_pmem;
> +        uint64_t next_vmem;
> +        uint64_t next_pmem;
> +    } QEMU_PACKED *part_info = (void *)cmd->payload;
> +    QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> +    uint64_t size = cxl_dstate->pmem_size;
> +
> +    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    /* PMEM only */
> +    part_info->active_vmem = 0;
> +    part_info->next_vmem = 0;
> +    part_info->active_pmem = size / (256 << 20);
> +    part_info->next_pmem = part_info->active_pmem;

Setting next like this is logical, but it's not per the CXL spec:

8.2.9.5.2.1
"Next Persistent Capacity: If non-zero, this value shall become the
Active Persistent Capacity on the next cold reset. If both this field and the
Next Volatile Capacity field are zero, there is no pending change to the
partitioning."

next_(vmem|pmem) should start as zero and only change as the result
of a successful set_partition_info command.

From your cover letter:
* Volatile memory devices (easy but it's more code so left for now).
Wondering if this is something I could do, and follow that with
set_partition support. Does that sound reasonable? 

Alison

> +
> +    *len = sizeof(*part_info);
> +    return CXL_MBOX_SUCCESS;
> +}
> +

snip

