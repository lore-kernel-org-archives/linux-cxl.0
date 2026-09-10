Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BCD38F920
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084503; cv=none; b=islJ7jF9skKMRYFWXKUmJ9NA6JRaGl0/xTSScw7DOdHCBTrQRhCZMUhSOcR+pXdWu5fL54xC8jkVB+UJ61dSQJ+cZdAVdbTtCwYrGslc7jfdR+G5WA1stb7yccPW5UtaiBJNZXTe3uZDTFSCuj9a7ZRkzLC4D8Pxv9+rq8DZFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084503; c=relaxed/simple;
	bh=kGGsWduKsA/VwPBsEMqqtmuS5tIBtvmqXTx32oucayQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nk9dqh73W81REirBkiOddlqyFhJO4BNws5j69JO3/94LJ8XuBwxWaWTU7pm78F3up9XtRoDu463MO3EWnrYT68i0S1TsfDzzMS7wLFSif3O/X5Z61wkD2nsJu7zjyusZr+PWNfjoZCxO/3bzyAoAcVvaxS4ZttuiaxeMKjVttiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWNC3AUE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWNC3AUE"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-86a46577018so393966b3a.2
        for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789084501; x=1789689301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zUKsTbregIqbdospRNq3LNl3gP5CCzVFNPzIZlRCh3A=;
        b=dWNC3AUELizNgmg96SPP5ToBlcDmAdVYAbfK1q4vMxcPMUWF8Jw5mFY/Yc9sMA5fb+
         opDJYuPUIpeU/ZzSw8T0YWD+8W2S11AyScH4a0ZSB90XHbMb7CueekfoZbOm2WPWBFc5
         5brxgG+fS3fdyJdgz1Z+ZbLVh+XvyNnBIpoqSyvHvKdtmqyWRpQUfm4T2CfKe2mJXpuc
         Vat1URyFCtebdWvjMmLsyAKp+DBjsc+RBfwdThvR3XqQyUZyQ/BSNL6QBqKJOSqjJTMN
         fxYqsnltGMYMlWLEIOuArPXCE/c9n1MTXG7YpCbRv+T8R+pUPxRWXP/hIvvCHqC7S9iN
         cTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789084501; x=1789689301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUKsTbregIqbdospRNq3LNl3gP5CCzVFNPzIZlRCh3A=;
        b=FNERTkgrtZcOGxWjq0i2Sik1BKAE3Biqk8DnZKjaPgarSZ1XPyYJacSplrX0vlo5kG
         vDpYxqI3OKxXfMjDNYtc6vPIQEGM7rpKVlKRgUDzTf7uXj8tMGznvWM8kyuJ8Hu3W6Gi
         BrUlb1skpQeLBrq82Geh8ALYR9eXlvnlow8OP+t5XrZcuc/FZ7X1lh29kjyqqThLgwF5
         j74Qh5JBFoIyVr+U5hjHg/mgQndROT1LoW3s+DqS6nMSv9kXanpKjtd4pqHz76JHbw8v
         1htihyYLKmmTV9zNpmNsv1RajcmOJKiYwPEwsr+oRHg1irHAuUIVMaCqVd6EVQEmSFTj
         7W1Q==
X-Forwarded-Encrypted: i=1; AKwUvBwBZWkebIlKCzHhFvGB+q0faPwQPLzCQvCIxO9O2Oimigw2KSvYC01FkgsTykYo5xfHTSljpQKuKrs=@vger.kernel.org
X-Gm-Message-State: AFuF++ncLUwPFHsGEkuaYdQUvqPPRuKsHV5xQHsVvHFJzWLnudMgbQPB
	vXm7nPrAN6Sceo31PAK4iEvUwlxtJkcbw6xRWKMZCEfXxwnmvx7ZVWgqoDdtyr2+
X-Gm-Gg: AYBFou1pT5kqcjEm9gf0ifxDKLqUvr/aA7WWOSjpP1ISNXXNCcGQi7b2TtIG9O5MbC0
	i92NdzqgVI1BNAiVPrOR3WBCrweCsmvNxN6KFEVnYgfr9Hwd6BtFHc29nnzgPzGwYsOz7VPT4Mm
	D6ZF/2AO33g0IYeJMSKvFUiMjEIhlo7nEFo8nYv44ZCQNX8X1VmAY2UnKrWmhQaukqORuzG47i4
	f2OGrAEaCDsv3m+IDvlq01w5O6DKdi2gfyS9Ki3hmml98p8gk0uKrxdOuumP6dq/E28WQTt8QsB
	ytokb1i36IWXiWuvwdw14zWaS4yk+eaH4KGZExn7DjBo8MDxwBsvBW7sbQ9ESAxaS9hOkvBgnMA
	5naMG+rnzfcYPtWPpjuKIczJLylb2t9PLoqZJ56L0Ti+eQxppLK5yAzubLAqPbSvADVIm2dHoAe
	xhEbjKD0luZN70t1bWGEjySLqfvy+2mnq6+J1pLXykak1QJRFlS8v/yjA6nxLJjtnOLF1A7wHP7
	2jixO4D6OGeR5x+/SXIOKpNXy0=
X-Received: by 2002:a05:6a00:4206:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-86b3130ceb5mr2155573b3a.13.1789084501133;
        Thu, 10 Sep 2026 16:55:01 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b286c3f70sm254449b3a.18.2026.09.10.16.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:55:00 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 11 Sep 2026 08:56:18 +0900
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, dave.jiang@intel.com, gourry@gourry.net,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <aqNDoqRyMiTP3aNz@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-4-anisa.su@samsung.com>
 <20260908214310.2f9abccb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908214310.2f9abccb@jic23-huawei>

On Tue, Sep 08, 2026 at 09:43:10PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Sep 2026 03:15:06 -0700
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Devices which support Dynamic Capacity (DC) are configured
> > via mailbox commands. CXL r4.0 section 9.13.3 requires the host to issue
> > the Get DC Configuration command in order to properly configure DCDs.
> 
> I don't see text saying quite this and have a concern around what
> might be interpreted as being required should we ever deal deeper
> device resets.  I think you could in practice cache the result of
> this.  There is no specific implication that it 'must' be issued.
> 
> The text I see that is relevant is
>   The basic sequence to utilize Dynamic Capacity include:
> ...
>    * Issue Get Dynamic Capacity Configuration command:  The device reports its
>      number of available regions and each region's base address, length, block
>      size, and DSMAD Handle.
> 
> I read that as meaning that the host does to get the info not that
> it is needed to configure DCDs on the device side.
> 
> Anyhow, I'd just reword a tiny bit to something like
>   CXL r4.0 section 9.13.3 describes the use of the Get DC Configuration command
>   in order to obtain the DCD region/partition characteristics.
> 
Sure, done.

> > 
> > Implement the DC mailbox commands as specified in CXL 4.0 section
> > 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > information. Disable DCD if an invalid configuration is found.
> > 
> > Linux has no support for more than one dynamic capacity partition. Read
> Seems backwards. Perhaps
>   Initial enablement for Linux only supports one dynamic capacity partition.
> 
Makes sense, reworded.

> > all the partitions the device reports but validate only the first, and
> > configure it as 'dynamic ram 1'.
> > 
> > The specification requires that volatile capacity starts at DPA 0 and pmem
> > starts at the DPA immediately following it, but DC partitions only need
> > to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> > So a device could leave a gap between ram/pmem (static) capacity and its first
> > DC partition, or between one DC partition and the next.
> > 
> > However, Linux follows the precedent set by PMEM/RAM partitions and requires the
> > first DC partition to begin at the DPA immediately following static
> > capacity.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> A couple of other things inline.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 199bb986d674..a484e23b2b3a 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1349,6 +1349,241 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
> >  	return -EBUSY;
> >  }
> >  
> 
> ...
> 
> > +static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> > +			struct cxl_dc_partition *dev_part)
> > +{
> > +	u64 blk_size = le64_to_cpu(dev_part->block_size);
> > +	u64 len = le64_to_cpu(dev_part->length);
> > +
> > +	/*
> > +	 * Not an error; leave the entry empty. A partially zeroed partition
> > +	 * is rejected by the checks below. CXL r4.0 Table 8-347.
> > +	 */
> > +	if (cxl_dc_partition_unavailable(dev_part)) {
> > +		*part = (struct cxl_dc_partition_info) { };
> > +		dev_dbg(dev, "Partition 0 unavailable for DC\n");
> > +		return 0;
> > +	}
> > +
> > +	*part = (struct cxl_dc_partition_info) {
> > +		.start = le64_to_cpu(dev_part->base),
> > +		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> > +	};
> > +
> > +	/*
> > +	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
> > +	 * takes an unsigned long, which truncates blk_size on 32 bit
> 
> oh. That's ugly.  Worth just fixing?  I guess we don't want a general
> macro like that on the critical path for this patch.  Perhaps one to revisit.
>
+ 1 for revisiting.

> > +	 */
> > +	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
> > +	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
> > +		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
> > +		return -EINVAL;
> > +	}
> 
> ...
> 
> 
> > +/* Returns the number of partitions in dc_resp or -ERRNO */
> > +static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
> > +			     u8 partition_count,
> > +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> > +			     size_t dc_resp_size)
> > +{
> > +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> > +		.partition_count = partition_count,
> > +		.start_partition_index = start_partition,
> > +	};
> > +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> > +		.payload_in = &get_dc,
> > +		.size_in = sizeof(get_dc),
> > +		.size_out = dc_resp_size,
> > +		.payload_out = dc_resp,
> > +		/* The device must return at least the fixed header */
> > +		.min_out = sizeof(*dc_resp),
> > +	};
> > +	size_t expected_sz;
> > +	int rc;
> > +
> > +	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	/* A DCD reports between 1 and 8 partitions */
> > +	if (dc_resp->avail_partition_count == 0 ||
> > +	    dc_resp->avail_partition_count > CXL_MAX_DC_PARTITIONS) {
> 
> This strikes me as a compatibility issue waiting to happen.  Today the spec
> supports 8, but maybe in future it will support more and I'd not consider
> that a backwards compatibility break (which this would make it).  I'd clamp
> to CXL_MAX_DC_PARITIONS and maybe print with dev_info() if you see something
> bigger in the wild.
> 
I see... I did the below and moved it to the caller
cxl_dev_dc_identify() so the dev_err/dev_info messages are only printed
once, since the current function is called in a loop.

		avail = dc_resp->avail_partition_count;
		if (avail == 0) {
			dev_err(dev, "Device reported no DC partitions\n");
			return -EIO;
		}

		/* More than Linux handles is not a reason to refuse DCD */
		if (avail > CXL_MAX_DC_PARTITIONS) {
			dev_info(dev, "Device reported %u DC partitions, reading the first %u\n",
				 avail, CXL_MAX_DC_PARTITIONS);
			avail = CXL_MAX_DC_PARTITIONS;
		}
> > +		dev_err(mbox->host,
> > +			"Device reported %u available DC partitions, expected 1 to %u\n",
> > +			dc_resp->avail_partition_count, CXL_MAX_DC_PARTITIONS);
> > +		return -EIO;
> > +	}
> > +
> ...
> 
> 
> > +	/*
> > +	 * The payload carries trailing extent/tag count fields after the
> > +	 * partition array (CXL r4.0 Table 8-346) which the driver ignores, so
> > +	 * the response is at least, not exactly, expected_sz.
> > +	 */
> 
> More generally we shouldn't be checking that a record isn't longer than expected
> because of similar backwards compat concerns.  Check is always that it is at least
> as large as we need.
> 
Reworded to just:

/* The trailing extent/tag counts (CXL r4.0 Table 8-346) are not read */

so it doesn't imply that if we were to read the trailing fields, the
check here would be mbox.size_out == expected_sz

> > +	expected_sz = struct_size(dc_resp, partition,
> > +				  dc_resp->partitions_returned);
> > +
> > +	if (mbox_cmd.size_out < expected_sz) {
> > +		dev_err(mbox->host,
> > +			"Payload size %zu less than expected %zu for %u partitions\n",
> > +			mbox_cmd.size_out,
> > +			expected_sz,
> > +			dc_resp->partitions_returned);
> > +		return -EIO;
> > +	}
> > +
> > +	dev_dbg(mbox->host, "Read %d/%d DC partitions\n",
> > +		dc_resp->partitions_returned, dc_resp->avail_partition_count);
> > +	return dc_resp->partitions_returned;
> > +}
> > +
> 
> > +/**
> > + * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
> > + *                         device.
> > + * @mbox: Mailbox to query
> > + * @dc_info: The dynamic partition information to return
> > + *
> > + * Read every partition the device reports, but validate only the first:
> > + * Linux maps partition 0 and nothing else, so a defect in capacity the
> > + * driver never touches is not a reason to refuse the device dynamic
> > + * capacity.  The remaining entries of @partitions are left unset.
> > + *
> > + * Return: 0 if identify was executed successfully, -ERRNO on error.
> > + *         on error only dc_info is left unchanged.
> > + */
> > +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> > +			struct cxl_dc_partition_info *dc_info)
> > +{
> > +	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
> > +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;
> > +	struct device *dev = mbox->host;
> > +	u8 start_partition;
> > +	u8 num_partitions;
> > +	u8 partition_count;
> > +	size_t dc_resp_size;
> > +
> > +	/*
> > +	 * Bound requested number of partitions by mailbox payload size. The
> > +	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
> > +	 * the subtraction below from underflowing.
> > +	 */
> > +	partition_count = min_t(size_t, CXL_MAX_DC_PARTITIONS,
> > +				(mbox->payload_size - sizeof(*dc_resp) -
> > +				 sizeof(struct cxl_mbox_get_dc_config_tail)) /
> > +				sizeof(struct cxl_dc_partition));
> 
> I doubt we need min_t() rather than min() but maybe I'm missing something.
> Pretty much anything can be compared with small constants without needing
> to specify the type used.
> 
I think min() should be fine. Changed to min().

Thanks,
Anisa
> > +	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
> > +		       sizeof(struct cxl_mbox_get_dc_config_tail);
> > +
