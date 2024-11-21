Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8ED7F477
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213911; cv=none; b=lNehgvtbJwPPB8pnXIx/2XCa7dEilQ4KnDdKMJ5N9WjPZHxIVGr53IT3GjMwpvNhpYFjT036uedktTUiVinmrM1/LtUjSuoO2B6e+HZneH4rSvX47bbslvyV0X7Q0tYUHjGBTJmXCQGc5Oqtn/sgY+vfbX6FoRwenjwvpF36ciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213911; c=relaxed/simple;
	bh=+ZALcRVsaUF3LtVwD4rAtcIcEUbnZSCbmITjaLxhjgc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiATbKwQfWCwXWf1jeMklcj/QCZwG9cxFWSWx81Yhe4r4p6udZhHaNyATaHAJno/WyhtN5wpXWkdQoPxhdtRYyG+kucDI5ahfjZPNoNmgjsT1LQDQjpdp/14EjggexS6sEqMN85VPdA1Eto3RYsVLu7AMX78kh3T/+MUMBaxLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvRdQ2jvfz6LD5s;
	Fri, 22 Nov 2024 02:31:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B3EF51400F4;
	Fri, 22 Nov 2024 02:31:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 19:31:46 +0100
Date: Thu, 21 Nov 2024 18:31:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 14/20] cxl: Move defines and error codes from
 cxlmem.h to cxl/mailbox.h
Message-ID: <20241121183144.00005648@huawei.com>
In-Reply-To: <20241115212745.869552-15-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-15-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Moving some internal definitions to cxl/mailbox.h in order to be accessed
> by FWCTL CXL driver.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I'm not keen on the rename being in this patch which is otherwise
just a move.  If that can't get pushed back to earlier patch
then do it as a precursor.

Jonathan

> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index f48eebb855f7..e753d5d1d708 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h

> +/**
> + * struct cxl_feat_entry - CXL Spec r3.1 Table 8-97
> + * @uuid: Feature identifier
> + * @id: Feature Index
> + * @get_feat_size: Get Feature Size
> + * @set_feat_size: Set Feature Size
> + * @flags: Attribute Flags
> + * @get_feat_ver: Get Feature Version
> + * @set_feat_ver: Set Feature Version
> + * @reserved: reserved, must be 0
> + */
> +struct cxl_feat_entry {
> +	uuid_t uuid;
> +	__le16 id;
> +	__le16 get_feat_size;
> +	__le16 set_feat_size;
> +	__le32 flags;
> +	u8 get_feat_ver;
> +	u8 set_feat_ver;
> +	__le16 effects;
Not documented.

> +	u8 reserved[18];
> +} __packed;

> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index e0c7e49795ed..9103bac054b9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1354,7 +1354,7 @@ static void fill_feature_vendor_test(struct cxl_feat_entry *feat)
>  	feat->flags = cpu_to_le32(BIT(5));
>  	feat->get_feat_ver = 1;
>  	feat->set_feat_ver = 1;
> -	feat->set_effects = cpu_to_le16(BIT(0) | BIT(9));
> +	feat->effects = cpu_to_le16(BIT(0) | BIT(9));

Feels like the rename should be in the earlier patch.

>  }
>  
>  static int mock_get_supported_features(struct cxl_mockmem_data *mdata,

