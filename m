Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8E24DCF9;
	Mon,  9 Mar 2026 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057660; cv=none; b=WXznZfSqQrzIL8b4IMz920UdLJIU39T8axIwR9T4x2EWFamgYX2sgIJlyWNgLLp2GHHQujKLqt2/qYtTcaQvsNF25mBq+DveZDu/EdpsriknTDHeY+PcQH2cMCMhytJa5SdOlUJKfgeEsl7vgfAdnEXJXQ5TdjoFr23v60oE36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057660; c=relaxed/simple;
	bh=yjq5KXbbm4/qOljZqig5Tbug5LT6GqFKymXhpHGEQ8s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cChIINTB8Nw6SzAgATngixzUtbBd9NzGfTWNIo8Ipxom+10lcT/ZF+GIfEVLY8p8tfT13/DXUEcX09n+UNBGuTmJthSLFQOCR17lOOnTmC+jmWG3tiaEDWu+4mHPoN1ecUvLGMGu5i4D1slBMvfV5DCafvs/HB7M56Z7b5/sw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTwYm4nqGzJ46Yd;
	Mon,  9 Mar 2026 20:00:12 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A0C34056B;
	Mon,  9 Mar 2026 20:00:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 12:00:54 +0000
Date: Mon, 9 Mar 2026 12:00:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sungwoo Kim <iam@sung-woo.kim>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>,
	<daveti@purdue.edu>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
Message-ID: <20260309120053.000031cc@huawei.com>
In-Reply-To: <20260308185958.2453707-2-iam@sung-woo.kim>
References: <20260308185958.2453707-2-iam@sung-woo.kim>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun, 8 Mar 2026 14:59:58 -0400
Sungwoo Kim <iam@sung-woo.kim> wrote:

> A race exists when two concurrent sysfs writes to delete_region specify
> the same region name. Both calls succeed in cxl_find_region_by_name()
> (which only does device_find_child_by_name and takes a reference), and
> both then proceed to call devm_release_action(). The first call atomically
> removes and releases the devres entry successfully. The second call finds
> no matching entry, causing devres_release() to return -ENOENT, which trips
> the WARN_ON.
> 
> Fix this by replacing devm_release_action() with devm_remove_action_nowarn()
> followed by a manual call to unregister_region(). devm_remove_action_nowarn()
> removes the devres tracking entry and returns an error code.

Naive question (or just me being lazy).  Why can't we take the
write lock on cxl_rwsem.region?

Jonathan
