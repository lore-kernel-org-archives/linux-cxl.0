Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3324886C;
	Fri, 11 Jul 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251876; cv=none; b=tpTQQGqsavdMbnp60ynFvV/d1XPjxiJWNrE9RViO5iI/Ng82s+XRgiuM2uV0OuSWd35UBY0m3GU81Vq3UBlJ2kT4dPUkxJgnOgyx5vTJPzi9boVoUPGxXgxWPKShvZD3MUHp9IP6q4nGoyZ9q3d+3GHVFog5GZHK2m9CzF2T24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251876; c=relaxed/simple;
	bh=SiHRblTPehjltAQJCHDToZeTFQyxvlq2oAOYsBAlWww=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPrpamYlQvBqBUvkKl5kHhMwNX2O1ZrcpK+mPNETIVEyVa3ET2fQ/iT0jWcqI6/sS0yn4mZkt/gSyOysoRfs5PkRlKB3+WLVV58CXPSyqxcBLrGvjmYL3/ZdvRdGsSOoovbJ8vOaBV+C+i/OkZKjkV9SMcFZRL2TjT5YmhHKjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdy6H2BG0z6L5G0;
	Sat, 12 Jul 2025 00:36:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BBDC81402FE;
	Sat, 12 Jul 2025 00:37:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 18:37:50 +0200
Date: Fri, 11 Jul 2025 17:37:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] cxl/core: Introduce a new helper
 cxl_resource_contains_addr()
Message-ID: <20250711173748.000015db@huawei.com>
In-Reply-To: <20250711032357.127355-2-ming.li@zohomail.com>
References: <20250711032357.127355-1-ming.li@zohomail.com>
	<20250711032357.127355-2-ming.li@zohomail.com>
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

On Fri, 11 Jul 2025 11:23:55 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function cxl_resource_contains_addr() to check if the resource
> range contains the input address.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

