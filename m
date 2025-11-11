Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE0299928;
	Tue, 11 Nov 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875116; cv=none; b=REXpFy1Anpx7tenMaBAM22SXY2zuA6wGXNdneMkgFHyWkRQblODYRdUd0zseEwHWqkHcR2U9eR/CvFYHDBwxoDZkk15IaThr5SoJvQXuKpE50nCXUAvahPNJQzp4a2e2/1r7kfJnraaVabDj7bj1BNM/ogDLxedSdz+ll3Uo0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875116; c=relaxed/simple;
	bh=GLZxYOQnsIVh9M9C9ht2AHv0VVI60bEYex4wJU1u8ws=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b36905tHB1lJ43NSlqe6TzldCmNKgWSh08B6meAChAy4li9qhYEetsv61bNGAfDdexcSzMOatWPwqdpslouBzOOICPGngmGaIaWeu5Gl1jcnUJ02jX6GTOP8XJPlEN7a/5c5SET83DBLY1R/YI9BdOumPbQxh7JW2jugPWg+h6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Vr71hbszHnH7N;
	Tue, 11 Nov 2025 23:31:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C062140136;
	Tue, 11 Nov 2025 23:31:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:31:51 +0000
Date: Tue, 11 Nov 2025 15:31:50 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 11/14] cxl/atl: Lock decoders that need address
 translation
Message-ID: <20251111153150.000051cf@huawei.com>
In-Reply-To: <20251103184804.509762-12-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-12-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 3 Nov 2025 19:47:52 +0100
Robert Richter <rrichter@amd.com> wrote:

> There is only support to translate addresses from an endpoint to its
> CXL host bridge, but not in the opposite direction from the bridge to
> the endpoint. Thus, the endpoint address range cannot be determined
> and setup manually for a given SPA range of a region. If the endpoint
> has address translation enabled, lock it to prevent the kernel from
> reconfiguring it.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
I'm fine with your explanation to Dave so
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
