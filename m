Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5D1C689C
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770622; cv=none; b=lT1Yx1qUDWkOR2xstql4iQ7NoQm+ihuhN2xIMPswef/IJQtjr1uc/4ZLtT/oC1ZPN7YtHUaV8G4FcytjIc5IstFkYYl506cqQTuIJGzyhjQOudyN2MTvB3ZDof3lVqO8uRvqT0Cok0yc1M8fSWSlk7ATOThxlK85voXlOAiC9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770622; c=relaxed/simple;
	bh=4f/Te00gZjn6CbwdKHn0440c6Y1uPI1O4xadPO/DVtQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M117gM44w+AiehUAkuRFryB+Azu2Mw+4vProLTCUBo97quM6OCG4CFUdMHWecLmJ5LOQNL6C3aSpfK2Z/jIaXH6okGpS59yu9sSVBXgxPi3NmQOOFbq4JhUH+WHSvxiCu0n6q/+vY3NXaHP5Otc8TFT/1G+3/DRTwaEDiWndb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtVs64WFlz6J77F;
	Tue, 27 Aug 2024 22:52:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 16FB6140B39;
	Tue, 27 Aug 2024 22:56:57 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 15:56:56 +0100
Date: Tue, 27 Aug 2024 15:56:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/pci: Rename cxl_setup_parent_dport() and
 cxl_dport_map_regs()
Message-ID: <20240827155655.00001bd8@Huawei.com>
In-Reply-To: <20240827045755.1837473-1-ming4.li@intel.com>
References: <20240827045755.1837473-1-ming4.li@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 04:57:53 +0000
Li Ming <ming4.li@intel.com> wrote:

> The name of cxl_setup_parent_dport() function is not clear, the function
> is used to initialize AER and RAS capabilities on a dport, therefore,
> rename the function to cxl_dport_init_aer(), it is easier for user to

> understand what the function does. Besides, adjust the order of the
> function parameters, the subject of cxl_dport_init_aer() is a cxl port,
Hmm. It's not just aer, so maybe cxl_dport_init_ras_reporting() is broader
naming that incorporates the fact this includes the CXL specific stuff.
Obvious that might be used to get more detail on an AER error report,
but it's not part of aer.

Don't want to just use _ras() because of all the ras control stuff that
isn't related to this function.

Otherwise LGTM.

Jonathan

> so a struct cxl_dport as the first parameter of the function should be
> better.
> 
> cxl_dport_map_regs() is used to map CXL RAS capability on a cxl dport,
> using cxl_dport_map_ras() as the function name.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
