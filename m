Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EF27CCDA;
	Mon, 19 May 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668808; cv=none; b=jo6IKG6te6NwaCcI7/1OwJaVb9flEFve2CPqWSigElUwCPBoFaUqMFtDFqfoGG6zJMyoP3yJ30MdcaTlSN02ruptX+m41t6Oo6r57Pw9DnRXjrDRwQUBtGkrCmnojqrGTMXJmV5HylLynkQ/d10PFcc7edfJ2R+O3nP76+GMGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668808; c=relaxed/simple;
	bh=/UuJChUS6f2hqhSeC2+UM0QF0uDsSV1LwOX3xKnLAz8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U27xoJpYQSpnHJYJxVPxf3WSCT6jCbh9XhqvlStURCQ/CaPXPUDlO8vK7+IiYKTZpgCGkptGJub3wjqbvRVmuB5N7tul7SWcTZ75UTNi5q0f5eie0enLvonGaSHsZYgL73HdEouJFU2u2z73r5/uGY4WGYuco2I4MrM7uZXTFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1M5s50Hzz6M57D;
	Mon, 19 May 2025 23:28:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 53DE7140392;
	Mon, 19 May 2025 23:33:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 May
 2025 17:33:21 +0200
Date: Mon, 19 May 2025 16:33:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/feature: Remove redundant code of get supported
 features
Message-ID: <20250519163319.00002544@huawei.com>
In-Reply-To: <20250516143220.35302-1-ming.li@zohomail.com>
References: <20250516143220.35302-1-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 16 May 2025 22:32:20 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In cxlctl_get_supported_features(), there is a code block that handles
> the case where the requested is equal to 0. But the code following the
> code block can also handle this situation. So the code block is not
> needed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
