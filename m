Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E994597A
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7wfT5W2fz6J9Zb;
	Mon,  8 Jan 2024 21:59:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F28361400D9;
	Mon,  8 Jan 2024 22:01:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 14:01:43 +0000
Date: Mon, 8 Jan 2024 14:01:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v14 19/19] cxl: Check qos_class validity on memdev probe
Message-ID: <20240108140142.0000415c@Huawei.com>
In-Reply-To: <2fb48806-ae84-4e6e-82aa-712b4e511142@intel.com>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
	<170248579618.801570.17463788516390290503.stgit@djiang5-mobl3>
	<20231219164221.000011c8@Huawei.com>
	<2fb48806-ae84-4e6e-82aa-712b4e511142@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int cxl_qos_match(struct cxl_port *root_port,
> >> +			 struct list_head *work_list,
> >> +			 struct list_head *discard_list)
> >> +{
> >> +	struct cxl_dpa_perf *dpa_perf, *n;
> >> +	struct qos_class_ctx ctx;
> >> +	int rc;
> >> +
> >> +	if (list_empty(work_list))
> >> +		return 0;
> >> +
> >> +	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
> >> +		ctx = (struct qos_class_ctx) {
> >> +			.matched = false,
> >> +			.dev_qos_class = dpa_perf->qos_class,
> >> +		};  
> > 
> > 		as above the dev_qos_class doesn't change so can we not
> > 		reject it early here? 
> > 		if (!dpa_perf->qos_class)
> > 			continue; /* I think? */  
> 
> Not sure what you mean here. qos_class can be 0.
oops. Invalid was I think my intent though who knows. That was last year!
