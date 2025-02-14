Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DC28F4;
	Fri, 14 Feb 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549721; cv=none; b=YeoaBKdN9CcqEcPanNvyUjapkMlhdstK6WirI4FWH0ZnHqnuRWJZ85P22QshJzwDHpdXDu3ZGtCob93wHcEddH9C09Odad/PWufPEQnw+GfSM3Tp9UnJACDVYqdvpCYqOV0vczOfhD7RuXLUCIWN3gVyv+gFLihSs8su6ZVN5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549721; c=relaxed/simple;
	bh=CQ4tXeWsLPEiYr7KOohad8pCc+w8jND+nuTwU/QaXBQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtMhuwXmQMgCxcqmPnqoyeUO1sQ8g/jWoaC+RJ/ZcHLZZEzUioJl/DnUmDgTPiqHy8We8ER17Ruau4gasTpOIl4UP2L7nohNKWbjVkEWC7JCgmVqvf75caTWkMSkLC+45I+XMJgO8IIXUMjtmeNhKHJXIACcEnjgOiMapMJnEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvcWY0rgMz6L51n;
	Sat, 15 Feb 2025 00:12:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1270B14038F;
	Sat, 15 Feb 2025 00:15:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:15:15 +0100
Date: Fri, 14 Feb 2025 16:15:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 10/18] cxl/region: Factor out code to find a root
 decoder's region
Message-ID: <20250214161514.00004fe7@huawei.com>
In-Reply-To: <20250211095349.981096-11-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-11-rrichter@amd.com>
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

On Tue, 11 Feb 2025 10:53:40 +0100
Robert Richter <rrichter@amd.com> wrote:

> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
> 
> No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
