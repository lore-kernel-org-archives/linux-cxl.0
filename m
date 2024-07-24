Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829573440
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jul 2024 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721858931; cv=none; b=KgoEEKDtam7fHHlYLWgdRy+c+ay7pdoOQ0vqAvX6qq+H2x+4k5AOxwIpcEkX93PapvGJ+6Up6E0tcNCc3CV5u3c0vcJ2/N4EnO+C9+/H9YeTS1HioIcHgMraI1ePtzGhWHGIPnFnFBRu/Iy1cPy4OWjEVBmaGe8W+GD02u1Gp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721858931; c=relaxed/simple;
	bh=IWr3O4/A5x4w5KkL6nzTgyA0U3D6t0hd9tQVl8Y4cdw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcocPZ/FQhvM4gnoUtodXW7CYsZq+Yy3anitoIm1//oGtJ12cBBCAIA5RmBfINNIdklbaS8kr3pEPEVhIuQUkYtLtk8Km5JZ/waknm2mF7Jpb37x9Dpcq8Hw1EMaTSWvuC3UYJfGFtk+1FayGashfcQhDLt1IALXa8Hj2Dl0t/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhriuYI+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhriuYI+"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66493332ebfso2483577b3.3
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jul 2024 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721858928; x=1722463728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAFu/fllX1RvcaxSCacmsTnvlkppv4gYUkHiVySgTB8=;
        b=DhriuYI+AhGrY0Zu2/S4KCE7PZ9D9M1vSRp2D9cvYDwZl9lTj7bTScOShwnPGEN/nG
         HTmQWOu5scM+1Gd5J2yQKfC8agR2E112giPEv15W8glFfRE89R8PRODplcon6FrxPeqj
         JyPk0gvctIx2SWfzyN0qcQcY+drcceQMONaUXJmyifrwaD9TynVF+TDzfBRt1W6Psvwb
         kpeSISt/PLX8v7M8lIw7+YAa3Bpxl+BZOTNCn7Ju+gktoCK1UT74kOCDaOiw05zix+Zl
         PnobZUVGsNH05LNQWnlwzsdT/R2dZywECtee5mRe1cqMfUbCE/K8Zx7QUi/6an3Gnq5m
         ij7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721858928; x=1722463728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAFu/fllX1RvcaxSCacmsTnvlkppv4gYUkHiVySgTB8=;
        b=VitOowMGFk3vep4Rhtin82TNayUtZSI2qYksIEP07zwJsX4YdlVnPp4JjQ5n+PMn2Y
         x5oZRwIivj0rc6dCxxLcyYMu+qRBFZCwcMGR2/9gV6X+LSQnDwFW9knCRySa6RzQ9c1c
         6naMH1IGtVe8vGSnhpFcW2YClJNnPXDL+icx/smf5+YrC3OE7BM8DzIx9kgclZhssceb
         A8BAmghOOuBeHFYwn1XCjdSLKZzfkO02UFqrD6RVn2SOJeIyxz93WriOVrXhjYQvbVNZ
         lK/sMB7NS2UkymPh0eYkNAmYwkZfn8jKwDctzswtafSGOMHfcRJA/snw6iXehRAB8OCS
         cATQ==
X-Gm-Message-State: AOJu0Yzm+3qwIK5Zo7stob3rwsnzsZtnXD8iUa1H//HBWbS3YipxtNPQ
	kYMuDnrvGP8WTINK8z49+2OK4uW/416ogHsBRjplrcfHyCf8sA6k
X-Google-Smtp-Source: AGHT+IHTs5aYDaTTZJAyK+EQqCxvF68xYIhg6Tkvr9ZrZbuqhQlxd4zJ0fVocXHANxFQ1wEno1j8YQ==
X-Received: by 2002:a05:690c:681:b0:66a:b6d2:c184 with SMTP id 00721157ae682-675113b3457mr13113787b3.16.1721858928135;
        Wed, 24 Jul 2024 15:08:48 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67567869dfbsm513307b3.35.2024.07.24.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:08:47 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jul 2024 15:08:45 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net
Subject: Re: [PATCH 2/2] cxl: Convert cxl_internal_send_cmd() to use 'struct
 cxl_mailbox' as input
Message-ID: <ZqF7bePpnnGXmgw-@debian>
References: <20240724185649.2574627-1-dave.jiang@intel.com>
 <20240724185649.2574627-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724185649.2574627-3-dave.jiang@intel.com>

On Wed, Jul 24, 2024 at 11:55:17AM -0700, Dave Jiang wrote:
> With the CXL mailbox context split out, cxl_internal_send_cmd() can take
> 'struct cxl_mailbox' as an input parameter rather than
> 'struct memdev_dev_state'. Change input parameter for
> cxl_internal_send_cmd() and fixup all impacted call sites.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/cxl/core/mbox.c   | 38 ++++++++++++++++++++------------------
>  drivers/cxl/core/memdev.c | 23 +++++++++++++----------
>  drivers/cxl/cxlmem.h      |  2 +-
>  drivers/cxl/pci.c         |  6 ++++--
>  drivers/cxl/pmem.c        |  6 ++++--
>  drivers/cxl/security.c    | 23 ++++++++++++-----------
>  6 files changed, 54 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9501d2576ccd..b50f6db3b244 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -225,7 +225,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>  
>  /**
>   * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
> - * @mds: The driver data for the operation
> + * @cxl_mbox: CXL mailbox context
>   * @mbox_cmd: initialized command to execute
>   *
>   * Context: Any context.
> @@ -241,10 +241,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   * error. While this distinction can be useful for commands from userspace, the
>   * kernel will only be able to use results when both are successful.
>   */
> -int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
> +int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	size_t out_size, min_out;
>  	int rc;
>  
> @@ -707,7 +706,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>  			.payload_out = out,
>  		};
>  
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  
>  		/*
>  		 * The output payload length that indicates the number
> @@ -796,7 +795,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
>  		/* At least the record number field must be valid */
>  		.min_out = 2,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		kvfree(ret);
>  		return ERR_PTR(rc);
> @@ -988,7 +987,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> -			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +			rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  			if (rc)
>  				goto free_pl;
>  			i = 0;
> @@ -999,7 +998,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	if (i) {
>  		payload->nr_recs = i;
>  		mbox_cmd.size_in = struct_size(payload, handles, i);
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  		if (rc)
>  			goto free_pl;
>  	}
> @@ -1036,7 +1035,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			.min_out = struct_size(payload, records, 0),
>  		};
>  
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  		if (rc) {
>  			dev_err_ratelimited(dev,
>  				"Event log '%d': Failed to query event records : %d",
> @@ -1107,6 +1106,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>   */
>  static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_partition_info pi;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -1116,7 +1116,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  		.size_out = sizeof(pi),
>  		.payload_out = &pi,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
>  		return rc;
>  
> @@ -1143,6 +1143,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>   */
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -1157,7 +1158,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  		.size_out = sizeof(id),
>  		.payload_out = &id,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -1185,6 +1186,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
>  static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	int rc;
>  	u32 sec_out = 0;
>  	struct cxl_get_security_output {
> @@ -1196,14 +1198,13 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  		.size_out = sizeof(out),
>  	};
>  	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
>  
>  	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
>  		return -EINVAL;
>  
> -	rc = cxl_internal_send_cmd(mds, &sec_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &sec_cmd);
>  	if (rc < 0) {
> -		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
> +		dev_err(cxl_mbox->host, "Failed to get security state : %d", rc);
>  		return rc;
>  	}
>  
> @@ -1220,9 +1221,9 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
>  		return -EINVAL;
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
> -		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> +		dev_err(cxl_mbox->host, "Failed to sanitize device : %d", rc);
>  		return rc;
>  	}
>  
> @@ -1337,6 +1338,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_mbox_set_timestamp_in pi;
>  	int rc;
> @@ -1348,7 +1350,7 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  		.payload_in = &pi,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	/*
>  	 * Command is optional. Devices may have another way of providing
>  	 * a timestamp, or may return all 0s in timestamp fields.
> @@ -1365,7 +1367,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> -	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_poison_out *po;
>  	struct cxl_mbox_poison_in pi;
>  	int nr_records = 0;
> @@ -1392,7 +1394,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  			.min_out = struct_size(po, record, 0),
>  		};
>  
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  		if (rc)
>  			break;
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7c99f89740a9..df9c9a2335e6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -281,7 +281,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_inject_poison inject;
>  	struct cxl_poison_record record;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -311,13 +311,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.size_in = sizeof(inject),
>  		.payload_in = &inject,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
>  		goto out;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> -		dev_warn_once(mds->cxlds.dev,
> +		dev_warn_once(cxl_mbox->host,
>  			      "poison inject dpa:%#llx region: %s\n", dpa,
>  			      dev_name(&cxlr->dev));
>  
> @@ -336,7 +336,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>  
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_clear_poison clear;
>  	struct cxl_poison_record record;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -375,13 +375,13 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.payload_in = &clear,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
>  		goto out;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> -		dev_warn_once(mds->cxlds.dev,
> +		dev_warn_once(cxl_mbox->host,
>  			      "poison clear dpa:%#llx region: %s\n", dpa,
>  			      dev_name(&cxlr->dev));
>  
> @@ -718,6 +718,7 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>   */
>  static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_fw_info info;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -728,7 +729,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
>  		.payload_out = &info,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -752,6 +753,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
>   */
>  static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_activate_fw activate;
>  	struct cxl_mbox_cmd mbox_cmd;
>  
> @@ -768,7 +770,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>  	activate.action = CXL_FW_ACTIVATE_OFFLINE;
>  	activate.slot = slot;
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  /**
> @@ -783,6 +785,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>   */
>  static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_transfer_fw *transfer;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -802,7 +805,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  
>  	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	kfree(transfer);
>  	return rc;
>  }
> @@ -933,7 +936,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  		.poll_count = 30,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		rc = FW_UPLOAD_ERR_RW_ERROR;
>  		goto out_free;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 17e83a2cf1be..645a2f878120 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -812,7 +812,7 @@ enum {
>  	CXL_PMEM_SEC_PASS_USER,
>  };
>  
> -int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
> +int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bd8ee14a7926..511a54335784 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -661,6 +661,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  				    struct cxl_event_interrupt_policy *policy)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd = {
>  		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
>  		.payload_out = policy,
> @@ -668,7 +669,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  	};
>  	int rc;
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		dev_err(mds->cxlds.dev,
>  			"Failed to get event interrupt policy : %d", rc);
> @@ -679,6 +680,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  				    struct cxl_event_interrupt_policy *policy)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> @@ -695,7 +697,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  		.size_in = sizeof(*policy),
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		dev_err(mds->cxlds.dev, "Failed to set event interrupt policy : %d",
>  			rc);
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 12e68b194820..946cc7af423b 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -123,6 +123,7 @@ static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
>  				    struct nd_cmd_get_config_data_hdr *cmd,
>  				    unsigned int buf_len)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_lsa get_lsa;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -144,7 +145,7 @@ static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
>  		.payload_out = cmd->out_buf,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	cmd->status = 0;
>  
>  	return rc;
> @@ -154,6 +155,7 @@ static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
>  				    struct nd_cmd_set_config_hdr *cmd,
>  				    unsigned int buf_len)
>  {
> +	struct cxl_mailbox *cxl_mbox = mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_set_lsa *set_lsa;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -180,7 +182,7 @@ static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
>  		.size_in = struct_size(set_lsa, data, cmd->in_length),
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  
>  	/*
>  	 * Set "firmware" status (4-packed bytes at the end of the input
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 21856a3f408e..38e6e5d97097 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -14,6 +14,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	unsigned long security_flags = 0;
>  	struct cxl_get_security_output {
> @@ -29,7 +30,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  		.payload_out = &out,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return 0;
>  
> @@ -70,7 +71,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_set_pass set_pass;
>  
> @@ -87,7 +88,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
>  		.payload_in = &set_pass,
>  	};
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -96,7 +97,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_disable_pass dis_pass;
>  	struct cxl_mbox_cmd mbox_cmd;
>  
> @@ -112,7 +113,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>  		.payload_in = &dis_pass,
>  	};
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -131,12 +132,12 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd = {
>  		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
>  	};
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
> @@ -144,7 +145,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	u8 pass[NVDIMM_PASSPHRASE_LEN];
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -156,7 +157,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>  		.payload_in = pass,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -169,7 +170,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_pass_erase erase;
>  	int rc;
> @@ -185,7 +186,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>  		.payload_in = &erase,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> -- 
> 2.45.2
> 
