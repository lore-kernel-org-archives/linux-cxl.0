Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F8EC5
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653612; cv=none; b=r7Kn9gXDLmJopdPuL/jO06kp+4Xt1WNlHi5GTieug3FDVbVxeuay0NMLMBg6zsBoqVQWz6Uv9evgyrui8Grt/2o1xsenfHFGpdRhNmSqdY/DwrDOhuiahHNAYiONqTvLLZHGQUeAu3xdRhRNzd5lkRnzxLAvJMDci0d6iNnTm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653612; c=relaxed/simple;
	bh=MB+Uu1hshq1a7vPVb+/AEXs05BSBYXeS9v8DwZGhZ0M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMRWUQgn8iKPSZZPSy7cmcEjbiqWNY3IDdHg7xo2opA2hE8FLZBrePacxa7/Zs7iB4YkcsXf0RmmT68uxKuSYT2kqYQ+gctaLG0+w/SXkj2CVsqanvSZRnqHL8GzrP+kKjC2uKjfSpEsfhiBqmCpQcEhBb1gmqC33P/cR/pfZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf7M82Shrz6K5cC;
	Fri, 24 Jan 2025 01:33:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 992BF140A70;
	Fri, 24 Jan 2025 01:33:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 18:33:27 +0100
Date: Thu, 23 Jan 2025 17:33:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 03/19] cxl: Enumerate feature commands
Message-ID: <20250123173326.0000410e@huawei.com>
In-Reply-To: <20250122235159.2716036-4-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add feature commands enumeration code in order to detect and enumerate
> the 3 feature related commands "get supported features", "get feature",
> and "set feature". The enumeration will help determine whether the driver
> can issue any of the 3 commands to the device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    |  3 +++
>  include/cxl/features.h  |  7 +++++++
>  include/cxl/mailbox.h   |  1 +
>  4 files changed, 52 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index bdb8f060f2c1..5e21ff99d70f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -38,6 +38,21 @@ static bool cxl_raw_allow_all;
>  	.flags = _flags,                                                       \
>  	}
>  
> +#define cxl_for_each_feature_cmd(cmd)                                          \
> +	for ((cmd) = &cxl_feature_commands[0];                                 \
> +	     ((cmd) - cxl_feature_commands) < ARRAY_SIZE(cxl_feature_commands); (cmd)++)
> +
> +#define CXL_FEATURE_CMD(_id, sin, sout, _flags)                                \
> +	[CXL_FEATURE_ID_##_id] = {                                             \
> +	.info =	{                                                              \
> +			.id = CXL_FEATURE_ID_##_id,                            \
> +			.size_in = sin,                                        \
> +			.size_out = sout,                                      \
> +		},                                                             \
> +	.opcode = CXL_MBOX_OP_##_id,                                           \
> +	.flags = _flags,                                                       \
> +	}
> +
>  #define CXL_VARIABLE_PAYLOAD	~0U
>  /*
>   * This table defines the supported mailbox commands for the driver. This table
> @@ -69,6 +84,13 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>  };
>  
> +#define CXL_FEATURE_COMMAND_ID_MAX 3
Why do we need this define separately from CXL_FEATURE_ID_MAX as I'm fairly sure they 
must always be the same.  A [] array would work here too.

> +static struct cxl_mem_command cxl_feature_commands[CXL_FEATURE_COMMAND_ID_MAX] = {
> +	CXL_FEATURE_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_FEATURE_CMD(GET_FEATURE, 0xf, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_FEATURE_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
> +};

> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index b92da1e92780..7a8be3c621a1 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -5,6 +5,13 @@
>  
>  struct cxl_mailbox;
>  
> +enum feature_cmds {
> +	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
> +	CXL_FEATURE_ID_GET_FEATURE,
> +	CXL_FEATURE_ID_SET_FEATURE,
> +	CXL_FEATURE_ID_MAX,

No comma on that one as it's meant to always be the terminator.

> +};


