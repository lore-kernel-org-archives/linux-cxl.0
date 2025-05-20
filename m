Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251533DB
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745598; cv=none; b=dsBhS//04WoAl2PCY0RMccvMmIWdp6+1LKsjfhIoyiViWeNusIxk64b4V+V9zMV3Dg6hpSUdNxuFyeL7Ji0o3S/kUTWp5O0EwQjSe/bSOzFdyYf6KZiSd/iiWFCkH7DSltLfkf7waLD875J4aBXM/tWOTgPFsX1huWCjElm077Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745598; c=relaxed/simple;
	bh=ga6kVQV9XBjse21HVg5SchTFAe84AqsXCoS5GwU5dZE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdRDoK3hVHAOjL8cN67ZZp7CjPKcM78bZTRvZp/7P4d1mHd9nBs6NV82EGJmYRDxTPmL7HIr82IN2yE/boX7zoEfPws+/d6QbE21PjMfqpyNZW5YqYVLcTUmuAj6hmVdkVrLWT9Ft01yBiBbokljlEVFzDgCs7xqs6xf7tAhneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1vXX6G9gz6L5Br;
	Tue, 20 May 2025 20:50:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 129C51402FE;
	Tue, 20 May 2025 20:53:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 14:53:12 +0200
Date: Tue, 20 May 2025 13:53:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 09/10] cxl: Create an xarray to tie a host bridge to
 the cxl_root
Message-ID: <20250520135310.00003e4c@huawei.com>
In-Reply-To: <20250507004310.3536991-10-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 6 May 2025 17:43:09 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper functions to setup association of a host bridge device to a
> related cxl_root. Functions are in preparation to support the moving
> of host bridge ports creation from cxl_acpi to cxl_memdev probe path.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
I've nothing to add to Gregory's naming comments beyond agreeing that
it could do to be a little more obvious what is what here!

