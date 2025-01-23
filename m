Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2F2AE6C
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654452; cv=none; b=fieKa6tTYo3CxNQrLCdQWKGUEyqBdrKkcujWynJHz+LWcaV4Z79rbnhaTu607twiOh6CGhHm+8ELVLx42ZUNQ70A+eUb3K9ngQsn197BRUeheckP4lj5su+amKJ7Sez6f/ZOG9aXAWDhP0L41sVsuUDutYcU6jyRKI5czSW0kBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654452; c=relaxed/simple;
	bh=n0rh+bzSYNpcT7kkgaVdvY6xY9hFwkz8m0DFNRm3bE4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJPv6R+Qh9f/Nna0JuCB8Jn7nOflzLGGnBx13HGwS+b8TI0BGOiJmHIkN/DnteTjXEMKEMKMVu1llzhmm6f6XANUi48Dtp9Q8h7rWepzOvGtk/jR3SpiizAe0ttSAl2QmYWn9pXy29P3Lao38CQE0aTxcDwQvxIgenCsiczQRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf7gJ62dDz6K5qf;
	Fri, 24 Jan 2025 01:47:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 266D11404C4;
	Fri, 24 Jan 2025 01:47:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 18:47:27 +0100
Date: Thu, 23 Jan 2025 17:47:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 06/19] cxl/test: Add Get Supported Features mailbox
 command support
Message-ID: <20250123174726.000058e1@huawei.com>
In-Reply-To: <20250122235159.2716036-7-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:37 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add cxl-test emulation of Get Supported Features mailbox command.
> Currently only adding a test feature with feature identifier of
> all f's for testing.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v1:
> - Fix setting of num_entries endieness issue. (Jonathan)
> ---
>  include/cxl/features.h       | 23 ++++++++++
>  tools/testing/cxl/test/mem.c | 87 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index 429b9782667c..8ff7d90932d6 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -28,6 +28,29 @@ struct cxl_mbox_get_sup_feats_in {
>  	u8 reserved[2];
>  } __packed;
>  
> +/* CXL spec r3.2 Table 8-87 command effects */
> +#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
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
> +/*
> + * CXL spec r3.2 Table 8-109
> + * Get Supported Features Supported Feature Entry
> + * Atribute Flags
> + */
> +#define CXL_FEATURE_F_CHANGEABLE		BIT(0)
> +#define CXL_FEATURE_F_PERSIST_FW_UPDATE		BIT(4)
> +#define CXL_FEATURE_F_DEFAULT_SEL		BIT(5)
> +#define CXL_FEATURE_F_SAVED_SEL			BIT(6)
> +
>  struct cxl_feat_entry {
>  	uuid_t uuid;
>  	__le16 id;

A little odd to bring these defs in with the CXL test support
but I suppose that's really just a patch ordering thing.

Jonathan

