Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3301B3926
	for <linux-cxl@vger.kernel.org>; Tue, 24 Dec 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056315; cv=none; b=pbd+P9mY841G8Df2oorsLm9GeaE/BnLkC55nq8SYgFfk3xGyHpTpSJiGSF//2UwU0XN/h6RkhRczngWPpletjBybrnDskAtv8G2007Jq7W6PKlGX+VGAtE+EuJ8VJVItrkSziWY3qFQmfFD0AoLCaos3fHCoygQlD8OggRayTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056315; c=relaxed/simple;
	bh=XmEPd51duE0quMQXp5iWYE8GZme5jJZlGfAQVlHUmRw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgpRRRuTAkLz0cA2ZCwlqrFECMmA28Vn3NuLxTThhRhTy5Hqb851TzvW+/e7aMYj6imMgzenJyPatGpc8aHn+8VpVdhdY9iCvgyUg3D48l7GvRiRFGe/jvq1KjD0J2X4YfsKUAGVWqrQ+QribRYCqUXotCYtBaxiuIezQSePlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHfl20tPzz6K5my;
	Wed, 25 Dec 2024 00:01:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E625140736;
	Wed, 25 Dec 2024 00:05:11 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:05:10 +0100
Date: Tue, 24 Dec 2024 16:05:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, Huaisheng Ye <huaisheng.ye@intel.com>, Li Zhijian
	<lizhijian@fujitsu.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Fix region creation for greater than x2
 switches
Message-ID: <20241224160508.00007d9e@huawei.com>
In-Reply-To: <173378716722.1270362.9546805175813426729.stgit@dwillia2-xfh.jf.intel.com>
References: <173378716722.1270362.9546805175813426729.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 09 Dec 2024 15:33:02 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Huaisheng Ye <huaisheng.ye@intel.com>
> 
> The cxl_port_setup_targets() algorithm fails to identify valid target list
> ordering in the presence of 4-way and above switches resulting in
> 'cxl create-region' failures of the form:

<snip>

> Fix the method to calculate @distance by iterativeley multiplying the
> number of targets per switch port. This also follows the algorithm
> recommended here [1].
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Link: http://lore.kernel.org/6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch [1]
> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> [djbw: add a comment explaining 'distance']
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes since the RFC [1]:
> * add a comment to clarify what 'distance' represents (Li Zhijian)
That definitely helps!

