Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9128980F
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024758; cv=none; b=hKXnHGEwlgasr04saWePb4MZVz+T7G9Ambj8ZTzavZMsVyBe5TEWo2xb2Y77E+DEL6BV4Rp1jMHiPBmLpEfbFALzUQ7eM08KNWqdSpzhyMue+Aa8q0rkgMhwdQdYQaRO6q1+7DnfwVkmFJiryEXpVoZmARrxcLgkgd8HDA5h28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024758; c=relaxed/simple;
	bh=+2Ah3Ox5nyl6teah44dQnf+9Adeu8/7K6faXfPxvma4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1dHebAUYT6X9bl4us+BYtymD6FbzVJHQ2i5+SZRP1M7Rk14NLb1qTY2OiB0SEquoQsnDh0xHxraNF43Osfu7+wrgqY0EK1fBDGA+sXoXmDyL8diPFUpZntBUJQD8p8xapCwMOXKEEa5VyGXe8SKw7OrqtuDA17TKCbtAuGuQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fcpD65G8czHnGck;
	Sat, 21 Mar 2026 00:38:46 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8457A40587;
	Sat, 21 Mar 2026 00:39:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 16:39:11 +0000
Date: Fri, 20 Mar 2026 16:39:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <gourry@gourry.net>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 6/6] cxl: Add HDM-DB region creation and sysfs interface
Message-ID: <20260320163910.00003298@huawei.com>
In-Reply-To: <20260315202741.3264295-7-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
	<20260315202741.3264295-7-dave@stgolabs.net>
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

On Sun, 15 Mar 2026 13:27:41 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> A single Type 3 device can expose different parts of its memory with different
> coherency semantics. For example, some memory ranges within a Type 3 device
> could be configured as HDM-H, while other memory ranges on the same device
> could be configured as HDM-DB. This allows for flexible memory configuration
> within a single device. As such, coherency models are defined per memory region.
> 
> For accelerators (type2), it is expected for the respective drivers to manage
> the HDM-D[B] region creation. For type3, relevant sysfs tunables are provided
> to the user.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Seems fine to me, but I'm suffering Friday so don't really trust my
wakefulness enough to tag this version.
