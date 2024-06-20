Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C261AAE3C;
	Thu, 20 Jun 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882025; cv=none; b=JTYCzJmX3YVAEy+0mx7PThqaclp/jd0mILyAjrhA0LZzpc3w8w+9GUcdXlvPwoofRU8kshUtdq084ZJIX2fFVwZsE03vS+ASiLzWZp3AKIYc/d7QxLCOBcaxR41pR9SgxBctRojZX0lB7HsoLe4mn2/49LbvdPxZAGmMf8woND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882025; c=relaxed/simple;
	bh=+15SEO7s9fPAXDlSVWgRq2WgxDQxLqYWdLWFCT6QWAk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH1H5Nl9PviTLAGLXYpjWKfF1zhtBZZosYsvOjsyndEv9+F4BfKS3ODF03+SAuGTPhFHAeEIZQAaZccb9C3v+2BTHU4FGp1k5U0HtF6fw+B/Ixd/Wp9YpyaQXgaqaB1Zm0RgTCEAG49NxaxZZUDkgPJTBH/1g2q/epnKOLAYCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4dCP59wMz6JBHx;
	Thu, 20 Jun 2024 19:13:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D9480140CB1;
	Thu, 20 Jun 2024 19:13:39 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 12:13:39 +0100
Date: Thu, 20 Jun 2024 12:13:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v3 2/3] cxl/region: Support to calculate memory tier
 abstract distance
Message-ID: <20240620121338.0000734f@Huawei.com>
In-Reply-To: <20240618084639.1419629-3-ying.huang@intel.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
	<20240618084639.1419629-3-ying.huang@intel.com>
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

On Tue, 18 Jun 2024 16:46:38 +0800
Huang Ying <ying.huang@intel.com> wrote:

> An abstract distance value must be assigned by the driver that makes
> the memory available to the system. It reflects relative performance
> and is used to place memory nodes backed by CXL regions in the appropriate
> memory tiers allowing promotion/demotion within the existing memory tiering
> mechanism.
> 
> The abstract distance is calculated based on the memory access latency
> and bandwidth of CXL regions.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


