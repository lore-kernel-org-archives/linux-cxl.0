Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0053368AD
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794245; cv=none; b=i7HWRA0DOZMt956F+QoOzX1yj4xw3S4h9mWObkKfnxU3UjJemcPUj0xMrOOF8MgJrDC0k9sL4sIuZ1f2RaC5cGDUDnbxWVF5/JcQVvuN9U3JUA8doU0IluYrdoSY95FMO8Ht5j1hRTGQ6/nm2KPjuXGzAVRk8CTKBjIrEXJqgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794245; c=relaxed/simple;
	bh=4jomw9femtuQiMOv7jLnkKUYNDD4z0VUHegbpGfSii4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6oP3khdMXtIMj9KHMmdpyJ5qz9upIWUXnsAy+Bvj2c7BNi32GH9suK2kBwXtm6crLkFo87WJQFYIw2s0vOVwx0jkl9l4aHxQ6jXZe6NbHMZbQBOwE5MDPROXNvF4eojNEiDeV+JcFz+yAtOv02sgC3+n2sa2h5i83EmpnRmYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS38C6NyBzJ46DM;
	Fri,  6 Mar 2026 18:50:03 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C043440572;
	Fri,  6 Mar 2026 18:50:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 10:50:41 +0000
Date: Fri, 6 Mar 2026 10:50:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	<linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, <gourry@gourry.net>
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Message-ID: <20260306105039.00007f51@huawei.com>
In-Reply-To: <69aa341fcf526_6423c1002c@dwillia2-mobl4.notmuch>
References: <20260305204057.1516948-1-kbusch@meta.com>
	<69aa28d0d9076_6423c100da@dwillia2-mobl4.notmuch>
	<aaotQCg0TspiiaDH@kbusch-mbp>
	<69aa341fcf526_6423c1002c@dwillia2-mobl4.notmuch>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 5 Mar 2026 17:55:43 -0800
dan.j.williams@intel.com wrote:

> Keith Busch wrote:
> > On Thu, Mar 05, 2026 at 05:07:28PM -0800, dan.j.williams@intel.com wrote:  
> > > > The call from cxl_acpi_probe() is guarded by
> > > > IS_ENABLED(CONFIG_CXL_PMEM), which evaluates to true for both =y and =m.  
> > 
> > <snip>
> >   
> > > So I do not think this is sufficient because there is no
> > > devm_cxl_add_nvdimm_bridge() stub in the CONFIG_CXL_PMEM=n case, right?  
> > 
> > It's called from a preprocesser "#if 0" section, so it shouldn't be
> > compiled in. At least it seems perfectly fine in local testing, but is
> > that compiler specific? I think this should have been optimized out.  
> 
> Oh, duh, yes, the IS_ENABLED() stays there. Hmm, this indeed looks like
> it does everything right. I forgot that the dependency checker will make
> sure that you can not select CXL_ACPI=y and CXL_PMEM=m.
> 
> So,
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...this is better than what I proposed.
> 
I prefer Keith's solution to Gregory's just because of removing a surprising foot gun.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

