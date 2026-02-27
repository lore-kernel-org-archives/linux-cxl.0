Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4414314A82
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194909; cv=none; b=KaAffqJmXeT5pN+qyK6x5dH3X4nnOfJNvPO41I/hHTJJDGWMo2rwMwHXfTyYQVh9Q1ceQPfSMwG8+X4Eh0uIwYAH/LA/jQvu1uxGq9nGFfue8L41xzkDraXfoivM/1x9WeOXCfrLG9w5xZX4KkS7moONOQd7a9BHcdTwTMnupek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194909; c=relaxed/simple;
	bh=57I2Z5sSrzg56u5YXaVKQCG96wXRE1bdUbKKw0B0K90=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXU59ImnifnsQD3adLaCiKfLl+xr82S1TUViiae5529DXa2SXKUXXAIv3XRELRaTx51DdWunUl37hmlBh+V894hDo/hs2C1y6PY+0Zlm4nZwyrXwomDmnT7bFm7FdU08OXGpsRAMLkikZmpWPI3rIw/djeeSNC91ryyAwAQGe6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMnVN14Q3zHnGck;
	Fri, 27 Feb 2026 20:21:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id F1C9440584;
	Fri, 27 Feb 2026 20:21:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 12:21:45 +0000
Date: Fri, 27 Feb 2026 12:21:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 2/3] cxl: export internal structs for external Type2
 drivers
Message-ID: <20260227122144.00007cc0@huawei.com>
In-Reply-To: <20260225121430.3839189-3-alejandro.lucero-palau@amd.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
	<20260225121430.3839189-3-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Feb 2026 12:14:29 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for type2 support, move structs and functions a type2
> driver will need to access to into a new shared header file.
> 
> Differentiate between public and private data to be preserved by type2
> drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/cxl.h    |  97 +------------------
>  drivers/cxl/cxlmem.h | 114 ----------------------
>  include/cxl/cxl.h    | 226 +++++++++++++++++++++++++++++++++++++++++++
I'm a tiny bit dubious that this has 'yet' reached the state where the copyright
notice in cxl.h is appropriate.  This patch for instance is just code movement
which I'd not consider sufficient.

Meh, it'll be valid in the end!

Trivial follow through from the earlier patch.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..11f76d61c9f1
> --- /dev/null
> +++ b/include/cxl/cxl.h

> +/**
> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> + * driver specific struct.
> + *
> + * @parent: device behind the request
> + * @type: CXL device type
> + * @serial: device identification
> + * @dvsec: dvsec capability offset
> + * @drv_struct: driver struct embedding a cxl_dev_state struct
> + * @member: drv_struct member as cxl_dev_state

Follow through from previous...

> + * @mbox: true if mailbox supported
> + *

