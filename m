Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24E21B8F8;
	Tue, 29 Apr 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940892; cv=none; b=NjbJnhercP1U2tS2iDWtUyGXDrH4bYTVKrjI798Wbr/mipyLkrDCQVRMexxSMl/3/nYqIXv4sNuWlxipQ+UD+KtpJWDYSPbzCI5GfDJdkDuGy4snoueWYpOaTgDRevDS2ROkcJ8J9UYnYj11JzlYHeLS7Y44Ho4ECNL58QxITVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940892; c=relaxed/simple;
	bh=LiUQo6GAZ+wuv9L2yLsXzocAbXJsEUOnptnyTnkiBC4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdPth013FNym+UpNlbG73ZiBvUuL5Y1XPD550w4DmEIij7FOfYx44TvxyEfPNrot1gSBWnhGp2R8SpdrhfFOIICRehTiqmliHFVtU9uwM+NjIRYIUwEjnHfjGXVkfhJGUzo7ltw0uPfviAX2GSeGj2H5Awl2ZvACWh5HTFuOtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn47x5VVGz67QRR;
	Tue, 29 Apr 2025 23:32:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 304951402F0;
	Tue, 29 Apr 2025 23:34:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 17:34:47 +0200
Date: Tue, 29 Apr 2025 16:34:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v5 06/14] cxl/region: Avoid duplicate call of
 cxl_port_pick_region_decoder()
Message-ID: <20250429163446.00006e8f@huawei.com>
In-Reply-To: <20250428214318.1682212-7-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
	<20250428214318.1682212-7-rrichter@amd.com>
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

On Mon, 28 Apr 2025 23:43:09 +0200
Robert Richter <rrichter@amd.com> wrote:

> Function cxl_port_pick_region_decoder() is called twice, in
> alloc_region_ref() and cxl_rr_alloc_decoder(). Both functions are
> subsequently called from cxl_port_attach_region(). Make the decoder a
> function argument to both which avoids a duplicate call of
> cxl_port_pick_region_decoder().
> 
> Now, cxl_rr_alloc_decoder() no longer allocates the decoder. Instead,
> the previously picked decoder is assigned to the region reference.
> Hence, rename the function to cxl_rr_assign_decoder().
> 
> Moving the call out of alloc_region_ref() also moves it out of the
> xa_for_each() loop in there. Now, cxld is determined no longer only
> for each auto-generated region, but now once for all regions
> regardless of auto-generated or not. This is fine as the cxld argument
> is needed for all regions in cxl_rr_assign_decoder() and an error would
> be returned otherwise anyway. So it is better to determine the decoder
> in front of all this and fail early if missing instead of running
> through all that code with multiple calls of
> cxl_port_pick_region_decoder().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Subject to considering that name change

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
