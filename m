Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA114A4D6
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846060; cv=none; b=bC335dZ9AhMzH5fDC5tjRq+4qnHLG5VU7jEwqca71D/c9geTl4+2yKyWVzr7Hbpts7YgWDARGawe3MUJPzbnDaBp5njHCYumWS2CUFs4nFg2h/EzkB17i+QZNfDrKv3WBqKKvAzKJknVo4DTQ/ZpmMR8PmLfkBzN3IItU2gctB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846060; c=relaxed/simple;
	bh=oEZD4SyDB0R8lywRh9dMTK6zw1TwoCZjTCKv3VO44CU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpDHBmgGqoFPpr+Rn1A46kgHsX7wUf/YaDL6BWTn2FHwjW3YxE1D7Bnp0RlBvjKBhbY7aHZ4PhnGBBTPsb9gq1BD8jjJmRORX8wNnWEJOtE9KXNX/m9xg4nZH+qVNn2M+TcLOW1DZlX4sDVVb5VtgWvZv17yWdqfGwRl75dGIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv2ln3qRbz6K7FK;
	Wed, 28 Aug 2024 19:50:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C6DFE1400D4;
	Wed, 28 Aug 2024 19:54:14 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 12:54:14 +0100
Date: Wed, 28 Aug 2024 12:54:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alejandro.lucero-palau@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <fan.ni@samsung.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v2 1/2] cxl: Move mailbox related bits to the same
 context
Message-ID: <20240828125413.000045ab@Huawei.com>
In-Reply-To: <20240827215116.536126-2-dave.jiang@intel.com>
References: <20240827215116.536126-1-dave.jiang@intel.com>
	<20240827215116.536126-2-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 14:49:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external callers and avoid exporting of CXL driver
> specific bits such has device states. The allocation of
> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> mailbox can be created independently.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If this is useful to Alejandro, it seems like the sort of
refactoring that makes sense anyway, so perhaps queue this
up this cycle if no negative feedback comes in?

Jonathan
