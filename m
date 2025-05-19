Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A302857C1
	for <linux-cxl@vger.kernel.org>; Mon, 19 May 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669382; cv=none; b=Re6H/16KkwEyIxgqgFrit9hltrrZVKvsU7ehP22kwACMxXaHAAb8/FCV3SfCforEA5oxT1U9vA/f4+6nH4UyjKzHzynteBiEq3yqZmAPueLVHYcOzMV6mIvgqwnySbRj4w4+QQGcH0S7aQuzotBJCsBdLTcpnd2yAZNLZmFFgiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669382; c=relaxed/simple;
	bh=dvfQtSanWrEEd3MwIIcWNRFHc7OUj/ZD6prAKwRqJco=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Odhf0cbjMznSOGhM7Pw3vvSXEpxaHjrnzx5xSVIVBpuNRx9MB8eS0PZ4zXnJ1NdDbvzgRevdOmzW+VIaXkkZHR3p9UtWn66Vzx0kKfQVB82Fm/vMyaH84pO0wuqcOOPj/kPLwHE3yXGD5pUYKDOlwk8YIGXuJdITAoU8X1JHLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1MPX5Ct7z6K9Jn;
	Mon, 19 May 2025 23:42:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 74001140276;
	Mon, 19 May 2025 23:42:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 May
 2025 17:42:56 +0200
Date: Mon, 19 May 2025 16:42:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <gourry@gourry.net>
Subject: Re: [PATCH v2 0/3] cxl: Update CXL documentation for access
 coordinates calculation
Message-ID: <20250519164253.00006854@huawei.com>
In-Reply-To: <20250515000923.2590820-1-dave.jiang@intel.com>
References: <20250515000923.2590820-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 14 May 2025 17:09:20 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> v2:
> - Language clarifications (Gregory)
> - Move all CDAT bits into single document. (Gregory)
> - Define CDAT terms. (Gregory)

Obviously I'm late to the game, but fwiw I looked through this
and it looks good to me as well.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Add CXL access coordinates calculation documentation including CDAT details.
> 
> 
> Dave Jiang (3):
>   cxl: docs/platform/cdat reference documentation
>   cxl: docs/platform/acpi/srat Add generic target documentation
>   cxl: doc/linux/access-coordinates Update access coordinates
>     calculation methods
> 
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/linux/access-coordinates.rst          |  86 +++++++++++++
>  .../driver-api/cxl/platform/acpi/srat.rst     |  27 ++++
>  .../driver-api/cxl/platform/cdat.rst          | 118 ++++++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
> 
> 
> base-commit: 7855bc1362518673103bd9357827572207e6f6d9

