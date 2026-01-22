Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8743636E
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081546; cv=none; b=hhyyTo3XEFD9fpaarRKk5R2Hn6HKKT4HSN2F965sUAxyUB9WgjJBikFcCNPf316MqO68jF7w1yzzlFmBvk4uBNBmFKv2VtmxFQHD9fZ8LE08axcXvT91k0Ko1AWcZ4Ud1c4pdZzVMVm1BueKDz+yKLmeJNrTIFBkIK5eDlTsNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081546; c=relaxed/simple;
	bh=JBUO0w/8Qvvqj7L0KMfW016G5gTm2sAJ4M0toWsHnmk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaVZzj9M1JG2D5M5SAfzPMms7/lpMHkyirNiRUgoY1UjRMCXTkX0FkVFK5ygHvSqwZRe+6paXpfqUZyi0wfem+ZYXV0lp9pEu+wNf4e4rWu4pbS4+J8ObOMSOeIAOaGkQqEE7gADAdtIXRpazxC20kYXoaMi7Lis5uN1V/I/3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxf6633T5zHnH7G;
	Thu, 22 Jan 2026 19:31:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0923E40571;
	Thu, 22 Jan 2026 19:32:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 11:32:17 +0000
Date: Thu, 22 Jan 2026 11:32:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 1/9] cxl/port: Cleanup handling of the nr_dports 0 -> 1
 transition
Message-ID: <20260122113216.00004eb2@huawei.com>
In-Reply-To: <20260122033330.1622168-2-dan.j.williams@intel.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-2-dan.j.williams@intel.com>
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

On Wed, 21 Jan 2026 19:33:22 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> There are multiple setup actions that can occur for a switch port after it
> is known that it has at least one active downstream link. That work is
> currently split between __devm_cxl_add_dport(), the add_dport() helper, and
> cxl_port_add_dport() where decoder setup occurs.
> 
> Clean this up by moving all @dport object setup responsibilities into
> add_dport() and all port effects into cxl_port_add_dport().
> 
> add_dport() handles taking a reference on @dport->dport_dev, and
> cxl_port_add_dport() grows the awareness to setup the port component
> registers. This removes an awkward open-coded xa_erase() from the middle of
> __devm_cxl_add_dport() and instead tasks cxl_port_add_dport() with calling
> the common @dport destruction path if anything goes wrong.
> 
> After this @port->nr_dports is always the count of @dports in the
> @port->dports xarray, and cxl_dport_remove() is symmetric with add_dport().
> With ->nr_dports now reliably tracking the number of dports the use of
> ida_is_empty() can be dropped. Recall that the ida is only cleared on
> "release" of decoder objects, and release can be arbitrarily delayed past
> unregistration.

Given we only care about nr_dports going to and and from 0, why do
we need nr_dports at all?  Why not use xa_empty() as the condition.

Does this now guarantee we don't need the extra nr_dports reset in
cxl_switch_port_probe()?  That also made me suspicious of something
funny going on as the count should have dropped to zero if we
are in state to rebind.

Other than those this looks good to me and both of those are perhaps
topics for other patches even if maybe they could be done in here.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
