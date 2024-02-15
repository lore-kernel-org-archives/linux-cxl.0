Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF801134CC9
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013841; cv=none; b=L3uqWINr3Q8Bfyy96pMGveeFjPvOGxJjxGvydfFA3eqzJIFEfFwUtvWt2RpMnuFQie4eSjfsJhbG7tBgYWdj1BFCE64zjvkke8nuPuPDWI211qpce6YDU7PyVdhOoh5JkApheUXRqAVEo+J3c10Ag7pBMAtIrzCVMFK9LeAtPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013841; c=relaxed/simple;
	bh=DSGs0iEdxyiSoBURsq8B9XIX6uLyaj7nNy9D2IpWDiI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOb/1aHe5/sXhqP5FGv7IVJSqYwKsY9NjIMxLmX+zwkUfW9V2OCHfbaBYLMjwjYE3JqwwSvIPeqNmk1ev2irAn2CSSRzfAz+jeb0dRkXIZqRN7b5pguOxDVncnO8JDQqPNAdTbW36RjfQq6oyxR18U+QZIuyIag65JTXfInNHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKqp4jBNz67n0t;
	Fri, 16 Feb 2024 00:13:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BB42140682;
	Fri, 16 Feb 2024 00:17:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:17:10 +0000
Date: Thu, 15 Feb 2024 16:17:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 0/4] cxl: Fix memdev qos_class sysfs attributes
Message-ID: <20240215161709.000053c0@Huawei.com>
In-Reply-To: <20240206190431.1810289-1-dave.jiang@intel.com>
References: <20240206190431.1810289-1-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 12:03:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> v5:
> - Only update the perf sysfs groups (Dan)
> - Remove unnecessary type cast (Jonathan)
> 
> v4:
> - Fix resetting of dpa_perf (Wonjae)
> - Change cxl_qos_match() to return bool. (Jonathan)
> - Remove unnecessary void * casting. (Jonathan)
> - Replace open code with sysfs_update_groups() helper. (Jonathan)
> 
> This series provides fixes to the memdev qos_class sysfs attributes. The
> current code emits duplicate sysfs attribute under the same directory and
> the ram qos_class clobbers the pmem qos_class. Move the attributes under
> static definitions and allow the attributes to show up under ram and pmem
> directory individually.
> 
> The series also adds cxl_test support in order to allow CXL CLI add a unit
> test for qos_class attributes.

I see Dan has this queued up already but fwiw (excluding patch 4 because
I've not looked at the cxl-test stuff for a while).

For patches 1-3
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
