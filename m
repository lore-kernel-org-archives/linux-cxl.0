Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0F1C5783
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770824; cv=none; b=JMqFi5FxUr/h1PwrDEpQVLnYgNYJ8b+BSVOrz2740dTA5561Rboeyyp88yyJegRmFEZKkwmO4Qc80HK59khuXziXZ8R/xaYe0KW1SMHXcM5QZNsvVWf7kJmVu7gvSOWLEPG85ttpkgUfAoY4gWAf+gosqKfldMsANLDqvyS6h/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770824; c=relaxed/simple;
	bh=rPfeAIYMqFQ5e0xgyPr3OmbdtW/v/QU2cbwPGM+wdlI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcQmQf1tPinS81xsA7AvcZRiQSdAADw9DH+k6nWt1Foow3Py9VNeM18IEu8uWKFuM+urk2Yd9tp+9uuEQQNjRq0Zwj+fTFOhpfl812lPre9ZzHK6knvBc71j3l+hOTQntVsx5RPH/qYiEVQA9y+I3lQ/LauCnE1R+2ilqxoU2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtVxq2p11z6K5kp;
	Tue, 27 Aug 2024 22:57:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C148140B3C;
	Tue, 27 Aug 2024 23:00:19 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:00:18 +0100
Date: Tue, 27 Aug 2024 16:00:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/pci: cxl_dport_map_rch_aer() cleanup
Message-ID: <20240827160017.00007102@Huawei.com>
In-Reply-To: <20240827045755.1837473-2-ming4.li@intel.com>
References: <20240827045755.1837473-1-ming4.li@intel.com>
	<20240827045755.1837473-2-ming4.li@intel.com>
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

On Tue, 27 Aug 2024 04:57:54 +0000
Li Ming <ming4.li@intel.com> wrote:

> cxl_dport_map_ras() is used to map CXL RAS capability, the RCH AER
> capability should not be mapped in the function but should mapped in
> cxl_dport_init_aer(). Moving cxl_dport_map_ras() out of
> cxl_dport_map_ras() and into cxl_dport_init_aer().
> 
> In cxl_dport_init_aer(), the AER capability position in RCRB will be
> located but the position is only used in cxl_dport_map_rch_aer(),
> getting the position in cxl_dport_map_rch_aer() rather than
> cxl_dport_init_aer() is more reasonable and makes the code clearer.
> 
> Besides, some local variables in cxl_dport_map_rch_aer() are
> unnecessary, remove them to make the function more concise.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
Seems sensible
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
