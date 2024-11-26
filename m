Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A078282F4;
	Tue, 26 Nov 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633252; cv=none; b=ZQYmEPsjy3ILLPjoTAmevA94gLMNGCZuKbqBmLKA/3PP5Bxb6azI5F8NP8mFbilAKBevzDuDtQx1FfpJXrQJAejdBqlui9+GYGuGqjCobanXqO+/g7ydaq+ZmDsNFJJxL7StyG9plYRKXuzNMSC+PxsN5q1l5+14hDTXboigQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633252; c=relaxed/simple;
	bh=zI5YOT8XnDtvtAIsnkbSBvefKhsLLJTfl9Nr7998J78=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upMBDAiaFc6QuSFsrHr+gkWKjHCNnjLORpHtqbUQBQyo/im1SDanz+B9jbiFZn7as9Uk8ijJ8l9ot1CHinn7dnn+Nq58NKLxDnG8Efvjsaoj1OHf0V7A3FLExSN+7Zqb2MeLQRd8fOd53V3CQNTP20cb9ukTtDP2wkJV5sr1q1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XyQg76FQpz6K8qh;
	Tue, 26 Nov 2024 22:58:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 308FD140447;
	Tue, 26 Nov 2024 23:00:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 16:00:45 +0100
Date: Tue, 26 Nov 2024 15:00:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Huang Ying <ying.huang@intel.com>, Yao Xingtao
	<yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/test: Simulate an x86 Low Memory Hole for tests
Message-ID: <20241126150044.0000273b@huawei.com>
In-Reply-To: <20241122155226.2068287-4-fabio.m.de.francesco@linux.intel.com>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
	<20241122155226.2068287-4-fabio.m.de.francesco@linux.intel.com>
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

On Fri, 22 Nov 2024 16:51:54 +0100
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> Simulate an x86 Low Memory Hole for the CXL tests by changing
> mock_cfmws[0] range size to 768MB and CXL Endpoint Decoder HPA range size
> to 1GB and have get_cfmws_range_start() return two different addresses
> which depend on whether the passed device is real or mock.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 050725afa45d..b61c3d78fed3 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -212,7 +212,7 @@ static struct {
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M * 4UL,
> +			.window_size = SZ_256M * 3UL,
This is changing the test whether or not we have ARCH_LOW_MEMORY_HOLE.
Doesn't that result in failures on arm64 etc?

Jonathan

>  		},
>  		.target = { 0 },
>  	},
> @@ -744,7 +744,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>  	struct cxl_endpoint_decoder *cxled;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *port, *iter;
> -	const int size = SZ_512M;
> +	const int size = SZ_1G;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_dport *dport;
>  	struct device *dev;

