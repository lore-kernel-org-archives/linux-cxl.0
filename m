Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF11E9B01
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138410; cv=none; b=CZprtbW7APkNO/20jh9BQJ+YDgnUrEf1rda+kcqbKZLQeACC/t7suqIe62xBOv6MBYY4UfuvqObyfezX9GmY+8T6/GIVNbFjbzNNDVaCUjUkfamWjHL8jw8snsRRfGTaN6VzHCDUyEfuqAodSGTiH2hDgFEOXeV162H9Rnk0TLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138410; c=relaxed/simple;
	bh=x+wdKJCzGHXTDd7YDVzATx93+qeokYXj6TtgILNVeqk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT2/8gH4gvVwVydJ2BGpo3xkoERKYzoFX3vi+4yj3eDSr/8K7q4m+NlDgMg4o7JRx3OF2tVU5GPtDpGwekhU3Cbv+B4wOpqE/xa3GIIcFdiq59fkigSPMWKST4oB3uoSEsynRfiLzXfCYORlDdPGjMxBMg2H85/qhHqfFokc2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzpD403CSz6H6wR;
	Fri, 21 Feb 2025 19:43:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A46CC140B55;
	Fri, 21 Feb 2025 19:46:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Feb
 2025 12:46:44 +0100
Date: Fri, 21 Feb 2025 11:46:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <ming.li@zohomail.com>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
Message-ID: <20250221114642.000011fa@huawei.com>
In-Reply-To: <20250220220235.276831-2-dave@stgolabs.net>
References: <20250220220235.276831-1-dave@stgolabs.net>
	<20250220220235.276831-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 20 Feb 2025 14:02:32 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add a helper to fetch the port/device GPF dvsecs. This is
> currently only used for ports, but a later patch to export
> dirty count to users will make use of the device one.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

(was in v4 reply)
