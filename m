Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F11487ED
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654270; cv=none; b=nfvNjj/P6wub8b8R1qBFFS021uJVDYhX76jXFOOpv8US9CFb+S5HQN5k+I4a7NMqsYAFZTWclQmLBIuHXFMlpkQu0Y1+LIghHOpEHE1kjQw7mFtPDWSTe5blxMD/EXNwGe2WFTAEXoPdjQl76EXSUhWSGhIqXZEgTTN/fED6InA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654270; c=relaxed/simple;
	bh=YxhzfhNyVl1MUVxIst6mWc3pAIQuvZYnBa6m402vgcQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG3loZnvC5DNslGETCQ7qog6IxwFkeH9XsnNJFBF3shJOinA4S4zVZwY573mnNE/6Sxa5yxRkkU9oJvRmauFJMHri3rNwJQPKtQJsrQwBKhj0sLC2vWxjU8+xH/DtRc9wffRU4K8F0dyZHZYIr/3g7h9e4aaVeXrUxOIPq7R3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf7Yx2Qcxz6L5Ky;
	Fri, 24 Jan 2025 01:42:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CC70E1404C4;
	Fri, 24 Jan 2025 01:44:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 18:44:25 +0100
Date: Thu, 23 Jan 2025 17:44:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 05/19] cxl: Add features driver attribute to emit
 number of features supported
Message-ID: <20250123174424.00006340@huawei.com>
In-Reply-To: <20250122235159.2716036-6-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Enable sysfs attribute emission of the number of features supported by the
> driver/device. This is useful for userspace to determine the number of features
> to query for.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

