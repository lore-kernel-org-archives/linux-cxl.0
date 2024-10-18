Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0772010E6;
	Fri, 18 Oct 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249460; cv=none; b=TI39SVffcDGh+/sNVMFSpiGhmzqRekXSV2TMIOA3SIkrCdS/agJulReao4V8eISMj0X37TcD4xjo9IMYQtklp2Jlo/EVPrl5LlcXzRGfc56KmJ+Pp7KNIffBAthMq8K7Pru51Qpy93ek+z/rWzOhwWkTI4LvCyGUeVu4KuvXkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249460; c=relaxed/simple;
	bh=+xGeuhUxIqF8diO+N3W/XAQkvBNA15z23E2Ktsiu1Eg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imIL5MRUjP0ZjclF4hL9cB+/4oDWXii36jKTt3EofYWNKr4WVOhXYeqrzBnirHN426geiatifJat1mT6XGmv48nlOVMWvdnMSbmmrgX0M5oDDw8D/0YRlKD0Q7sN2yGWo3J3xILdW6GlljByp43HqQj5qAw8cYuuNO2h1LK3a2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVMJP50RHz6HJdy;
	Fri, 18 Oct 2024 19:03:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A8CC1400F4;
	Fri, 18 Oct 2024 19:04:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 13:04:15 +0200
Date: Fri, 18 Oct 2024 12:04:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 0/4] Updates for CXL Event Records
Message-ID: <20241018120414.00006c61@Huawei.com>
In-Reply-To: <20241016163349.1210-1-shiju.jose@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 17:33:45 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.1 CXL Event Records has updated w.r.t CXL spec rev 3.0.
> Add updates for the above spec changes in the CXL events records and CXL
> trace events implementation.
> 
> Note: Please apply following fix patch first if not present.
> https://patchwork.kernel.org/project/cxl/patch/20241014143003.1170-1-shiju.jose@huawei.com/
> 
> Shiju Jose (4):
>   cxl/events: Updates for CXL Common Event Record Format
>   cxl/events: Updates for CXL General Media Event Record
>   cxl/events: Updates for CXL DRAM Event Record
>   cxl/events: Updates for CXL Memory Module Event Record
> 
>  drivers/cxl/core/trace.h | 201 +++++++++++++++++++++++++++++++++------
>  include/cxl/event.h      |  20 +++-
>  2 files changed, 190 insertions(+), 31 deletions(-)
> 

Hi Shiju,

Why are these an RFC?  Seem in a good state to me and the
questions I'm seeing are naming stuff that to me doesn't
justify RFC status.

Jonathan
