Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A21F4C9B;
	Fri, 21 Mar 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558862; cv=none; b=lEe8LKsRxBTStefRhcDK5DXZab3F+iVkN16v/hxj5F+D2CAzvB3T9Z+vXxtvVNIhpXL/vd/aytv6iACZCPYMPD1aOsBdI9M4qP8xCBWlIuXdCR4A4KTTmA4ro+JW3HWHuZkTJUOGPImDeMrYtjfZvsDsIc23seD0/7opPkerf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558862; c=relaxed/simple;
	bh=8R7GE7sqg8tOvcXdh0uQVCj1Em9EOW2a5EVrSprnlpA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8gzTLBBaaP/MyjMWfllw9iSnPnYwMX8TogPPj3gCLryaM333/cNURgBEMwTAKLRG9zKCwKDDaB4uAvFGX3v10MrjMV65RMHro9UUVO7OudyCyzZBBgeAxiITlPGhy6EiKvkHLyl+K1KVX+YNSYTZBp/IPB15MgxxFGHQUtN+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK1KX6JYPz67FVn;
	Fri, 21 Mar 2025 20:02:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C8E08140142;
	Fri, 21 Mar 2025 20:07:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 13:07:37 +0100
Date: Fri, 21 Mar 2025 12:07:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Li Ming <ming.li@zohomail.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch v1 2/3] cxl/pci: Update Port GPF timeout only when
 the first EP attaching
Message-ID: <20250321120735.000078b9@huawei.com>
In-Reply-To: <20250321054007.fidkwiemotwqyui3@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
	<20250319035516.222054-3-ming.li@zohomail.com>
	<20250321054007.fidkwiemotwqyui3@offworld>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 20 Mar 2025 22:40:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 19 Mar 2025, Li Ming wrote:
> 
> >If a CXL switch is under a CXL root port, The Port GPF Phase timeout
> >will be updated on the CXL root port when each cxl memory device under
> >the CXL switch is attaching. It is possible to be updated more than
> >once. Actually, it is enough to initialize once, other extra
> >initializations are redundant.  
> 
> It's actually not updated more than necessary because update_gpf_port_dvsec()
> checks first:
> 
> 	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
> 	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
> 		return 0;
> 
> >When the first EP attaching, it always triggers its ancestor dports to
> >locate their own Port GPF DVSEC. The change is that updating Port GPF
> >Phase timeout on these ancestor dports after ancestor dport locating a
> >Port GPF DVSEC. It guaranttess that Port GPF Phase timeout updating on a  
> 
> s/guaranttess/guarantees
> 
> >dport only happens during the first EP attaching.  
> 
> ... but yeah, I think this is still better, logically.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Agree that this seems sensible.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> (with the caveat that if patch 1 is not necessary then this would need to
> be redone).

