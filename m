Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C4630E84D
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690319; cv=none; b=J2FdK+YP7Znta+osIrgMJx0tZB2IZqTzgsfXvYcABfiD3xQvamhoKc6N6U6kSR7lEtWuj6KdIS2ZALDPkJNWHyceEPUGtXpOZNuKenx2xYHxg5TuvYUuCPhRj6PStefTXiTcxsHtaeK0/6qXl1rn3ZwaWfv4IVh+W+S/3H+MXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690319; c=relaxed/simple;
	bh=7AkWtVAdvwHEKNudKdk/QWBvIMEir7GcvxKvvw6b4cQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZviB9ZOFIXymr4d6tidMM6V3GDgdPnq/a6ieIj5y6VP4Cnu5yBHlyF/KjgD04iTonUrHPrWYf9L/AzX+DRmydBSrUtzoy3dxBFB+M5IPmpA9pmZqZutrze9VNc7zaA6RtCSuEJwIJ8debBPpM+iG7pl2U4cr2E5FX1ZhuYiYa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQrcZ6tvRz6D94X;
	Mon, 23 Jun 2025 22:51:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B91231402EF;
	Mon, 23 Jun 2025 22:51:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:51:53 +0200
Date: Mon, 23 Jun 2025 15:51:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <jgroves@micron.com>, <ravis.opensrc@micron.com>,
	<fan.ni@samsung.com>, <anisa.su@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 7/7] cxl/mbox: Add Populate Log support
Message-ID: <20250623155151.00002696@huawei.com>
In-Reply-To: <20250617221509.ro27iocdmfllvvwg@offworld>
References: <20250617193611.564668-1-dave@stgolabs.net>
	<20250617221509.ro27iocdmfllvvwg@offworld>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 15:15:09 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> From: Ravi Shankar <ravis.opensrc@micron.com>
> 
> Adding UAPI support for
>   CXL r3.1 8.2.9.5.5 Populate Log.
> 
> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
This looks fine to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
