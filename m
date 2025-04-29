Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052872746A;
	Tue, 29 Apr 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939857; cv=none; b=iu1Mfp4XJENZ+ahtD12JnnySwvwlWsh1Kh1mV6k4KUTkH2hjSpmR4t/onx6XuM6oJz4daRDlGen5d9W6fVZ2VE+diqyn2XwQC5zFq5xeAOcDZVKDg6f5qZbLdlCKOJYhmb0wJ9gr6rbPLHynS0ACY0y7Sjno416JZsKWduUirDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939857; c=relaxed/simple;
	bh=fY4dRPoP+pQiFTZxHFDTFvVK7d9nBKXDZluCuZrax28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQt5q6hWYy3Rq+PDLMkfzU/KEIKPxiG1GTwXwK9m3uFCBxKXSpnOc257HdxjsW8INsEH4qUBMrT4kZreKNUPexQPYeYy+zsGP5zipdoG4zBiMdlAcwZSIRmrxLHgS1pMAco0aPAquX+Er04FUagkbfEhfk0lk4w3MZlVmGdkGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn3hm64bzz6K5p3;
	Tue, 29 Apr 2025 23:12:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2C7514038F;
	Tue, 29 Apr 2025 23:17:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 17:17:31 +0200
Date: Tue, 29 Apr 2025 16:17:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v5 02/14] cxl/pci: Moving code in cxl_hdm_decode_init()
Message-ID: <20250429161729.000063b3@huawei.com>
In-Reply-To: <20250428214318.1682212-3-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
	<20250428214318.1682212-3-rrichter@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Apr 2025 23:43:05 +0200
Robert Richter <rrichter@amd.com> wrote:

> Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
> cxl_hdm_decode_init()") changed the code flow in this function. The
> root port is determined before a check to leave the function. Since
> the root port is not used by the check it can be moved to run the
> check first. This improves code readability and avoids unnesessary
> code execution.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
