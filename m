Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AB79E1
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811026; cv=none; b=cNIjJp7UvIi3o5cccKMW+TJ58JQGec3Xv2SLPOoxYn4KGqf0jGbzNT5+jeXy1xm7zWpFzIvq5UDPwUc6XT6Lik9T3pivaG2Dgdlzj1cEec3BA0J4mTCYuADJpo2Y+bCQwFsZ1xMUfPpqF7NqVlAvRIY8Ezi7zWSu+96wXjA5e3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811026; c=relaxed/simple;
	bh=pAc+f8FKoq0Lf8NbMfsat7dWEjJHzuLbfk5DQg9KYAU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeV7dV6/2GaahWgnw08MHvtn5Znx3na7vd0EdfSAtDH638IMeGOR4ZLOI7WhGv/AyhZ5VINCngEcR0OyyKUT1FKexRh0DTVvcTXTmmunlF/JRZVf0SkApHNOZ5me8txIg62VOiViHF8Wb/AgHPmXzIYeI+xBlije8XTgqnp/w8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJbPg6lL4z6K9hn;
	Fri, 13 Jun 2025 18:35:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E9C7F140426;
	Fri, 13 Jun 2025 18:37:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 12:37:01 +0200
Date: Fri, 13 Jun 2025 11:37:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, Terry Bowman
	<terry.bowman@amd.com>, Li Ming <ming.li@zohomail.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Tony Luck
	<tony.luck@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2] cxl/ras: Fix CPER handler device confusion
Message-ID: <20250613113700.00006192@huawei.com>
In-Reply-To: <20250612192043.2254617-1-dan.j.williams@intel.com>
References: <20250611171721.2048408-1-dan.j.williams@intel.com>
	<20250612192043.2254617-1-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 12 Jun 2025 12:20:43 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> By inspection, cxl_cper_handle_prot_err() is making a series of fragile
> assumptions that can lead to crashes:
> 
> 1/ It assumes that endpoints identified in the record are a CXL-type-3
>    device, nothing guarantees that.
> 
> 2/ It assumes that the device is bound to the cxl_pci driver, nothing
>    guarantees that.
> 
> 3/ Minor, it holds the device lock over the switch-port tracing for no
>    reason as the trace is 100% generated from data in the record.
> 
> Correct those by checking that the PCIe endpoint parents a cxl_memdev
> before assuming the format of the driver data, and move the lock to where
> it is required. Consequently this also makes the implementation ready for
> CXL accelerators that are not bound to cxl_pci.
> 
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: Terry Bowman <terry.bowman@amd.com>
> Cc: Li Ming <ming.li@zohomail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
