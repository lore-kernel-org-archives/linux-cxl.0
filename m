Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D61A4F12;
	Fri, 11 Jul 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251928; cv=none; b=RPkHBjKpFaO7rVYE7p+R7qHby9K1HlqkgL+1WWFdQrlDD+BrfwYnJ4kpZ3q+d3NSyBIqbfbGko//DA7TMBKVGkRr2CPunFQbsKrxtFS7mu4UsykUkBBWFp9fe922r7chIoVe6vS0wQXoMXYAxrC3DIB4eSIlCZTP/A0TWITlCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251928; c=relaxed/simple;
	bh=Ne4b2nGTgDipPzxcSr9Mkib01zEJHl0OHOE2wQdI+bQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdvzqI304HsikBoSeHrIN850+je0jry5nu2tfWEd/vpGMouIiihYFxZX1oSWtiIr3h7Z1xrC7qA6PsXGy9TySIrhkWARIWfqNu7b1m5YFAQY3WY35/pn/4rpL9aDIKef+OT2/nl/eSnxraHnK1HJgQw23lDeLiaR110tWcJiHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdy7H07xSz6L5Kn;
	Sat, 12 Jul 2025 00:37:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 71BE3140277;
	Sat, 12 Jul 2025 00:38:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 18:38:41 +0200
Date: Fri, 11 Jul 2025 17:38:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] cxl/edac: Fix wrong dpa checking for PPR
 operation
Message-ID: <20250711173840.000072f0@huawei.com>
In-Reply-To: <20250711032357.127355-3-ming.li@zohomail.com>
References: <20250711032357.127355-1-ming.li@zohomail.com>
	<20250711032357.127355-3-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 11:23:56 +0800
Li Ming <ming.li@zohomail.com> wrote:

> Per Table 8-143. "Get Partition Info Output Payload" in CXL r3.2 section
> 8.2.10.9.2.1 "Get Partition Info(Opcode 4100h)", DPA 0 is a valid
> address of a CXL device. However, cxl_do_ppr() considers it as an
> invalid address, so that user will get an -EINVAL when user calls the
> sysfs interface of the edac driver to trigger a Post Package Repair(PPR)
> operation for DPA 0 on a CXL device. The correct implementation should
> be checking if the input DPA is in the DPA range of the CXL device.
> 
> Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
