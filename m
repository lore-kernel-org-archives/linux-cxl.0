Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F39233704
	for <linux-cxl@vger.kernel.org>; Tue, 15 Jul 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592855; cv=none; b=fadTrl1FaAdUFgH/stXVylZoNQSXAx3+QZ2BFltM6RU5IHl1ZlAeqJEgJ3M8LM5ekGnw8SAiMcm9lGlUDH4TvusbxBoeGvWG7Bb7yoHpnInCpm8jx7DhRJQBEAwLt7YqfQd9wXKNSOUrGdAkP2vc7tOBKo5bXdCA9MI87UKZkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592855; c=relaxed/simple;
	bh=jPt3CDbLx0t1Ge9FEqItSrVPTvjkAvAl8AGN9wzNa3Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPHtGbS1foLN8nS246I+azn3vRUGg8Rqz6VEQAonEJHivqI4VgjgjnNE0nYaMoKrhHEMLEW0Gaj2lWuxzr2lSYaXGHqY7pNvbNmK5aJ3EJeqvO/RpSMQEMlemvDe/8zFa9y23IDZyrJNrFgbv4jxenzU7bceK7dLg1DZu9oaGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhN8T44hVz6L4wJ;
	Tue, 15 Jul 2025 23:17:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A6A7414025A;
	Tue, 15 Jul 2025 23:20:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 17:20:43 +0200
Date: Tue, 15 Jul 2025 16:20:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] cxl/region: Add inject and clear poison by
 region offset
Message-ID: <20250715162042.0000545e@huawei.com>
In-Reply-To: <aHHnWgKx3YBx__8H@aschofie-mobl2.lan>
References: <cover.1751513505.git.alison.schofield@intel.com>
	<4f33bcb42217139e0884784e60139e29c647f62b.1751513505.git.alison.schofield@intel.com>
	<20250703153138.00000a00@huawei.com>
	<aHHnWgKx3YBx__8H@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

> > > +
> > > +	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> > > +	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> > > +		dev_dbg(&cxlr->dev,
> > > +			"Failed to resolve DPA for region offset %#llx\n",
> > > +			offset);
> > > +
> > > +		return -EINVAL;  
> > 
> > If rc was set, preferable to return that. I'd split the condition
> > into two parts to avoid this.  
> 
> I want to dev_dbg() regardless, so how about adding the rc to dev_dbg()
> and returning like this:
> 
>         rc = region_offset_to_dpa_result(cxlr, offset, &result);
>         if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
>                 dev_dbg(&cxlr->dev,
> -                       "Failed to resolve DPA for region offset %#llx\n",
> -                       offset);
> +                       "Failed to resolve DPA for region offset %#llx rc %d\n",
> +                       offset, rc);
>  
> -               return -EINVAL;
> +               return rc ? rc : -EINVAL;
>         }
> 
LGTM
