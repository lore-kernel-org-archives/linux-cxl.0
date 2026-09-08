Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA835AC3F
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900198; cv=none; b=HNN1s5BHpRCyTY96gh0YEcG/APbOpfz+NTwhbA57N/tS8qG5hPy4wOkcu5pwl5EJlV89BAoFwVx9nK5Zg1p4TbXtlFbgRPzKKLMdKw/96GlWTya3FT7aqF+DqghTThdIVelAmdbDc06yBIoeRvks+ROo/dRqZzHgHrLfjIG3zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900198; c=relaxed/simple;
	bh=oWgOOj7fVPwebdG26Ld2fLKWCHoxlAz8j7VMu1LllfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lj81r4OySVivXOuJBoi1+ckVjAgHl/u3wVs//ApgZ0K2IMpav4exv1ZSS+1MLksIGgAaa6XcjH86j0U5Uuipw13TAl2JcL2rhyGSwba0rJNbMV86V7T0YVavN1cigJQ8vNCY10EMeh8/go8nXtFg0ozZLkZ299Ua1sN6Vb5m0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e53YN7qb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e53YN7qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C23F1F00A3A;
	Tue,  8 Sep 2026 20:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900196;
	bh=ldMVVNXI4msIcaKVbKty8kWBVLDN0F/ocp4FvwPaJ48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e53YN7qbbDM3yC2N8j9TsZPbnilyp6EdOAbJkFf3H8Mvnb0P5dt3tVDWu56SJ/pdQ
	 h9W3gohkzxloPQVmnPd2TcCX6DXzZCn6DCSzTcBn7XEF/5sgscRvMWz1WGezaDQRb9
	 jnfZpK7Ve7jbFp5XO9uwsIex59cwFI46OfpuMervSgxP3KTYt00OQAXM56Xnh1N2Rx
	 +b89hCRchY3BAenAByzDeoG/32TfaM9b0wmCuyYwmvoaTZg0lUCfJ6DlFnO87ozoQd
	 7dhmKE8SNQC9mE4Ce9eJd1cmojZYDlzp74Z2qq97sdwpOojtwbGVzUjiGji8zhfYMx
	 QYBwiejgc1fJg==
Date: Tue, 8 Sep 2026 21:43:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 benjamin.cheatham@amd.com, Ira Weiny <iweiny@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <20260908214310.2f9abccb@jic23-huawei>
In-Reply-To: <20260908102124.2231730-4-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-4-anisa.su@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 03:15:06 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 requires the host to issue
> the Get DC Configuration command in order to properly configure DCDs.

I don't see text saying quite this and have a concern around what
might be interpreted as being required should we ever deal deeper
device resets.  I think you could in practice cache the result of
this.  There is no specific implication that it 'must' be issued.

The text I see that is relevant is
  The basic sequence to utilize Dynamic Capacity include:
...
   * Issue Get Dynamic Capacity Configuration command:  The device reports its
     number of available regions and each region's base address, length, block
     size, and DSMAD Handle.

I read that as meaning that the host does to get the info not that
it is needed to configure DCDs on the device side.

Anyhow, I'd just reword a tiny bit to something like
  CXL r4.0 section 9.13.3 describes the use of the Get DC Configuration command
  in order to obtain the DCD region/partition characteristics.

> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Linux has no support for more than one dynamic capacity partition. Read
Seems backwards. Perhaps
  Initial enablement for Linux only supports one dynamic capacity partition.

> all the partitions the device reports but validate only the first, and
> configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux follows the precedent set by PMEM/RAM partitions and requires the
> first DC partition to begin at the DPA immediately following static
> capacity.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>

A couple of other things inline.

Thanks,

Jonathan


> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 199bb986d674..a484e23b2b3a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1349,6 +1349,241 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  

...

> +static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> +			struct cxl_dc_partition *dev_part)
> +{
> +	u64 blk_size = le64_to_cpu(dev_part->block_size);
> +	u64 len = le64_to_cpu(dev_part->length);
> +
> +	/*
> +	 * Not an error; leave the entry empty. A partially zeroed partition
> +	 * is rejected by the checks below. CXL r4.0 Table 8-347.
> +	 */
> +	if (cxl_dc_partition_unavailable(dev_part)) {
> +		*part = (struct cxl_dc_partition_info) { };
> +		dev_dbg(dev, "Partition 0 unavailable for DC\n");
> +		return 0;
> +	}
> +
> +	*part = (struct cxl_dc_partition_info) {
> +		.start = le64_to_cpu(dev_part->base),
> +		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> +	};
> +
> +	/*
> +	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
> +	 * takes an unsigned long, which truncates blk_size on 32 bit

oh. That's ugly.  Worth just fixing?  I guess we don't want a general
macro like that on the critical path for this patch.  Perhaps one to revisit.

> +	 */
> +	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
> +	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
> +		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
> +		return -EINVAL;
> +	}

...


> +/* Returns the number of partitions in dc_resp or -ERRNO */
> +static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
> +			     u8 partition_count,
> +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> +			     size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> +		.partition_count = partition_count,
> +		.start_partition_index = start_partition,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = dc_resp_size,
> +		.payload_out = dc_resp,
> +		/* The device must return at least the fixed header */
> +		.min_out = sizeof(*dc_resp),
> +	};
> +	size_t expected_sz;
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* A DCD reports between 1 and 8 partitions */
> +	if (dc_resp->avail_partition_count == 0 ||
> +	    dc_resp->avail_partition_count > CXL_MAX_DC_PARTITIONS) {

This strikes me as a compatibility issue waiting to happen.  Today the spec
supports 8, but maybe in future it will support more and I'd not consider
that a backwards compatibility break (which this would make it).  I'd clamp
to CXL_MAX_DC_PARITIONS and maybe print with dev_info() if you see something
bigger in the wild.

> +		dev_err(mbox->host,
> +			"Device reported %u available DC partitions, expected 1 to %u\n",
> +			dc_resp->avail_partition_count, CXL_MAX_DC_PARTITIONS);
> +		return -EIO;
> +	}
> +
...


> +	/*
> +	 * The payload carries trailing extent/tag count fields after the
> +	 * partition array (CXL r4.0 Table 8-346) which the driver ignores, so
> +	 * the response is at least, not exactly, expected_sz.
> +	 */

More generally we shouldn't be checking that a record isn't longer than expected
because of similar backwards compat concerns.  Check is always that it is at least
as large as we need.

> +	expected_sz = struct_size(dc_resp, partition,
> +				  dc_resp->partitions_returned);
> +
> +	if (mbox_cmd.size_out < expected_sz) {
> +		dev_err(mbox->host,
> +			"Payload size %zu less than expected %zu for %u partitions\n",
> +			mbox_cmd.size_out,
> +			expected_sz,
> +			dc_resp->partitions_returned);
> +		return -EIO;
> +	}
> +
> +	dev_dbg(mbox->host, "Read %d/%d DC partitions\n",
> +		dc_resp->partitions_returned, dc_resp->avail_partition_count);
> +	return dc_resp->partitions_returned;
> +}
> +

> +/**
> + * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
> + *                         device.
> + * @mbox: Mailbox to query
> + * @dc_info: The dynamic partition information to return
> + *
> + * Read every partition the device reports, but validate only the first:
> + * Linux maps partition 0 and nothing else, so a defect in capacity the
> + * driver never touches is not a reason to refuse the device dynamic
> + * capacity.  The remaining entries of @partitions are left unset.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + *         on error only dc_info is left unchanged.
> + */
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info)
> +{
> +	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
> +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;
> +	struct device *dev = mbox->host;
> +	u8 start_partition;
> +	u8 num_partitions;
> +	u8 partition_count;
> +	size_t dc_resp_size;
> +
> +	/*
> +	 * Bound requested number of partitions by mailbox payload size. The
> +	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
> +	 * the subtraction below from underflowing.
> +	 */
> +	partition_count = min_t(size_t, CXL_MAX_DC_PARTITIONS,
> +				(mbox->payload_size - sizeof(*dc_resp) -
> +				 sizeof(struct cxl_mbox_get_dc_config_tail)) /
> +				sizeof(struct cxl_dc_partition));

I doubt we need min_t() rather than min() but maybe I'm missing something.
Pretty much anything can be compared with small constants without needing
to specify the type used.

> +	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
> +		       sizeof(struct cxl_mbox_get_dc_config_tail);
> +
