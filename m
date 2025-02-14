Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47E7E0ED;
	Fri, 14 Feb 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551049; cv=none; b=RZv+Ra+30e204l1sQmohJe2X++zfBOlFDhKtwJzubyXRo13TyFio2OXX3hJYnVYO3+GD0i14SIXd5AJjeimhf0aEfIItRI9OzgQv7x+fFICcfKXX0tKRV9QRNrWQHWe/3dN1vMjrhe7neKeYSoa81VMpZ9uRiyOpqoKJMcA7Iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551049; c=relaxed/simple;
	bh=Mw3btE9LP1ArVmq03djacVWw7mZ5mz3wN6Pt8ADfMmo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqwRgsGEdyrxeynXXIH4I1P8uAdtUsbXmxi7SdFxl+PoH4JmY3hcnW8CNx++FnnV8EDXe31OH3z11N+2SuzCKhCQ1VoMfLH5AF4XirDKAgJccQZEPvT/IWSsjSPLd6+EMENBaB0yOizBU96xXNGpZflDHn6kwA6Ln2VWWyMu61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvd382fSFz6HJfD;
	Sat, 15 Feb 2025 00:36:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 259C8140A77;
	Sat, 15 Feb 2025 00:37:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:37:25 +0100
Date: Fri, 14 Feb 2025 16:37:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 17/18] cxl: Add a dev_dbg() when a decoder was added
 to a port
Message-ID: <20250214163724.000003d5@huawei.com>
In-Reply-To: <20250211095349.981096-18-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-18-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:53:47 +0100
Robert Richter <rrichter@amd.com> wrote:

> Improve debugging by adding and unifying messages whenever a decoder
> was added to a port. It is especially useful to get the decoder
> mapping of the involved CXL host bridge or PCI device. This avoids a
> complex lookup of the decoder/port/device mappings in sysfs.
> 
> Example log messages:
> 
>   cxl_acpi ACPI0017:00: decoder0.0 added to root0
>   cxl_acpi ACPI0017:00: decoder0.1 added to root0
>   ...
>    pci0000:e0: decoder1.0 added to port1
>    pci0000:e0: decoder1.1 added to port1
>   ...
>   cxl_mem mem0: decoder5.0 added to endpoint5
>   cxl_mem mem0: decoder5.1 added to endpoint5
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
