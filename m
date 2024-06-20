Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B01AC245;
	Thu, 20 Jun 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887764; cv=none; b=QAsWsHTaZHROtRB+Pio+GyzkGTiWhc9fps6d8tIAyVtwgG9tmaBwafKUGMLa+ML970OIttl8A0H2pRsRpoyvbaxHfiS50r0gkipcUt6e78MHeyFDAP+WS+e1RGnfLcSAwMgRhBe8WShfuRlWCOYp8+pGMg+uth8+5ISJ4OCay8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887764; c=relaxed/simple;
	bh=IUvgoDslhWC9mCuSL9+lF7PxGVGHedFsWIeSGTu3G+4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUkUPotDjLYOxbXDGR5kbb9l4zjfOuyCwQCBI8PhzC/nsuKi4/gtkf1Z5HJAizgy3Gv1Lle35tb+EABYJPLpg+i7BIbVsCGE6Dw1OQUDpKnMwe50XxJJVwzvim99i88wKr3wUOkjskmwtL2owzhdvHB8+u/biiqluRk6frHnRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4gKn0R76z6JBYy;
	Thu, 20 Jun 2024 20:49:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EE00F140A34;
	Thu, 20 Jun 2024 20:49:18 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 13:49:18 +0100
Date: Thu, 20 Jun 2024 13:49:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 5/9] cxl/pci: Update RAS handler interfaces to
 support CXL PCIe ports
Message-ID: <20240620134917.000056dc@Huawei.com>
In-Reply-To: <20240617200411.1426554-6-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-6-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:07 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL RAS error handling includes support for endpoints and RCH downstream
> ports. The same support is missing for CXL root ports, CXL downstream
> switch ports, and CXL upstream switch ports. This patch is in preparation
> for adding CXL ports' RAS handling.
> 
> The cxl_pci driver's RAS support functions use the 'struct cxl_dev_state'
> type parameter that is not available in CXL port devices. The same CXL
> RAS capability structure is required for most CXL components/devices
> and should have common handling where possible.[1]
> 
> Update __cxl_handle_cor_ras() and __cxl_handle_ras() to use 'struct
> device' instead of 'struct cxl_dev_state'. Add function call to translate
> device to CXL device state where needed.
> 
> [1] CXL3.1 - 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
I've not looked at how it's used yet as reading these in order,
but based on the explanation and code here looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



