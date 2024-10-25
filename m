Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E82064E7;
	Fri, 25 Oct 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860664; cv=none; b=cHOQO1LPXco7lZLfFHO47KaNvz3yY1smA7xdF5xy2V1pl7PBHxBQ76BLO+cqxgIwErco0c0tJmfgJevryvspHb6UcCaM4P62bQyOVr1LcGmpCYUNcpzXOXg9z/GI198xZ0uaVF+fS9RH0+RoijW8OwQCm+0pNQQHYtA3+qy84tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860664; c=relaxed/simple;
	bh=Y1RZb6KqG1rw1MxCJ5TI3i661l03bGfsXHyk9cHPn5s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVe98GOmyDAfKDTraViRlsanxZefUddh+6tmA3ASNZI2tUkfjlkdBKghvqzj9R0P3NBJI5/JrLSUAnb1O/y0rsF5FpBka9jpL02RikC5mUALYwGfi8VWahO2WYLL93gKvervqga8lA8VqW9YemHOQvUD2oF8E/EUb78X6H7yRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZjJc5vhhz6K6PJ;
	Fri, 25 Oct 2024 20:48:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 574CB1408F9;
	Fri, 25 Oct 2024 20:50:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 14:50:57 +0200
Date: Fri, 25 Oct 2024 13:50:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v3 6/6] cxl/test: Update test code for event records to
 CXL spec rev 3.1
Message-ID: <20241025135056.00003932@Huawei.com>
In-Reply-To: <20241025114555.1363-7-shiju.jose@huawei.com>
References: <20241025114555.1363-1-shiju.jose@huawei.com>
	<20241025114555.1363-7-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 12:45:55 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Update test code for General Media, DRAM, Memory Module Event
> Records to CXL spec rev 3.1.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
I ran the test and it looked sensible.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Side note, cxl_test fails on ARM due to attempting to hotplug
memory outside of the PA range the system supports.  Problem
for another day when I'll either fix it post a proper bug report.

Jonathan

> ---
>  tools/testing/cxl/test/mem.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index ad5c4c18c5c6..614783eb3f84 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -401,6 +401,10 @@ struct cxl_test_gen_media gen_media = {
>  			.channel = 1,
>  			.rank = 30,
>  		},
> +		.component_id = { 0x3, 0x74, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd2, 0x7e, 0x2f, 0x31, 0x9b, 0x3c, 0x81, 0x4d },
> +		.cme_threshold_ev_flags = 3,
> +		.cme_count = { 33, 0, 0 },
> +		.sub_type = 0x2,
>  	},
>  };
>  
> @@ -429,6 +433,11 @@ struct cxl_test_dram dram = {
>  		.bank_group = 5,
>  		.bank = 2,
>  		.column = {0xDE, 0xAD},
> +		.component_id = { 0x1, 0x74, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd2, 0x7e, 0x2f, 0x31, 0x9b, 0x3c, 0x81, 0x4d },
> +		.sub_channel = 8,
> +		.cme_threshold_ev_flags = 2,
> +		.cvme_count = { 14, 0, 0 },
> +		.sub_type = 0x5,
>  	},
>  };
>  
> @@ -456,7 +465,10 @@ struct cxl_test_mem_module mem_module = {
>  			.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
>  			.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
>  			.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> -		}
> +		},
> +		/* .validity_flags = <set below> */
> +		.component_id = { 0x2, 0x74, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd2, 0x7e, 0x2f, 0x31, 0x9b, 0x3c, 0x81, 0x4d },
> +		.event_sub_type = 0x3,
>  	},
>  };
>  
> @@ -478,13 +490,18 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
>  
>  static void cxl_mock_add_event_logs(struct mock_event_store *mes)
>  {
> -	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
> +	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK |
> +			   CXL_GMER_VALID_COMPONENT | CXL_GMER_VALID_COMPONENT_ID_FORMAT,
>  			   &gen_media.rec.media_hdr.validity_flags);
>  
>  	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
> -			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
> +			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN | CXL_DER_VALID_SUB_CHANNEL |
> +			   CXL_DER_VALID_COMPONENT | CXL_DER_VALID_COMPONENT_ID_FORMAT,
>  			   &dram.rec.media_hdr.validity_flags);
>  
> +	put_unaligned_le16(CXL_MMER_VALID_COMPONENT | CXL_MMER_VALID_COMPONENT_ID_FORMAT,
> +			   &mem_module.rec.validity_flags);
> +
>  	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
>  	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
>  		      (struct cxl_event_record_raw *)&gen_media);

