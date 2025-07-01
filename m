Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47B246782
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365881; cv=none; b=qc/KEKcID2HYwxP6fLIL4W9tDMt8JQPH9dQn8ze4riobqyqi7cWKbszS/AE4MYOe1ZpJqoHhwo1TKlmSip14Rkm3a0snhGIRgdb+4W+33Py4DjCoQr91RXGnkSH0M6U9ZR0Bb7EBp7wL2DU8kH3DgEzSgsFb2mhmN+agRNJznqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365881; c=relaxed/simple;
	bh=WMSHYdSMgGOp97W0+fPqc2/+PHVO5xy0iioJ0+FctpA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRgw57dts233TgFC4Ksi8d4QHAwNlgQ0HKd4S/x7WmiUh6djTsyesuyU+QmvSof+66/7+FSthpWIDH8/+JsN0jTIth+9pMAlbzwnzBx0DzvSyJDTW9J1Pu6bWoxI7sP9zArcHXsXl5RumLFV6o4VBJQzjiyX5fw/0SEYiO9hd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWfPj4wt0z6HJZW;
	Tue,  1 Jul 2025 18:28:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C75451404C5;
	Tue,  1 Jul 2025 18:31:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 12:31:15 +0200
Date: Tue, 1 Jul 2025 11:31:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v4 3/9] cxl: Add helper to reap dport
Message-ID: <20250701113114.000073a1@huawei.com>
In-Reply-To: <20250624213916.1665889-4-dave.jiang@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
	<20250624213916.1665889-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 14:39:10 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Refactor the code in reap_dports() out to provide a helper function that
> reaps a single dport. This will be used later in the cleanup path for
> allocating a dport.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


