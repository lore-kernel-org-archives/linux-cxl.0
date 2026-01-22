Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118AA393DDC
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095932; cv=none; b=rAyl5besoZxfbpeulZ7FcBUTxyRZPC34zXR5ijCqtNQzb06W3Y5DgBUWcRO57kJ3J50ZYDQKyE4FP+Bcgs6vOA9gpO0Mg6sgxVD2XxQ+NuS9weB7VlOEHL27VZEju/WJqNb7spAWs8r12aO8ZmG1t4jiSoX6HejTN3+lRmBLwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095932; c=relaxed/simple;
	bh=0CsRh7tjD39Zfye+l2T15JkcmHdAWQNeeCYHV7xsrrk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNPkfQAtxabyE6HvGGaHA1Oy0qQVdtzesE4tJ2ZvB+XCp1RjS9EI5cOlZGpLfpqt2hBTt/ce2DVrRXX7O3O/Wcy+SWiy1uZiwbGUtVMlp/Zhzw97LB/6+T7IkoRxmt7DCbY0EbEt3oe/+ic8jOmkTM/tqSgP7MtwzTGI/wzZfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=fail smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxlQp4sh8zHnGkT;
	Thu, 22 Jan 2026 23:31:30 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9714640570;
	Thu, 22 Jan 2026 23:32:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 15:32:05 +0000
Date: Thu, 22 Jan 2026 15:32:04 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 9/9] cxl/port: Unify endpoint and switch port lookup
Message-ID: <20260122153204.00006647@huawei.com>
In-Reply-To: <20260122033330.1622168-10-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-10-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 19:33:30 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In support of generic CXL protocol error handling across various 'struct
> cxl_port' types, update find_cxl_port_by_uport() to retrieve endpoint CXL
> port companions from endpoint PCIe device instances.
> 
> The end result is that upstream switch ports and endpoint ports can share
> error handling and eventually delete the misplaced cxl_error_handlers from
> the cxl_pci class driver.
> 
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
