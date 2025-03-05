Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEF1FCCE0
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164593; cv=none; b=GmpzWC8t5SXgdnupEG3UbXjtrcj0p2+dJBBWJtlJDy00o82cdLMzItNeWjLBw9QNplvTllgPp1lsuC5OCE/duTI3NJf5XmBB9zsGF/1D/NB97WqNxg6z6JtZJi7BMw6TWKi+Y09Bx65X8RncWfRLmSFVYUtLEXqv2030c/g6oG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164593; c=relaxed/simple;
	bh=6AeGg2TJx+EOxKASa/6Z2pzSEdLM07OALRwSKgOOX+Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWQAvm7DxiITnDNHH0jMx0H2tlXKZAmgky2+2cplqbErE4RtoY1jdWf1z0KOMiFbmyMWQBTaxkqrzafIeME0HRqyCgssMKk6HgWoEzr3+ZMUuJOylitQ0a8+Pubsns+dc3ruVXkNO9o7WMeujXw8knSHlnsiQGJG2J5ftHTV8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z75jf2HTQz6L52J;
	Wed,  5 Mar 2025 16:45:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 192DB140A08;
	Wed,  5 Mar 2025 16:49:48 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Mar
 2025 09:49:45 +0100
Date: Wed, 5 Mar 2025 16:49:40 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH v3 2/3] hw/cxl: factor out calculation of sanitize
 duration from cmd_santize_overwrite
Message-ID: <20250305164940.00004a70@huawei.com>
In-Reply-To: <20250220052724.1256642-3-vinayak.kh@samsung.com>
References: <20250220052724.1256642-1-vinayak.kh@samsung.com>
	<CGME20250220052736epcas5p254a601a6710b3fd58a827ca99680d746@epcas5p2.samsung.com>
	<20250220052724.1256642-3-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 20 Feb 2025 10:57:23 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

> Move the code of calculation of sanitize duration into function
> for usability by other sanitize routines
> 
> Estimate times based on:
>              https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Hi.

Authorship of this patch is confused. Should Davidlohr
have a Co-developed-by tag? (I think those are used in qemu)
If not should the From tag be set to Davidlohr?

I'm going to post a series for potential merge without this
fixed as I'd like some more review anyway, but good to clarify
what is going on in this patch.

Jonathan
