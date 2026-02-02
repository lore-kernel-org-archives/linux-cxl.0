Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8A1A76DE
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042449; cv=none; b=epNT51dcPHwciEkYf+CjmwaSJK01sqXh3JdzqLKGZM5yMyFkHh7VDXPdr9oX2iXVR0bF4drhgEfHl6Kg6coDHg66mjpCYPAmkEECCfZq/3fi9lPKfozywKC1uoGv1WY8yvbNCqs0f/DWdSYfQb8VzqX3B4KbXFpedWCyWKhHrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042449; c=relaxed/simple;
	bh=y6OC5OwJw90iUVDLS9OYKXjO8WlnoGqVKwb6KgP7IgI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmKCq9pdmREIqJ5UAPgfJfQoK6UPye/BnjfN/VlKaeDQV04V2sYaXUkwD739fpA05kw9LA5YAmuv/reQrPmPfzbNhX6NYAKwqmq4XL6H0VnT+3jTNl7v7Uth4Q4djKVbRDBOohXZeE5brxthZk2AyLwLT1v5DhGxwNEtdNIW5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4TSm4qxczJ46DD;
	Mon,  2 Feb 2026 22:26:32 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 86F0A4056A;
	Mon,  2 Feb 2026 22:27:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 14:27:17 +0000
Date: Mon, 2 Feb 2026 14:27:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <dave.jiang@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH v2 3/9] cxl/port: Cleanup dport removal with a devres
 group
Message-ID: <20260202142716.00002d3b@huawei.com>
In-Reply-To: <20260131000403.2135324-4-dan.j.williams@intel.com>
References: <20260131000403.2135324-1-dan.j.williams@intel.com>
	<20260131000403.2135324-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 30 Jan 2026 16:03:57 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for adding more setup actions like RAS register mapping,
> introduce a devres group to collect all the dport creation / registration
> actions. This replaces the maintenance tedium of open coding several
> devm_release_action() calls in del_dport().
> 
> Tested-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
I think this is on the right side of the 'too clever' boundary
as it is reasonably easy to follow so

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
