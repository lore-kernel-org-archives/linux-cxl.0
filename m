Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3A152DEF
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165235; cv=none; b=D3FEZ4Jy+Llo+8vqu2dU8PpUqTz/lI6FHIU2ksV0/fra5IxpbsyBZZoIqZ9jRLNb0mZn4xE+nBoaeRN40H3vISuqFGfGkHxNay+LTji2vwhNIYw0szrR2r7YdWd9uW5VsMC6M2aH7kOvZJNMxpIws7EgeI/3JFMUXLzLnFgmESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165235; c=relaxed/simple;
	bh=Fduir/sTc3kuiz7rtJHXjKGl7QGxCBZ7jizLqUoDsY0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyHkejm6XFXbWSi8kqKHGHCW77pjszcMvADa+6snmEr4aMcoJVMEbOH5cWEHGqx6oFCo37J3XGZs7UOEB34agXQs9/pNpWhix6QXT77FH9kVmBp+Bw5HT/Nsz7ingYw2leAbmMnn3jp+sEmYfQLmk4DxrA+WpabVRK0X0VvD+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8s8w2hpKz6GCC7;
	Thu,  4 Apr 2024 01:25:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C45214058E;
	Thu,  4 Apr 2024 01:27:09 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 18:27:08 +0100
Date: Wed, 3 Apr 2024 18:27:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/region: Move cxl_trace_hpa() work to the region
 driver
Message-ID: <20240403182708.000001e6@Huawei.com>
In-Reply-To: <0174dc9414d4beb71828f66e173a8fcc4ebe76ab.1711598777.git.alison.schofield@intel.com>
References: <cover.1711598777.git.alison.schofield@intel.com>
	<0174dc9414d4beb71828f66e173a8fcc4ebe76ab.1711598777.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 27 Mar 2024 21:36:31 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> This work belongs in the region driver as it is only useful with
> CONFIG_CXL_REGION. Add stubs in core.h for when the region driver

1 stub.  Is there a prize for trivial comment of the day? ;)

> is not built.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
