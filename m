Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15421B8EC;
	Mon,  9 Jun 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488789; cv=none; b=tfjNArmO5bKjHkw2+nXjsoPLRIuIjqf/6SjBnj77owwk9NLvRl9SI7EJ1dsp8W5ydCebUscSOux97M/TaN+OPriNWV/UZiCTdGHWqKFeYXHs+YsFL6ATAavR6CYp13bmd5Iz1TBJKgARiUTbXu2aBe+eUgUPIMH/mtNLgU6a2YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488789; c=relaxed/simple;
	bh=6425sUT3qp/eMwl8bhbaV0GvgGK38CKKWgsI+gxrBHU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aggoHyCBBMni/ICVSdFUFzZ4Oe0tGVHuvZoGfsCWH3IUOlRUjA2yf9nxC248cffPHoaB0JoioIesL64hA/qLq1vqloR/oxkvFEr6IAkniF8doxx32buOIzjMruPIp6boElRCKVrYzRSvPLTR9eS03RKMO9EBT350Rzi5MHbb62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGJF06vHqz6L5NZ;
	Tue, 10 Jun 2025 01:04:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F42E140276;
	Tue, 10 Jun 2025 01:06:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 19:06:23 +0200
Date: Mon, 9 Jun 2025 18:06:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Message-ID: <20250609180622.000033cc@huawei.com>
In-Reply-To: <20250603104314.25569-1-ming.li@zohomail.com>
References: <20250603104314.25569-1-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  3 Jun 2025 18:43:13 +0800
Li Ming <ming.li@zohomail.com> wrote:

> When trying to update the scrub_cycle value of a cxl region, which means
> updating the scrub_cycle value of each memdev under a cxl region. cxl
> driver needs to guarantee the new scrub_cycle value is greater than the
> min_scrub_cycle value of a memdev, otherwise the updating operation will
> fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).
> 
> Current implementation logic of getting the min_scrub_cycle value of a
> cxl region is that getting the min_scrub_cycle value of each memdevs
> under the cxl region, then using the minimum min_scrub_cycle value as
> the region's min_scrub_cycle. Checking if the new scrub_cycle value is
> greater than this value. If yes, updating the new scrub_cycle value to
> each memdevs. The issue is that the new scrub_cycle value is possibly
> greater than the minimum min_scrub_cycle value of all memdevs but less
> than the maximum min_scrub_cycle value of all memdevs if memdevs have
> a different min_scrub_cycle value. The updating operation will always
> fail on these memdevs which have a greater min_scrub_cycle than the new
> scrub_cycle.
> 
> The correct implementation logic is to get the maximum value of these
> memdevs' min_scrub_cycle, check if the new scrub_cycle value is greater
> than the value. If yes, the new scrub_cycle value is fit for the region.
> 
> The change also impacts the result of
> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
> minimum min_scrub_cycle value among all memdevs under the region before
> the change. The interface will return the maximum min_scrub_cycle value
> among all memdevs under the region with the change.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks for fixing this up.
