Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227F947D93F
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032797; cv=none; b=H0nGYsPUb/cb0n/E6Uu1P/BJ04lY6X0mRWAxEQY75XMZhpOyA4VNxyYCh6HYX5koYcKZxbpN/uHH9HbwEK9qRbaG2YQQnQkd+pY1EjbQwxObdY4uVg7LEK0i32b55GwI5TP04capOY9HVBQz6TeZbsN6dyj0EFHRgVDHCfEoOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032797; c=relaxed/simple;
	bh=GRD477/R1dJo8WjmRWRkgrAV7fRGev410mDkdhc18d4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJ4B510HXe37OBsAtclirpwgbjp3yyIzuUY04M7fBL4Qqy/gq7OeOA8QT/3EM6qc7hcBDh+YqCfeDiJ+Njt680uztVkCsVfg43OltHmrWDJjytfXBNJws+CSH01aiOYz9xloJp9cEiet1thFF3tdR1JrQ1cGZqsCDXmwDOoDfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/bobHJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/bobHJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409111F000FF;
	Mon, 21 Sep 2026 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032793;
	bh=DItpegv/+EpvzI/TD9/Y/p0vbdP9jlky1qKw7Z7EVzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V/bobHJaLS7peL+ucyJOw0OoR2T8tziXGMjvkVzadF6vD3mpUyrcAj3ZGJ+yA/U3D
	 ZiXa3vTv2ox1B1V/meYqAqA55w/xfmWel4Azf2OvsYJuoHKhmF4jX8yZ3u+wpwg7p1
	 qOJp3p9exVqK105ShlFpq9Z1ixDxEhWK07HOFSmAPqNKOwVSQF9smMELGauOChY/mC
	 9+edeLr4R0wRGxTFW5qvtPg5yAbh3A4Z1QdKery/NMOsWKWHX8E90XR3kD663O8CFp
	 ybX6hH9l7zdoo20hJBbGsnXfp74UnFI5zEzKiX2/uPmgrAaluPoIPqtfV7sV/LlrKT
	 uOwXwFPjsR3zQ==
Date: Tue, 22 Sep 2026 00:19:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, Gregory Price
 <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <20260922001949.2a0af2e4@jic23-hlaptop>
In-Reply-To: <20260918203049.7273-3-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
	<20260918203049.7273-3-anisa.su@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 13:30:11 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 describes the use of
> the Get DC Configuration command in order to obtain DCD partition
> characteristics.

Wrap has ended up a tiny bit uneven after edits.  I'd rewrap whole commit
to 75 chars if you happen to respin for other reasons.

> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Initial enablement for Linux only supports one dynamic capacity
> partition. Read all the partitions the device reports but validate
> only the first, and configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux chooses not to support gaps between static and dynamic
> capacity, and requires the first DC partition to begin at the DPA
> immediately following static capacity.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Co-developed-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


A personal aim of successfully giving the most trivial feedback ever
is achieved.  See below.



> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..15df8db314d9 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -643,6 +643,54 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> +{
> +	struct cxl_dc_partition_info dc_info = { };
> +	struct device *dev = mds->cxlds.dev;
> +	u64 total;
> +	int rc;
> +
> +	if (!mds->cxlds.media_ready)
> +		return 0;
> +
> +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> +	if (rc) {
> +		dev_warn(dev,
> +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (dc_info.start < info->size) {
> +		dev_err(dev,
> +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> +			dc_info.start, info->size);
> +		return -EINVAL;
> +	}
> +
> +	/* A gap between static capacity and the DC partition is not supported */
> +	if (dc_info.start > info->size) {
> +		dev_warn(dev,
> +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> +			 dc_info.start, info->size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (check_add_overflow(info->size, dc_info.size, &total)) {
> +		dev_err(dev,
> +			"DC partition 0 size %#llx overflows DPA space ending at %#llx\n",
> +			dc_info.size, info->size);
> +		return -EINVAL;
> +	}
> +
> +	info->size = total;
> +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> +		dc_info.start, dc_info.size);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
> +
>  
It is already the case that there is a double line here which is not
common in this file. I have no idea why it is here!
If you happen to respin maybe drop it?

>  /**
>   * cxl_set_capacity: initialize dpa by a driver without a mailbox.

