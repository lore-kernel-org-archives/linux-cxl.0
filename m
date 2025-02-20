Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A128F5
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013318; cv=pass; b=ig5ZAqwugEBeXZVW7nS834uE7d8mCqUcqRmlNdtcZgn13pJdd9xRACT6dnwxPqzEzQaRKZ5eWgyaWsZ+0nZNXHTTDgZ01460yY/Oj5UK6UtSHxgMkUOgvIXynfMUEDKF6+3aqPtqiGNUBjtmecX/l4bBVi3LHE09v9yCYi4VxIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013318; c=relaxed/simple;
	bh=FKCpVRrzUr+6lELeeFa4iwpM1zSdLFqrAZqiFnGIeDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvrjibnibxG4UceEgKgARF7kQ/4+/2ufx2lZb8KseFT1Q1/bqTNOkn7b33Z/tCmLbd574lh9LEQK0MN4F0rHkaCqBxfrFRX7e4zgYdoAUBcWF14h17tJ/AGYq7ptdOQ9bcTYUbVVRaPme1cufriPdiUwlHDG8+G3hr7XpVswGyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=CEFrA5xa; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="CEFrA5xa"
ARC-Seal: i=1; a=rsa-sha256; t=1740013300; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n9TGsiAisE3MOcz6/VSg3vBFVlqVuuap6XITP8PG3/37ioKvS2KBUaovvZ/LzoBknyijBqqQugTE/NnN8qPH73HHhEhWL7wJE6Lv8fXJbNBneXaZRG6h+W29hMKx/cTjF8H83aELZmYU/A5HXCjko0nIvOngpKrhSgt0QK83PbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740013300; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FKCpVRrzUr+6lELeeFa4iwpM1zSdLFqrAZqiFnGIeDQ=; 
	b=oLbdOeIjRsbq0w2tb1ute5ZCUJ7CacM7/6SByoLWD5m3pYdisaldDTRpS7Ofd+r3Jzqoe4FgXYLsv5tDT9E5mErIbID7M5AZc6iGDbVS0XhZG8g8fDqbdCR0wIvQ2pxrFaxUu96/8uOKNBZ2WFxqXTzdNh00+tQVE24gC1QvElY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740013300;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=FKCpVRrzUr+6lELeeFa4iwpM1zSdLFqrAZqiFnGIeDQ=;
	b=CEFrA5xaDjHRdNX6gO9kg6Y7uoNTxgpwhlZfRF9pJ32F2pc9aeyfNbuEdfyKW8Db
	X0wk6n74yibLHlX6QX89Vw6HCbrL1FcZdhFlYeaWWfKDGiMFs+LGOiI8UAPIjSt3hs1
	8bBPGBYwPoDIuO+E9O7ZejI0O2D1Viuzm5x9EnKE=
Received: by mx.zohomail.com with SMTPS id 1740013297626667.3886336676063;
	Wed, 19 Feb 2025 17:01:37 -0800 (PST)
Message-ID: <f56101e7-8aa1-4271-a053-8e95a2ee9490@zohomail.com>
Date: Thu, 20 Feb 2025 09:01:36 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tools/testing/cxl: Set Shutdown State support
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-5-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250219062832.237881-5-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227e841bd94b9258ffad92c53fa0000bb3bb31bf89e8fdd60d539dc257929bd50f0cc5b670a51083a:zu08011227b7643c92a33cb25a4177ef550000424d86e00959820d759be34bd4e92eda8647b6c9964cd0769d:rf0801122dc4a47cc1b77857212f632cd2000051d6190c4956e27367d40cdf8ae054c220fba2be6973d6838848792d6e0c98:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 2:28 PM, Davidlohr Bueso wrote:
> Add support to emulate the CXL Set Shutdown State operation.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Li Ming <ming.li@zohomail.com>

