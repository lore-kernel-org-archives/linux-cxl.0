Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2373B9D8D;
	Mon, 23 Mar 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278713; cv=none; b=ALpg8hOBT2U/zidvCLIeNzP4Yt8eBNuTnUof0+KCZeNowwGtJZKOmUjQGBfrW3xDk7u/4MyliNJznlKOkCx1aI37jmMcK5eZgzJ4WpKplmpcU9lEV3iDcgQBiGw9gGtkRMwSkD9LZYx/VN/VSdo2v5g57aI7jD0zsUyF7LBj7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278713; c=relaxed/simple;
	bh=g0k/Xbj/7tpWZAbT8bE2mKHvSQ4ji+WNpVwRzJLWBfU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ql0Lr2Re4dWcbbqENYKYfbvozWF8D7EAZj6h1LVnW2WLREPPYc+lqvQEpsg4lF20gGTw+tNjq4rQHkiS4wyTTFxSKRdMsMGsp3YktuNMS8uC6+oNgd9g8sw4g5UGetYiwIIeqzLJknKBS8kHx7CSN2Dteeauk1PFOYO2NzUyIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffc7n5X4LzHnGk0;
	Mon, 23 Mar 2026 23:11:17 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CA4240569;
	Mon, 23 Mar 2026 23:11:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 15:11:48 +0000
Date: Mon, 23 Mar 2026 15:11:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/3] cxl/core/region: move dax region device logic
 into region_dax.c
Message-ID: <20260323151147.000024a2@huawei.com>
In-Reply-To: <20260322131638.3636725-3-gourry@gourry.net>
References: <20260322131638.3636725-1-gourry@gourry.net>
	<20260322131638.3636725-3-gourry@gourry.net>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 22 Mar 2026 09:16:37 -0400
Gregory Price <gourry@gourry.net> wrote:

> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the CXL DAX region device infrastructure from
> region.c into a new region_dax.c file.
> 
> This will also allow us to add additional dax-driver integration paths
> that don't further dirty the core region.c logic.
> 
> No functional changes.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
