Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C5264A62
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539122; cv=none; b=PfxgwecOoSZBoJo8NHuPKCImAPGFqgvpJPAJhXidxEFSrQl3yZoQHqlJgTabcd4l6CFMNO34hIemsKbkdrS9nEBm+GC3bMdmeKpRbKCZIP4pibmNXLAA/siwZTT3pZzeVW69DbmLIcP3KDIheYaP3gGKohRqhvFn0qgaMyqr7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539122; c=relaxed/simple;
	bh=lY6XJ+JQpyHES2/rJx332h6ssxlUXKtKoWq6r93/5lU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeMdVgkwn9qvxMPorX/jVYItYhPn10NzEXKrbgZQLoP3W7Mflv+ASAlGGHieV7ZXLxQ4StTvCPhwnYTFMSViZRshwFQKS8ZPzKzF3dsOLGhAuhQd7LW3hGPmPLvLhSBoz3TnMbZOE9oH0K3iKHGgb7uXUeRlvQKWm16S1VGF9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvXbk2677z6L5Cl;
	Fri, 14 Feb 2025 21:15:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D275D140113;
	Fri, 14 Feb 2025 21:18:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 14:18:36 +0100
Date: Fri, 14 Feb 2025 13:18:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
Message-ID: <20250214131835.0000678f@huawei.com>
In-Reply-To: <Z62akRdahoGqHN5x@phytium.com.cn>
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
	<20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
	<20250211092655.00004310@huawei.com>
	<Z62akRdahoGqHN5x@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

> > So I'm not keen to change this.  Ideally we'd have made this a required
> > parameter from the start, but we didn't and doing so now would result
> > in a backwards compatibility problem.
> > 
> > So I think this is kind of a 'won't fix' situation on the qemu side.  
> Ok, I see.
> 
> Maybe we could modify the Example command lines in docs/../cxl.rst to remind
> users to add this parameter. Is this feasible?

Yes. That would a good thing to add for the persistent examples.

