Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE741A08A4
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262381; cv=none; b=TlefoflFYrb2sWBuR5VA38JBjgotEjaPtzkEmT9ZZXaaWWDcuxgTgd0aSM1eFLU6gOfoEppYK+3vGyumRwmTotydqOdkMyEOCd9m/9YrlDokzustj5fjnV5/tDLdesr+c3sYCJXfQ0hTf5ohO4mFwZQOC1ySFwjFUN1LpUNRN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262381; c=relaxed/simple;
	bh=p7Cbkc5NesmO/DBuvb7TLgoDiKScxYzht4Dy/15+p+U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovBjHxCJ3XR84Fa8IJFaQo0LHh0vmpsivmD+x+wA9SuI+RBRBQro83oAaAxxiyPxfbwkUOlpjLhGdMrswKRUDwuH2bw1UozpvX1D5h+WBx6KPNaMqaDwDH54UK12KbYjAu64uLS2Vz4C3/LI8LGY687/eb5sr+SUCHRjuaaZsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3MRN0L5Bz6M4v0;
	Fri, 15 Aug 2025 20:50:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C9D9F1400CA;
	Fri, 15 Aug 2025 20:52:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 14:52:56 +0200
Date: Fri, 15 Aug 2025 13:52:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v8 03/11] cxl: Add a cached copy of target_map to
 cxl_decoder
Message-ID: <20250815135255.00003218@huawei.com>
In-Reply-To: <20250814222151.3520500-4-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
	<20250814222151.3520500-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 14 Aug 2025 15:21:43 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a cached copy of the hardware port-id list that is available at init
> before all @dport objects have been instantiated. Change is in preparation
> of delayed dport instantiation.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM, though I haven't yet gotten to reading where it's used in later patches...

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

