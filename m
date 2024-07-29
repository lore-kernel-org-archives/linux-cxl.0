Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6588145FED
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jul 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252554; cv=none; b=aRYTer1fq+zQZdNX5ucR2Ur1LSt9GTn9pNHoUggL4CLpHo3HF9h+NYzLIcCM34eq+JDuiS6JbPXVU9EtAerk6TkP/fggVReaJKwudNK+Q+BRh41gQVl1MLnwF+7e+gDVGQr5Hlh2GsYtr2W/CZAR1EstOHRcqKUwpk9D9UtagLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252554; c=relaxed/simple;
	bh=LKPLNUu+t46WwY4muRBiqjRiaiXYcXfVLoT9/CRtA/0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PINA0lJcOuutWImtcd6gmUb5N95oJZ70sg3B5JkRu/W1x2miboF5Lo2WIB8vfMQEtraoeSti806sZQtqkGUfv7NJlQsG8+XpL23PAagq2zJFEVAmz/3Jo60IpPUQpvR26RMnze73CHUoRCANZMEimpxPbSe3ICdmWprolzsDGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WXbg85w5Rz6K5fV;
	Mon, 29 Jul 2024 19:27:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 17B0B140B30;
	Mon, 29 Jul 2024 19:29:09 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 29 Jul
 2024 12:29:08 +0100
Date: Mon, 29 Jul 2024 12:29:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH 10/13] fwctl/cxl: Add support for fwctl RPC command
 to enable CXL feature commands
Message-ID: <20240729122907.0000540a@Huawei.com>
In-Reply-To: <20240718213446.1750135-11-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240718213446.1750135-11-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jul 2024 14:32:28 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> feature commands: Get Supported Features, Get Feature, and Set Feature.

I'll come back to this in reply to the cover letter, but this is
problematic because some of those features will almost certainly be
covered by standard kernel drivers and if Set Feature is enabled
those drivers will need to be hardened against the state mysteriously
changing under them.

This corner is the bit that worries me most about fwctl in general.
Anyhow, one for the cover letter / policy discussion not deep
in the patch series.


> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_DEBUG_READ_ONLY. The Set Feature call is gated by the effects
> of the feature reported by Get Supported Features call for the specific
> feature.

Break the moves of error codes etc out as a precursor no-op patch to
make review of the real guts of this easier.

Trivial comment inline.
> diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
> index 22f62034c021..01f0771148e1 100644
> --- a/drivers/fwctl/cxl/cxl.c
> +++ b/drivers/fwctl/cxl/cxl.c
> @@ -51,10 +51,133 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  	return info;
>  }

> +static bool cxlctl_validate_hw_cmds(struct cxl_mailbox *cxl_mbox,
> +				    const struct fwctl_cxl_command *send_cmd,
> +				    enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_mem_command *cmd;
> +
> +	/*
> +	 * Only supporting feature commands.
> +	 */
> +	if (!cxl_mbox->num_features)
> +		return false;
> +
> +	cmd = cxl_get_mem_command(send_cmd->id);
> +	if (!cmd)
> +		return false;
> +
> +	if (test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
> +		return false;
> +
> +	if (test_bit(cmd->info.id, cxl_mbox->exclusive_cmds))
> +		return false;
> +
> +	switch (cmd->opcode) {
> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +	case CXL_MBOX_OP_GET_FEATURE:
> +		if (scope >= FWCTL_RPC_DEBUG_READ_ONLY)
> +			return true;
> +		break;

return false here.

> +	case CXL_MBOX_OP_SET_FEATURE:
> +		return cxlctl_validate_set_features(cxl_mbox, send_cmd, scope);
> +	default:
> +		return false;
> +	};
> +
> +	return false;

And drop this.

> +}

