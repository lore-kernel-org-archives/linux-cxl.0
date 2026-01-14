Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59028507B;
	Wed, 14 Jan 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413608; cv=none; b=B2+puqrWWusC5fqGapSG3auzDjux8ak0M7TuSbCAWgTw+V1xIzeshsQJJgcWUYHlnc4Blz3curOHBRor73haKn5qsr0T9vHQxmFl5pNt+TeBp9AjNFDaKmq6mRVxWHt/2K75yBtQ9ETZxpla5M9BSbFZxxEwnOeECMynXAePJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413608; c=relaxed/simple;
	bh=M34BM79TIF+UnnMtazw55oIflDWsNBnnu1vB6d3FCJQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5Kzff17gX+VidIcr15lHv5s1hfbbvjqTf0yLFoL80eGnJ449ODkVrOAhw8dt0a3bUzEnX1P+59KoG1RqxLMUG53FuCv8wbpgB6yGYb4mDp1fsYrzzcLACA0Mq7wkdT/KcQQbzoyewSNVVl8rV+RzaGm80+UMsB9KN0OBVKSZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drv5b4dnszJ468x;
	Thu, 15 Jan 2026 01:59:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A26A940539;
	Thu, 15 Jan 2026 02:00:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:00:01 +0000
Date: Wed, 14 Jan 2026 18:00:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <20260114180000.00002533@huawei.com>
In-Reply-To: <20260112111707.794526-3-rrichter@amd.com>
References: <20260112111707.794526-1-rrichter@amd.com>
	<20260112111707.794526-3-rrichter@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 12 Jan 2026 12:16:45 +0100
Robert Richter <rrichter@amd.com> wrote:

> This adds a convention document for the following patch series:
> 
>  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> Version 7 and later:
> 
>  https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> 
> Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Head hurts from reading this :(  Hopefully I never do again!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

