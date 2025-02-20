Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABB212B3D;
	Thu, 20 Feb 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072647; cv=none; b=idcxm2L9O6BIkhWBxmm+6sItzIt3q5I6jQ7J28zPSNE4yfGu067/g7r/LDp43Z9Y/uV+xn1WERPkQcHQxwKyC2iyvWBKh4PhwvMdvQnhP96bgIYTOqaykMO74YWLxlx6NEf04Kv0pFwGbHmU/m7Antl+UxSMf8KgXbpAiUPlwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072647; c=relaxed/simple;
	bh=VrMP9vBukzDz6aGBUoCl8lkB6PDGHUByCrqml2NY2Yk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PN2JLKb3LSEmqs/JVw1xFqhIO+/f6tpAJflfSEHApR4heYCCm9+KPClC8qbO6iSVJG88ibaljvfNbpH2PdwyWMgkSEmVqAWy+ewGoUdDYodopUtC66ofIMUWlJJFLq1zWHT8fG1EKTtc4S9dEEfsmSOE4bIQ8ISbArQ0A86YkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzKxW6Gvkz6HJfl;
	Fri, 21 Feb 2025 01:29:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DB3281400D9;
	Fri, 21 Feb 2025 01:30:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 18:30:42 +0100
Date: Thu, 20 Feb 2025 17:30:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v5 1/1] cxl/pmem: debug invalid serial number data
Message-ID: <20250220173041.00005a01@huawei.com>
In-Reply-To: <20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
References: <20250219040029.515451-1-wangyuquan1236@phytium.com.cn>
	<20250219040029.515451-2-wangyuquan1236@phytium.com.cn>
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

On Wed, 19 Feb 2025 12:00:29 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> This adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> For cxl-test to work properly, always +1 on mock device's serial
> number.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
