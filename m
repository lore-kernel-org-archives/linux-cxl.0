Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77251C3F1D;
	Tue, 27 Aug 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776304; cv=none; b=Af88N1OFbwLftCYauTt6pLzPE2f4QH+ZQnW14b3a7dwpEdwm+g3l7V8/33lldMljZxItI4kS5yaDXfol1dvLuy+XjZ04wDb4fgWWXY7VvWH2wRyizqIK0ba63oEfCm2mQS4w9N+93OQ5qo/wVzA9IRZlb0+Y7RshDzRyZdMaWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776304; c=relaxed/simple;
	bh=neXWuSCOxzPjfyAsAeYu2ZldXr8/R4YIy8iNnsi1SRg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKEmwB3F8FL0VamWVwnvu8uxBeYrUcM0o+XKcBkeXF5ODA8cJieApHuICZKUekx44DQyUYSCRHPuk/YPDyJUOO2wB4b2geYMnKdd1FK/aHCdCHqCS7CQuPpxChgrA6jK8TZDdKeNBL2WEWq4VP2G0tEEMU9UFZscjZZP/GKDQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtXzB6sSSz6K9Bp;
	Wed, 28 Aug 2024 00:28:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D23F9140447;
	Wed, 28 Aug 2024 00:31:38 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:31:38 +0100
Date: Tue, 27 Aug 2024 17:31:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Remove lock from memory notifier
 callback
Message-ID: <20240827173137.0000404f@Huawei.com>
In-Reply-To: <20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com>
References: <20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com>
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

On Wed, 14 Aug 2024 12:49:39 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> In testing Dynamic Capacity Device (DCD) support, a lockdep splat
> revealed an ABBA issue between the memory notifiers and the DCD extent
> processing code.[0]  Changing the lock ordering within DCD proved
> difficult because regions must be stable while searching for the proper
> region and then the device lock must be held to properly notify the DAX
> region driver of memory changes.
> 
> Dan points out in the thread that notifiers should be able to trust that
> it is safe to access static data.  Region data is static once the device
> is realized and until it's destruction.  Thus it is better to manage the
> notifiers within the region driver.
> 
> Remove the need for a lock by ensuring the notifiers are active only
> during the region's lifetime.
> 
> Furthermore, remove cxl_region_nid() because resource can't be NULL
> while the region is stable.
> 
> Link: https://lore.kernel.org/all/66b4cf539a79b_a36e829416@iweiny-mobl.notmuch/ [0]
> Cc: Huang, Ying <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Seems a sensible cleanup irrespective of the bug / future issue.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
