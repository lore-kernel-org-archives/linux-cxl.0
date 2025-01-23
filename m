Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD01E884
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656019; cv=none; b=l85Kzubcsb5qH3uocBM7NaLHeD39S5HT5J2t4fDQr6TcpFlRadokyeH858S+dQeUktOwfskGAwqbskiJ5Kh8DUMb5eprBUABXjefVVrIJWh1syzvu1grf7g+yXtM0pR69ky45SaR+SYuoG9wd4WdL4xCcaYgTsmEiZRc0N3oxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656019; c=relaxed/simple;
	bh=9VydQ/FDrLJZbxAksZoeZ/WIeqMmVpLCqq5+OQWmp18=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYvI0Oklzx3DLmrAwo6x1NH2nRe8/X7mPgPj75Tp8pLAM01YMTzAovoPet3SHAFiBaW2GF/yOYmXb3k1NNmdgxOgk0y2fiV8DhGArdCedwwq0JtRKdzkMjj7fKsRhl9lRdWFNaCTqAVGZMRaSCKM9+fyHluVbP23ags8Nolg/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf8FQ717sz6K7kc;
	Fri, 24 Jan 2025 02:13:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 541F31404C4;
	Fri, 24 Jan 2025 02:13:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:13:33 +0100
Date: Thu, 23 Jan 2025 18:13:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 13/19] cxl: Move cxl feature command structs to user
 header
Message-ID: <20250123181332.00000ac9@huawei.com>
In-Reply-To: <20250123181254.00002b42@huawei.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-14-dave.jiang@intel.com>
	<20250123181254.00002b42@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 23 Jan 2025 18:12:54 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 22 Jan 2025 16:50:44 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > In perparation for cxl fwctl enabling, move data structures related to
> > cxl feature commands to a user header file.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> 
> Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I missed the cancel button....

