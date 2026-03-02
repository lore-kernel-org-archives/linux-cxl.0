Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A383E0C49
	for <linux-cxl@vger.kernel.org>; Mon,  2 Mar 2026 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465209; cv=none; b=r4HbuF2Q9Y/eckszZ1SrsaXnGeLkQ6/R/tspImnQcnSyPfUBmp7VIjXXEhAXaVk6ryzXOBajLvt2X6uApHghlCOzOrfyDHQw7xJcEhvXO3Bu4gQ5usnzNSFpe/4FZKe29RKLwcwngGZDW2ob57sOg/Tie0y0lcq5KWmVvJRJQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465209; c=relaxed/simple;
	bh=JBvxr7zS8gTjJwkwHCF6y7VZXQtJiIFvBHSF2FrCapQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9X8TJ0VBJw3AwaF9NIPJLexHUt9VfeaMcE31wuM206oEsMRlDgspMU33lX9qe9rju2TXKiuxDX0TVZilHp7Bp7CTT9ItCYPE/2MQ1/xOJK5shW5A1Mc67m0klw/keq7qAQjyiwdtVhJfoBTTxPtkNaO4iBITzlm1rXgY+q/Ano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPjSk1lnjzJ46bj;
	Mon,  2 Mar 2026 23:26:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D386A4056E;
	Mon,  2 Mar 2026 23:26:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 15:26:45 +0000
Date: Mon, 2 Mar 2026 15:26:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Gregory Price
	<gourry@gourry.net>
Subject: Re: [PATCH v3 2/3] cxl/region: Factor out interleave ways setup
Message-ID: <20260302152643.00003027@huawei.com>
In-Reply-To: <20260228173603.1125109-3-alejandro.lucero-palau@amd.com>
References: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
	<20260228173603.1125109-3-alejandro.lucero-palau@amd.com>
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

On Sat, 28 Feb 2026 17:36:02 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices can be triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Maybe we should take this opportunity to make ->interleave_ways
unsigned and move all logic to assume this is never negative.

However this is a more minimal change so I'm fine with this and
potentially a future tidy up to make all ways values unsigned.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

