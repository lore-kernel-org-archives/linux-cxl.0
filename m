Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A54145B22
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jul 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253717; cv=none; b=mVuD/HMEkjhjjmRR5sIl8o/gElUrpSrtlaY8SIdlsx7SPK9qUkO/ClhrqzTaYXeHyC06o7YGojLTLdh64JgalSZrw8OSdIoC1BTpYLwUpvFdls+6h+jFSQ8ZoYRwZRjabue+g2zNP99L8sjXMmdJnkjWrsyVHREktXyVEnCrkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253717; c=relaxed/simple;
	bh=/pzOAodyXNgk5RuwQLPbQORAqMCQFeqWG5h0sX6D0Uw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlvvNcUVOFyXDR3Nt6+owtzleDhaVbBpVfpBGyayGO5q9slwbnJ2Nrv81GCkwFH5PvGrVlltK3mmMu0WXUc5xI4kpVjUYmFxP///V+5qKuYpFWqUt8fblfH1Q5iU2TTIjont94aKOHR5rZuNXs40Qr9oWwB2+ywsUkTXOAmJAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WXc5X2hbqz6K5fV;
	Mon, 29 Jul 2024 19:46:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B6253140CB9;
	Mon, 29 Jul 2024 19:48:32 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 29 Jul
 2024 12:48:32 +0100
Date: Mon, 29 Jul 2024 12:48:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH 11/13] fwctl/cxl: Add query commands software
 command for ->fw_rpc()
Message-ID: <20240729124831.0000790c@Huawei.com>
In-Reply-To: <20240718213446.1750135-12-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240718213446.1750135-12-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jul 2024 14:32:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add a software command through the ->fw_rpc() in order for the user to
> retrieve information about the commands that are supported. In this
> instance only 3 commands are supported: Get Supported Features, Get
> Feature, and Set Feature.
> 
> The expected flow of operation is to send the call first with 0 set
> to the n_commands parameter to indicate query of total commands
> available. And then a second call provides the number of commands
> to retrieve with the appropriate amount of memory allocated to store
> information about the commands.

We will need another layer of querying to query what features
are supported for each type of access. Get is probably always reasonable
in some cases we may want to block Set even with taint as it may provide
a nasty footgun.

Jonathan
