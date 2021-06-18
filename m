Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0498FC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AB9613D1
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhFRQc6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:32:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:5771 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhFRQcx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 18 Jun 2021 12:32:53 -0400
IronPort-SDR: LcNLSZXch7qjaggdF+6N4MC0vR24ryYmJOQS7BJnjsHgzpw++FWk9uvse5FpUQ6S2wY+xzGaTt
 SXh7NSGXkJ1g==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193895764"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193895764"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:30:35 -0700
IronPort-SDR: YT7zks3NBV3mdC4Reb7PxUoeqy8dFuRMDhLuLXpx1TIWO02ACJNUni4j4R7mKTbk3gNab1v4LS
 3FmeF/QqcVsw==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="451447696"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:30:35 -0700
Date:   Fri, 18 Jun 2021 09:30:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH V2 2/3] cxl/mem: Account for partitionable space in
 ram/pmem ranges
Message-ID: <20210618163035.GB1905674@iweiny-DESK2.sc.intel.com>
References: <20210617221620.1904031-1-ira.weiny@intel.com>
 <20210617221620.1904031-3-ira.weiny@intel.com>
 <20210618145902.00001dbe@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618145902.00001dbe@Huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 18, 2021 at 02:59:02PM +0100, Jonathan Cameron wrote:
> On Thu, 17 Jun 2021 15:16:19 -0700
> <ira.weiny@intel.com> wrote:
> 
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
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Trivial editorial stuff inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> 
> > 
> > ---
> > Changes for V2:
> > 	Jonathan
> > 		Account for Get Partition Info being optional
> > 		Fix documentation
> > 	Dan
> > 		Store the active capacities in struct cxl_mem
> > 		Make cxl_mem_get_partition() static until there is a
> > 		need to export it.
> > ---
> >  drivers/cxl/mem.h |  5 +++
> >  drivers/cxl/pci.c | 98 ++++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 98 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > index 9dc34418db36..8d7bd966a298 100644
> > --- a/drivers/cxl/mem.h
> > +++ b/drivers/cxl/mem.h
> > @@ -79,5 +79,10 @@ struct cxl_mem {
> >  	u64 volatile_only_bytes;
> >  	u64 persistent_only_bytes;
> >  	u64 partition_align_bytes;
> > +
> > +	u64 active_volatile_bytes;
> > +	u64 active_persistent_bytes;
> > +	u64 next_volatile_bytes;
> > +	u64 next_persistent_bytes;
> >  };
> >  #endif /* __CXL_MEM_H__ */
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 94b7ee08ef67..341885345b53 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1455,6 +1455,55 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
> >  	return ret;
> >  }
> >  
> > +/**
> > + * cxl_mem_get_partition_info - Get partition info
> > + * @cxlm: The device to act on
> > + * @active_volatile_bytes: returned active volatile capacity; in bytes
> 
> Perhaps over documented?  Would be very very odd if _bytes attribute wasn't
> in bytes so maybe don't need to state it in the comment?

Ok...  I keep saying this to myself because all the table values are in 256MB
increments so I just kept typing it!!!  :-D

I'll remove the redundancies...

> 
> > + * @active_persistent_bytes: returned active persistent capacity; in bytes
> > + * @next_volatile_bytes: return next volatile capacity; in bytes
> > + * @next_persistent_bytes: return next persistent capacity; in bytes
> > + *
> > + * Retrieve the current partition info for the device specified.  The active
> > + * values are the current capacity in bytes.  If not 0, the 'next' values are
> 
> Definitely don't need to say they are in bytes again.

Sure...

> 
> > + * the pending values, in bytes, which take affect on next cold reset.
> > + *
> > + * Return: 0 if no error: or the result of the mailbox command.
> > + *
> > + * See CXL @8.2.9.5.2.1 Get Partition Info
> > + */
> > +static int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
> > +				      u64 *active_volatile_bytes,
> > +				      u64 *active_persistent_bytes,
> > +				      u64 *next_volatile_bytes,
> > +				      u64 *next_persistent_bytes)
> > +{
> > +	struct cxl_mbox_get_partition_info {
> > +		u64 active_volatile_cap;
> > +		u64 active_persistent_cap;
> > +		u64 next_volatile_cap;
> > +		u64 next_persistent_cap;
> > +	} __packed pi;
> > +	int rc;
> > +
> > +	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
> > +				   NULL, 0, &pi, sizeof(pi));
> > +
> 
> In my view, slightly better to not have a blank line between statement
> and error handling.

Fair enough.  I go back and forth depending on how the code looks.

All changed, v3 comming,
Ira

> 
> > +	if (rc)
> > +		return rc;
> > +
> > +	*active_volatile_bytes = le64_to_cpu(pi.active_volatile_cap);
> > +	*active_persistent_bytes = le64_to_cpu(pi.active_persistent_cap);
> > +	*next_volatile_bytes = le64_to_cpu(pi.next_volatile_cap);
> > +	*next_persistent_bytes = le64_to_cpu(pi.next_volatile_cap);
> > +
> > +	*active_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +	*active_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +	*next_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +	*next_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
> >   * @cxlm: The device.
> > @@ -1573,18 +1622,53 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
> >  			cxlm->persistent_only_bytes,
> >  			cxlm->partition_align_bytes);
> >  
> > +	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
> > +	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> > +
> > +	return 0;
> > +}
> > +
> > +static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
> > +{
> > +	int rc;
> > +
> > +	if (cxlm->partition_align_bytes == 0) {
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
> > +
> > +	dev_dbg(&cxlm->pdev->dev, "Get Partition Info\n"
> > +		"     active_volatile_bytes = %#llx\n"
> > +		"     active_persistent_bytes = %#llx\n"
> > +		"     next_volatile_bytes = %#llx\n"
> > +		"     next_persistent_bytes = %#llx\n",
> > +			cxlm->active_volatile_bytes,
> > +			cxlm->active_persistent_bytes,
> > +			cxlm->next_volatile_bytes,
> > +			cxlm->next_persistent_bytes);
> > +
> >  	/*
> >  	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> >  	 * For now, only the capacity is exported in sysfs
> >  	 */
> >  	cxlm->ram_range.start = 0;
> > -	cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
> > +	cxlm->ram_range.end = cxlm->active_volatile_bytes - 1;
> >  
> >  	cxlm->pmem_range.start = 0;
> > -	cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
> > -
> > -	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
> > -	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> > +	cxlm->pmem_range.end = cxlm->active_persistent_bytes - 1;
> >  
> >  	return 0;
> >  }
> > @@ -1618,6 +1702,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = cxl_mem_create_range_info(cxlm);
> > +	if (rc)
> > +		return rc;
> > +
> >  	return cxl_mem_add_memdev(cxlm);
> >  }
> >  
> 
