Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101224A1D
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656824; cv=none; b=gYZEd0HrTRvny5u2MofJQa4oQYHF9GUooUD+Qc7StLMb92kr158pgkg1c1Lai8DLnbfIeeQ7kegYGxIRLBPA1Ur7D7Ikf9DrimSjwiBNeVmop/hN5qDNa/g5g/ZXe4uxaRUHvXnitHmMFJ8LRYektEh745w9tkOJvok9w+JTecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656824; c=relaxed/simple;
	bh=UWCj99yvHO6YahFSro3lxlAtrUhnAAdVtOeSJYY5X4Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNx1N6yitwaX0TCv2TERIhQ5p+VpYLpYbsCoddMqu4RBCRV+aEVxg2Gscj907rfJwqcAwbcPbAfweZs8GyMEkPGaQIkhFxZdLE60YDMDdeiROXKemcrigK09JbiHt+CExHguJmjcufPK2JLiPwfBT9sTkEdXLUV4668mHWpG/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf8W26tr9z6L5CL;
	Fri, 24 Jan 2025 02:25:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 87769140519;
	Fri, 24 Jan 2025 02:26:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:26:59 +0100
Date: Thu, 23 Jan 2025 18:26:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 16/19] cxl: Add support to handle user feature
 commands for set feature
Message-ID: <20250123182657.00007db2@huawei.com>
In-Reply-To: <20250122235159.2716036-17-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-17-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper function to parse the user data from fwctl RPC ioctl and
> send the parsed input parameters to cxl_set_feature() call.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

