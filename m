Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5332CF76
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434213; cv=none; b=dpod9BBPS+mKcy0ovYt3vZkGmhjSIy0UBPkkZmFgHU6sSFCA47+jRyQdHT29DklltWqso29/EtG8TFg9yc9MYKp+GS9jdU/HEXGawZEhfG3GoUZC5whx/5XF3/Ytg1KHK5tE4tjdqi31wAvH5nCs9H5H/Vp1nueGzg4cZp+rf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434213; c=relaxed/simple;
	bh=KyKkAjPTzI1zQevVkJUBSTwwRmNDXpwegnibdh2TYTY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3HCKPwQaJtmcTnu5XlAm9ln06KJ96T1EfH8ftghSuzKzQmqDwnaUl2ROOoo37NNRjukI2I2j/55YerQ0EUUsZ3W+F0WosBTcQq8nKT9SDDvKaPbUndmBdBpL2ZYNakfeoS6XdYl42kPge4E0bMN56JXfQeYYeSabDBR/+74mmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLpZv1gQTz6F94y;
	Wed, 10 Sep 2025 00:05:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E58A21402F2;
	Wed, 10 Sep 2025 00:10:06 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 18:10:06 +0200
Date: Tue, 9 Sep 2025 17:10:05 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/region: Refactor address translation funcs
 for testing
Message-ID: <20250909171005.000040f6@huawei.com>
In-Reply-To: <f0c6fa733cea8585f2bfda0851489bd7ca2e2b2c.1756446925.git.alison.schofield@intel.com>
References: <cover.1756446925.git.alison.schofield@intel.com>
	<f0c6fa733cea8585f2bfda0851489bd7ca2e2b2c.1756446925.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 29 Aug 2025 00:21:25 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> In preparation for adding a test module that exercises the address
> translation calculations, extract the core calculations into stand-
> alone functions that operate on base parameters without dependencies
> on struct cxl_region.
> 
> Mark the new functions as static outside of test builds by adding
> and using a new __mock_export label.

For the __mock_exports magic, I assume that can be applied in existing
cases as well.  Perhaps better to introduce it for them first?
That would give a nice clear example of what changes.

> 
> This refactoring enables unit testing of the address translation logic
> with controlled inputs, while maintaining identical functionality in
> the existing code paths.
> 
> The moved code has only one change. In the new cxl_calculate_position()
> eiw_to_ways(eiw, &ways) replaces the prior usage of p->interleave_ways,
> since the new function cannot depend upon struct cxl_region_params.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Otherwise LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


