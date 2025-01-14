Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F1229635;
	Tue, 14 Jan 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853407; cv=none; b=TXSgl7BckW/ifhfMiXF04Hp/muyUuSGR8vn307W2nQZC8JArWpwZeimgQmR51R9MmRCNQXCwmeHAn+mKEvzng4BDws3M+Ba1i/RCwbTVkOry//mfQn98zg1NbmqLPNeuvBfuVH7VmHTs3Shi7xG+4tpcU5pI6nFF025j7Hqt3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853407; c=relaxed/simple;
	bh=fr06APyZYyXc8/4JTf9QZ1A6Y8afBZXFTtQrp1kWVJk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUa1IhfzNI68Y2jZeixx+il/Gnmoevh7lzk3Zin+GBepqhGeA7Pr8/YHkEACG6HZqguUB8tTyRy2G9CRSNKf5DT5M9ePjE36BE8xQGNFHyhjIA3QAXg/Md0oWdIMfUOAsI12ZdmQs3DhbKk3QP1YypQtTTAAgLma0OtFtNtD0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXRNz53tTz6M4KQ;
	Tue, 14 Jan 2025 19:14:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FEAD140A86;
	Tue, 14 Jan 2025 19:16:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:16:42 +0100
Date: Tue, 14 Jan 2025 11:16:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 28/29] cxl/region: Show message on broken target list
Message-ID: <20250114111641.00001cf5@huawei.com>
In-Reply-To: <20250107141015.3367194-29-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-29-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 15:10:14 +0100
Robert Richter <rrichter@amd.com> wrote:

> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 775450a1a887..2af3b6c14f46 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1870,6 +1870,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	}
>  	put_device(dev);
>  
> +	if (rc)
> +		dev_err(port->uport_dev,
> +			"failed to find %s:%s in target list of %s\n",
> +			dev_name(&port->dev),
> +			dev_name(port->parent_dport->dport_dev),
> +			dev_name(&cxlsd->cxld.dev));
> +
>  	return rc;
>  }
This function would benefit from some __free() magic dust.
Then we could return in the good path in the loop and not need the if (rc)
check here.

Otherwise looks fine.

Jonathan

>  

