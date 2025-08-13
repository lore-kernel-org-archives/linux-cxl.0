Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD21136347;
	Wed, 13 Aug 2025 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088080; cv=none; b=OfDYes1q7z5WniR3YvoAqud2U6uJn+pXedJPgPAjpPc55SvSAN+7yontymmWnPM3+fsnmyZBkDjb0I6xAPswmNixeMO6rdhpDTn5JAurhYmUZS/sRbO5MBVbDn1axacYTL56BYXKayr7SE3UsCj72/kL3kVLNV82hQas6JgYePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088080; c=relaxed/simple;
	bh=WVI7u46lb9RHFhVR+adg6ooJk/Oubo9mQASG5pRCIV8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJyA3Lxece8VKRNdp3/AzS7AeAAmcKQxToyCADjEJxCyTFPg7zz2+qRJ3AfL9nzIvIN9+lnWiEA51UF9BdBrze+MD5Leo7njZ5s73lnOfW29nQM6f7z/zaaVqvkFI97vtAkSxRzwNjP0Dv/BXeUbljIT7AlqrsiioU1Kzu13JWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c26yd2GZgz6L55p;
	Wed, 13 Aug 2025 20:25:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E0AF71402C8;
	Wed, 13 Aug 2025 20:27:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Aug
 2025 14:27:53 +0200
Date: Wed, 13 Aug 2025 13:27:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4 v4] cxl/core: Change match_*_by_range() signatures
Message-ID: <20250813132751.00000e97@huawei.com>
In-Reply-To: <20250724142144.776992-2-fabio.m.de.francesco@linux.intel.com>
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
	<20250724142144.776992-2-fabio.m.de.francesco@linux.intel.com>
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

On Thu, 24 Jul 2025 16:20:31 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> Replace struct range parameter with struct cxl_endpoint_decoder of
> which range is a member in the match_*_by_range() functions and rename
> them according to their semantics.
> 
> This is in preparation for expanding these helpers to perform arch
> specific Root Decoders and Region matchings with
> cxl_endpoint_decoder(s).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
