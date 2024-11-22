Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA752309BF
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288849; cv=none; b=csvobx9dVUCsZLJwUgQOS7GowhuQ6WO1yMLGDQh80eX8CAeB36zL5adf28Eneu46MD84ceI3iEO8ZZESXVQdPdOXSAvRhTmXD3dfQxAxstCkptqTvknwzMePtsqI/gWrUtg6M4GDRXf5e6QiYgW5e1Gw1vPHYBf0kfVUVVOvb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288849; c=relaxed/simple;
	bh=mKGxpsvVxxRLER0TaZHOFd/Jxcp8xDmsYV3gnUt6Rgs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0WiUebniXp7c/s/KhV56814SxPTULRKrcvm46I/ehUxKQUDl7c1iB1JSHXsvJZmSsq7Mm8eqHQjvuYI7Vf+W1lMYtD+AvP7DQnf1dFR8Z0WoXKm37pp2FdTr8QGkSyuOtj71oc0HDWXKQJH2McfPKWwHMj9OtZr7baYI1plpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvzJF08yvz6K5XG;
	Fri, 22 Nov 2024 23:18:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CA5E140B38;
	Fri, 22 Nov 2024 23:20:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 16:20:43 +0100
Date: Fri, 22 Nov 2024 15:20:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 18/20] cxl/test: Add Set Feature support to
 cxl_test
Message-ID: <20241122152042.00001df9@huawei.com>
In-Reply-To: <20241115212745.869552-19-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-19-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:51 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add emulation to support Set Feature mailbox command to cxl_test.
> The only feature supported is the device patrol scrub feature. The
> set feature allows activation of patrol scrub for the cxl_test
> emulated device. The command does not support partial data transfer
> even though the spec allows it. This restriction is to reduce complexity
> of the emulation given the patrol scrub feature is very minimal.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
