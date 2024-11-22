Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC62309BF
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288762; cv=none; b=WrbNzw9t5fThf7qDf0r4ya7O58Ksm5KogWppDt37xU7yEDwLVGTYNaMpeHmTWgd0PCjoEv0BiVgoOqY7lPkFQe4T81CbXJWHnbLj1TIY+akFB5B38+uS4ORh7Q0B+tvNsyPXwst4JP+nFZFJ59DSFiFh02BE6Cnj0vtN1nj0PEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288762; c=relaxed/simple;
	bh=DpsXvOwNLiKyF7pfP0gSaDph1N9EU3HifGgnzQuQ+C8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsICK1p5AvNzWspXafadToBiW84ELBbVRDJaNjy4IufxT7KfgUvcUyhlhbFHouNvoZPVSQ/p3CFXmF3M3DYCHb8WoWOvx2djDV1OnGpl/DduBnU2Bq4U9bzxYR/Tu5tYmVMd/Z6IuRXnVVxmPlDao2VkDWivarB17uydRE+6aFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvzJp1KLKz6D94b;
	Fri, 22 Nov 2024 23:18:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C9754140447;
	Fri, 22 Nov 2024 23:19:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 16:19:15 +0100
Date: Fri, 22 Nov 2024 15:19:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 17/20] cxl/test: Add Get Feature support to
 cxl_test
Message-ID: <20241122151913.00001ab8@huawei.com>
In-Reply-To: <20241115212745.869552-18-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-18-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:50 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add emulation of Get Feature command to cxl_test. The feature for
> device patrol scrub is returned by the emulation code. This is
> the only feature currently supported by cxl_test. It returns
> the information for the device patrol scrub feature.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

