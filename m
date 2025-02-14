Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24626772D;
	Fri, 14 Feb 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551083; cv=none; b=KL5PrF1pHIrMIwNlMO8+Thl9vQ1fvVwhLjxa/bJizwIczPzja/arP+KOJ1//iossIdyQ8VHScVWFv1w/vnhOdCpNCUueLjw7S9i62WWcwclQ6rMQW7PAeFi3g9SJotYvlFxXUiUvCwxhGxoV503Cfug3fDSq39VMWbVJnyEkdmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551083; c=relaxed/simple;
	bh=5OPVb7m5df2EcHYY/XuL+JV7Boa3i1xtk+u+WanVTJA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCcsmER1j3BjcR0guFmP/AV/w/jGhVebD+mJgAdh4B+B88QUCg+bzU0qN7mG0Th0c7snFvXZaa6uvLe1VlLOKpvej5VKA/gghws1Xz7Rd7vOC9dXDbktyhxqxKQE5wLttqAUB8bboHjbbkLZLS66caQCN51Zj3eE/3oFgYTr4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvd3p2rK8z6HJcn;
	Sat, 15 Feb 2025 00:36:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FC5A1402CB;
	Sat, 15 Feb 2025 00:38:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:37:59 +0100
Date: Fri, 14 Feb 2025 16:37:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 18/18] cxl/acpi: Unify CFMWS memory log messages with
 SRAT messages
Message-ID: <20250214163758.00002f4b@huawei.com>
In-Reply-To: <20250211095349.981096-19-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-19-rrichter@amd.com>
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

On Tue, 11 Feb 2025 10:53:48 +0100
Robert Richter <rrichter@amd.com> wrote:

> CFMWS entries have a similar importance as SRAT table entries to
> describe memory regions. For CXL error analysis and memory debugging
> information of both is needed. Unify output of both messages to
> improve logging. Change the style of CFMWS message according to SRAT
> output. Also, turn messages into a dev_info() same as for SRAT.
> 
> SRAT pr_info() for reference:
> 
> drivers/acpi/numa/srat.c:
>   pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
