Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8826AD9
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669969; cv=none; b=nF3eRB1dZyYgkQNyxqzNuSmlG+vygHvuFAGzd2MQShs2qFgaCP0d15wL2rHNIoqDGIVtNVSR2RjM52aU3HUHRA1/P42r7lq+HOcDZpbvbTQVkmH3Fy35RaC7FgjcXI1bHTOxlGRcXAVDwm5Vg4UaWa8BipxRKkmUbYSi77V3igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669969; c=relaxed/simple;
	bh=Q6VVcQIqCHioaYPJUBuU9ajGlBGk2qgnigukunLdlUw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZh+0zOlwXZzuEm5r0aRsQ73d08vfpNKvdCrC+vbW/Dpj18BE835a+pPhyhfhQBoOuBB78EDe0j0PcGc5E1+DAPzB+on2XliKa9bKne3bGlTdpSOb2tiMQUeNyAWt/3u7dcP6e74k2MaBHpx3QYUIIaRAhMcajPUm0DGz1GGMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz8LL1483z6L55J;
	Sat,  9 Aug 2025 00:16:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B7FB14027A;
	Sat,  9 Aug 2025 00:19:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 18:19:22 +0200
Date: Fri, 8 Aug 2025 17:19:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/acpi: Make the XOR calculations available for
 testing
Message-ID: <20250808171921.00000cb9@huawei.com>
In-Reply-To: <e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com>
References: <cover.1754291501.git.alison.schofield@intel.com>
	<e2ffaa6a29117fd9832542e4ac314b46ab2d1fd8.1754291501.git.alison.schofield@intel.com>
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

On Mon,  4 Aug 2025 01:52:40 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> In preparation for adding a test module that can exercise the address
> translation functions performed on XOR configured regions, the XOR
> function needs to be refactored and the ability to create a CXIMS
> provided.
> 
> Refactor the XOR function by extracting the core calculation into a
> standalone function. Enhance the parameter validation since this new
> function will be called from the test module where the parameters
> may not be guaranteed valid.
> 
> To allow the test module to create a CXIMS without exposing the full
> cxl_cxims_data structure, add new functions that can create and free
> a CXIMS.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

I'm not particularly keen on code that is just there to create opaque
stuff for tests that may or may not be built but I guess it's not huge
so fair enough.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
