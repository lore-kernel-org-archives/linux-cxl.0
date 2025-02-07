Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F1175D5D;
	Fri,  7 Feb 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951922; cv=none; b=uOagNtBFo+GoDPm3h1/9mjuj1YTnJpDQ7sEigMYeRjwYR9JLM81Px8ybDGShk/xSqD3HihhOQD2yAYl3wmzFaUUGtal3pPN7eHppytcIvZt+Wi2sZ20/w8ow8cBPNsRGf/we5N3WVPj1awl3JxXSSDIgdS6lG5WSN8WG1TSydjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951922; c=relaxed/simple;
	bh=Mxi/kbDfBoPbjHHSUVZrSOgI/a74xAa3U1mvABJGcOA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4Gw/DaoaZLhB5W74obRyMn+SgGK1YPWwbcj7mxUoQchlcYCRPSyldtZTcQh+Xy20cYJKfdoGXveL2Q1u2Wf7o61ot7bm6vFjXTr4a4RqhfpPsL/V8yOuFC107NlNtXarjSOoekoUSmeqlfT+BfXeA9YxMmv6rzqr/o4pmJmMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqMRq0dBzz6L500;
	Sat,  8 Feb 2025 02:09:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8378814034D;
	Sat,  8 Feb 2025 02:11:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 19:11:55 +0100
Date: Fri, 7 Feb 2025 18:11:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v2 01/18] cxl: Remove else after return
Message-ID: <20250207181154.00006c8e@huawei.com>
In-Reply-To: <20250207153753.418849-2-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
	<20250207153753.418849-2-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 7 Feb 2025 16:37:36 +0100
Robert Richter <rrichter@amd.com> wrote:

> Remove unnecessary 'else' after return. Improves readability of code.
> It is easier to place comments. Check and fix all occurrences under
> drivers/cxl/.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
