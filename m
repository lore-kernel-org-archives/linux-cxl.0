Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7BBC48BE8
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 18:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F5F613EB
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 18:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFRSun (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:50:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:52780 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhFRSun (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 18 Jun 2021 14:50:43 -0400
IronPort-SDR: c7UDXumy5Yl7e7RL2wqvpkShfM1tweUXiVXn41BXarZdFKaKPCkbd/xjD824RYfToPTSpBw4Lo
 AXQOPyQ6ZspA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="186982193"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="186982193"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 11:48:32 -0700
IronPort-SDR: xSdJZbSQwZZ6A9Mdf1cjuzLSrSHMbpnbT8W44TYSoQIl/blPNKhB2aCMVBLQEO44OIWK3Wb9x9
 1O62q7+wIoyA==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="485784717"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 11:48:32 -0700
Date:   Fri, 18 Jun 2021 11:48:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH V3] cxl/mem: Account for partitionable space in ram/pmem
 ranges
Message-ID: <20210618184832.GD1905674@iweiny-DESK2.sc.intel.com>
References: <20210617221620.1904031-3-ira.weiny@intel.com>
 <20210618163129.1912453-1-ira.weiny@intel.com>
 <20210618165833.2jem3rshyy7szsm6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618165833.2jem3rshyy7szsm6@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 18, 2021 at 09:58:33AM -0700, Widawsky, Ben wrote:
> On 21-06-18 09:31:29, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Memory devices may specify volatile only, persistent only, and
> > partitionable space which when added together result in a total capacity.
> > 
> > If Identify Memory Device.Partition Alignment != 0 the device supports
> > partitionable space.  This partitionable space can be split between
> > volatile and persistent space.  The total volatile and persistent sizes
> > are reported in Get Partition Info.  ie
> > 
> > 	active volatile memory = volatile only + partitionable volatile
> > 	active persistent memory = persistent only + partitionable persistent
> > 
> > Define cxl_mem_get_partition(), check for partitionable support, and use
> > cxl_mem_get_partition() if applicable.
> 
> This doesn't look right to me, but I'll happily stand corrected.
> 

[snip]

> > +
> > +static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
> > +{
> > +	int rc;
> > +
> > +	if (cxlm->partition_align_bytes == 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This...

> > +		cxlm->ram_range.start = 0;
> > +		cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
> > +		cxlm->pmem_range.start = 0;
> > +		cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
> > +		return 0;
> > +	}
> > +
> > +	rc = cxl_mem_get_partition_info(cxlm,
> > +					&cxlm->active_volatile_bytes,
> > +					&cxlm->active_persistent_bytes,
> > +					&cxlm->next_volatile_bytes,
> > +					&cxlm->next_persistent_bytes);
> > +	if (rc < 0) {
> > +		dev_err(&cxlm->pdev->dev, "Failed to query partition information\n");
> > +		return rc;
> > +	}
> 
> If the command is not supported, you're going to get back -ENXIO here and fail.
> I think what you want to do also is use IDENTIFY if PARTITION_INFO doesn't
> exist.

... should handle the situation where Get Partition Info is not supported.

I did not see it explicitly stated but I believe if Partition Align Bytes is
non-0 then partitioning is supported and Get/Set Partition Info should work.

> 
> Assuming my assessment is correct, I think it's time to make
> cxl_mem_mbox_send_cmd grow a little bit better error handling. I'd recommend
> something like this and then checking for -ENOTSUPP.
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b1a5a18dba92..3b7d8a905393 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -92,6 +92,7 @@ struct mbox_cmd {
>         size_t size_out;
>         u16 return_code;
>  #define CXL_MBOX_SUCCESS 0
> +#define CXL_MBOX_UNSUPPORTED 0x15
>  };
> 
>  static int cxl_mem_major;
> @@ -876,9 +877,15 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
>         if (rc)
>                 return rc;
> 
> -       /* TODO: Map return code to proper kernel style errno */
> -       if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
> +       switch (mbox_cmd.return_code) {
> +       case CXL_MBOX_SUCCESS:
> +               break;
> +       case CXL_MBOX_UNSUPPORTED:
> +               return -ENOTSUPP;
> +       default:
> +               /* TODO: Map return code to proper kernel style errno */
>                 return -ENXIO;
> +       }


I'm not opposed to adding this though.

Ira
