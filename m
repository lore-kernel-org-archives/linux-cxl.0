Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B65254B05
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293516; cv=none; b=e8/6i8O4pgwG9nCY9I7yPaI95DOIMSfHHwdGf0rXu3PPh+Rf0dyJxr+MATij7bOBuN84pdHHj5t09rtYuKoYI7qn2gGzQiAXkZ04NuD99urPoMEGvP/NO6RPZ5ZOLPvcVUyM+zPkmiqU/SoEE3qI1mmHRtEUc+O0Rsf093I3GhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293516; c=relaxed/simple;
	bh=cwY8DJ2mXtiymReahBIYY+ZF2d5eAvsT/5H66g1ImKA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBwLJJ5cIbGBihDYpg4dSX11NXC1yM6S3Ozft4S9ZVjtJ6zFakZVINY32EuFtfOH5fzvioIIvJ4VvMv2qONTYXShVc9R9BGwcwSFI9zU+nCEU3YpkXL0DU++1X+oJPy4lKI1t/ZB7UtSwq7qjgFCs3IjXxjRynXs/pLkSrhHcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ysnmk2R1Yz6L55V;
	Wed, 12 Feb 2025 01:02:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CA04F1400DD;
	Wed, 12 Feb 2025 01:05:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:05:11 +0100
Date: Tue, 11 Feb 2025 17:05:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 01/15] cxl: Enumerate feature commands
Message-ID: <20250211170509.00006de4@huawei.com>
In-Reply-To: <20250207233914.2375110-2-dave.jiang@intel.com>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
	<20250207233914.2375110-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 7 Feb 2025 16:37:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add feature commands enumeration code in order to detect and enumerate
> the 3 feature related commands "get supported features", "get feature",
> and "set feature". The enumeration will help determine whether the driver
> can issue any of the 3 commands to the device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One trivial comment inline. Either way LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v4:
> - Move features cap to mbox. (Dan)
> - Drop features_cmds bitmap. (Dan)
> - Move setup of cxlfs to next patch since there's nothing to do here.
> ---
>  drivers/cxl/core/mbox.c | 36 +++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxlmem.h    |  3 +++
>  include/cxl/features.h  | 13 +++++++++++++
>  include/cxl/mailbox.h   |  3 +++
>  4 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 include/cxl/features.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9c1b9e353e3e..5f8f5945cc02 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -706,6 +706,35 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>  	return 0;
>  }
>  
> +static int check_features_opcodes(u16 opcode, int *ro_cmds, int *wr_cmds)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
> +	case CXL_MBOX_OP_GET_FEATURE:
> +		(*ro_cmds)++;
> +		return 1;
> +	case CXL_MBOX_OP_SET_FEATURE:
> +		(*wr_cmds)++;
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/* 'Get Supported Features' and 'Get Feature' */
> +#define MAX_FEATURES_READ_CMDS	2
> +static void set_features_cap(struct cxl_mailbox *cxl_mbox,
> +			     int ro_cmds, int wr_cmds)
> +{
> +	/* Setting up Features capability while walking the CEL */
> +	if (ro_cmds == MAX_FEATURES_READ_CMDS) {
> +		if (wr_cmds)
> +			cxl_mbox->feat_cap = CXL_FEATURES_RW;
> +		else
> +			cxl_mbox->feat_cap = CXL_FEATURES_RO;
> +	}
> +}
> +
>  /**
>   * cxl_walk_cel() - Walk through the Command Effects Log.
>   * @mds: The driver data for the operation
> @@ -721,7 +750,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	struct cxl_cel_entry *cel_entry;
>  	const int cel_entries = size / sizeof(*cel_entry);
>  	struct device *dev = mds->cxlds.dev;
> -	int i;
> +	int i, ro_cmds = 0, wr_cmds = 0;
>  
>  	cel_entry = (struct cxl_cel_entry *) cel;
>  
> @@ -733,6 +762,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		if (cmd) {
>  			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
>  			enabled++;
> +		} else {

All the following (is poison etc) are also effectively 'else' cases for this
if (cmd) but for simplicity of code that's not checked.

So maybe this should not be an else either?


> +			enabled += check_features_opcodes(opcode, &ro_cmds,
> +							  &wr_cmds);
>  		}
>  
>  		if (cxl_is_poison_command(opcode)) {
> @@ -748,6 +780,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>  			enabled ? "enabled" : "unsupported by driver");
>  	}
> +
> +	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
>  }
>  


