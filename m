Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FFA2139CE
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662492; cv=none; b=P5hStTKOIToMMZakefLKYctQONpe2P/DSHRM21gHl9hRmRm56UNE23kLpmAhojaHHaWBCJsy2t2zcJEEdaQfUE1zmWgf0bGl7+yPm0mfV2y2PQVOZGrUvqmTZKzX5xmS1DNLLyt9y8pfJibBTcxacjno1pAWPjfEu1NXoQNxqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662492; c=relaxed/simple;
	bh=Fy0gWrChVBUTivUK4SamyazOG395SoMFQe+wlqrU/80=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KW0CS8btJ/yaZF4MyrPSdQAkaE6vp8D8v9qcLaRCGqiC2WapUh5Y9dTiVMd6J+Ch24q5KUG9sZtzuY2EKe1VWMyfCVioYMkb5/ovuNVySU6cdB+w5L1YaYKQ/Nz3MJXQe38ar2Vg1TPuRRdlquFKSOcPpYJTR1ky1v6s6UitR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwtLm3TZcz67fPC;
	Tue, 28 Oct 2025 22:39:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B80C41402EF;
	Tue, 28 Oct 2025 22:41:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 14:41:27 +0000
Date: Tue, 28 Oct 2025 14:41:25 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] cxl/region: Add support to indicate region has
 extended linear cache
Message-ID: <20251028144125.0000133b@huawei.com>
In-Reply-To: <5e9e4ac9-c0e1-4c30-b4da-1f97e14bdb39@amd.com>
References: <20251022203052.4078527-1-dave.jiang@intel.com>
	<5e9e4ac9-c0e1-4c30-b4da-1f97e14bdb39@amd.com>
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

On Fri, 24 Oct 2025 12:05:31 -0500
"Cheatham, Benjamin" <benjamin.cheatham@amd.com> wrote:

> On 10/22/2025 3:30 PM, Dave Jiang wrote:
> > Add a region sysfs attribute to show the size of the extended linear
> > cache if there is any. The attribute is invisible when the cache
> > size is 0, which indicates it does not exist.
> > 
> > Moved the cxl_region_visible() location in order to pick up the
> > new sysfs attribute definition.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> 
> I pointed out a few typos below, but contents look good so:
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

With the bits Ben noted tidied up, looks good to me too.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
