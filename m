Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60C35A95E
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989366; cv=none; b=odUmKnRfbWzwZOkaEykrhIUqaXPz+oRUX4PxkSnZmjJbyABvh5jMlQgllfh2jOPxqXnEcXHkhZfrjqT8QeWbZP0aELqe8qVB2m96+NhVlqrTBwHG2p2OgDaOEOK8ICtrE1PsDFyRuvX464a26KiGPbM1akMmYKZW5LzChMnjxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989366; c=relaxed/simple;
	bh=NmpTu9t/PdpdgjPRzHuBYsfFZODoMkn8VGLg9yOFCcM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6llnIC4MOAK7MyCuf44Hh3RwIA+DdsvRJXSO1jqMdYDZZC2pdwaKarUW1PWxIobnaTe3wcr1TCE8r/MZedU9wCh+JBW8kiBV3A6w+mruQJMNx75fkZB9W9StOs49a8crYVGrk0WZdbLQwLRhVJfKgq6QWPjJVN9Ll6Rpn49j8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWfYK0WvBzHnGhy;
	Thu, 18 Dec 2025 00:35:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9324D40539;
	Thu, 18 Dec 2025 00:35:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 16:35:58 +0000
Date: Wed, 17 Dec 2025 16:35:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 12/17] cxl/core: Add CXL snoop filter setup and
 allocation
Message-ID: <20251217163556.00001f58@huawei.com>
In-Reply-To: <20251111214032.8188-13-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-13-Benjamin.Cheatham@amd.com>
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

On Tue, 11 Nov 2025 15:40:27 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> The CXL snoop filter capability (CXL 3.2 8.2.4.23) is a mandatory
> capability for CXL 2.0+ root ports that is used by the host and CXL
> devices to manage CXL cache coherence.
> 
> Snoop filters may be shared by several CXL root ports, with each snoop
> filter having a unique group id. Create snoop filter instances as CXL
> root ports are added to the system. If the snoop filter already exists,
> add the root port to the existing filter instead.
> 
> Snoop filter instances are used to keep track of the amount of CXL cache
> space active under the filter. The CXL specification allows rejecting
> CXL devices based on the amount of filter subscription, but determining
> when the filter is oversaturated is most likely implementation specific.
> To address this, add a cxl_core module parameter to specify whether
> adding a CXL.cache device's cache to an already full filter should fail
> device probe. The default setting of the parameter is to allow
> oversaturation of the filter ("strict_snoop=off").
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
> 
> Jonathan asked about the allocation policy when the snoop filter is
> "full". I had the device fail probe beforehand, but it got me thinking
> that it may be worthwhile to add an option to over commit the filter
> instead, hence the module parameter. I'm game to other suggestions, but
> a config symbol didn't feel right since the setting probably varies by
> platform/user.

Doesn't feel like a module parameter is appropriate as may depend on
specific devices as well. Ideally we want the capacity and device requirements
to be exposed to user space before deciding to bring it in and how to handle
minimum vs ideal levels.

Tricky topic and once we get a little nearer merging this + have some
device drivers to poke at lets revisit. Maybe on one of the sync calls.

 
> 
> Also I'll add Cache_SF_Coverage support when this series goes out of
> RFC (I forgot to do it this time around).
> 

On a related topic, how do we know the right Cache_SF_Granularity for
a given system?  Might be a specification gap (or I just can't find it)

Jonathan


