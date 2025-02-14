Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF487264A8C;
	Fri, 14 Feb 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539876; cv=none; b=sqVDXGaYbBspMa9h20Qe6808d09y7/kQdw3hnvcKCJXBnHbhBaVy2CMqimtb2EgrNINHZGLs5AxklDVD2fRJOCSqJ9Ao1LuNgafCIMRemSmvFnNnKL/8qpxy000sQLMw2gAXWWqJB2+YtSmWsIAeVA6/oodyRTnkHLJeT5d0nCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539876; c=relaxed/simple;
	bh=szwuR8pT6tDcxiH9KwpNtjX7OQD4Ox2zPGrInwNgtNU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8cxrN7SCct93FTnOij+rHivzU2A/IsddU6GRXHB330FS22eda55o7koNqsR8fyPj7el7L13343/at2rU2ZKyGS9/NTr1PAshrv8kdPP65tdEX0FJavchkdCmdCMdk5f58AN5jmBtsTv8WiPC7X7O8f6dsXZPN+XS/XTbs8x0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvXwF5KtNz67ydF;
	Fri, 14 Feb 2025 21:29:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AF201402CB;
	Fri, 14 Feb 2025 21:31:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 14:31:10 +0100
Date: Fri, 14 Feb 2025 13:31:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v2 1/1] cxl/pmem: debug invalid serial number data
Message-ID: <20250214133109.00006249@huawei.com>
In-Reply-To: <20250214030952.4047438-2-wangyuquan1236@phytium.com.cn>
References: <20250214030952.4047438-1-wangyuquan1236@phytium.com.cn>
	<20250214030952.4047438-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 14 Feb 2025 11:09:52 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> For cxl-test to work properly, always +1 on mock device's serial
> number.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
A minor comment inline.  Thanks for sorting this out.

Jonathan

> ---
>  drivers/cxl/pmem.c           | 7 +++++++
>  tools/testing/cxl/test/mem.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index f9c95996e937..cc854169e50b 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -384,6 +384,13 @@ static int cxl_pmem_region_probe(struct device *dev)
>  		};
>  		info[i].offset = m->start;
>  		info[i].serial = cxlds->serial;
> +
Even though it's error path, it seems odd to check the serial
number is valid just after 'using' it.

I would do
		info[i].offset = m->start;

		if (cxlds->serial == 0) {
			//include missing alongside invalid in this error message.
			dev_err(dev, "%s: invalid or missing serial number\n",
				dev_name(&cxlmd->dev));
			rc = -NEXIO;
			goto out_nvd;
		}
		info[i].serial = cxlds->serial;

> +		if (info[i].serial == 0) {
> +			dev_err(dev, "%s: invalid serial number\n",
> +				dev_name(&cxlmd->dev));
> +			rc = -ENXIO;
> +			goto out_nvd;
> +		}
>  	}
>  	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
>  	ndr_desc.mapping = mappings;
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 8d731bd63988..9e098cf06603 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1533,7 +1533,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  
> -	cxlds->serial = pdev->id;
> +	cxlds->serial = pdev->id + 1;
>  	if (is_rcd(pdev))
>  		cxlds->rcd = true;
>  

