Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E226156A;
	Tue, 11 Feb 2025 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295131; cv=none; b=C+HB92HwNshGrSsT8szCJ/O8BKNRG+exGo4hyXGLF1s354CEKFnkPtUVrlau0vEu0vre9K6kiAu9vtX0BmEdUrdGBBGqHLADhaYF/h8J4s6ThHtE49eemSbty2mVG+/Z4Ilf6yq7z79foUX9yuf3TvZQKj7hbeh+Z/biUuG5Vsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295131; c=relaxed/simple;
	bh=yonxLy7nmrzB+FmUpAV/SaoVvSxVuIbvXtQaO1njNVE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxnWqcpeoZ90FfDlmhxe/FeyhFVwKT47/ldDkofWgx3ybTweitHmgBv1twTLj+br7D1+vioA/Vg6JjY0Vl2YSdo3A3V0yt7TGOfP3t9MGeLnkUz6ClxXiMNgUH3kjFIEd/XvS8IBVp7an0Vfaq1zT8+FaKnnXlRAwwXGo6Q2mis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YspNR36CFz6H8Yh;
	Wed, 12 Feb 2025 01:29:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 805D41400DD;
	Wed, 12 Feb 2025 01:32:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:32:06 +0100
Date: Tue, 11 Feb 2025 17:32:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 5/7] cxl/core: Use guard() to drop goto pattern of
 cxl_dpa_alloc()
Message-ID: <20250211173205.00003022@huawei.com>
In-Reply-To: <20250211075727.351895-6-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
	<20250211075727.351895-6-ming.li@zohomail.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:57:25 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In cxl_dpa_alloc(), some checking and operations need to be protected by
> a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
> cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
> by using guard() to hold the rwsem.
> 
> Creating a new function called __cxl_dpa_alloc() to include all checking
> and operations needed to be procted by cxl_dpa_rwsem. Using
> guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
> function.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
