Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A031E9B01
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138432; cv=none; b=QiL/Ur5jzHIRmsOUvcSxgUr7kpH+B4zWrquLr0SBEl7eGAFZSUHISYQcY9aExCWsObaayxdXZ6zM/hQE0toW+x1oYbS2pPbKp63/9eMc8O0JEeXjhGiZfMNXm3tQu7K08jOdJhx7bHBz5JVjOOjWZsARcbL8z9zaTmwg5dCNjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138432; c=relaxed/simple;
	bh=W1D3TP2BK1xG6UJHoSJcsh8oyef7BMAjaUedPurmUqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOOyXMh9Lx0X3GPKHK2hH6XhHMYtBWMOpCgMhdh4Ygaw/sDuE5W+Fwy6JQuGFdxOO29MGFbpqV3IR0wZwzolDY3er6AbBlPqk/e58UWDCG6vnUQ9ybstb3rz0JhPM6GwZe5fX/G8uJYxX4dvdVqBP8MIQv6gMuUdqHxzO/op4U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzpFS14m4z6M4b1;
	Fri, 21 Feb 2025 19:44:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B07A140B55;
	Fri, 21 Feb 2025 19:47:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Feb
 2025 12:47:06 +0100
Date: Fri, 21 Feb 2025 11:47:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <ming.li@zohomail.com>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
Message-ID: <20250221114705.000010ff@huawei.com>
In-Reply-To: <20250220220235.276831-3-dave@stgolabs.net>
References: <20250220220235.276831-1-dave@stgolabs.net>
	<20250220220235.276831-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 20 Feb 2025 14:02:33 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> ... to a better suited 'cxl_arm_dirty_shutdown()'.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
