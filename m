Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650A18C936;
	Tue, 29 Oct 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215168; cv=none; b=uCHnfAYenjg0oh6TA8UIK3+0cmLARO1sFENW+ppzL3c+5m+mDJd1B8+ru2X5Z1LOD0jNL6/TJ1W3k7ki90wFjGZblxYj4zUYGbGSLW8wMlfXX/3LSKypZ+qXMCneOneRJKVqf5/Trq0eMqgtEk3PeKJFw8I78htrKFCR97+4YmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215168; c=relaxed/simple;
	bh=ejoq5ptnUOsVen2Bm6iWVtG3NTwdMNtnCBuPDvnoomw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNoaQsQ/Yhzvy0tshTbmQXUm/Obwf0eDFdmtCoOOnuiUfrUHX54l6a7RZxwT0MLU1D6lWaAU4AxXcmrGPnkx2ahGkMX31dK//grv/VK1yDYIB1H62cN45dOAduKBbMJIpatlio7eXpBmnBrbvwCsG7jsXYjcGWvsoax3Tj+iPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdDR40YJ4z6D8YT;
	Tue, 29 Oct 2024 23:18:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A4301140B30;
	Tue, 29 Oct 2024 23:19:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 16:19:17 +0100
Date: Tue, 29 Oct 2024 15:19:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Dan Williams"
	<dan.j.williams@intel.com>, Fan Ni <fan.ni@samsung.com>, "Bagas Sanjaya"
	<bagasdotme@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] Documentation/printf: struct resource add start
 == end special case
Message-ID: <20241029151916.000051f5@Huawei.com>
In-Reply-To: <20241025-cxl-pra-v2-2-123a825daba2@intel.com>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
	<20241025-cxl-pra-v2-2-123a825daba2@intel.com>
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
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 19:46:54 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> The code when printing a struct resource will check for start == end and
> only print the start value.
> 
> Document this special case.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
FWIW LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
