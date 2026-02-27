Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967E326D73
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772193202; cv=none; b=nDv7yXgk40908Z+hBXtOVQbLzhmsp52ohAG4itXFJ1OT1jRjQ7fp7OSsMLcpfJVSnfOhx18X9SMvCHCM4aBjpgTvMFI1+yBKj4mZnHtUvTcvhKPqMbiP0uQCWBrtj8hqoAvkr48oYptZH/cjxg4VWJ8Vb6TQS2dDYB+cdMkOjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772193202; c=relaxed/simple;
	bh=fH6vSQSr2Cs4CtqI96qq2vppoUgBbKsRsmHvJV/mrs0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atH6O/3CrLglvQ9faInsSyeyWABHGlmJO6985RabYn+yhp+rE8JGE+AFdf6bIDwH3HP97t6km0O+emc53LRNdngrWdSJQGbsSVI2+c47u/7TsShpvzgokALLeOqk5RS1kR6Z8axi0QL2LM8gflhGeHbW54i/e7ZseK5bU+3JVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMmsm0zDrzJ46Bv;
	Fri, 27 Feb 2026 19:52:44 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E15640571;
	Fri, 27 Feb 2026 19:53:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 11:53:09 +0000
Date: Fri, 27 Feb 2026 11:53:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v4] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
Message-ID: <20260227115308.0000249b@huawei.com>
In-Reply-To: <20260226184439.1732841-1-alison.schofield@intel.com>
References: <20260226184439.1732841-1-alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 26 Feb 2026 10:44:36 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_detach_ep() is called during bottom-up removal when all CXL memory
> devices beneath a switch port have been removed. For each port in the
> hierarchy it locks both the port and its parent, removes the endpoint,
> and if the port is now empty, marks it dead and unregisters the port
> by calling delete_switch_port(). There are two places during this work
> where the parent_port may be used after freeing:
> 
> First, a concurrent detach may have already processed a port by the
> time a second worker finds it via bus_find_device(). Without pinning
> parent_port, it may already be freed when we discover port->dead and
> attempt to unlock the parent_port. In a production kernel that's a
> silent memory corruption, with lock debug, it looks like this:
> 
> []DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
> []WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
> []Call Trace:
> []mutex_unlock+0xd/0x20
> []cxl_detach_ep+0x180/0x400 [cxl_core]
> []devm_action_release+0x10/0x20
> []devres_release_all+0xa8/0xe0
> []device_unbind_cleanup+0xd/0xa0
> []really_probe+0x1a6/0x3e0
> 
> Second, delete_switch_port() releases three devm actions registered
> against parent_port. The last of those is unregister_port() and it
> calls device_unregister() on the child port, which can cascade. If
> parent_port is now also empty the device core may unregister and free
> it too. So by the time delete_switch_port() returns, parent_port may
> be free, and the subsequent device_unlock(&parent_port->dev) operates
> on freed memory. The kernel log looks same as above, with a different
> offset in cxl_detach_ep().
> 
> Both of these issues stem from the absence of a lifetime guarantee
> between a child port and its parent port.
> 
> Establish a lifetime rule for ports: child ports hold a reference to
> their parent device until release. Take the reference when the port
> is allocated and drop it when released. This ensures the parent is
> valid for the full lifetime of the child and eliminates the use after
> free window in cxl_detach_ep().
> 
> This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
> devices present.
> 
> Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
New rule makes sense to me and implementation looks good.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
