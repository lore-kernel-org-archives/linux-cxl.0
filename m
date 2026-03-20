Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD923CFF70
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024156; cv=none; b=SiwOEV5SJ+rdcuZZBO+KOn1zlrLsJbYcxWoGNGJhD4LW7TANrDwJCYkbWHqvROB+E4dRe8Q+0+QQUDKIaH9YAP8grfQ/lzCZabRuSrmH35UJBN6FMNa4SSjgAsJHNRYb2h8DFa/d1N0xFVFXBUO1d4j9YO9dMnOvNS+T3uJoI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024156; c=relaxed/simple;
	bh=K/gNQniZ8de+XUGIqPuARA5R6s0xNPVthG67eN+zh0U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAKpbb/bpxN39XR0BcsdH+DRNtQlQA3T9r8tOhi4MDTb2k5ZDScl4aoYPJ5jgzjpBSjJpe/luaTpKoe07iOwljTvDeqWwjCo6AZiMisXeSHykLltXN5xI19OqqkFObLfti2HIyatkFP35/rygEDLU2XP3xJa5KDERkAeb/iV1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcnzr5XQtzJ468m;
	Sat, 21 Mar 2026 00:28:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FB3940587;
	Sat, 21 Mar 2026 00:29:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 16:29:09 +0000
Date: Fri, 20 Mar 2026 16:29:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/6] cxl: Wire BI setup and dealloc into device
 lifecycle
Message-ID: <20260320162908.0000528a@huawei.com>
In-Reply-To: <20260315202741.3264295-5-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
	<20260315202741.3264295-5-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 15 Mar 2026 13:27:39 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Setup BI flows during cxl_mem_probe() after endpoint enumeration and
> EDAC registration, and tear down BI during endpoint detach.
> 
> BI setup failure is non-fatal - the device continues to operate
> in HDM-H mode without back-invalidate support.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Not sure it needed to be separate from patch 3 but it's fine as is.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
