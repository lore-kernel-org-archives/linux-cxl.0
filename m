Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC1256C70
	for <linux-cxl@vger.kernel.org>; Wed, 12 Feb 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382942; cv=none; b=WSrSI63e1YdIdCw4/V0fvnyBH9HgN7ZrcNseE6CdCQ4RLJzttJ9TBJxTsD4GBnPyU7nL4lqbBhsgX92qW8NZo7GPUCkCK6qz0pEFJgVnMZsUlYr/HNDz+LNiqos4Tv5sH/3nDtP1szRpcuNtzoJVOW4Ml/sn82I8mzjcQEOjPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382942; c=relaxed/simple;
	bh=3TX6voKE6a958ZwLZyVv9p1PBJa5XbGUexN3hwRwrFY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2O4JiOpvkUkT1QPsDIt8aqtLeesINclfm6179v/HKq6BrenYJzUAIHkTahspUaXYWXdn4KpcP5SpwPRpniKIMJ3mHlYRYUG1B5r53pdURefay3jDzMRCj0BrC69oeZu61fOdRb7f5gb4sOHrLaD7pp829LBDU1hliijg+0vSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtQs26HFGz6H7Ys;
	Thu, 13 Feb 2025 01:53:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 770D9140441;
	Thu, 13 Feb 2025 01:55:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 18:55:36 +0100
Date: Wed, 12 Feb 2025 17:55:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v5 10/15] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250212175534.000035d5@huawei.com>
In-Reply-To: <20250211182909.1650096-11-dave.jiang@intel.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
	<20250211182909.1650096-11-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 11:28:04 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> Feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the Feature reported by Get Supported Features call for the specific
> Feature.
> 
> Only "Get Supported Features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get Supported Features"
> will filter the Features that are exclusive to the kernel. The flag
> field of the Feature details will be cleared of the "Changeable"
> field and the "set feat size" will be set to 0 to indicate that
> the feature is not changeable.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One trivial suggestion inline. Feel free to ignore!

J
> ---
> v5:
> - drop unused feature_cmds. (Dan)
> - Fix index of for loop. (Ming)
> ---
>  drivers/cxl/core/features.c | 218 +++++++++++++++++++++++++++++++++++-
>  include/uapi/cxl/features.h |   1 +
>  include/uapi/fwctl/cxl.h    |  29 +++++
>  3 files changed, 246 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 923c054599ad..a43be03ada43 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -365,11 +365,225 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  	return info;
>  }

> +static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
> +				       const struct fwctl_rpc_cxl *rpc_in,
> +				       enum fwctl_rpc_scope scope,
> +				       u16 opcode)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
> +
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +	case CXL_MBOX_OP_GET_FEATURE:
> +		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
> +			return false;
> +		if (scope >= FWCTL_RPC_CONFIGURATION)
> +			return true;
> +		return false;

Trivial but could do

		return scope >= FWCTL_RPC_CONFIGURATION;

up to you though.

> +	case CXL_MBOX_OP_SET_FEATURE:
> +		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
> +			return false;
> +		return cxlctl_validate_set_features(cxlfs, rpc_in, scope);
> +	default:
> +		return false;
> +	}
> +}


