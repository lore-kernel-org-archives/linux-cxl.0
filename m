Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56AA389DF8
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095634; cv=none; b=eF7Xmg37uOcMx4Iwm3rd1cR5ghZAv9N45Skxf0ZejPP3CbCgKrDBqzVJwc7Pbzx0LskLOBHK0dA6IG4v7Et75Lctf6teHXyYgLivkjwh5UcGKXjdUGd8la4CXhDQb2jLJX3q5BHXqIn2fklUCPfFBIzwN4flIyjVZ21y8cMN8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095634; c=relaxed/simple;
	bh=iLDVFXmVIdw8ZHDimOyqA9cZl8hooBDfw4s+rYi1oH0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9U57+TUrbV7R4LB7YkbMUXiCgG9a0lZZdDOjiCSu4lXia3qbnvGX33mQHSTqbW6d5WcPcpv6KGpIAfdoovd5Fp0xHKqALlh/rrLEMOI8lQvFX/wHEee1l9xkJycorOAF45ypU8pzdRhhIwic03oCiNbXjBhlbqNi0iZB8JrLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxlKF2gdJzJ467t;
	Thu, 22 Jan 2026 23:26:41 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 484A340570;
	Thu, 22 Jan 2026 23:27:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 15:27:08 +0000
Date: Thu, 22 Jan 2026 15:27:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 8/9] cxl/port: Move endpoint component register
 management to cxl_port
Message-ID: <20260122152707.00003366@huawei.com>
In-Reply-To: <20260122033330.1622168-9-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-9-dan.j.williams@intel.com>
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

On Wed, 21 Jan 2026 19:33:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for generic protocol error handling across CXL endpoints,
> whether they be memory expander class devices or accelerators, drop the
> endpoint component management from cxl_dev_state.
> 
> Organize all CXL port component management through the common cxl_port
> driver.
> 
> Note that the end game is that drivers/cxl/core/ras.c loses all
> dependencies on a 'struct cxl_dev_state' parameter and operates only on
> port resources. The removal of component register mapping from cxl_pci is
> an incremental step towards that.
> 
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
