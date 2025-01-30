Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205C1E5020;
	Thu, 30 Jan 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244646; cv=none; b=Lzlxzz06cKdFLLU0mi/4Ej5dkMT5aBsU8+jdT3Nb+wAwPRCqfL6z5R5dhNAx7aaM2bgadbLB7qdTaDNaIFOO5AB3RkgoIGnP6njzPUR/QutCEaDlKgedwyC9kdN7ZUAUNENw3GHX+MHgDaDZMnXN9o9qTMIf6kxBhhzI9ry3Am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244646; c=relaxed/simple;
	bh=z+5w+QHxNDpEQsXCLQI6Ln/cXNrfptfAIVYUzxzV3QE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buIPep6J/DvFrHasRghPnhM/94IJychn7MmmEVp9F7fmMUDBMxaqei7KXHZcR6XBYAUfp5BE9xYcnZ6biETtA7uCvN8tjrEWvmWwrkhOb2LWsoXHPqacP0e5u+/AqCbPN8WV7bi+1uWERZY2Gvt3Jh7pHQCpKKzCCwiHL/R16rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkKtv42Bsz6J6bg;
	Thu, 30 Jan 2025 21:41:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 90B2B1400D4;
	Thu, 30 Jan 2025 21:44:02 +0800 (CST)
Received: from localhost (10.47.30.69) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 14:44:01 +0100
Date: Thu, 30 Jan 2025 13:44:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/2] cxl/memdev: Remove unused partition values
Message-ID: <20250130134400.00007247@huawei.com>
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
	<20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
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

On Tue, 28 Jan 2025 12:51:07 -0600
Ira Weiny <ira.weiny@intel.com> wrote:

> The next volatile and next persistent values are unused and are
> cluttering the cxl_memdev_state.
> 
> Remove these values.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
