Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1573D34B7;
	Thu, 15 Jan 2026 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498298; cv=none; b=ss2pfjmxMGhtGpW6cY3HsZ5czOQn78QmQZrtqdY3hx17/q7M5wrLpOh9U1X7qQKQiCZNpSeZ5rFFALFzzyDedHAjnHnqfdZUHuRrl/qJeoxNjjCXIEiGjylo/lwcZ+UGbdCRu5tvNRcKQoVQ5UMMy+/oZ2wThtXko1Sj3oI+Lfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498298; c=relaxed/simple;
	bh=AmrGom/q9paYcpt7rNJtSxlkLBlgnJ35hGHkTDAsJKU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFVbZQY/bEbOiU3boGe0fhKn2WJ7A1n6SgR1RT7HgLuA62Y/RwX2BRPx1nEEBv4EHqKW10dceZZlQ03dqun3se9bBlP02THnosKVlNMbpPyehY2KjDiZRctcqPYCrp/mKLYO6ANocvQB81nigX0i41qcVfSKx9x3tuKp0nXL4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsVQF166jzJ4674;
	Fri, 16 Jan 2026 01:31:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BCCBA40539;
	Fri, 16 Jan 2026 01:31:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 17:31:33 +0000
Date: Thu, 15 Jan 2026 17:31:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi: Remove cxl_acpi_set_cache_size()
Message-ID: <20260115173131.0000500b@huawei.com>
In-Reply-To: <eb8b98b7-1c56-415b-b0d7-a87f7a33701d@intel.com>
References: <20260109154042.331296-1-ming.li@zohomail.com>
	<eb8b98b7-1c56-415b-b0d7-a87f7a33701d@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 9 Jan 2026 08:53:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/9/26 8:40 AM, Li Ming wrote:
> > cxl_acpi_set_cache_size() returns an error only when the size of the
> > cache range is not matched with the CXL address range. Almost all
> > implementation of setting cache size is in cxl_acpi_set_cache_size(),
> > cxl_setup_extended_linear_size() does nothing except printing a warning
> > in above error case, but cxl_acpi_set_cache_size() also prints a warning
> > at the same time. So can consolidates these two functions into one, keep
> > the function name as cxl_setup_extended_linear_size().
> > 
> > Signed-off-by: Li Ming <ming.li@zohomail.com>  
> 
> Thanks for the cleanup. Should've happened when I moved it from core to acpi.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
