Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF51B14E9
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741223; cv=none; b=M8TLB5LgORSx0JmG05jEedc/6E5hSFUkAsTiVsueMHQVrieLMX7IIrkbbi+Fg+90SNY3/+tTPKVKTdIzDR45mZ50aH3djC1L0rNaNLQSMJXYXiSnO5vGKke6rJ2eyniEzlxFgjiVZdlLc3elT/BPRJA+wxYEuByqab7DqFfmQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741223; c=relaxed/simple;
	bh=rSiuFNu4vKPtT7cyfnkB2GZFiGOFERND4CMujjlbZpU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJWjraSUHZ5rFtTrMu8VldyTPJwoqalcu42Ky8h5nFHfZi1OAi2SFgW3YF04eTx4VOpcoPopnNC3Lu29BhLdAlPMvoBxjUoD7ey9o2ZGKe2eC40luWmeER0hVndmGktFBWY8dB5YwIcH2FHC+ufGIWH11oBJ1EO+Y5XWdLcBiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WlB9k5Rhzz6K6gh;
	Fri, 16 Aug 2024 00:56:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 92250140A87;
	Fri, 16 Aug 2024 01:00:18 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 18:00:18 +0100
Date: Thu, 15 Aug 2024 18:00:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alejandro.lucero-palau@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 2/2] cxl: Convert cxl_internal_send_cmd() to use 'struct
 cxl_mailbox' as input
Message-ID: <20240815180017.00003ae2@Huawei.com>
In-Reply-To: <20240724185649.2574627-3-dave.jiang@intel.com>
References: <20240724185649.2574627-1-dave.jiang@intel.com>
	<20240724185649.2574627-3-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Jul 2024 11:55:17 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> With the CXL mailbox context split out, cxl_internal_send_cmd() can take
> 'struct cxl_mailbox' as an input parameter rather than
> 'struct memdev_dev_state'. Change input parameter for
> cxl_internal_send_cmd() and fixup all impacted call sites.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
