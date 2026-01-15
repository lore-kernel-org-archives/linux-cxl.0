Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742F3BF31F
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501829; cv=none; b=sLTg0axUdceAF7FGg8/Wp4trP+CFmUWEfMe4eHO1KcP3MzVIA7gvDPHLvOAReWygV/M02h5KnAFuohrU3bgEDczYA+1UJgca9e1LyuTZthFAxT/8gEl6qIbSrmS3pUIq1tcbNjcCntQk1i8mzaT08sKPuVkvvT1zLIjFlX7v2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501829; c=relaxed/simple;
	bh=mnMxit6ds8zC+G2c2TI3mFdER1OSlOpxq/tcpc9Iisc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7whcVgQL0D6N4ZFwoaR4kGAD6HUaVeGzy1sqYcGaME6uICfYmczoUP7+PzQiGXLJFhDRjF++xM7nWn6H2X/oulCUftS1wGNKkudQbbRRy9GxONJFK8tI3EIbElNwWFU9i3OMFDNUrkPsjAvIgjcmVGzXPaNVoPcekb+mlH8AwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsWk92bClzJ469b;
	Fri, 16 Jan 2026 02:30:09 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C99440086;
	Fri, 16 Jan 2026 02:30:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 18:30:25 +0000
Date: Thu, 15 Jan 2026 18:30:24 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
CC: <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/core: Fix cxl_dport debugfs EINJ entries
Message-ID: <20260115183024.000011ac@huawei.com>
In-Reply-To: <6e9fb657-8264-4028-92e2-5428e2695bf1@amd.com>
References: <6e9fb657-8264-4028-92e2-5428e2695bf1@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 9 Jan 2026 07:57:38 -0600
"Cheatham, Benjamin" <benjamin.cheatham@amd.com> wrote:

> Protocol error injection is only valid for CXL 2.0+ root ports and CXL
> 1.1 memory-mapped downstream ports as per the ACPI v6.5 spec (Table
> 8-31). The core code currently creates an 'einj_inject' file in CXL debugfs
> for all CXL 1.1 downstream ports and all PCI CXL 2.0+ downstream ports.
> This results in debugfs EINJ files that won't work due to platform/spec
> restrictions.
> 
> Fix by limiting 'einj_inject' file creation to only CXL 1.1 dports and
> CXL 2.0+ root ports. Update the comment above the check to more accurately
> represent the requirements expected by the EINJ module and ACPI spec.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
