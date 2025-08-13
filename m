Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AB2E6115
	for <linux-cxl@vger.kernel.org>; Wed, 13 Aug 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089457; cv=none; b=fQpsREt/RDzcbu3JkbrAGbYWCBpuy6MfhmI42qruAYsei/XGPtj1XpTiPbhJWDQeB6dde2EJtd3QhPd7ik8cC8SACKEffrabqsXLkSRhHShmvEiDx3uhIz1WPkHZ86JH7eo7yZsnuUrF1QUNQtyMhRf66j9SECy1qPULdwQLGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089457; c=relaxed/simple;
	bh=5i7uebTBsVX0pqDqpvCTglkO+m8wU7KrPMjQBbsv+po=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jT+navkwPKDgLA9QkEPUw4gynWT0pe1BydHabcibgdSS/JUlCxNx2rIow3HkQdS6YoATQ2mFydnmEfs90nXAHjbDR1p6hC94t3/vwMSS3IfLmJXHWlYjyqx/G2OM+Q4ohJYP01a6flsMFRUPDodH+tYuvniEdinb4jFJb0/sKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c27T70NqTz6L5jt;
	Wed, 13 Aug 2025 20:48:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D311714025A;
	Wed, 13 Aug 2025 20:50:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Aug
 2025 14:50:51 +0200
Date: Wed, 13 Aug 2025 13:50:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: "Bowman, Terry" <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v5] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
Message-ID: <20250813135049.00001391@huawei.com>
In-Reply-To: <29af4cc2-6a7d-4960-ac30-eb41238ad478@intel.com>
References: <20250730152519.125601-1-dave.jiang@intel.com>
	<3be496e0-a651-4dfe-b3d7-01df30350893@amd.com>
	<29af4cc2-6a7d-4960-ac30-eb41238ad478@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 4 Aug 2025 08:14:30 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/4/25 8:04 AM, Bowman, Terry wrote:
> > On 7/30/2025 10:25 AM, Dave Jiang wrote:  
> >> Create new config CONFIG_CXL_RAS and put all CXL RAS items behind
> >> the config. The config will depend on CPER or PCIE AER to build.
> >> Move the related RAS code from core/pci.c to core/ras.c.
> >>
> >> Cc: Robert Richter <rrichter@amd.com>
> >> Cc: Terry Bowman <terry.bowman@amd.com>
> >> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >> v5:
> >> - Make cxl_handle_rdport_errors() static. (Dan)
> >> ---
> >>  drivers/cxl/Kconfig       |   4 +
> >>  drivers/cxl/core/Makefile |   2 +-
> >>  drivers/cxl/core/pci.c    | 319 --------------------------------------
> >>  drivers/cxl/core/ras.c    | 312 +++++++++++++++++++++++++++++++++++++
> >>  drivers/cxl/cxl.h         |   8 -
> >>  drivers/cxl/cxlpci.h      |  16 ++
> >>  tools/testing/cxl/Kbuild  |   1 +
> >>  7 files changed, 334 insertions(+), 328 deletions(-)
> >>
> >> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> >> index 48b7314afdb8..b36bb0cabe58 100644
> >> --- a/drivers/cxl/Kconfig
> >> +++ b/drivers/cxl/Kconfig
> >> @@ -233,4 +233,8 @@ config CXL_MCE
> >>  	def_bool y
> >>  	depends on X86_MCE && MEMORY_FAILURE
> >>  
> >> +config CXL_RAS
> >> +	def_bool y
> >> +	depends on ACPI_APEI_GHES || PCIEAER_CXL
> >> +
> >>  endif  
> > 
> > Hi Dave,
> > 
> > Can PCIEAER_CXL and CXL_RAS be combined or must they remain separate?
> > They both enable CXL specific AER and RAS handling.  
> 
> I don't have any objections. CXL_RAS will just depends on PCIEAER with the merge.
> 
> Thoughts Jonathan and Dan?

No strong feelings either way.

Jonathan


> 
> > 
> > -Terry
> >   
> 
> 

