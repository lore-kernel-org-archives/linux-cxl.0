Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11B3B585C;
	Mon, 13 Apr 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093600; cv=none; b=LT6i4y07eew6cvEPpnaPDOnz3RaeoEUKlRAWn373Jjy3yNCIirVuSzeOaGdCOCL8S+J2qgWyL9DOvuLcnJ4OCxdJ+8ursmOuVqHd+p2YpWGCI4d32GpL6L8RaxRwFA0RbY+BTSBScVCovgbc7Z843AN40kMq0BmrozKSsI10OjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093600; c=relaxed/simple;
	bh=JXRMc0wy+BbDeeQTxXicS4g9lB0JzeS51S6VXGCc5uQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeA3JmZM2FKsj83m2colnKaxvclNlcO+4ExV4Q2O7qTxN9M6r/1CsGZK34GpZkW8B9zOs7Wm/c2Bt80BFtMZpeJi9XxAN77O4TsDVEqmulUwgkEMBJ5F9PcOWVqwI6hX2V9rUxo3VBac8fDA/d5xymgyZnxLpJRxyL2QZvwqCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fvWKJ1hgwzJ46Zv;
	Mon, 13 Apr 2026 23:19:16 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 41C574058B;
	Mon, 13 Apr 2026 23:19:56 +0800 (CST)
Received: from localhost (10.203.86.132) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Apr
 2026 16:19:55 +0100
Date: Mon, 13 Apr 2026 16:19:54 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <john@jagalactic.com>
CC: Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, John Groves <John@Groves.net>
Subject: Re: [PATCH] dax/fsdev: fix uninitialized kaddr in
 fsdev_dax_zero_page_range()
Message-ID: <20260413161954.00006daf@huawei.com>
In-Reply-To: <0100019d8262cda2-9714d31c-8fc1-4ca5-b32d-4df678240d14-000000@email.amazonses.com>
References: <20260412154944.461748-1-john@jagalactic.com>
	<0100019d8262cda2-9714d31c-8fc1-4ca5-b32d-4df678240d14-000000@email.amazonses.com>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 12 Apr 2026 15:50:06 +0000
John Groves <john@jagalactic.com> wrote:

> From: John Groves <John@Groves.net>
> 
> __fsdev_dax_direct_access() returns -EFAULT without setting *kaddr when
> dax_pgoff_to_phys() returns -1 (pgoff out of range). The return value
> was ignored, leaving kaddr uninitialized before being passed to
> fsdev_write_dax().
> 
> Check the return value and propagate the error.
> 
> Thanks to Dan Carpenter and the smatch project for reporting this.
> 
> Signed-off-by: John Groves <john@groves.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
