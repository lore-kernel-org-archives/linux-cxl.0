Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D333F6;
	Fri, 21 Mar 2025 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558924; cv=none; b=u/58BjNCYcKObX+Wigbh9SFGuuDjF7mwCgrr9MSDChukcsu97lanVfeX6ONy2li5WMTL/B9cJ2T5E3lt5FfZJ5X263YKjyx1KQPIyokaReeU+lLGHiOFdfQKXHF/Ny1WmEBQK5ehui5S/cq5dE6ntBWTzb7clOfn76WnK3XK+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558924; c=relaxed/simple;
	bh=KlheGVRcrOYSlNYpnXMhs/VRVoZmQVcoJCMKAeV7Usg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAvaXshLab8k6DPO0cXU6ajTnlq6SSBpT47aTGFbSQrvlpLsm1B1f6Ite612Dlp1CoN7F/QekioK6JE3+HUQR51V5ViCQ3hgyf84Sk0dsMCJLYWlEQErpzJVEwIdDgD1H/Or6wVEk/gU4XF0pxRrznFY+GAoJVLIO+Y4XN7cYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK1NZ3rqGz6M4r8;
	Fri, 21 Mar 2025 20:05:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EDE451407C6;
	Fri, 21 Mar 2025 20:08:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 13:08:39 +0100
Date: Fri, 21 Mar 2025 12:08:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Li Ming <ming.li@zohomail.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch v1 1/3] cxl/core: Fix caching dport GPF DVSEC issue
Message-ID: <20250321120838.00006a35@huawei.com>
In-Reply-To: <20250321074154.ltenxqprgxizh5kx@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
	<20250319035516.222054-2-ming.li@zohomail.com>
	<20250321074154.ltenxqprgxizh5kx@offworld>
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

On Fri, 21 Mar 2025 00:41:54 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 19 Mar 2025, Li Ming wrote:
> 
> >Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, only
> >CXL Downstream switch ports and CXL root ports have GPF DVSEC for CXL
> >Port(DVSEC ID 04h).
> >
> >CXL subsystem has a gpf_dvsec in struct cxl_port which is used to cache
> >the offset of a GPF DVSEC in PCIe configuration space. It will be
> >updated during the first EP attaching to the cxl_port, so the gpf_dvsec
> >can only cache the GPF DVSEC offset of the dport which the first EP is
> >under. Will not have chance to update it during other EPs attaching.
> >That means CXL subsystem will use the same GPF DVSEC offset for all
> >dports under the port, it will be a problem if the GPF DVSEC offset
> >cached in cxl_port is not the right offset for a dport.
> >
> >Moving gpf_dvsec from struct cxl_port to struct cxl_dport, make every
> >cxl dport has their own GPF DVSEC offset caching, and each cxl dport
> >uses its own GPF DVSEC offset for GPF DVSEC accessing.  
> 
> This conversion looks good if necessary.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Whilst I somewhat doubt we'll see this in the wild, they could indeed
be different.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
