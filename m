Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828ECA6F
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876858; cv=none; b=h0vymN3F3Xi1i+jivQwfdGn0n4gnmKFpcJ5/dhISQonbQk2XsYSomNs+gCUUBEIf6idCa5zWsPZ/mKC/h6M7BJDsnQimZp7KYQm5Fiiz1ZrfeD1cwXSKofyiDr/Jb1JM8sCQ3IDYhVXZOxsnQLEiUGT+9Dt/n3qKKonJ+ab8Oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876858; c=relaxed/simple;
	bh=03NRY44AjygphS/mowZkMZpZQHBnNvMHYU8KDgxjqO8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSnC9Irt4epR8KREEJjBQxW+orpIs50YOAh4fw7dma18jBONU8EYmWRBcUlYhOlrDV4L4I9+EjJNiJ7HmwoWQ/NlVvda0GaA+J7N9HoNmmNjhCSsAZvdDBVlAvw8gGYaynIsnXppWM+Jgtda/pQj6xYllpYQHn7yehD1kd06vGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5WTb6vdyzHnGjc;
	Wed, 12 Nov 2025 00:00:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5568F1402F6;
	Wed, 12 Nov 2025 00:00:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 16:00:52 +0000
Date: Tue, 11 Nov 2025 16:00:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH 2/2] cxl: Clarify comment in spa_maps_hpa()
Message-ID: <20251111160051.0000075c@huawei.com>
In-Reply-To: <aQzWjOttMB2eCQRh@gourry-fedora-PF4VCD3F>
References: <20251106170108.1468304-1-dave.jiang@intel.com>
	<20251106170108.1468304-3-dave.jiang@intel.com>
	<aQzWjOttMB2eCQRh@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 6 Nov 2025 12:10:36 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Nov 06, 2025 at 10:01:08AM -0700, Dave Jiang wrote:
> > Update the comment in spa_maps_hpa() to clearly convey the construction
> > of extended linear cache.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Link: https://lore.kernel.org/linux-cxl/68eea19c7e67e_2f899100a8@dwillia2-mobl4.notmuch/
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> 
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
