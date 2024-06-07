Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5ED15B99B
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772665; cv=none; b=F5zALr2Uh1gE8jUgx+XCSk42sNPpdZ1CfPwDvYMD2rPMryMOynU/UDc+wegnAmxnUj8JiY1flnPH+sWDpKXLKnmN0nr2a8PsY7nl7WK/g9RFuQJgsWLEMtbF1GOU7VUoCMoGjm7uinquA3MU9Lwdc/iWmUe9pp2G0GRa5t+1Wi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772665; c=relaxed/simple;
	bh=S4TJ0h8qLM4C/1Bu7w4I34M+ghjrfKSNqKdual+Wg3I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhnkJLbtPUgqc7W8RL/RXYJN9vh9N8U5Tf0qYYrNVQRsKXlKZIdXdhAapB9v9LYae0Yk4z5tr90QCieQSkN2IGSbwaMf3JZ3b4ziRM3DVNAdLJcuGESuw2nVFuBxBJQbuBZg6HVY4hV9BlfaQ+K3+DSrlHlTYF/GDeApqkW/sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwkrX02Z2z6GCwl;
	Fri,  7 Jun 2024 22:59:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 58461140CB9;
	Fri,  7 Jun 2024 23:04:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:04:19 +0100
Date: Fri, 7 Jun 2024 16:04:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cxl/region: Verify target positions using the
 ordered target list
Message-ID: <20240607160418.000033e5@Huawei.com>
In-Reply-To: <562c5e2097f32567bf7aa505d7952d9c068d830b.1715192606.git.alison.schofield@intel.com>
References: <cover.1715192606.git.alison.schofield@intel.com>
	<562c5e2097f32567bf7aa505d7952d9c068d830b.1715192606.git.alison.schofield@intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  8 May 2024 11:47:52 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a root decoder is configured the interleave target list is read
> from the BIOS populated CFMWS structure. Per the CXL spec 3.1 Table
> 9-22 the target list is in interleave order. The CXL driver populates
> its decoder target list in the same order and stores it in 'struct
> cxl_switch_decoder' field "@target: active ordered target list in
> current decoder configuration"
> 
> Given the promise of an ordered list, the driver can stop duplicating
> the work of BIOS and simply check target positions against the ordered
> list during region configuration.
> 
> The simplified check against the ordered list is presented here.
> A follow-on patch will remove the unused code.
> 
> For Modulo arithmetic this is not a fix, only a simplification.
> For XOR arithmetic this is a fix for HB IW of 3,6,12.
> 
> Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
