Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B13D5234
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498208; cv=none; b=GP9i/ulMr8OFcwjeEitj0Cc8mIMqi72sgsJjP9oxGnzulkxI1eRAuCpmXtOXnK4A5Z+49PcFXztK9otW6+d9DvCebB15qZ7tBwYmmSBKw5LT0V6COkMzMdnIyJD/SSk9cQDIc+ExyvS6IAvAUXb74bMeBilIpInpL8E2plK2/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498208; c=relaxed/simple;
	bh=miFmfqHwlaSQeDRPFtNITHsdWYrBGzadRWU9qtaleDI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrnjWSG5BRrRwAhGbxaCisfS5rEmpB8cZYIjvL/sEBkko5W5tA5cDNzpPwxCdKywqhd4eIoQfvfhCg/81g2A9yO/PTeeccrpP26SSmaqfNfeKGqxTU6tNIjIxfoyvJT3sBYXD4HNjNf06rTXczgETP4aroUk6hhPsKb13NGf3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsVNT388FzJ467C;
	Fri, 16 Jan 2026 01:29:45 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C2E640572;
	Fri, 16 Jan 2026 01:30:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 17:30:01 +0000
Date: Thu, 15 Jan 2026 17:30:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] cxl/region: Translate HPA to DPA and memdev in
 unaligned regions
Message-ID: <20260115173000.00006110@huawei.com>
In-Reply-To: <0d7d47672e81d0c4d9a4e5e335ca536dbecb9dee.1768008522.git.alison.schofield@intel.com>
References: <cover.1768008522.git.alison.schofield@intel.com>
	<0d7d47672e81d0c4d9a4e5e335ca536dbecb9dee.1768008522.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri,  9 Jan 2026 17:54:14 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> The CXL driver supports an expert user debugfs interface to inject and
> clear poison by a region offset. That feature requires translating a
> HPA (the region address) to a DPA and a memdev to perform the poison
> operation.
> 
> Unaligned regions do not have an algebraically invertible mapping
> from HPA to DPA due to the region offset skew. The region base is not
> aligned to a full interleave. Add a helper to perform the unaligned
> translations that first calculates the DPA offset and then tests it
> against each candidate endpoint decoder.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
