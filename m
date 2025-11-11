Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46136A03F
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876812; cv=none; b=MfYAj5ZIJ12YYM87V95j1Z5IyB5Dgjk1rm2avX+dgVJPG2A7GFVZFzRltU+bp4bQBR8W3eIfR9TTcXjT80cGij5QkF8tfHGV6hRWC1f27gluVW/Tjlgk/K0e6+X+63Fp5k5TFwiV5UZobkCsG0st/Ozv9Ii0QzXqAYJTsLWib2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876812; c=relaxed/simple;
	bh=QEmdIxXaIl5ehTgmotxpYhmVRdGPICYpS0wHINUESqU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oja0+d1aEulBlilxuWG+Mi0km5U6UFEjz8O7BEsvlN+6OCcna5DiDY6niz3yULRRdFNcs9HQEPiF9xnsjjj1Tqm8Id5uzNXXU3HhMm8zSvTKzVdja8x7Imcvf7OhRBnfJnO9BZctk/CT0qEyfPpBOFf+tiUNgcYNqy9tn/BBvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5WSg71HqzHnGkM;
	Tue, 11 Nov 2025 23:59:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 56C8F14033F;
	Wed, 12 Nov 2025 00:00:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 16:00:04 +0000
Date: Tue, 11 Nov 2025 16:00:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH 1/2] cxl: Rename region_res_match_cxl_range() to
 spa_maps_hpa()
Message-ID: <20251111160003.00002a48@huawei.com>
In-Reply-To: <aQzVqdjXTihh8KyU@gourry-fedora-PF4VCD3F>
References: <20251106170108.1468304-1-dave.jiang@intel.com>
	<20251106170108.1468304-2-dave.jiang@intel.com>
	<aQzVqdjXTihh8KyU@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 6 Nov 2025 12:06:49 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Nov 06, 2025 at 10:01:07AM -0700, Dave Jiang wrote:
> > The function name region_res_match_cxl_range() does not accurately
> > convey the operation of address comparison with cache size. Rename
> > to spa_maps_hpa() to provide a better function name.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Link: https://lore.kernel.org/linux-cxl/68eea19c7e67e_2f899100a8@dwillia2-mobl4.notmuch/
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> 
> My favorite kind of patch
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>

I can never remember which is which between hpa and spa, so I'll just assume this
is the right way around.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huwei.com>
