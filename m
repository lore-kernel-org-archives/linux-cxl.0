Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D4290D95
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671259; cv=none; b=KlcO8iMEn9KsO3QTBPrKQSsa6LD8b9r+eYC66tryTsSEWP6Phs7VrhaEScn7hYYodISzpldSV2cfKryE23/EZtErFje2EpUWD2EgCHf7hjaGtUPqAvxdotFmdsbqeF+YsCPd9DzORDg8RfRdkFZZH4eTE6LTGddDj4Q0Gs/uuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671259; c=relaxed/simple;
	bh=neTE7zPicZyDfpFFQnz9cowx7jqwxKUmroyovyklGnI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noT+OEGl9PStq68Sfwr2CN866c/evnte+LCOb0nNlz82qJc8Gq9iw/LiYKeRa1KDOvlBkpWOGZkr0g3mTs/lkY99W/V+MVpplKWqmZr9RFrCTpoksUBJYEYaJRCKdVNYEf7SNrwzqkhUIPjyXhzONF2RPOGzA3w71qHQTdvWCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhxBy5xB0z6M4t7;
	Wed, 16 Jul 2025 21:06:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4926F140276;
	Wed, 16 Jul 2025 21:07:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 15:07:33 +0200
Date: Wed, 16 Jul 2025 14:07:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 3/4] cxl/events: Add extra validity checks for CVME
 count in DRAM Event Record
Message-ID: <20250716140732.000028c9@huawei.com>
In-Reply-To: <20250716104945.2002-4-shiju.jose@huawei.com>
References: <20250716104945.2002-1-shiju.jose@huawei.com>
	<20250716104945.2002-4-shiju.jose@huawei.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Jul 2025 11:49:44 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> According to the CXL Specification Revision 3.2, Section 8.2.10.2.1.2,
> Table 8-58 (DRAM Event Record), the CVME (Corrected Volatile Memory Error)
> Count field is valid under the following conditions:
> 1. The Threshold Event bit is set in the Memory Event Descriptor field,
> and
> 2. The CVME Count must be greater than 0 for events where the Advanced
> Programmable Threshold Counter has expired.
> 
> Additionally, if the Advanced Programmable Corrected Memory Error Counter
> Expire bit in the Memory Event Type field is set, then the Threshold Event
> bit in the Memory Event Descriptor field shall also be set.
> 
> Add validity checks for the above conditions while reporting the event to
> the userspace.
> 
> Note: CXL spec rev3.2 Table 8-58. DRAM Event Record, (Field: CVME Count
> at Event), "For events in which the advanced programmable threshold
> counter has expired, this field value shall be a value greater than 0.
> Counter expiration events in which the corrected memory error count
> is 0 shall not generate a media event record".
> Q: Should kernel drop the event record in this case or user space
> to handle?
> 
Would be reasonable to combine this with previous patch but I don't mind
that much.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
