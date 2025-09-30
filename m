Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2D3043C4;
	Tue, 30 Sep 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244150; cv=none; b=LhMSEgB5WfOxTqBTLsuRm1mO/K+VkW6degB5cSkI0ont6r5yJQhmCuDooG7hCW1RuxWHNzQtPL9m7TeCcfqM9C24LPPsfKFbef2u2Hf+qPLcnkcapno6ftb8Av3a5U7uMg/hBm+KOvtSSR6lStCLBrOb0laZKQAY+k2VY3YC2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244150; c=relaxed/simple;
	bh=G2Hj3Hw0reSLo5/FJ/xT4+fdV5ZxXGDqaqkoEPlq3wQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9RXP3Hw6uzO/vmmFI8u94LydjIbOHKMZuYg2ZgcLXpngNa4C3GBczJFeqveQqrRB/n/lT9kY3gLA9S5RoIk9Y6wSYAmO9RL9cMs/RIVwdLE/tXsqhy7EnsHJmLOrRxjHvCn7tmtAThgvz5brjqUQdGxXXYiWalv2D48KLcivn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cbgzg2mCFz6L4x5;
	Tue, 30 Sep 2025 22:53:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E40EC140276;
	Tue, 30 Sep 2025 22:55:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 15:55:45 +0100
Date: Tue, 30 Sep 2025 15:55:43 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/port: Remove devm_cxl_port_enumerate_dports()
Message-ID: <20250930155543.00000139@huawei.com>
In-Reply-To: <235bf94a-da23-4200-87e4-c6a0c92cb21a@intel.com>
References: <20250927100709.146507-1-ming.li@zohomail.com>
	<235bf94a-da23-4200-87e4-c6a0c92cb21a@intel.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 29 Sep 2025 09:43:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 9/27/25 3:07 AM, Li Ming wrote:
> > devm_cxl_port_enumerate_dports() is not longer used after below commit
> > commit 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> > 
> > Delete it and the relevant interface implemented in cxl_test.
> > 
> > Signed-off-by: Li Ming <ming.li@zohomail.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks Ming. For some reason I thought I did this. But it seems not...
I never object to deleting unused code  - particularly when the testing
wrappers can go aw well.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

