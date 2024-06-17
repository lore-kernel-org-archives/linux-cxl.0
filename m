Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520D13AD1E
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642605; cv=none; b=Q5a+B6LFFW99lVWVfLqNIQVu182Mk0lt/gmdOXTgeDaSD7H5jsv2iFkWjfP4P9P2PomZt+vyTZDOkXvbLHTRMCxdDvhhIXs7y90yNNXyiijw8aE96vdpJGHIvZr/Hh3mpoFpnV9gUeD8LYilMSICDNiqWX8k0DIglmm8um5up4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642605; c=relaxed/simple;
	bh=q2tSueLWa7iMyNDafiaSw3aR3CIfF/8f47QXkGXuT50=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mO4/b8SyJy0Gv1EkHlCnQFfxGQ5ddr6Ec8kAvoTFK1r/rH6eHZLR161dVvV8ZsnXGLs9psoT03/RHeyiP+uJ6i1s7ZzZABwEiOjly99BWkqP/tdAvTZK0BZjwwcxWFbDVlvBnxONuR8hqpSBHEcTdGhtE2gLyYd6C94cnQg90Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W2wYb3kPdz6J9yK;
	Tue, 18 Jun 2024 00:38:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A9C4F140519;
	Tue, 18 Jun 2024 00:43:20 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 17 Jun
 2024 17:43:20 +0100
Date: Mon, 17 Jun 2024 17:43:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] cxl: documentation: add missing files to cxl
 driver-api
Message-ID: <20240617174319.00007b40@Huawei.com>
In-Reply-To: <20240614084755.59503-3-yaoxt.fnst@fujitsu.com>
References: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
	<20240614084755.59503-3-yaoxt.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 14 Jun 2024 04:47:55 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Add the missing files into cxl driver api and fix the compile warning.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
