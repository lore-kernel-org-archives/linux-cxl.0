Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398CE155C82;
	Wed, 14 Jan 2026 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415555; cv=none; b=OJBBRQFEfX6R6sWPAN6qoPcYLsq35jfTJBPKBLpdj3FWHfgRAPoOdu11F/YEHD6q8cEtfWo5Yj5zVrFTDp28DXJNeJixmMLHaSGo0ApCckPx1YLBhHjZAJKj895meKhi/WX+CGjFtwr/HZURCTOrWg+d6w/rvZYX2WSNjUnFsxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415555; c=relaxed/simple;
	bh=NT107MivTJZVGwaOUF5zRajyL2oLtnL8BiizNe4Cddk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuFCAHTK6A4DM+7sP6fCwdH3H+fFTyeIy27WS9iKJX9K2xN3Nrge+OYEy4O5P5qe7bMEc9n7bV2PBj/0/MizT3gCs6V6EMuMYrjtUg0/0FH8Wrrwe3jCfu0q4MaNHursVA/VqpaNBRPx9FZOnhffG4w+k38K97IfPpGe7lm6zpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drvq23CN0zJ467m;
	Thu, 15 Jan 2026 02:32:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B5E540570;
	Thu, 15 Jan 2026 02:32:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:32:28 +0000
Date: Wed, 14 Jan 2026 18:32:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v10 12/13] cxl/region: Factor out code into
 cxl_region_setup_poison()
Message-ID: <20260114183227.00004945@huawei.com>
In-Reply-To: <20260114164837.1076338-13-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
	<20260114164837.1076338-13-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 17:48:28 +0100
Robert Richter <rrichter@amd.com> wrote:

> Poison injection setup code is embedded in cxl_region_probe(). For
> improved encapsulation, readability, and maintainability, factor out
> code into function cxl_region_setup_poison().
> 
> This patch is a prerequisite to disable poison by region offset for
> Normalized Addressing.
> 
> No functional changes.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>


Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
