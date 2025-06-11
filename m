Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD02820D0
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648642; cv=none; b=kxsppwwLUCr5cJIxSMp7UKmRcmM9KOrghKLOzb+xe0CzMeIqZ43OrhX9NUT0t5lX93WW8EGQ3vVeqeKWULx3j7swm0AZ5oXKg38vHhkkyvUZEIfyrW5LRLvyrUAnpC8boh82aHDv/pohiRFEv5ylQkR/6FtBVfAGL2gFmlXDqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648642; c=relaxed/simple;
	bh=CDXvnfoSA/obFgSN9WXkIO95C5YxKZlq35BDGCr/dsI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUalfK0m9QGoSZQeX6YwMM1GR/6Rhzj5Lz+Q7u/OXCo51mDce9+r3MBfBCmEm1b2tjE8+slgcx9/0oJG4L/9lGxJmGnAmCxj/Z/robovt7buITPXIpJaP9ht2ASx8KvHg8x3HGW5MinBPicqGFXQIsSs+XrP4TZJhuWA6R90Pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHRJD2qVBz6L4yf;
	Wed, 11 Jun 2025 21:26:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CE034140433;
	Wed, 11 Jun 2025 21:30:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Jun
 2025 15:30:38 +0200
Date: Wed, 11 Jun 2025 14:30:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] cxl: Remove core/acpi.c and cxl core dependency on
 ACPI
Message-ID: <20250611143037.00002911@huawei.com>
In-Reply-To: <20250610172938.139428-1-dave.jiang@intel.com>
References: <20250610172938.139428-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 10 Jun 2025 10:29:38 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> cxl_core when adding the extended linear cache support. Add a callback
> in the cxl_root_decoder to retrieve the extended linear cache size from
> ACPI via the cxl_acpi driver.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
