Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D24363C4E;
	Tue, 11 Nov 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874277; cv=none; b=t88VWR2n9vYtykxPDko712g6oZ+tGobbuR1cfOjgV+XnJ5hteBZMK7ptp+ekyDcOeWLTDPN3F11KMLpF4pf30DmXOEmYPCFzcdyAYj2cCBwBWZgy0I7u4qGi0rNMFwqD5lo5YVkKA64ucDbtfJN481nHzrTxCEQ1+8AkomBiddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874277; c=relaxed/simple;
	bh=j9JgHAZs7BUMIc9gwRZxJ02wsLNP0A1avQ7YFdAjcCQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lue8cPOHmCoHtgUyzK4Fe44+peWPnvNZ1G68l/Npo1Ofhy5jI152ury3qbl0D3exUBdjDIOUGNf2QPPpo0MCn6tgqaD8fjsGCe+CPTMcUHkMXlAQPELu4wcFElFXR7Xrp25wn1fRvWgJkPVo0/5cVKSa8m0D78hhHhjZhwodSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5VWj38KPzJ46BK;
	Tue, 11 Nov 2025 23:17:21 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A1021402F7;
	Tue, 11 Nov 2025 23:17:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:17:51 +0000
Date: Tue, 11 Nov 2025 15:17:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 09/14] cxl/acpi: Prepare use of EFI runtime services
Message-ID: <20251111151750.00005fe8@huawei.com>
In-Reply-To: <20251103184804.509762-10-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-10-rrichter@amd.com>
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

On Mon, 3 Nov 2025 19:47:50 +0100
Robert Richter <rrichter@amd.com> wrote:

> In order to use EFI runtime services, esp. ACPI PRM which uses the
> efi_rts_wq workqueue, initialize EFI before CXL ACPI.
> 
> There is a subsys_initcall order dependency if driver is builtin:
> 
>  subsys_initcall(cxl_acpi_init);
>  subsys_initcall(efisubsys_init);
> 
> Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
> its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
> efisubsys_init() first.
> 
> Reported-by: Gregory Price <gourry@gourry.net>
> Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
