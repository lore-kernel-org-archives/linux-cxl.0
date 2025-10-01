Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89EE23E32D;
	Wed,  1 Oct 2025 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329267; cv=none; b=mJXXcjw3g+cnM5U37cgPYMzv9UPOhfCo5b1b1hoxOEiJO34k0oePtPo6xYdJ7ExxHPXNn4Dn+3yNxFCRBV3lnayO6gKiSVmA+RxkQfq/IN2sDrSsU17iOPxN4bp19/QXvYoyO5MlliUvrrCvYlizTSQVVWmlM+TLulVQi7WOE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329267; c=relaxed/simple;
	bh=kVG2/j2DIaRElDyA07UvN82zVOcq5OhO/45v1SKCR+M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMSXbMGqSEFeD7sOxjIjNu7tFn+DjCRpUMetKzgFjk6BOJunemdP53FYGcyJ7z9goVrve0KOHEuSz6MbrozyCSGiZO29jL4XBE/6S+3kxdWZqbnO+1ZOZm51LyifZj55TGmncvJnWsyvS4fVHgTNqgj+RJ6U8QSW/471BaVR8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccHVb198Bz67HW3;
	Wed,  1 Oct 2025 22:33:59 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 989C514037D;
	Wed,  1 Oct 2025 22:34:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 15:34:15 +0100
Date: Wed, 1 Oct 2025 15:34:12 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] cxl/port: Avoid missing port component registers
 setup
Message-ID: <20251001153412.000073bc@huawei.com>
In-Reply-To: <20251001060337.431639-1-ming.li@zohomail.com>
References: <20251001060337.431639-1-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  1 Oct 2025 14:03:37 +0800
Li Ming <ming.li@zohomail.com> wrote:

> port->nr_dports is used to represent how many dports added to the cxl
> port, it will increase in add_dport() when a new dport is being added to
> the cxl port, but it will not be reduced when a dport is removed from
> the cxl port.
> 
> Currently, when the first dport is added to a cxl port, it will trigger
> component registers setup on the cxl port, the implementation is using
> port->nr_dports to confirm if the dport is the first dport.
> 
> A corner case here is that adding dport could fail after port->nr_dports
> updating and before checking port->nr_dports for component registers
> setup. If the failure happens during the first dport attaching, it will
> cause that CXL subsystem has not chance to execute component registers
> setup for the cxl port. the failure flow like below:
> 
> port->nr_dports = 0
> dport 1 adding to the port:
> 	add_dport()	# port->nr_dports: 1
> 	failed on devm_add_action_or_reset() or sysfs_create_link()
> 	return error	# port->nr_dports: 1
> dport 2 adding to the port:
> 	add_dport()	# port->nr_dports: 2
> 	no failure
> 	skip component registers setup because of port->nr_dports is 2
> 
> The solution here is that moving component registers setup closer to
> add_dport(), so if add_dport() is executed correctly for the first
> dport, component registers setup on the port will be executed
> immediately after that.
> 
> Fixes: f6ee24913de2 ("cxl: Move port register setup to when first dport appear")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Seems reasonable.  Alternative would have been to carry a 'it went horribly wrong'
flag and fail the later additions as well (on basis a failure in the relevant calls
is very unlikely). This seems simpler.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

J
