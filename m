Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CD15D1
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990919; cv=none; b=VYlFLR34TJ0IDYL8mfAdEJR3UMVl+dZQDgwNqs5GZb1bqrQrEIoXaH0ctWafyQqPPJJ+MI8li7cmQbxgfT7MeBeiarTOO2jGuztNuzzqdiYaIOgrDCkMBhncZ9nsGX7INR+oFczcpVsJRlivSqq2lVXtQ/ItNjsrkijiZFl+3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990919; c=relaxed/simple;
	bh=AAcbSFlsRikJ8whevtQc6DINSk1fBLSdz/jV+vC2cmw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gM7M8GFQ6EeYXwJK5SnvY3ocjT/HTvwZdenbFqSJrPtNfRhvcjaNDF2YyDS0pCkqC+EYHn4hnKeBfZPeCjjFpWijPLiwQWLMyafVoJy10yXchrgxwFoiaGDrlzfyXVttQELobz90qJaZYb8Z3ia6EQdo2As+fbXh9fOvqf1qx9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5PRl6GLPz6K99X;
	Sat, 22 Jun 2024 01:26:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E1346140CB9;
	Sat, 22 Jun 2024 01:28:34 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 18:28:34 +0100
Date: Fri, 21 Jun 2024 18:28:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Svetly Todorov <svetly.todorov@memverge.com>
CC: <qemu-devel@nongnu.org>, Gregory Price <gregory.price@memverge.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH RFC v2 0/3] cxl: Multi-headed Single Logical Device
 (MHSLD)
Message-ID: <20240621182833.000029c9@huawei.com>
In-Reply-To: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
References: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Apr 2024 13:04:05 -0700
Svetly Todorov <svetly.todorov@memverge.com> wrote:

> MHSLDs allow multiple hosts to access dynamic capacity on a single
> backing device. This complicates DC management because adds,
> removals, and accesses need to be vetted such that hosts don't
> stomp on each other's data.
> 
> This patchset proposes a set of hooks to be called in cxl_type3.c
> when each of the above events happens. The results of the hooks
> can be used to prevent illegal DC operations in the corresponding
> cxl_* functions. 

Hi,

I had a quick go at applying this to my gitlab tree cxl staging tree
to make it more generally available.  It unfortunately needs some updates
for the change to Extent Groups in the most recent DCD code.

Whilst I can probably sort that, it's going to happen particularly soon.

I'll be pushing a new tree shortly if you have time to rebase.

Jonathan
