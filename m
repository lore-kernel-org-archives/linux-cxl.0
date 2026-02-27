Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD528D830
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195093; cv=none; b=BLzfrB3B03PCkov0ZwNfjIKYwoqX+oPWzqDBVbZqwUM6jN3/0o+c+B7YoKazHXYwm6KM9yZqlTXnEIQpFyXsTkqyabF1BBI2Q/2zMdyW3hToaUFMxZVmEnA7VuedzMfePKzK0rMtANNFsUlkeXribx2fMJdzfiyfozSJ8DQQBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195093; c=relaxed/simple;
	bh=ZOyXoW+G/o/p1aKxwvJF+eytkY4wN+BuYS2mgEYLyQQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntTpEcFezxDYsrNmmTlXZRHJUqYxzBh9G0PiZ3FVWRkH5wiCjy3bZT6uxm/ULubrSvPH4AW8ozijuZ71a5pb8raJ/5In/Keclfp7huNj3chiJZiZMxjNmGl8kdpLKlinwR+RqGBoUI52Katm57kzn6FG8Xn4eT5BrI87u7RDVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMnYv4vsLzHnGhl;
	Fri, 27 Feb 2026 20:24:03 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 837004056E;
	Fri, 27 Feb 2026 20:24:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 12:24:48 +0000
Date: Fri, 27 Feb 2026 12:24:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 3/3] cxl: Move pci generic code
Message-ID: <20260227122447.00001e0e@huawei.com>
In-Reply-To: <20260225121430.3839189-4-alejandro.lucero-palau@amd.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
	<20260225121430.3839189-4-alejandro.lucero-palau@amd.com>
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

On Wed, 25 Feb 2026 12:14:30 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
> initialization.
> 
> In preparation for type2 support, move helper functions from cxl/pci.c to
> cxl/core/pci.c in order to be exported and used by type2 drivers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
