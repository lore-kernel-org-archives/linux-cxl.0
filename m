Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FA6ADD;
	Fri, 11 Jul 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251960; cv=none; b=kB4+QLsY84tjg0DHlytxI9MXydoBKNBs8prbjJ8+SnuqQJ6oaPlsSt+UfLGTuzdZWATMq2I9s06H3c4+Wcq5ApMBUQp3z4/wImO5gWqJfFWGy8AAR3ft/7nCEtl/6e6FVqtBhpw09Ew6Q0YomHhf+I1c0QdHcmHBNVtAncd2L5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251960; c=relaxed/simple;
	bh=Bavph+0LP6Q8dI1LAyJDwSa6sRIPEBbOQNcRMMjg6kc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohAI/DJzL+XV/gTI41dRB56LrD20zgU33n5xMVjGONbMoVU4UpJLlsgDQLv++UvCPo2suPHglLfEwDyfSr6glbYn7ux32DvHP1n3hzTcVL3u/9eVSwDcjgY0avOP1SVLcLNsj2Nl21mx+wjx+PfD1+o/uKgW3h4aAlgKWPb6j3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdy7g474sz6M4mr;
	Sat, 12 Jul 2025 00:38:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F626140370;
	Sat, 12 Jul 2025 00:39:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 18:39:15 +0200
Date: Fri, 11 Jul 2025 17:39:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] cxl/core: Using cxl_resource_contains_addr() to
 check address availability
Message-ID: <20250711173914.00004df6@huawei.com>
In-Reply-To: <20250711032357.127355-4-ming.li@zohomail.com>
References: <20250711032357.127355-1-ming.li@zohomail.com>
	<20250711032357.127355-4-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 11:23:57 +0800
Li Ming <ming.li@zohomail.com> wrote:

> Helper function cxl_resource_contains_addr() can be used to check if a
> resource range contains an input address. Use it to replace all code
> that checks whether a resource range contains a DPA/HPA/SPA.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Nice
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
