Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279E8821
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368813; cv=none; b=q/UfH3SYpudA0BaVJxU5k71fxwci7JKA8LRSiUKWWmWwcYXFf/2Q+biIQSrM8VrVRGAdhlzZM4vyQakIS0ewN7UbXlZW5x6d7o27RgcUfela9a9jIm7ymlgNNgKjUj3nEl8dR027tHfy+esBKcCJlg5Su68PBeKyihQeJkrWfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368813; c=relaxed/simple;
	bh=gsFkCbunRWtleV4TvVANcWFKLfcZHdteJVI69DRis3M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecdHVbAT8+3hxOxnn85ix9OnLbjo+V8WPLv+4lBq++PrX4WfBLmorMRLkx05/1Ko3jSY/LCLAfOssLbqa4KADlRtI20htFKjC/7tCgt0MFOKvO6FTjTyau/m01KbYCV1kEnHOzBU5trIkIs+IWIG7+FHjLQYtO2uiQQuD4wBPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWgXx0wd5z6L5f5;
	Tue,  1 Jul 2025 19:19:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9719E140373;
	Tue,  1 Jul 2025 19:20:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 13:20:07 +0200
Date: Tue, 1 Jul 2025 12:20:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v4 8/9] cxl: Create an xarray to tie a host bridge to
 the cxl_root
Message-ID: <20250701122006.000047a2@huawei.com>
In-Reply-To: <20250624213916.1665889-9-dave.jiang@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
	<20250624213916.1665889-9-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 14:39:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper functions to setup association of a host bridge device to a
> related cxl_root. Functions are in preparation to support the moving
> of host bridge ports creation from cxl_acpi to cxl_memdev probe path.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
