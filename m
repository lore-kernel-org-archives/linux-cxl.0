Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3310788
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772822; cv=none; b=iO6ux5vlEG5z4jryw2rssrjNm3JNckYsWOwPzzrMiBF8pOgX99yWeoGiaxlXPE2HQX15gogncFyaN3uRaurZbQ2N/ivRdpw22yBLxaph1QbZ4uE2tPcIKvy4rgCXqT+cisnj7EEyIiqhA9hoHdENxsGu0nbbmXrw5n2tGgmwEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772822; c=relaxed/simple;
	bh=1T7saU5jZsGWD3gZp+b5aCJBipA5MQICix2uEBh77AE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkM7tKAG3kG3pZs57vjHnR6ATifPIV0MKtPXvRUr86auosKImvn6/K+hMYEWwU1dxSsfib4YtbvjRah0vHdX2ZOF5IjOaV2H4LCAyQUwYDfAbBm5G+cP0ibbmldHJ5bZ5qq8iAy0MNTtkX6clfOAjqS86DxIO1qizc+7xTSWPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwktx72T9z6G9H6;
	Fri,  7 Jun 2024 23:02:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AF9AA140B30;
	Fri,  7 Jun 2024 23:06:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:06:44 +0100
Date: Fri, 7 Jun 2024 16:06:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] cxl: Remove defunct code calculating host bridge
 target positions
Message-ID: <20240607160643.00000117@Huawei.com>
In-Reply-To: <2f2536ae494a158292951141c17881828e85fd23.1715192606.git.alison.schofield@intel.com>
References: <cover.1715192606.git.alison.schofield@intel.com>
	<2f2536ae494a158292951141c17881828e85fd23.1715192606.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  8 May 2024 11:47:53 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL Spec 3.1 Table 9-22 requires that the BIOS populate the CFMWS
> target list in interleave target order. This means that the calculations
> the CXL driver added to determine positions when XOR math is in use,
> along with the entire XOR vs Modulo call back setup is not needed.
> 
> A prior patch added a common method to verify positions.
> 
> Remove the now unused code related to the cxl_calc_hb_fn.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

FWIW given this just removes unused code.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
