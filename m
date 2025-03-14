Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E81A83F8
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953644; cv=none; b=hJLyfQCIVWqJoeBeL7N98lclTsZd3FUrl//djRIDkwVQlsKoLIePMMbU5mIkPRzidwNcvCqE9Gbguw4ErFcg/AcjBr2PQfXabrL69Pbbopppk2tKJ3YStj6j7SybZJUAlIdjHG4A6BZzNhCbyYEK3MAdGuG8SXW8L+28l2oIa88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953644; c=relaxed/simple;
	bh=rv3nBVFCKH3hhiGID4HW7D15Kjh+Hk3YVItECPz7Umg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tn+B9BzF7lUTiFcWR0RJMjNQONoz08LP94CXYBAdWGmuvZoRcnLmiSE1h2+Th9fOaSso0tm1Fx0fb3TSIWgTh5movxXCL8FLQGfYJin+OGhGZ0p8BpvxBWW8lddozdUBrD2PVq7Uk266arZ3kekY7c/yj/Xacv3N9FEktFezuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDjW720xRz6K6fb;
	Fri, 14 Mar 2025 19:56:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AB3D140DD5;
	Fri, 14 Mar 2025 20:00:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 13:00:37 +0100
Date: Fri, 14 Mar 2025 12:00:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <20250314120036.000034a9@huawei.com>
In-Reply-To: <20250306232239.2609017-1-alison.schofield@intel.com>
References: <20250306232239.2609017-1-alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Mar 2025 15:22:37 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL driver requires the granularity of a region and its root
> decoder to be the same. This is particularly restrictive for 3-way
> host bridge interleaves where the only spec defined interleave
> configurations for creating 6-way and 12-way regions on a 3-way HB
> interleave require mixed granularities.
> 
> CXL 3.2 Specification 9.13.1.1:
> Legal Interleaving Configurations: 12-way, 6-way, and 3-way

Ah this is finally a valid reason to do coarser interleave first
(going away from host). That was subject of long discussions way back
when original interleaving code was discussed (mostly because
my mental model did it that way around and I couldn't follow what
the kernel code was doing).

We 'could' revisit allowing this more generally - at least for
already configured set ups.  Only real reason for that is
either that someone ships a config that does it for a different
case, or that we want to avoid special casing 3*x cases.

Jonathan
