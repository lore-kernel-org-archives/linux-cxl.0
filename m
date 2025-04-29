Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBD224891;
	Tue, 29 Apr 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941124; cv=none; b=V5KMV6nDvapLnOmADMuYszGOOFp6cGI8QG77//U8TBlKmrsznO3gJMl5nFe9y+X86u6pDgnafkN6TRdaE99J4iZ7qvq+ZSaoTksNluTXOHCx8sKIh65w41+pIPny+EegJm01Nqvps7u3c7vbqIlrxPqB+GAgcD5iEXWR3JODqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941124; c=relaxed/simple;
	bh=me9CAjuh9mBidyld5Fir3rpXNQ04l2/D0L58Psf5jt4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRabX909KPIusprFP8NClwh33QtWzVuztpUqHqAvKWPENmaiefsY2kOOajNpbZFvo3kC9JftptX113vei24Xuf8lgtVqWaeR8iDbyyPSSkAmiPKk38bjbVOviS2csKA7fYQrGOnK9bC13QeQt1X7/nVcBAWBzDGzl8Mh81XXPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn4DP219bz6L5Dw;
	Tue, 29 Apr 2025 23:36:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B9777140447;
	Tue, 29 Apr 2025 23:38:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 17:38:39 +0200
Date: Tue, 29 Apr 2025 16:38:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v5 08/14] cxl/port: Replace put_cxl_root() by a cleanup
 helper
Message-ID: <20250429163838.000070ae@huawei.com>
In-Reply-To: <20250428214318.1682212-9-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
	<20250428214318.1682212-9-rrichter@amd.com>
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

On Mon, 28 Apr 2025 23:43:11 +0200
Robert Richter <rrichter@amd.com> wrote:

> Function put_cxl_root() is only used by its cleanup helper. Remove the
> function entirely and only use the helper.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Oops. I had a bonus space, but missed the cancel button
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
