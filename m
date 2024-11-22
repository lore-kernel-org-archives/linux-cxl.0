Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344D1494DA
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286973; cv=none; b=Q3b11dHZ3isCOsHRCgMWLc16BC3GXtpqMpojWJ7f+SO1QRbuCT21N5XawNhfLmIngvG0ftGo3is4TtIdN76MRftjFutp9K0Xg7menAzBdZMC0lHBkxT17OhIMncRFUJyIElRZu+Ib7MBeCRwRfha1J20PeYtHvClRi9f8pbkDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286973; c=relaxed/simple;
	bh=YwDKjxapm0lhyf4eld5Dtv0HTna9jwod8kjCxP3qdyY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr8V1wtGIuETl2cebUacTgLE/hwO+GW2NcoqYYW+1G+WUOTYQKvAtosz/pLPiioAyWXN0RbHqloNTzqj9MVT6Ug0N8t+g+9p7X3u65bjCndfoQWUoeFOB+QvfZiVtVjLhbGzsDlZ0OE4O4lCufs1Qz1j6f8860S6RIz5LHogOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvyfN3L6vz6D94b;
	Fri, 22 Nov 2024 22:49:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1195214010C;
	Fri, 22 Nov 2024 22:49:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 15:49:25 +0100
Date: Fri, 22 Nov 2024 14:49:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 15/20] fwctl/cxl: Add support for fwctl RPC
 command to enable CXL feature commands
Message-ID: <20241122144923.00007b88@huawei.com>
In-Reply-To: <20241115212745.869552-16-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-16-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_DEBUG_READ_ONLY. The Set Feature call is gated by the effects
> of the feature reported by Get Supported Features call for the specific
> feature.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

A few comments inline

Jonathan


>  
> -int cxl_send_cmd(struct cxl_mailbox *cxl_mbox, struct cxl_send_command __user *s)
> +static int cxl_send_cmd(struct cxl_mailbox *cxl_mbox, struct cxl_send_command *send,
> +			struct cxl_mbox_cmd *mbox_cmd)
> +{
> +	int rc;
> +
> +	rc = cxl_validate_cmd_from_user(mbox_cmd, cxl_mbox, send);
> +	if (rc)
> +		return rc;
> +
> +	rc = handle_mailbox_cmd_from_user(cxl_mbox, mbox_cmd, send->out.payload,
> +					  &send->out.size, &send->retval);
> +	if (rc)
> +		return rc;

return handle_mailbox_cmd_from_user()

> +
> +	return 0;
> +}
> +
> +/**
> + * handle_mailbox_cmd_from_fwctl() - Dispatch a mailbox command for userspace.
> + * @cxl_mbox: The mailbox context for the operation.
> + * @mbox_cmd: The validated mailbox command.
> + *
> + * Return:
> + *  * %0	- Mailbox transaction succeeded. This implies the mailbox
> + *		  protocol completed successfully not that the operation itself
> + *		  was successful.
> + *  * %-ENOMEM  - Couldn't allocate a bounce buffer.
> + *  * %-EINTR	- Mailbox acquisition interrupted.
> + *  * %-EXXX	- Transaction level failures.
> + *
> + * Dispatches a mailbox command on behalf of a userspace request.
> + * The output payload is copied to userspace by fwctl.
> + *
> + * See cxl_send_cmd().
> + */
> +static int handle_mailbox_cmd_from_fwctl(struct cxl_mailbox *cxl_mbox,
> +					 struct cxl_mbox_cmd *mbox_cmd)
> +{
> +	struct device *dev = cxl_mbox->host;
Not sure I'd bother for one use.

> +	struct fwctl_rpc_cxl_out *orig_out;
> +	int rc;
> +
> +	/*
> +	 * Save the payload_out pointer and move it to where hardware output
> +	 * can be copied to.
> +	 */
> +	orig_out = mbox_cmd->payload_out;
> +	mbox_cmd->payload_out = (void *)orig_out + sizeof(*orig_out);
Messing around with void * seems awkward.
Isn't this just
	mbox_cmd->payload_out = orig_out + 1;

or (I prefer the above)
	mbox_cmd->payload_out += sizeof(*orig_out);

> +
> +	dev_dbg(dev,
> +		"Submitting %s command for user\n"
> +		"\topcode: %x\n"
> +		"\tsize: %zx\n",
> +		cxl_mem_opcode_to_name(mbox_cmd->opcode),
> +		mbox_cmd->opcode, mbox_cmd->size_in);
> +
> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
> +	if (rc)
> +		return rc;
> +
> +	orig_out->retval = mbox_cmd->return_code;
> +	mbox_cmd->payload_out = (void *)orig_out;

No need to cast a pointer to void *

> +
> +	return 0;
> +}
> +
> +int cxl_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
> +		      struct fwctl_rpc_cxl *rpc_in,
> +		      struct cxl_mbox_cmd *mbox_cmd, size_t *out_len)
> +{
> +	struct cxl_send_command send_cmd = {
> +		.id = rpc_in->id,
> +		.flags = rpc_in->flags,
> +		.in.size = rpc_in->op_size,
> +		.in.payload = rpc_in->in_payload,
> +		.out.size = *out_len,
> +	};
> +	struct cxl_mem_command *cmd;
> +	int rc;
> +
> +	cmd = cxl_mem_find_command_by_id(rpc_in->id);
> +	if (!cmd)
> +		return -EINVAL;
> +	send_cmd.raw.opcode = cmd->opcode;
> +
> +	rc = cxl_validate_cmd_from_fwctl(mbox_cmd, cxl_mbox, &send_cmd);

I'd not really expect to see fwctl specific code in a function called
simply cxl_mbox_send_cmd().  Perhaps a rename is appropriate?

> +	if (rc)
> +		return rc;
> +
> +	rc = handle_mailbox_cmd_from_fwctl(cxl_mbox, mbox_cmd);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_read)(&cxl_memdev_rwsem);
> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
> +	if (rc)
> +		return rc;
> +
> +	*out_len = mbox_cmd->size_out;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);

> diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
> index ce8960a9beaa..164f6774a2c1 100644
> --- a/drivers/fwctl/cxl/cxl.c
> +++ b/drivers/fwctl/cxl/cxl.c
> @@ -77,11 +77,106 @@ static void *cxlctl_hw_info(struct fwctl_uctx *uctx, int commands, size_t *out_l
>  	return_ptr(out);
>  }
>  
> +static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
> +					 const struct fwctl_rpc_cxl *rpc_in,
> +					 enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_feat_entry *feat;
> +	bool found = false;
> +	uuid_t uuid;
> +	u16 effects, mask;

Pick an order. Reverse xmas tree maybe.


> +
> +static bool cxlctl_validate_hw_cmds(struct cxl_mailbox *cxl_mbox,
> +				    const struct fwctl_rpc_cxl *rpc_in,
> +				    enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_mem_command *cmd;
> +
> +	/*
> +	 * Only supporting feature commands for now.
> +	 */
> +	if (!cxl_mbox->num_features)
> +		return false;
> +
> +	cmd = cxl_get_mem_command_for_fwctl(cxl_mbox, rpc_in->id);
> +	if (!cmd)
> +		return false;
> +
> +	switch (cmd->opcode) {
> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +		if (scope >= FWCTL_RPC_CONFIGURATION)
> +			return true;
> +		return false;

		return scope >= FWCTL_RFC_CONFIGURATION;

> +	case CXL_MBOX_OP_GET_FEATURE:
> +		if (scope >= FWCTL_RPC_DEBUG_READ_ONLY)
> +			return true;
> +		return false;
		return scope >= FWCTL_RPC_DEBUG_READ_ONLY;

> +	case CXL_MBOX_OP_SET_FEATURE:
> +		return cxlctl_validate_set_features(cxl_mbox, rpc_in, scope);
> +	default:
> +		return false;
> +	}
> +}
> +

>  static const struct fwctl_ops cxlctl_ops = {
> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index e753d5d1d708..3e5e9c9362f5 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h
> @@ -193,5 +193,11 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
>  int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox);
>  int cxl_mailbox_user_commands_info_get(struct cxl_mailbox *cxl_mbox, int nr_cmds,
>  				       void *outbuf, size_t *out_len);
> +struct cxl_mem_command *cxl_get_mem_command(u32 id);
> +struct cxl_mem_command *
> +cxl_get_mem_command_for_fwctl(struct cxl_mailbox *cxl_mbox, u32 id);
> +int cxl_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
> +		      struct fwctl_rpc_cxl *rpc_in,
> +		      struct cxl_mbox_cmd *mbox_cmd, size_t *out_len);
>  
>  #endif
> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> index a32c4c752db6..99804fc72f28 100644
> --- a/include/uapi/fwctl/cxl.h
> +++ b/include/uapi/fwctl/cxl.h


> +/**
> + * struct fwctl_rpc_cxl_out - ioctl9FWCTL_RPC) output for CXL
(FWCTL_RPC)  9/(

> + * @size: Size of the output payload
> + * @retval: Return value from device
> + * @payload: Return data from device
> + */
> +struct fwctl_rpc_cxl_out {
> +	__u32 size;
> +	__u32 retval;
> +	__u8 payload[];
Can we add counted_by to uapi headers?

Seems there are some existing examples so I guess that is fine.

> +};
> +
>  #endif
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 9dd37849c450..4e7c8c03cfe8 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -234,4 +234,16 @@ struct cxl_send_command {
>  	} out;
>  };
>  
> +/*
> + * CXL spec r3.1 Table 8-101 Set Feature Input Payload
> + */
> +struct cxl_set_feature_input {
> +	__u8 uuid[16];
> +	__u32 flags;
> +	__u16 offset;
> +	__u8 version;
> +	__u8 reserved[9];

This first bit matches with cxl_mbox_set_feat_hdr.
Good avoid the duplication.


> +	__u8 data[];
> +} __packed;
> +
>  #endif

