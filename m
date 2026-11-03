Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747262;
	b=1dm9nsRJkBomFmqzzghozQG6SQjWTqDaqxe0CQ3V0NhnO1DXmtP/MgjfC6GMf+Gygcos
	 AcbSFn0FyX3Jd7koc032tpaCvZrxMShWZz+PPiwauxdVCQk3pzk07X7v4J/f2/BlMBbBE
	 7f9sqHaF5c/8v7tJhmc9xosKTRBJzbUr3Gv0n6J6lAcjSex43VKo8SlHq+APVBNO1P5Z6
	 IAe0so4NL1DMFjO+PP+X1vXynmL6LCedM6E6auvjwxGc/qJKTSzZ05EnxLZq17qH63OLR
	 CZkTgOMj7aFLE1hVTPU0c+Iqqvat75kC7PxBD5KP8z8ec8nSIoniPAlFMAqGq0R4AQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747262;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xpkRIhmj0HtnqaslPJGXMXfemu44ABeK42xo/NUvehs=;
	b=eFGBM0fkWozhx8xs0c1O1M0+H2pMHDj5YahHTMfmiZeNPZszuYQJvhoijNelOeDxMpm3
	 PYcVl1V0ZxUF2ZRUdgN1rCaz9UZQo5eiyb6IE/DHJKwi+KIVvY/5A4ieGXLchpWookyrE
	 xUBPdQ3zmy0vUeJjiDBhPwMaQCSjGMNcuuLluSlfoxVK1oX35KOWJKgVy+aMWIO/5lOD+
	 2etEKMtyIaVWy7DeyKLSdo/TAtnc+myII10TGbqmM5mbTaRy3a3qfQXFlwXuuT5qp9b3I
	 /wkz0NUHy6puIGFx0xcaEmrTivcB2jywtIp11EYAzJUudZv64sC0FGBK7AXtkfrWcxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cwlETt0q;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F85606A31B
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 23:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47F85606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cwlETt0q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793747260; x=1825283260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a6kccX65t7xYtulszZHlUOVgCrTpdjMzHAdwitJP2Ng=;
  b=cwlETt0q4MFPCb8mZdFOd3pPRAeEgWrzpw48aVdE+kJnLeSN/juBqSsG
   dIIruS3lz/BO/H1nk0OapjAO9IFnQvZKivFMEjo6QGDzqg8Wv0Pl3oTsB
   6vM6HLhZAu9/F9ZK8exT52yg1AatEmB9zn1yRwgDqOtpvIVt6WWb2hLQ3
   qhAld7mCxZmhXxlF8TUm2M7ydtS1sgTacbR2USZw8GTMBSKaqAcP9zD/t
   FB4Fcn0jyIra4JATo3E5PA4HJ7LpNzd8CGqaRs8ZoiP+T8uIngF0t5WcI
   yfEDhT1OhrNxdSx1xoR69yxg4TgyMKJbZKkTSpkdpIuRd+W0HORs3oBZq
   A==;
X-CSE-ConnectionGUID: +tR4jYq/SgWxXePzb8R+XQ==
X-CSE-MsgGUID: b/FyBYi6RT6M2SX5knq8uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2518350"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2518350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 15:07:40 -0800
X-CSE-ConnectionGUID: ZLe7+kp2TNy9uVvjP41qrQ==
X-CSE-MsgGUID: T9hCCZZgSYejnqxaNkRITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6939872"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.235]) ([10.125.109.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 15:07:38 -0800
Message-ID: <c93ac992-a797-4779-b618-c2a5d4e03288@intel.com>
Date: Tue, 3 Nov 2026 16:07:38 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cxl/Documentation: Describe clearing a region
 targetN position
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
 <4d2fa8561a443d9859ca08c04950e6c15e168f98.1793724885.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <4d2fa8561a443d9859ca08c04950e6c15e168f98.1793724885.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/26 10:07 AM, Alison Schofield wrote:
> The region targetN ABI documents that writing to an occupied position
> returns EBUSY, but does not describe how to clear the position after
> assigning the wrong endpoint decoder.
> 
> Document how to clear a position by writing an empty string, how clearing a
> position decommits a committed region, and how the region can be committed
> again after all positions are filled.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

this change for the most part is unrelated to 1/2 right?

> ---
> 
> Changes in v4:
> - Minor wordsmithing in commit log
> v3: https://lore.kernel.org/linux-cxl/e87248b8d13d3f07741243a45891365450c66881.1793653629.git.alison.schofield@intel.com/
> 
> Changes in v3:
> - Restore the original entry text and append how to clear a position
> v2: https://lore.kernel.org/linux-cxl/efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com/
> 
> Changes in v2:
> - Say that writing the endpoint decoder already at a position succeeds
> - Split the entry into paragraphs and drop the v1 error code reordering
> v1: https://lore.kernel.org/linux-cxl/a007c751d88ee64c9d0b7bb3c69a486c42358b36.1790829690.git.alison.schofield@intel.com/
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7352dbd70bc7..3629c983f05c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -568,6 +568,10 @@ Description:
>  		not an endpoint decoder. Once all positions have been
>  		successfully written a final validation for decode conflicts is
>  		performed before activating the region.
> +		To clear a position, for example to replace an endpoint
> +		decoder, write an empty string (echo > targetX). Clearing
> +		a position in a committed region also decommits the region.
> +		It can be committed again after all positions are filled.
>  
>  
>  What:		/sys/bus/cxl/devices/regionZ/commit

