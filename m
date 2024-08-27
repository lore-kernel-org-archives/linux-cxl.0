Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB41C3F19
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770955; cv=none; b=goOOQFccG1rLFCuzExclQbRh+5TRx1oBIEAFzMzSwSq69RvEGE/CgobjgjT0S89R0y++EVHI1RKKUxvaDMYv406Q/F3htfOwgUjDHSzgbVvuOXOsoGhWXEpivwx2Ph29lcVKN0musV4rpmmnSGgnFVypot5Ux2PG5w4PFcP7xhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770955; c=relaxed/simple;
	bh=MHg5YztiiPWrgRb4wyrOCFX0mr0t7Gzq4ILzz4QJGSY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUNryp8UkADHo41mmbb+1nZASugzFBysh3DKpmZOC0LrRCePZNEFYRwCY0FvDU2mNQ5vCGrL905mCaHPf6+dRh90VvYw0UMNe0VEVXOi3PMXCw5oA4bxcoDcxbN/SSFguTvy3d0UG45AMm1JZNyVkwUuVZ60hTw8pbWr2H/l/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtW0K0Fdgz6K5cC;
	Tue, 27 Aug 2024 22:59:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 23E03140A71;
	Tue, 27 Aug 2024 23:02:29 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:02:28 +0100
Date: Tue, 27 Aug 2024 16:02:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/pci: Remove reduplicate host_bridge->native_aer
 checking
Message-ID: <20240827160228.00000963@Huawei.com>
In-Reply-To: <20240827045755.1837473-3-ming4.li@intel.com>
References: <20240827045755.1837473-1-ming4.li@intel.com>
	<20240827045755.1837473-3-ming4.li@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 04:57:55 +0000
Li Ming <ming4.li@intel.com> wrote:

> cxl_dport_init_aer() already checks host_bridge->native_aer before
> invoking cxl_disable_rch_root_ints(), so cxl_disable_rch_root_ints()
> does not need to check it again.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
