Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058030F813
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603218; cv=none; b=nEc44Y4Xs/0PGkJ7Wp9q5J59WTC1HHto1m/P5+4QINvyUV8M65kFtdba/AwMbwbG4eQLexIxZc49Fr9daQxusOVpPsBSQlJ0goCTeD3h2Qhu7JD46xphkRQ+IUoplFXQGhhwSnkzJphJf4x+3BazyyZlSu/H/lXyHHp5yuck+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603218; c=relaxed/simple;
	bh=O3WSezNGx9ecIpWW3ARdyqzKWp0cGYThzpubwe/FsCI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpjsXHZdD1SJBKMuU07IiKYoIeqeaI+2ROeGa4bsU/9msPSYs48dlI4lvtFE97gO04OcwijaFaiTYoAPpMrKSNYm2KKNMBobkVOwtY+1NHRidcD8UU0h+GeT2wh8Fa6r8QeEl/auNWWZXlwkp9jWqSFbnSTRMmiggC+xDxlONhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5nTr3Fytz6GFth;
	Tue, 19 Aug 2025 19:31:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 67CE014037D;
	Tue, 19 Aug 2025 19:33:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 13:33:34 +0200
Date: Tue, 19 Aug 2025 12:33:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 02/18] cxl: Move struct cxl_dev_state definition
Message-ID: <20250819123332.00004cb5@huawei.com>
In-Reply-To: <20250812212921.9548-3-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-3-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Aug 2025 16:29:05 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Move struct cxl_dev_state (and associated structs) from cxlmem.h to
> cxl.h. This is in preparation of adding a new CXL cache device type
> that will also use cxl_dev_state.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Hi Ben,

I'm just going to take a first (likely superficial look at this) so
comments may well be lightweight.  I need to get my head around it
before offering more substantial stuff.

Jonathan
> ---
>  drivers/cxl/cxl.h    | 114 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h | 113 ------------------------------------------
>  2 files changed, 114 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1de4fec5c8f4..751e5860423a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include <cxl/mailbox.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -696,6 +697,119 @@ struct cxl_ep {
>  	struct cxl_port *next;
>  };
>  
> +
One blank line probably enough.

> +/*
> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> + *			 HDM-DB, no requirement that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */
> +enum cxl_devtype {
> +	CXL_DEVTYPE_DEVMEM,
> +	CXL_DEVTYPE_CLASSMEM,
> +};


