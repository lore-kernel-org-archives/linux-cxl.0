Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B779E1;
	Fri, 13 Jun 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810844; cv=none; b=Bn4ervRLmgr5rpZnu1UxuUUESFX7AJgf5en0B/LfpzIWFAMUe6OkBApU0abjld44IeW3GzqSQXsupbOA3EQycpXs15bo/LyOsc972P97FL2wDVn9EBosHacbvK7Dsnh78MaO/Ya0T5z6/fn22dM9dYDBXUcYPmVj+8sx3MBia60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810844; c=relaxed/simple;
	bh=0Xsk0BzMXLVmV2arofZQHOukzwRb12YXb9fl2UpbEoA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwT2fgFr6f5Bct/g3XDctNKAo5F+vsF+bRWE6djY+6zUTbk1CbQPPFCX6q1Z3JeWLzUDyNwQPJycHgVgRVacyOHrlVtAGLTsKvOcTVWO223Wp+i64mBDSjqtLhskLcNvqnD4fwO8k1UKg2uVu6FLlGqUQ8+BRIZ7E1XzY9iU1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJbMv6qJmz6M4r9;
	Fri, 13 Jun 2025 18:33:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 193C01402F7;
	Fri, 13 Jun 2025 18:33:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 12:33:58 +0200
Date: Fri, 13 Jun 2025 11:33:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] cxl/edac: Fix potential memory leak issues
Message-ID: <20250613113357.00002214@huawei.com>
In-Reply-To: <20250613011648.102840-1-ming.li@zohomail.com>
References: <20250613011648.102840-1-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Jun 2025 09:16:48 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
> duplicate a cxl gen_media/dram event to store the event in a xarray by
> xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
> be freed in the case that the xa_store() fails.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
