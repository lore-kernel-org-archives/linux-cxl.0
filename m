Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF42FB62B;
	Mon, 15 Sep 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931278; cv=none; b=uatarmtTcVTRVSwm9mDoEcSwZOneFrfeE7GBc4nC29rSK2Y0L7DESVAm7vdUZzo1I2lafigiX4XBh8fiPndw8OInKdFJu4i6kr58V+GcVXdmGPhLrtuT+FvgX4GmEhr5eVeql3frzGfZsGEj4e8G8U20dJpLih2saE1qx3MiNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931278; c=relaxed/simple;
	bh=h2jAUNYY1Cyr0LsXGjQcYy57oP4wPnaE1HCVHJGXomc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shWSP2fTs+Kym+KtN8LU7qDh2ZfIL+SmxlERoYezTIglVZdyTCB/MQm/xwSEnzyOQi7PfUkUZUztVS8fgBGyKgFh9zhgCXO98x/YFLMgeCfeldq/rnaI65XWDPuzQ5iKJib6y7UK81elr86/mit719HwOiD2RPCaMP8FeTvh8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQLPV29rTz6L6Qj;
	Mon, 15 Sep 2025 18:10:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DDD631402EA;
	Mon, 15 Sep 2025 18:14:31 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 12:14:31 +0200
Date: Mon, 15 Sep 2025 11:14:30 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 01/11] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <20250915111430.00003fc6@huawei.com>
In-Reply-To: <a25bbb46-9f79-458e-9d4f-2de70c9ef22d@intel.com>
References: <20250912144514.526441-1-rrichter@amd.com>
	<20250912144514.526441-2-rrichter@amd.com>
	<a25bbb46-9f79-458e-9d4f-2de70c9ef22d@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 12 Sep 2025 08:52:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 9/12/25 7:45 AM, Robert Richter wrote:
> > A region is always bound to a root decoder. The region's associated
> > root decoder is often needed. Add it to struct cxl_region.
> > 
> > This simplifies code by removing dynamic lookups and removing the root
> > decoder argument from the function argument list where possible.
> > 
> > Patch is a prerequisite to implement address translation which uses
> > struct cxl_region to store all relevant region and interleaving
> > parameters.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
