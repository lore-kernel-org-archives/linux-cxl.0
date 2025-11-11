Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286130BF66
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870098; cv=none; b=sLvVaPUeBGmhz2g/i5q9wOBE48vTIynINS00vy/8lGtIQvE0zqAQDsA49WMv/QxfAWDJnHBbr11FPBJ1J3w9IX4VSKa1lEtfS68UaY9kW/5XHEeOqbfrDWFbJyR4IIldKP94HDXgcEF4U/eSWt31doKHKqC0qATJGayc+ZdXBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870098; c=relaxed/simple;
	bh=EFi+vplZ46vvCAal+Q0rX8nhktx8NFgmNBUpje1uR4I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX1V0ai8u9Divo1OwCLNURwjbDXYKZvVjFtvhXyl45Y0lw8suDoW2POSIk4fC86McQXq1iBu5TS3z7KORnCZOrT6T5vwgTIoFyHS7y6VrxmbF1KAklJZpIQ3KLk4cu7KOV39T+266C7hEXD//qsKo0rmkKxak3bahbH/KJtMGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Szc1LdJzHnHB9;
	Tue, 11 Nov 2025 22:07:56 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 60B06140432;
	Tue, 11 Nov 2025 22:08:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:08:12 +0000
Date: Tue, 11 Nov 2025 14:08:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] cxl/test: Standardize CXL auto region size
Message-ID: <20251111140810.00005e9c@huawei.com>
In-Reply-To: <20251031173224.3537030-2-dave.jiang@intel.com>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
	<20251031173224.3537030-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 31 Oct 2025 10:32:21 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Create a global define for the size of the mock CXL auto region used
> in cxl_test. Remove the declared size in mock_init_hdm_decoder()
> function.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Seems reasonable.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
