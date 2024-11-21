Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061519E965
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212137; cv=none; b=Mvf0PQenTvSqJQDjw19WXi3KbrYC3tomcU5NcXAj3ehRm9O8AV7nliC1nrU3IFLKwyrzfIYMhoxu6pm9VTLPQxCEenXtowhO0jisJ9P4D8w6npYxYXANvxo3cfxBH6HOLE+pquoRks+FDIYFF0Vm5a2QtPnBwrbA2IEUjrn/NO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212137; c=relaxed/simple;
	bh=1+CqOOZFVa1STbKV3uoys1SemgI+vv7UtluYvFQpx1k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vlen8D4bTauJf/R45BgRw9/3gfBMW2Cpg/SeqTjTJX0PeD9S07++R8ChtMn2MC1LAzQyiFPPFLdeXmv2hlTe9Q0SQX1+U9Qhc3Bdh3GHdTSEdPapryNJHMaTZKk85EqKny6Z3q4mlBu4fGiNmwmGL4GiDTsdALVPgffAnUSMReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvQvd5H36z6K6wr;
	Fri, 22 Nov 2024 01:58:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 25E001400F4;
	Fri, 22 Nov 2024 02:02:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 19:02:12 +0100
Date: Thu, 21 Nov 2024 18:02:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <20241121180211.0000452a@huawei.com>
In-Reply-To: <20241115212745.869552-10-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:42 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a cxl fwctl driver to allow sending of CXL feature
> commands from userspace through as ioctls. Create a driver skeleton for
> initial setup.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Other than what Jason already raised (most of which I missed ;)
LGTM.  With that all resolved.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 07a2983275a0..6bfd7942a3f7 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -30,6 +30,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  #define CXL_DEVICE_PMEM_REGION		7
>  #define CXL_DEVICE_DAX_REGION		8
>  #define CXL_DEVICE_PMU			9
> +#define CXL_DEVICE_FWCTL		10
Clash with HMU, but this will hopefully land well before that does and
not exactly a challenge to resolve!

J

