Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C504A1D
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656500; cv=none; b=gta7e0X4PQjmfcL/oxXucTsj6ozfF5onqOU2y+sPRlCxc11XtjRY+ycLOaUqI5WKtc59OVv2OHn1gVBPEof0OhU5Al0dyf0EyMUtslfSqG7BAdVPBlbj7VXSU4X5V46NoE8xaNgXQn3xLqwdH8Emxqib+iJxwuQVMo4pOzHThPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656500; c=relaxed/simple;
	bh=I9bvsUTAhQujmk8hiK5tF81btXxvMBfo4DvEe+5pRuQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FV7ujiCEOzDE9Le4eH0l8FOIEl0EL2gCAXvhQ8ar+NnIEKCcqV0Iasqwr6rATbngopfTUFKRxHm/FnrFQoWmmgOoHT0kweYsWOn+BVwJhwv8k2rPyJKtubKprP3NskpU+uPm0ELg5HBGTlmrY48aUhGw24MIYzRchC42hHK9/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf8Qh1FD5z6K8qs;
	Fri, 24 Jan 2025 02:21:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 862501404C4;
	Fri, 24 Jan 2025 02:21:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:21:35 +0100
Date: Thu, 23 Jan 2025 18:21:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250123182133.00004f2a@huawei.com>
In-Reply-To: <20250122235159.2716036-15-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-15-dave.jiang@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:45 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the feature reported by Get Supported Features call for the specific
> feature.
> 
> Only "get supported features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get supported features"
> will filter the features that are exclusive to the kernel and only
> report out features that are not kernel only.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few comments inline.

Jonathan

>

> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
> index cc72e73ae8d6..e65fc8479d21 100644
> --- a/drivers/cxl/features.c
> +++ b/drivers/cxl/features.c


> +static struct cxl_mem_command *
> +cxlctl_get_valid_hw_command(struct cxl_features_state *cfs,
> +			    const struct fwctl_rpc_cxl *rpc_in,
> +			    enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_mem_command *cmd;
> +
> +	if (!cfs->num_features)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	cmd = cxl_find_feature_command_by_id(rpc_in->command_id);
> +	if (!cmd)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!cxl_feature_enabled(cfs, cmd->opcode))
> +		return ERR_PTR(-EPERM);
> +
> +	switch (cmd->opcode) {
> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +	case CXL_MBOX_OP_GET_FEATURE:
> +		if (scope >= FWCTL_RPC_CONFIGURATION)
> +			return cmd;
> +		break;
> +	case CXL_MBOX_OP_SET_FEATURE:
> +		if (cxlctl_validate_set_features(cfs, rpc_in, scope))
> +			return cmd;
> +		break;

return ERR_PTR(-EINVAL); here perhaps.

> +	default:
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return ERR_PTR(-EINVAL);
Maybe better to return in the error cases above to make it clear locally
to them that they are errors.

> +}

> diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
> index 18b74252058a..55fa5b2a5d17 100644
> --- a/include/uapi/cxl/features.h
> +++ b/include/uapi/cxl/features.h
> @@ -14,6 +14,19 @@
>  #include <linux/uuid.h>
>  #endif
>  
> +/* CXL spec r3.2 Table 8-87 command effects */
> +#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)

These are duplicated with those in include/cxl/features.
Can we avoid that?


> +#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
> +#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
> +#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
> +#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
> +#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
> +#define CXL_CMD_BACKGROUND			BIT(6)
> +#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
> +#define CXL_CMD_EFFECTS_EXTEND			BIT(9)
> +#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
> +#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
> +
>  /* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */
>  struct cxl_mbox_get_sup_feats_in {
>  	__le32 count;


