Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E23DDDCD
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369120; cv=none; b=a8xfRfgaVvM6032GubudgJteiDatliJ6dIDurd5uwPx0pBUfKOEt6d2DApeZFNoxWDgVBP478LANSESQ1DvNoxXpvjDadc3/eiwuftp+pTBL065Yj6ilfn4pwTYG/FkZJO9YzU06cMEUAo2wq8jr/LwOjyhOD6nJJQvgQmMrwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369120; c=relaxed/simple;
	bh=7p4ixeNeRkuLVGx5PKLD80wF3OyfjTUPU+u0IiBYHdE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5YvRvxVukWXEMqjDStm1gIQa6MljAq6yBeH02d2FUkgx+T1qdsMdtafWAwQuQ6OoGfjqWcIAW9avUtKn0Bac3vJ01DqQHWKNm4lglH5bqZzKVBieFUrXIYlvPQiTeTN4CwKg5Unr7eoObwxw0kMJVyH0iryJX+nVA5powDsUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgFZq2sQXzJ468k;
	Wed, 25 Mar 2026 00:18:27 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8574C40584;
	Wed, 25 Mar 2026 00:18:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Mar
 2026 16:18:33 +0000
Date: Tue, 24 Mar 2026 16:18:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/mbox: Support Media Operation
Message-ID: <20260324161832.000043f4@huawei.com>
In-Reply-To: <20260323204013.4010634-2-dave@stgolabs.net>
References: <20260323204013.4010634-1-dave@stgolabs.net>
	<20260323204013.4010634-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Mar 2026 13:40:13 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add support for the Media Operation command (opcode 4402h) which
> enables targeted sanitize and zero operations on specific DPA
> ranges, as defined in CXL 4.0 Section 8.2.10.9.5.3.
> 
> Run Discovery during probe to learn the device's DPA range granularity
> and which operations are supported, and expose to sysfs accordingly:
> 
>   o 'security/sanitize' is multiplexed to allow single ranged input.
>   o 'security/zero' is added, also with single ranged input.
> 
> Operations are only allowed on DPA ranges that do not overlap any
> hardware-committed endpoint decoder to ensure not corrupting active
> mappings. Background operations are handled synchronously.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

Various comments inline,

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  31 +++-
>  drivers/cxl/core/mbox.c                 | 235 ++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               |  45 ++++-
>  drivers/cxl/cxlmem.h                    |  59 ++++++
>  drivers/cxl/pci.c                       |   4 +
>  5 files changed, 369 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c80a1b5a03db..da8f8dc92a5a 100644
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
> @@ -141,6 +143,13 @@ Description:
>  		states. If this file is not present, then there is no hardware
>  		support for the operation.
>  
> +		If the device supports the Media Operation command with the
> +		sanitize operation, a DPA range may be written as 'start
> +		length' in bytes to sanitize a targeted region of media.
> +		The start address and length must be aligned to the device's
> +		media operation granularity. The sanitize method applied to
> +		the range is the same as for whole-device sanitize.
> +
>  
>  What            /sys/bus/cxl/devices/memX/security/erase
>  Date:           June, 2023
> @@ -158,6 +167,20 @@ Description:
>  		support for the operation.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/security/zero
> +Date:		March, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Write a DPA range as 'start length' in bytes to this
> +		attribute to zero a specific region of device media via the
> +		Media Operation command. After completion, reads from the
> +		specified range will return zero.

This is only true if we've flushed any caches on the CPU Side of the link.
Will happen anyway I think as part of making the memory available.
Perhaps not worth mentioning that complexity here.

> The start address and
> +		length must be aligned to the device's media operation
> +		granularity. If this file is not present, then the device
> +		does not support the Media Operation zero command.
> +
> +
>  What:		/sys/bus/cxl/devices/memX/firmware/
>  Date:		April, 2023
>  KernelVersion:	v6.5
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index aaa5c6277ebf..b7047cb9abed 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c

>  
> +/**
> + * cxl_media_op_discover() - Discover supported media operation
> + * @mds: The device data for the operation
> + *
> + * Discover any available Media Operations.
> + *
> + * Return: 0 on success or if Media Operation is not supported,
> + * negative error code on failure.
> + */
> +#define CXL_MEDIA_OP_MAX_OPS 2
> +
> +int cxl_media_op_discover(struct cxl_memdev_state *mds)
> +{
> +	size_t out_size, in_size;
> +	void *payload_in;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_media_op_input *payload;
> +	struct cxl_mbox_media_op_discovery_args *args;

Ah. I'd forgotten this spec oddity of two different types
of trailing member, or technically a flex array in the middle
but one that is defined to be zero length if the structure
after it is present.   Maybe cleanest option is
a separate cxl_mbox_media_op_discover_input structure?  Probably
with a comment to say there is a zero length array in the middle.

> +	struct cxl_mbox_media_op_discovery_out *disc_out;
> +	int rc, i;
> +	u16 num_returned;
> +
> +	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		      mds->security.enabled_cmds))
> +		return 0;
> +
> +	in_size = sizeof(*payload) + sizeof(*args);
> +	payload_in = kzalloc(in_size, GFP_KERNEL);

With a discovery specific input structure can use kzalloc_obj() and
__free.

> +	if (!payload_in)
> +		return -ENOMEM;
> +
> +	payload = payload_in;
> +	payload->class = CXL_MEDIA_OP_CLASS_GENERAL;
> +	payload->subclass = CXL_MEDIA_OP_SUBCLASS_DISCOVERY;
> +	payload->dpa_range_count = 0;
> +
> +	args = payload_in + sizeof(*payload);
> +	args->start_index = 0;
> +	args->num_ops = cpu_to_le16(CXL_MEDIA_OP_MAX_OPS);
> +
> +	out_size = sizeof(*disc_out) +
> +		   CXL_MEDIA_OP_MAX_OPS * sizeof(disc_out->ops[0]);

kzalloc_flex() and __free() again.


> +	disc_out = kzalloc(out_size, GFP_KERNEL);
> +	if (!disc_out) {
> +		kfree(payload_in);

If you don't switch to __free(), use a second label in error path
to just free this.

> +		return -ENOMEM;
> +	}
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
> +		.payload_in = payload_in,
> +		.size_in = in_size,
> +		.payload_out = disc_out,
> +		.size_out = out_size,
> +		.min_out = sizeof(*disc_out),
> +		.poll_count = 1,
> +		.poll_interval_ms = 1000,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_dbg(cxl_mbox->host,
> +			"Media Operation Discovery failed: %d\n", rc);
> +		goto out;
> +	}
> +
> +	mds->media_op.granularity = le64_to_cpu(disc_out->granularity);
> +	num_returned = min_t(u16, le16_to_cpu(disc_out->num_returned),
> +			     CXL_MEDIA_OP_MAX_OPS);

If it claims to have returned more than we asked for, why not error out?
I might be missing something.

> +
> +	for (i = 0; i < num_returned; i++) {
> +		u8 cls = disc_out->ops[i].class;
> +		u8 sub = disc_out->ops[i].subclass;
> +
> +		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
> +		    sub == CXL_MEDIA_OP_SUBCLASS_SANITIZE)
> +			mds->media_op.sanitize_supported = true;
> +		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
> +		    sub == CXL_MEDIA_OP_SUBCLASS_ZERO)
> +			mds->media_op.zero_supported = true;
> +	}
> +
> +	dev_dbg(cxl_mbox->host,
> +		"Media Operation: granularity=%llu sanitize=%d zero=%d\n",
> +		mds->media_op.granularity,
> +		mds->media_op.sanitize_supported,
> +		mds->media_op.zero_supported);
> +
> +out:
> +	kfree(disc_out);
> +	kfree(payload_in);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_media_op_discover, "CXL");
> +
>  void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
> @@ -1308,6 +1408,141 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	return -EBUSY;
>  }
>  
> +static int __cxl_mem_media_op(struct cxl_memdev_state *mds, u8 class,
> +			      u8 subclass, u64 dpa_start, u64 dpa_length)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_media_op_input *payload;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u64 granularity;
> +	size_t size;
> +	int rc;
> +
> +	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		      mds->security.enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	/* ensure the specific operation was reported by Discovery */
> +	if (class == CXL_MEDIA_OP_CLASS_SANITIZE &&
> +	    subclass == CXL_MEDIA_OP_SUBCLASS_SANITIZE &&
> +	    !mds->media_op.sanitize_supported)
> +		return -EOPNOTSUPP;
> +	if (class == CXL_MEDIA_OP_CLASS_SANITIZE &&
> +	    subclass == CXL_MEDIA_OP_SUBCLASS_ZERO &&
> +	    !mds->media_op.zero_supported)
> +		return -EOPNOTSUPP;

Maybe nest multiple ifs.
	if (class == CXL_MEDIA_OP_CLASS_SANITIZE) {
		if (subclass == CXL_MEDIA_OP_SUBCLASS_SANITIZE &&
		    !mds->media_op.sanitize_supported)
`			return -EOPNOTSUPP;
		if (subclass = CXL_MEDIA_OP_SUBCLASS_ZERO &&
		    !mds->media_op.zero_supported)
			return -EOPNOTSUPP;
	}
Doesn't matter much whilst we have only two, but if we get lots it
may make them easier to find in the code.

...

> +
> +	size = sizeof(*payload) + sizeof(payload->dpa_range_list[0]);
> +	payload = kzalloc(size, GFP_KERNEL);
	payload = kzalloc_flex(*payload, dpa_range_list, 1);

I think... (not gotten used to these yet so I'm not 100% sure on syntax).

> +	if (!payload)
> +		return -ENOMEM;
> +
> +	payload->class = class;
> +	payload->subclass = subclass;
> +	payload->dpa_range_count = cpu_to_le32(1);
> +	payload->dpa_range_list[0].starting_dpa = cpu_to_le64(dpa_start);
> +	payload->dpa_range_list[0].length = cpu_to_le64(dpa_length);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
> +		.payload_in = payload,
> +		.size_in = size,
> +		.poll_count = 60,
> +		.poll_interval_ms = 1000,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	kfree(payload);
Apply some __free() magic.
> +
> +	if (rc < 0) {
> +		dev_dbg(cxl_mbox->host,
> +			"Media Operation (class=%u sub=%u) failed: %d\n",
> +			class, subclass, rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 99e422594885..a78a0469fb41 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c

> @@ -538,13 +572,22 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
>  	if (a == &dev_attr_security_sanitize.attr &&
> -	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> +	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds) &&
> +	    !(test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
> +		       mds->security.enabled_cmds) &&

I'd put that on one slightly long line for better readability.

Maybe add a comment on the dual use of the sanitize attribute.
That had me confused for a bit.


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

I'd put the two lines above on line line.  Bit log but more redable.

> +	     !mds->media_op.zero_supported))
> +		return 0;
> +
>  	return a->mode;
>  }
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 02054f233fc5..cde613b25581 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

> +/* Media Operation classes and subclasses (CXL 4.0 Table 8-331) */
> +#define CXL_MEDIA_OP_CLASS_GENERAL	0x00
> +#define CXL_MEDIA_OP_CLASS_SANITIZE	0x01
> +
> +#define CXL_MEDIA_OP_SUBCLASS_DISCOVERY	0x00
Maybe worth associating these more explicitly with which class they are
in?  Bit tricky to do without long names, but perhaps worth doing even
so.

> +#define CXL_MEDIA_OP_SUBCLASS_SANITIZE	0x00
> +#define CXL_MEDIA_OP_SUBCLASS_ZERO	0x01
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
> +	struct cxl_media_op_dpa_range dpa_range_list[];

__counted_by_le(dpa_range_count)

> +} __packed;
> +
> +/* Discovery operation-specific arguments (CXL 4.0 Table 8-332) */
> +struct cxl_mbox_media_op_discovery_args {
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
> +	} __packed ops[];  

__counted_by_le(num_returned) ?

> +} __packed;


