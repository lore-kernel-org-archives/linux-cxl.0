Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01839DBF4
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824043; cv=none; b=cgpQgTOPj6QNoZq2XhhKPnLtH508tZVxwRo7UlOZtInLmWiK61wqh0Fn7E5EGVj05gLAP/Ez7sMhyPenPyMroXwzV0R+5o32OwYJPbqKxhmVEJL0ykARb/cA26fR4N0S725zjn7LBOLLl+EvHlTgFD55KGdU0CBZL2DyLKB+E3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824043; c=relaxed/simple;
	bh=jYzG30G0xSj+uHMcieOxhH7gwz1QlT3MtmBJOOsWM4k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW/pI6UlVnDIF9G1L1pnln6s5kC96s0tj8LK3O5OqrRo6vWBIxM+yVp6FhuaS7q4k11WOVRPCBsxT9V3NX988RUlynSnMS+Z73IvD9x4vpg7NwGRs9/DmXzjGXsyTWxTzwlDYrIVVNBsiz/aVf5jLBkmWWTaGwATgZr8at250V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcECmyve; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcECmyve"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ccce967aa8dso970964a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824037; x=1792428837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DmcRn41ALiLXdYn14w+rbDoLtbalBs1Vh425jJ+9tNU=;
        b=LcECmyvezXwRFT9g9SvNqP0esJsOW51Qa2TZY5TMWWP8Cpj3xGiHe3EyP6zivrV308
         z5Tu9spF6YrH6eXD0nxrdMOEDZ0iZnLhTJ/oV6kYGr/FCZq6L+0I4oLkIlJyDpwb+KZe
         dC4bttyGthf9PpWATydgxjbzy6eeAOcIIPcuLa141rjm67dMm0WvpoKZfpsAKq1MhuG7
         td4bjh9zd/DWJXd1854Ksy2Hqz0xhLaC0FpQ67biCZy5bCBwMRRQ+Flhe+9pa9nz7tEm
         Cu3w77UR0BMfYkky1QEr2ZfLgqIrmYjCgJjLXpc7ZLxMb5eeoIGmutSGikqexn0Dj4Dv
         xT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824037; x=1792428837;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DmcRn41ALiLXdYn14w+rbDoLtbalBs1Vh425jJ+9tNU=;
        b=xZBt8ZEO+MhnCuhfn9qrFVSfGYvyMzWK/2X5D7YOPuBTOjfqPAsJ4VQEuDsOyd9Wqt
         kCaoj8dSzTLdlf/PobEGn8qyRFGEd6847GKOGpUR2n1hypHebf+41lmD+308pefJz9v1
         97ScziP7XK3XSouLcKhH5hvWd+lu7B2PeGNNdSgFbjToDtLcZXjXkHYlBm+azylvwfym
         xpiT/gV8OWXhrz3Q10y9HSanwsKsMLT89SJNTfJMNf0NHA4kAnyNSJfVMHoLQs+nhInG
         gdOSyHYXLwsH/wQl+h43G3dVO2APxl+4zVzUCM2IUsHfaF1lzOdevCasTKszdE6wUMBl
         jrtg==
X-Forwarded-Encrypted: i=1; AKwUvBxweIa1F8TI4ko5fjSrNCd+a3Gn/zeJtjXaN88kibUI5AJANKwQJAa+SVHOF9U2XmqvHTbuDRWFFS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK3CroHa1DZstHOYF1GD02JmH5LS685B34eauvkHnUjxy4DYgW
	R5YbtRxby5VbDzGSftz7e3TOKzB+eed44E2wWV/dPy+h3BBjJ3+NMcyo
X-Gm-Gg: AYBFou1iW6rfnjRT65oJOLleoSJaSESUJnYsY2ZLzolJYXT4iTFR2gxRm7av/yvna7M
	CW+l20GmVWGclUtbSgldFWbVsL4YN/KweDHECdpuGNWZjxpg09zUxm4QY005rzrdifem8Xst/vn
	dT+W3d7Wpxa6omMHmSE+2MH6i7U4L9zRKn0dxcq3w40fOMbYi1Wa12klc+1TU1oj9K3TFZpU5J0
	QOqTJRAAkg3W99DrQB7v2JZfz1BtYspsFGSF8GP3gI7g2qg/+y2D/qojUmR6HUjLk8mq4dhFiWb
	caNRzvOy3VIgFiVyuIzY9me3AriBFiUapwZW8dMu8EVx9xu1cJZ50RH9P2KeZbgDCfdtSs5FHrt
	Qc1h8T76uF0wz8Yy/u2fLO1ikuY5fuJlZsHXiN9abrPULPDDJF+pZGK6XdOPktGltp8TnNeGFqB
	FgTFij/o8SPFx9v0Ixx7bd6syvOJVSwVnpoG8vS9zOvWX1/bSnSZPUBazcZK8cJCG3aUI8J8pVq
	+GgdIcDB16jgV1B4WEi1ST4ZEJYzdYbRTmh3572tiqoqFZZGePa5CYXTZt0zH0FD8o7GeVugRzV
	QHyKj9BJF7jPcQ==
X-Received: by 2002:a05:6a21:4cc5:b0:3dd:d729:c62c with SMTP id adf61e73a8af0-3e16c067a60mr7864757637.54.1791824037103;
        Mon, 12 Oct 2026 09:53:57 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-24-19-224-150.hsd1.wa.comcast.net. [24.19.224.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm4204248b3a.15.2026.10.12.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:53:56 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 12 Oct 2026 09:53:54 -0700
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>, Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>
Subject: Re: [PATCH v16 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <as0QovdwD3YAhUHD@4470NRD-ASU.ssi.samsung.com>
References: <20261010225852.10727-1-anisa.su@samsung.com>
 <20261010225852.10727-3-anisa.su@samsung.com>
 <20261012124714.6556d6b4@jic23-hlaptop>
 <20261012125756.4672159e@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012125756.4672159e@jic23-hlaptop>

On Mon, Oct 12, 2026 at 12:57:56PM +0100, Jonathan Cameron wrote:
> On Mon, 12 Oct 2026 12:47:14 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 11 Oct 2026 07:54:53 +0900
> > Anisa Su <anisa.su887@gmail.com> wrote:
> > 
> > > From: Ira Weiny <iweiny@kernel.org>
> > > 
> > > Devices which support Dynamic Capacity (DC) are configured via mailbox
> > > commands. CXL r4.0 section 9.13.3 describes the use of the Get DC
> > > Configuration command in order to obtain DCD partition characteristics.
> > > 
> > > Implement the DC mailbox commands as specified in CXL 4.0 section
> > > 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > > information. Disable DCD if an invalid configuration is found.
> > > 
> > > Initial enablement for Linux only supports one dynamic capacity
> > > partition. Read all the partitions the device reports but validate
> > > only the first, and configure it as 'dynamic ram'.
> > > 
> > > The specification requires that volatile capacity starts at DPA 0 and
> > > pmem starts at the DPA immediately following it, but DC partitions only
> > > need to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1
> > > Table 8-347. So a device could leave a gap between ram/pmem (static)
> > > capacity and its first DC partition, or between one DC partition and
> > > the next.
> > > 
> > > However, Linux chooses not to support gaps between static and dynamic
> > > capacity, and requires the first DC partition to begin at the DPA
> > > immediately following static capacity.
> > > 
> > > Based on an original patch by Navneet Singh.
> > > 
> > > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > >   
> > 
> > A couple of things inline.  Only one that matters I think is the
> > cleanup.h fragility  / readability thing about constructors and 
> > destructors needing to be near each other.  That bit of guidance
> > came from a specific (and I think correct) comment from Linus
> > that he really wanted them together and if that meant declaring
> > the variables inline rather than in old school c style, then so be
> > it.  That might be in category of things Dave could cleanup up whilst
> > applying if all else is ready but that's up to him.
> >
> Forgot to add, with that tweak
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>  
> > Jonathan
> > 
> > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 199bb986d674..72af23ba288e 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c  
> > 
> > > +/* Returns the number of partitions in dc_resp or -ERRNO */
> > > +static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
> > > +			     u8 partition_count,
> > > +			     struct cxl_mbox_get_dc_config_out *dc_resp,
> > > +			     size_t dc_resp_size)
> > > +{
> > > +	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
> > > +		.partition_count = partition_count,
> > > +		.start_partition_index = start_partition,
> > > +	};
> > > +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> > > +		.payload_in = &get_dc,
> > > +		.size_in = sizeof(get_dc),
> > > +		.size_out = dc_resp_size,
> > > +		.payload_out = dc_resp,
> > > +		/* The device must return at least the fixed header */
> > > +		.min_out = sizeof(*dc_resp),
> > > +	};
> > > +	size_t expected_sz;
> > > +	int rc;
> > > +
> > > +	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
> > > +	if (rc < 0)
> > > +		return rc;
> > > +
> > > +	if (dc_resp->partitions_returned > partition_count) {
> > > +		dev_err(mbox->host, "Device returned %u partitions, requested %u\n",
> > > +			dc_resp->partitions_returned, partition_count);
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	/* The trailing extent/tag counts (CXL r4.0 Table 8-346) are not read */
> > > +	expected_sz = struct_size(dc_resp, partition,
> > > +				  dc_resp->partitions_returned);
> > > +
> > > +	if (mbox_cmd.size_out < expected_sz) {
> > > +		dev_err(mbox->host,
> > > +			"Payload size %zu less than expected %zu for %u partitions\n",
> > > +			mbox_cmd.size_out,
> > > +			expected_sz,
> > > +			dc_resp->partitions_returned);  
> > 
> > Not important, but if you do end up respinning, maybe don't have one parameter per line.
> > To me it doesn't really help with readability here.
> > 
> > > +		return -EIO;
> > > +	}
> > > +
> > > +/**
> > > + * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
> > > + *                         device.
> > > + * @mbox: Mailbox to query
> > > + * @dc_info: The dynamic partition information to return
> > > + *
> > > + * Read every partition the device reports, but validate only the first:
> > > + * Linux maps partition 0 and nothing else, so a defect in capacity the
> > > + * driver never touches is not a reason to refuse the device dynamic
> > > + * capacity.  The remaining partitions are read but not recorded.
> > > + *
> > > + * Return: 0 if identify was executed successfully, -ERRNO on error.
> > > + *         On error, @dc_info is left unchanged.
> > > + */
> > > +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> > > +			struct cxl_dc_partition_info *dc_info)
> > > +{
> > > +	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
> > > +	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;  
> > 
> > See the cleanup.h guidance.  This needs to move.
> > 
> > > +	struct device *dev = mbox->host;
> > > +	u8 avail_partitions = 0;
> > > +	u8 start_partition;
> > > +	u8 num_partitions;
> > > +	u8 partition_count;
> > > +	size_t dc_resp_size;
> > > +
> > > +	/*
> > > +	 * Bound requested number of partitions by mailbox payload size. The
> > > +	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
> > > +	 * the subtraction below from underflowing.
> > > +	 */
> > > +	partition_count = min(CXL_MAX_DC_PARTITIONS,
> > > +			      (mbox->payload_size - sizeof(*dc_resp) -
> > > +			       sizeof(struct cxl_mbox_get_dc_config_tail)) /
> > > +			      sizeof(struct cxl_dc_partition));
> > > +	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
> > > +		       sizeof(struct cxl_mbox_get_dc_config_tail);
> > > +  
> > 
> > 	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) =
> > 		kmalloc(dc_resp_size, GFP_KERNEL);
> > 	if (!dc_resp)
> > 
> > Maybe if everything else is fine, Dave can tweak this whilst applying.
> > 
> > star> +	if (!dc_resp)
> > > +		return -ENOMEM;
> > > +
> > > +	start_partition = 0;
> > > +	num_partitions = 0;
> > > +	do {
> > > +		int returned, rc;
> > > +
> > > +		returned = cxl_get_dc_config(mbox, start_partition,
> > > +					     partition_count, dc_resp,
> > > +					     dc_resp_size);
> > > +		if (returned < 0) {
> > > +			dev_err(dev, "Failed to get DC config: %d\n", returned);
> > > +			return returned;
> > > +		}
> > > +
> > > +		if (returned == 0) {
> > > +			dev_err(dev,
> > > +				"Device reported %u partitions available but returned none at index %u\n",
> > > +				dc_resp->avail_partition_count, start_partition);
> > > +			return -EIO;
> > > +		}
> > > +
> > > +		/* A DCD reports at least one partition (CXL r4.0 Table 8-346) */
> > > +		if (dc_resp->avail_partition_count == 0) {
> > > +			dev_err(dev, "Device reported no DC partitions\n");
> > > +			return -EIO;
> > > +		}
> > > +
> > > +		avail_partitions = min(dc_resp->avail_partition_count,
> > > +				       CXL_MAX_DC_PARTITIONS);
> > > +
> > > +		/*
> > > +		 * Only partition 0 is mapped, so it is the only one checked.
> > > +		 * The rest are read to complete the enumeration and dropped.
> > > +		 */
> > > +		if (start_partition == 0) {
> > > +			rc = cxl_dc_check(dev, &partitions[0],
> > > +					  &dc_resp->partition[0]);
> > > +			if (rc)
> > > +				return rc;
> > > +		}
> > > +
> > > +		num_partitions += returned;
> > > +		start_partition = num_partitions;  
> > 
> > I may be missing something subtle, but do start_partition and num_partitions ever
> > differ in value? Far as I can spot they are both only updated here.  If they
> > change in later patches and this is churn reduction ignore this comment!
> > 
Oh oops. I didn't clean up properly.
We used to copy each partition into a local array in batches:
		
	num_partitions += rc;
	for (i = start_partition, j = 0; i < num_partitions; i++, j++) {
		rc = cxl_dc_check(dev, partitions, i,
				  &dc_resp->partition[j]);
		if (rc)
			return rc;
	}
	start_partition = num_partitions;

But now we only validate the first, so it's no longer necessary. I removed the
loop but didn't clean up start_partitions/num_partitions.

Dave helped clean this up including the others you mentioned.

Thanks,
Anisa

> > 
> > > +
> > > +	} while (num_partitions < avail_partitions);
> > > +
> > > +	/* Linux only supports the 1st partition; nothing to do if it is unavailable */
> > > +	if (partitions[0].size == 0)
> > > +		return -ENODEV;
> > > +
> > > +	*dc_info = partitions[0];
> > > +	dev_dbg(dev, "Returning partition 0 %#llx size %#llx\n",
> > > +		dc_info->start, dc_info->size);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");  
> > 
> 
