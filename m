Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B510E3
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013152; cv=none; b=R+VBOeNhzOykzaPbjkvBk6Xkq077IQYcp3qXmE3WtmpHmnrFFAWhhGCr6hrsZbCLvCCMCX42GPxdr9+m0fV+vSdkapp0GeYYaQG3N8d+/WD7hwkJYkax0RifYeVZJUQ9a6e+0kg+fqAFphuWjpKNCV6unPQvBm+9p+r/C79crIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013152; c=relaxed/simple;
	bh=0EmfB1/KVR9Ys2IBISIOleK+QM6hCTo6o9QJHmm0sIY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPKBKNX9Oi/TLhrPqOQjWaJBeOXYN99RKRSXkE/JWHjHY3YR9HfcrM7Ov4jraHTEyxnC9/DVXb60g0YnK7jjs0GeRDj8xS2J8wYfNIy0rJzrqcMqQhboUrHw/LT8xbxIqzPtrv68chFq203CDVjFfQ7DdWcFgmGWEHUTfUd4zwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1bGb1m9fz6M4Xw;
	Tue, 12 Aug 2025 23:37:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A9BAB1402ED;
	Tue, 12 Aug 2025 23:39:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 17:39:07 +0200
Date: Tue, 12 Aug 2025 16:39:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] cxl/region: Introduce SPA to DPA address
 translation
Message-ID: <20250812163905.0000313e@huawei.com>
In-Reply-To: <422f0e27742c6ca9a11f7cd83e6ba9fa1a8d0c74.1754290144.git.alison.schofield@intel.com>
References: <cover.1754290144.git.alison.schofield@intel.com>
	<422f0e27742c6ca9a11f7cd83e6ba9fa1a8d0c74.1754290144.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  4 Aug 2025 01:00:11 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add infrastructure to translate System Physical Addresses (SPA) to
> Device Physical Addresses (DPA) within CXL regions. This capability
> will be used by follow-on patches that add poison inject and clear
> operations at the region level.
> 
> The SPA-to-DPA translation process follows these steps:
> 1. Apply root decoder transformations (SPA to HPA) if configured.
> 2. Extract the position in region interleave from the HPA offset.
> 3. Extract the DPA offset from the HPA offset.
> 4. Use position to find endpoint decoder.
> 5. Use endpoint decoder to find memdev and calculate DPA from offset.
> 6. Return the result - a memdev and a DPA.
> 
> It is Step 1 above that makes this a driver level operation and not
> work we can push to user space. Rather than exporting the XOR maps for
> root decoders configured with XOR interleave, the driver performs this
> complex calculation for the user.
> 
> Steps 2 and 3 follow the CXL Spec 3.2 Section 8.2.4.20.13
> Implementation Note: Device Decode Logic.
> 
> These calculations mirror much of the logic introduced earlier in DPA
> to SPA translation, see cxl_dpa_to_hpa(), where the driver needed to
> reverse the spec defined 'Device Decode Logic'.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


