Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15E39FDC
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8ZYj6ckBz67vyB;
	Tue,  9 Jan 2024 23:27:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 285FE1400D4;
	Tue,  9 Jan 2024 23:29:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 15:29:54 +0000
Date: Tue, 9 Jan 2024 15:29:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 2/3] cxl: Cleanup unnecessary uages of cxl_port local
 vars from cxl_root
Message-ID: <20240109152953.00006d96@Huawei.com>
In-Reply-To: <170476243490.115624.648453218819673314.stgit@djiang5-mobl3>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
	<170476243490.115624.648453218819673314.stgit@djiang5-mobl3>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 08 Jan 2024 18:07:14 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Remove the local vars that points to the 'struct cxl_port' withint 'struct
> cxl_root' and refer to the port directly.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A comment on existing code inline.  Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/cdat.c |   13 +++++--------
>  drivers/cxl/port.c      |    5 +----
>  2 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index f7ba7bd2e459..140935511bab 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -290,7 +290,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -static void cxl_qos_match(struct cxl_port *root_port,
> +static void cxl_qos_match(struct cxl_root *cxl_root,
>  			  struct list_head *work_list,
>  			  struct list_head *discard_list)
>  {
> @@ -302,7 +302,7 @@ static void cxl_qos_match(struct cxl_port *root_port,
>  		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>  			return;
>  
> -		rc = device_for_each_child(&root_port->dev,
> +		rc = device_for_each_child(&cxl_root->port.dev,
>  					   (void *)&dpa_perf->qos_class,

Whilst we are here: Why is the (void *) needed or useful?

>  					   match_cxlrd_qos_class);
>  		if (!rc)

> 

