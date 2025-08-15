Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BDF2882A6
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262662; cv=none; b=FXcLIIjuyGo+5B2I55IlfT3tflnGUxuE0+RpANDhbqeb3j8PRvjs/gYH4HdZi3Hh1nIrTprm7DjzenW0siIkiXxhnvwEP1YsgQtFbbNyRGUZuNRc/eEl0EwB3czplBplTgvkMGL8VLcQ2g9tuJcfiWv/dvx2sQRsDOGGSNYZUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262662; c=relaxed/simple;
	bh=T5U2F0wPooN2eKHRYMCdVqfAaejLiRUHPfRq+o79LSM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbnGR3MD/FXcviBN6K8QcRiAk/iNsQWF4ShiSAXjwYkMDxYfoXRii7Rg0S3taUP0KVgoSZW1oMfLij8BqdFg2a2DungbFN3p0eJxvK8UKAovqyjmTouFKwmQ5W/Fv8EdXBAUPgwfJrYI2kAxN8UdT7ndHRMPJCOMWSez2Qi1fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3MTM13Xbz6L5PG;
	Fri, 15 Aug 2025 20:52:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 70F96140279;
	Fri, 15 Aug 2025 20:57:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 14:57:36 +0200
Date: Fri, 15 Aug 2025 13:57:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v8 04/11] cxl: Move port register setup to first dport
 appear
Message-ID: <20250815135735.0000685d@huawei.com>
In-Reply-To: <20250814222151.3520500-5-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
	<20250814222151.3520500-5-dave.jiang@intel.com>
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

On Thu, 14 Aug 2025 15:21:44 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> This patch moves the port register setup to when the first dport appears
> via the memdev probe path. At this point, the CXL link should be
> established and the register access is expected to succeed. This change
> addresses an error message observed when PCIe hotplug is enabled on
> an Intel platform. The error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed for the
> hostbridge during cxl_acpi driver probe. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3
> and/or DVSEC ID 7 blocks which will trigger the error message. This
> behavior is defined by the spec and not a hardware quirk.
> 
> This change also needs the dport enumeration to be moved to the memdev
> probe path in order to address the issue. This change is just part of
> the code refactoring and is not a wholly contained fix itself.
> 
> Suggested-by: Dan Williamsn <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I'm a little nervous about what happens when we hot unplug EPs
on these systems and any left over address mappings for port to which
they are connected.  But from previous discussions I think the argument
was that they were benign if they do happen.

Anyhow, this looks fine to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
