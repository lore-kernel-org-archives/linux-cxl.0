Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CB37C112
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420320; cv=none; b=tpUl1LrqqOrgrk/5dkqYswLfoPbv93vUhWL8l7zSYgBrisuuu5xcwsE1CE0VMtuPtsV37A4/TVtP/dUZz8ZAp8hN5qpdIMAuVVFCj2tN0WiVq24OC3ndKqMHga39clEXLg2ClYTz2P1y9JxNoPvmLb9vL4Nw0x26td7BatifTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420320; c=relaxed/simple;
	bh=9031/+e2mDYwf48YaLwMphJ0IcHKfmslklSCE5jnJp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHXAtY2E3jk2hA+Hg4F2dh5Fc7LxAP8u8i7z2xcM7f/hhdb62ryLZVMSTimsJbxgNntzEloGg2c6X+H/mndlwNWgxDqLLiGONUO4+LTKaSXxcPHk7xAfcgBFEoETCCy4TrsWveblBwuivaciMbjbYOYbexJ2NgSmt89iof6/rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhsZPtLg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhsZPtLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777420317; x=1808956317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9031/+e2mDYwf48YaLwMphJ0IcHKfmslklSCE5jnJp4=;
  b=DhsZPtLgg9Rhak/EG3jDcq4Kf9+fzkbpvovJEbEsFufa6rd4964UJus7
   EKlsxkhgQUNz8MGIsmsyn2yogWy8TyGWrlkjKI704/3ee/r608IIoB5wH
   htfzkEmK2sIAqufVQbW4Eu3gfwC1joHa9OhNqw8Vw+O1lcUYxVjQvUSvx
   NsucNGfdmxSPFsCv0kvWHWKNpyxU3i2ojOSI+bvS6QDL2IuYn1fX0PqF/
   DQXSQO8An+WB4arUqz1JGxdmWTKPJOavWOQuTGSvThubI0JWRjDsSKaFz
   AjCE7nCeL+KcM6fBVRIqa7XQwdnAkseYwBglXhIzPWD3T5y3mV7alEAwq
   A==;
X-CSE-ConnectionGUID: r5kmd5eLSX6OjVgKWwo3aw==
X-CSE-MsgGUID: KaThhxy1SmOJn9TbGmtfCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88650533"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="88650533"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:51:56 -0700
X-CSE-ConnectionGUID: ApKd9H24Ts+ooH4oEBGVAw==
X-CSE-MsgGUID: kotKoq0bT9ahR4UvShDDIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="238430567"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.229]) ([10.125.108.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 16:51:55 -0700
Message-ID: <1999de6e-7f14-41d2-ace2-db00faede674@intel.com>
Date: Tue, 28 Apr 2026 16:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/mbox: Support Media Operation
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, dongjoo.seo1@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20260428200410.705675-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260428200410.705675-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 1:04 PM, Davidlohr Bueso wrote:
> Add support for the Media Operation command (opcode 4402h) which
> enables targeted sanitize and zero operations on specific DPA ranges,
> as defined in CXL 4.0 Section 8.2.10.9.5.3.
> 
> Operations are only allowed on DPA ranges that do not overlap any
> hardware-committed endpoint decoder to ensure not corrupting active
> mappings.
> 
> Following the path that we currently impose for background cmds, where
> users are left with the responsibility of breaking up work sanely, this
> implementation imposes an arbitrary limit of 1Gb range to avoid hogging
> locks (ie: region/dpa cannot change while media op is on going) and resource
> monopolization such as mbox. As such, background commands are processed
> synchronously, with a 30s timeout, and currently, per spec, there is no
> optional abort it either, nor a way for the device to inform how long the
> op could take, ala Scan Media. The observation is that this differs in
> semantics regarding the sanitize case, which for whole-device continues
> to be handled asynchronously, as a special case.
> 
> Run Discovery during probe to get the device's DPA range granularity
> and which operations are supported, and expose to sysfs accordingly:
> 
>   o 'security/sanitize' is multiplexed to allow single ranged input.

Maybe just introduce a new sysfs attrib instead of multiplexing?
security/sanitize_range

>   o 'security/zero' is added, also with single ranged input.
>   o 'security/range_limit' is added so users can see the max range supported.

media_op_range_limit?

> 

Can you split this into 3 patches: discover, sanitize_range enabling, and sanitize_zero?

Would be great to get some cxl_test coverage on the new added ops. 

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Changes from v1 (https://lore.kernel.org/all/20260428000220.587249-1-dave@stgolabs.net/):
>   - Change range input length from hex to dec, leaving dpa
>     address as hex which is more intuitive. (sashiko)
>   - Move !cxlmd->dev.driver check out of overlaps logic. (sashiko)
>   - Interruptible locking for region and dpa rwsems.
>   - Reduce bgcmd timeout to 30s.
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  64 ++++--
>  drivers/cxl/core/mbox.c                 | 248 ++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               |  66 ++++++-
>  drivers/cxl/cxlmem.h                    |  67 +++++++
>  drivers/cxl/pci.c                       |   4 +
>  5 files changed, 437 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..76e48e870d9f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -117,10 +117,12 @@ Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RO) Reading this file will display the CXL security state for
>  		that device. Such states can be: 'disabled', 'sanitize', when
> -		a sanitization is currently underway; or those available only
> -		for persistent memory: 'locked', 'unlocked' or 'frozen'. This
> -		sysfs entry is select/poll capable from userspace to notify
> -		upon completion of a sanitize operation.
> +		a whole-device sanitization is currently underway; or those
> +		available only for persistent memory: 'locked', 'unlocked' or
> +		'frozen'. This sysfs entry is select/poll capable from
> +		userspace to notify upon completion of a sanitize operation.
> +		Targeted range sanitize via Media Operation does not affect
> +		this state as it completes synchronously.
>  
>  
>  What:           /sys/bus/cxl/devices/memX/security/sanitize
> @@ -129,17 +131,25 @@ KernelVersion:  v6.5
>  Contact:        linux-cxl@vger.kernel.org
>  Description:
>  		(WO) Write a boolean 'true' string value to this attribute to
> -		sanitize the device to securely re-purpose or decommission it.
> +		sanitize the entire device, to securely re-purpose or
> +		decommission it. If the device supports the Media Operation
> +		command with the sanitize operation, a DPA range may be written
> +		as 'start length' in bytes to sanitize a targeted region of

Standard convention of sysfs prefers single value to be written. So maybe we can add a sanitize_start_dpa and a sanitize_range_len attribute and use sanitize as the trigger to start the operation. And if range is 0, then we revert to the old behavior of sanitize everything?

> +		media. The start address and length must be aligned to the
> +		device's media operation granularity, and the length must not
> +		exceed the value reported in 'range_limit'. The sanitize method
> +		applied to the range is the same as for whole-device sanitize.
> +
>  		This is done by ensuring that all user data and meta-data,
>  		whether it resides in persistent capacity, volatile capacity,
>  		or the LSA, is made permanently unavailable by whatever means
>  		is appropriate for the media type. This functionality requires
> -		the device to be disabled, that is, not actively decoding any
> -		HPA ranges. This permits avoiding explicit global CPU cache
> -		management, relying instead for it to be done when a region
> -		transitions between software programmed and hardware committed
> -		states. If this file is not present, then there is no hardware
> -		support for the operation.
> +		the device or relevant range to be disabled, that is, not
> +		actively decoding any HPA ranges. This permits avoiding explicit
> +		global CPU cache management, relying instead for it to be done
> +		when a region transitions between software programmed and
> +		hardware committed states. If this file is not present, then
> +		there is no hardware support for the operation.
>  
>  
>  What            /sys/bus/cxl/devices/memX/security/erase
> @@ -158,6 +168,38 @@ Description:
>  		support for the operation.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/security/zero
> +Date:		April, 2026
> +KernelVersion:	v7.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Write a DPA range as 'start length' in bytes to this

Same comment about multiple input in a single attribute. Maybe introduce these:

security/zero_start_dpa
security/zero_len
security/zero

> +		attribute to zero a specific region of device media via the
> +		Media Operation command. The start address and length must be
> +		aligned to the device's media operation granularity, and the
> +		length must not exceed the value reported in 'range_limit'.
> +		This functionality requires the range to be disabled, that is,
> +		not actively decoding any HPA ranges. This permits avoiding
> +		explicit global CPU cache management, relying instead for it
> +		to be done when a region transitions between software
> +		programmed and hardware committed states. After completion and
> +		onlining, reads from the specified range will return zero. If
> +		this file is not present, then the device does not support the
> +		Media Operation zero command.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/security/range_limit
> +Date:		April, 2026
> +KernelVersion:	v7.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Maximum DPA range length in bytes that may be specified
> +		for a single Media Operation (sanitize or zero). Userspace
> +		must break larger operations into chunks no larger than this
> +		limit. If this file is not present, the device does not support
> +		Media Operations.
> +
> +
>  What:		/sys/bus/cxl/devices/memX/firmware/
>  Date:		April, 2023
>  KernelVersion:	v6.5
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index aaa5c6277ebf..5535c342ff83 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -160,6 +160,10 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
>  		set_bit(CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
>  			security->enabled_cmds);
>  		break;
> +	case CXL_MBOX_OP_MEDIA_OPERATION:
> +		set_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +			security->enabled_cmds);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -893,6 +897,103 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
>  
> +#define CXL_MEDIA_OP_MAX_OPS 2
> +
> +/**
> + * cxl_media_op_discover() - Discover supported media operation
> + * @mds: The device data for the operation
> + *
> + * Discover any available Media Operations.
> + *
> + * Return: 0 on success or if Media Operation is not supported,
> + * negative error code on failure.
> + */
> +int cxl_media_op_discover(struct cxl_memdev_state *mds)
> +{
> +	int rc, i;
> +	u16 num_returned;
> +	u64 granularity;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_media_op_discovery_out *disc_out __free(kfree) = NULL;
> +	struct cxl_mbox_media_op_discovery_in *disc_in __free(kfree) = NULL;

Just declare them where you are using them. That's an exception for upstream coding style.

> +
> +	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		      mds->security.enabled_cmds))
> +		return 0;
> +
> +	disc_in = kzalloc_obj(*disc_in);
> +	if (!disc_in)
> +		return -ENOMEM;
> +
> +	disc_in->class = CXL_MEDIA_OP_CLASS_GENERAL;
> +	disc_in->subclass = CXL_MEDIA_OP_GENERAL_DISCOVERY;
> +	disc_in->dpa_range_count = 0;
> +	disc_in->start_index = 0;
> +	disc_in->num_ops = cpu_to_le16(CXL_MEDIA_OP_MAX_OPS);
> +
> +	disc_out = kzalloc_flex(*disc_out, ops, CXL_MEDIA_OP_MAX_OPS);
> +	if (!disc_out)
> +		return -ENOMEM;
> +
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
> +		.payload_in = disc_in,
> +		.size_in = sizeof(*disc_in),
> +		.payload_out = disc_out,
> +		.size_out = struct_size(disc_out, ops, CXL_MEDIA_OP_MAX_OPS),
> +		.min_out = sizeof(*disc_out),
> +		.poll_count = 1,
> +		.poll_interval_ms = 1000,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_dbg(cxl_mbox->host,
> +			"Media Operation Discovery failed: %d\n", rc);
> +		return rc;
> +	}
> +
> +	num_returned = le16_to_cpu(disc_out->num_returned);
> +	if (num_returned > CXL_MEDIA_OP_MAX_OPS) {
> +		dev_dbg(cxl_mbox->host,
> +			"Discovery returned %u ops, expected max %u\n",
> +			num_returned, CXL_MEDIA_OP_MAX_OPS);
> +		return -EINVAL;
> +	}
> +
> +	granularity = le64_to_cpu(disc_out->granularity);
> +	/* spec requires granularity to be a power of 2 and a multiple of 0x40 */
> +	if (!is_power_of_2(granularity) || !IS_ALIGNED(granularity, SZ_64)) {
> +		dev_dbg(cxl_mbox->host,
> +			"Discovery returned invalid granularity: %llu\n",
> +			granularity);
> +		return -EINVAL;
> +	}
> +	mds->media_op.granularity = granularity;
> +	mds->media_op.range_limit = rounddown(SZ_1G, granularity);
> +
> +	for (i = 0; i < num_returned; i++) {
> +		u8 cls = disc_out->ops[i].class;
> +		u8 sub = disc_out->ops[i].subclass;
> +
> +		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
> +		    sub == CXL_MEDIA_OP_SANITIZE_SANITIZE)
> +			mds->media_op.sanitize_supported = true;
> +		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
> +		    sub == CXL_MEDIA_OP_SANITIZE_ZERO)
> +			mds->media_op.zero_supported = true;

Maybe you can do:

		if (cls != CXL_MEDIA_OP_CLASS_SANITIZE)
			continue;

		if (sub == CXL_MEDIA_OP_SANITIZE_SANITIZE)
			mds->media_op.sanitize_supported = true;
		else if (sub == CXL_MEDIA_OP_SANITIZE_ZERO)
			mds->media_op.zero_supported = true;
> +	}
> +
> +	dev_dbg(cxl_mbox->host,
> +		"Media Operation: granularity=%llu sanitize=%d zero=%d\n",
> +		mds->media_op.granularity,
> +		mds->media_op.sanitize_supported,
> +		mds->media_op.zero_supported);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_media_op_discover, "CXL");
> +
>  void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -1308,6 +1409,153 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  
> +static int __cxl_mem_media_op(struct cxl_memdev_state *mds, u8 class,
> +			      u8 subclass, u64 dpa_start, u64 dpa_length)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_media_op_input *payload __free(kfree) = NULL;

same comment for this. declare in place.

DJ

> +	int rc;
> +
> +	payload = kzalloc_flex(*payload, dpa_range_list, 1);
> +	if (!payload)
> +		return -ENOMEM;
> +
> +	payload->class = class;
> +	payload->subclass = subclass;
> +	payload->dpa_range_count = cpu_to_le32(1);
> +	payload->dpa_range_list[0].starting_dpa = cpu_to_le64(dpa_start);
> +	payload->dpa_range_list[0].length = cpu_to_le64(dpa_length);
> +
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
> +		.payload_in = payload,
> +		.size_in = struct_size(payload, dpa_range_list, 1),
> +		.poll_count = 30,
> +		.poll_interval_ms = 1000,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_dbg(cxl_mbox->host,
> +			"Media Operation (class=%u sub=%u) failed: %d\n",
> +			class, subclass, rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __cxl_dpa_overlap_committed(struct device *dev, void *arg)
> +{
> +	const struct resource *range = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!(cxled->cxld.flags & CXL_DECODER_F_ENABLE))
> +		return 0;
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		return 0;
> +
> +	return resource_overlaps(cxled->dpa_res, range);
> +}
> +
> +static bool cxl_media_op_dpa_overlap(struct cxl_memdev *cxlmd,
> +				     u64 dpa_start, u64 dpa_length)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct resource range = DEFINE_RES_MEM(dpa_start, dpa_length);
> +
> +	if (cxl_num_decoders_committed(endpoint) == 0)
> +		return false;
> +
> +	return device_for_each_child(&endpoint->dev, &range,
> +				     __cxl_dpa_overlap_committed);
> +}
> +
> +/**
> + * cxl_mem_media_op() - Send a Media Operation command to the device.
> + * @cxlmd: The device for the operation
> + * @class: Media operation class
> + * @subclass: Media operation subclass
> + * @dpa_start: Starting DPA in bytes
> + * @dpa_length: Length of the DPA range in bytes
> + *
> + * Send a Media Operation command with a single DPA range.
> + *
> + * Requires corresponding decoder containing the range be offline to
> + * prevent corrupting any actively mapped memory.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int cxl_mem_media_op(struct cxl_memdev *cxlmd, u8 class, u8 subclass,
> +		     u64 dpa_start, u64 dpa_length)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	u64 granularity;
> +	int rc;
> +
> +	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		      mds->security.enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	/* ensure the specific operation was reported by Discovery */
> +	if (class == CXL_MEDIA_OP_CLASS_SANITIZE) {
> +		switch (subclass) {
> +		case CXL_MEDIA_OP_SANITIZE_SANITIZE:
> +			if (!mds->media_op.sanitize_supported)
> +				return -EOPNOTSUPP;
> +			break;
> +		case CXL_MEDIA_OP_SANITIZE_ZERO:
> +			if (!mds->media_op.zero_supported)
> +				return -EOPNOTSUPP;
> +			break;
> +		}
> +	}
> +
> +	granularity = mds->media_op.granularity;
> +	if (!granularity)
> +		return -EINVAL;
> +
> +	if (dpa_length == 0 ||
> +	    !IS_ALIGNED(dpa_start, granularity) ||
> +	    !IS_ALIGNED(dpa_length, granularity)) {
> +		dev_dbg(cxl_mbox->host,
> +			"DPA range not aligned to %llu-byte granularity\n",
> +			granularity);
> +		return -EINVAL;
> +	}
> +
> +	if (dpa_length > mds->media_op.range_limit) {
> +		dev_dbg(cxl_mbox->host,
> +			"DPA range length %llu exceeds limit %llu\n",
> +			dpa_length, mds->media_op.range_limit);
> +		return -EINVAL;
> +	}
> +
> +	guard(device)(&cxlmd->dev);
> +	if (!cxlmd->dev.driver || !is_cxl_endpoint(cxlmd->endpoint))
> +		return -EBUSY;
> +
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return rc;
> +
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return rc;
> +
> +	/* reject if the DPA range overlaps a committed decoder range */
> +	if (cxl_media_op_dpa_overlap(cxlmd, dpa_start, dpa_length))
> +		return -EBUSY;
> +
> +	return __cxl_mem_media_op(mds, class, subclass, dpa_start, dpa_length);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_media_op, "CXL");
> +
>  static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
>  {
>  	int i = info->nr_partitions;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 80e65690eb77..3db4e91170a8 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -164,9 +164,20 @@ static ssize_t security_sanitize_store(struct device *dev,
>  				       const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	u64 dpa_start, dpa_length;
>  	bool sanitize;
>  	ssize_t rc;
>  
> +	/* start with ranged sanitize */
> +	if (sscanf(buf, "%llx %llu", &dpa_start, &dpa_length) == 2) {
> +		rc = cxl_mem_media_op(cxlmd, CXL_MEDIA_OP_CLASS_SANITIZE,
> +				      CXL_MEDIA_OP_SANITIZE_SANITIZE,
> +				      dpa_start, dpa_length);
> +		if (rc)
> +			return rc;
> +		return len;
> +	}
> +
>  	if (kstrtobool(buf, &sanitize) || !sanitize)
>  		return -EINVAL;
>  
> @@ -199,6 +210,40 @@ static ssize_t security_erase_store(struct device *dev,
>  static struct device_attribute dev_attr_security_erase =
>  	__ATTR(erase, 0200, NULL, security_erase_store);
>  
> +static ssize_t security_zero_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	u64 dpa_start, dpa_length;
> +	ssize_t rc;
> +
> +	if (sscanf(buf, "%llx %llu", &dpa_start, &dpa_length) != 2)
> +		return -EINVAL;
> +
> +	rc = cxl_mem_media_op(cxlmd, CXL_MEDIA_OP_CLASS_SANITIZE,
> +			      CXL_MEDIA_OP_SANITIZE_ZERO,
> +			      dpa_start, dpa_length);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static struct device_attribute dev_attr_security_zero =
> +	__ATTR(zero, 0200, NULL, security_zero_store);
> +
> +static ssize_t security_range_limit_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%llu\n", mds->media_op.range_limit);
> +}
> +static struct device_attribute dev_attr_security_range_limit =
> +	__ATTR(range_limit, 0444, security_range_limit_show, NULL);
> +
>  bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
>  			       enum poison_cmd_enabled_bits cmd)
>  {
> @@ -479,6 +524,8 @@ static struct attribute *cxl_memdev_security_attributes[] = {
>  	&dev_attr_security_state.attr,
>  	&dev_attr_security_sanitize.attr,
>  	&dev_attr_security_erase.attr,
> +	&dev_attr_security_zero.attr,
> +	&dev_attr_security_range_limit.attr,
>  	NULL,
>  };
>  
> @@ -540,14 +587,31 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/* sanitize attr serves both whole-device sanitize and ranged media op */
>  	if (a == &dev_attr_security_sanitize.attr &&
> -	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> +	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds) &&
> +	    !(test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		       mds->security.enabled_cmds) &&
> +	      mds->media_op.sanitize_supported))
>  		return 0;
>  
>  	if (a == &dev_attr_security_erase.attr &&
>  	    !test_bit(CXL_SEC_ENABLED_SECURE_ERASE, mds->security.enabled_cmds))
>  		return 0;
>  
> +	if (a == &dev_attr_security_zero.attr &&
> +	    (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		       mds->security.enabled_cmds) ||
> +	     !mds->media_op.zero_supported))
> +		return 0;
> +
> +	if (a == &dev_attr_security_range_limit.attr &&
> +	    (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		       mds->security.enabled_cmds) ||
> +	     (!mds->media_op.sanitize_supported &&
> +	      !mds->media_op.zero_supported)))
> +		return 0;
> +
>  	return a->mode;
>  }
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 776c50d1db51..2fd8dc9c331d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -251,6 +251,7 @@ enum security_cmd_enabled_bits {
>  	CXL_SEC_ENABLED_UNLOCK,
>  	CXL_SEC_ENABLED_FREEZE_SECURITY,
>  	CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
> +	CXL_SEC_ENABLED_MEDIA_OPERATIONS,
>  	CXL_SEC_ENABLED_MAX
>  };
>  
> @@ -352,6 +353,67 @@ struct cxl_fw_state {
>  	int next_slot;
>  };
>  
> +/* Media Operation classes and subclasses (CXL 4.0 Table 8-331) */
> +#define CXL_MEDIA_OP_CLASS_GENERAL		0x00
> +#define CXL_MEDIA_OP_CLASS_SANITIZE		0x01
> +
> +/* General class subclasses */
> +#define CXL_MEDIA_OP_GENERAL_DISCOVERY		0x00
> +/* Sanitize class subclasses */
> +#define CXL_MEDIA_OP_SANITIZE_SANITIZE		0x00
> +#define CXL_MEDIA_OP_SANITIZE_ZERO		0x01
> +
> +/* Media Operation DPA Range (CXL 4.0 Table 8-330) */
> +struct cxl_media_op_dpa_range {
> +	__le64 starting_dpa;
> +	__le64 length;
> +} __packed;
> +
> +/* Media Operation Input Payload (CXL 4.0 Table 8-329) */
> +struct cxl_mbox_media_op_input {
> +	u8 class;
> +	u8 subclass;
> +	u8 rsvd[2];
> +	__le32 dpa_range_count;
> +	struct cxl_media_op_dpa_range dpa_range_list[] __counted_by_le(dpa_range_count);
> +} __packed;
> +
> +/* Discovery Input Payload (CXL 4.0 Table 8-329 + Table 8-332) */
> +struct cxl_mbox_media_op_discovery_in {
> +	u8 class;
> +	u8 subclass;
> +	u8 rsvd[2];
> +	__le32 dpa_range_count;
> +	__le16 start_index;
> +	__le16 num_ops;
> +} __packed;
> +
> +/* Discovery output payload (CXL 4.0 Table 8-333) */
> +struct cxl_mbox_media_op_discovery_out {
> +	__le64 granularity;
> +	__le16 total_supported;
> +	__le16 num_returned;
> +	struct {
> +		u8 class;
> +		u8 subclass;
> +	} __packed ops[] __counted_by_le(num_returned);
> +} __packed;
> +
> +/**
> + * struct cxl_media_op_state - Media Operation state
> + *
> + * @granularity: DPA range granularity (bytes) from Discovery
> + * @range_limit: maximum DPA range length per operation (bytes)
> + * @sanitize_supported: device supports ranged sanitize
> + * @zero_supported: device supports ranged zero
> + */
> +struct cxl_media_op_state {
> +	u64 granularity;
> +	u64 range_limit;
> +	bool sanitize_supported;
> +	bool zero_supported;
> +};
> +
>  /**
>   * struct cxl_security_state - Device security state
>   *
> @@ -429,6 +491,7 @@ struct cxl_memdev_state {
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
> +	struct cxl_media_op_state media_op;
>  	struct notifier_block mce_notifier;
>  };
>  
> @@ -479,6 +542,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>  	CXL_MBOX_OP_SANITIZE		= 0x4400,
>  	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
> +	CXL_MBOX_OP_MEDIA_OPERATION	= 0x4402,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> @@ -829,6 +893,9 @@ static inline void cxl_mem_active_dec(void)
>  #endif
>  
>  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
> +int cxl_media_op_discover(struct cxl_memdev_state *mds);
> +int cxl_mem_media_op(struct cxl_memdev *cxlmd, u8 class, u8 subclass,
> +		     u64 dpa_start, u64 dpa_length);
>  
>  /**
>   * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bace662dc988..95bf773aab14 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -878,6 +878,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
>  
> +	rc = cxl_media_op_discover(mds);
> +	if (rc)
> +		dev_dbg(&pdev->dev, "No Media Operation discovered\n");
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);

