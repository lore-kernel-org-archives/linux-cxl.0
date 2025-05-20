Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C41EB5DA
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740220; cv=none; b=k7YIy9ezBT+YUnEEOHX6Y8QTKjG4Gc7eWBrWyk8ZZu3s+cCLShohXru7M6pDEh+OnPauYP6wpFHt/RhCz0ZxBBTDVUcDjlpNWSUaRfs46ODbxzhQocZghtdCP9iXvQEwVlsrN2l5jGmYBSz1a2KztckRBj64ivHs5TG7pAd48uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740220; c=relaxed/simple;
	bh=P1smPv3IxdwZ9WpirriwavSU4pizoCpn/s+HugJFRJc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGUyp0o1BaDwTXmiuqsQBTTBToxW+pYEUfLSymH2EViFyGZjV1xwsmrmcb+atCyk6LqgmwBW2sEkZNWC3yJpGbVujXqxQdT568Svr2eW8AYDav7yvg0huCJTRRYZwOM5p9vnEnFHuDmIkADueCwBqJnxCUamuLbrAsdkfJjLOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1sWC3GhJz6M4rF;
	Tue, 20 May 2025 19:18:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 51E9E1402FF;
	Tue, 20 May 2025 19:23:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 13:23:36 +0200
Date: Tue, 20 May 2025 12:23:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 04/10] cxl: Remove adding of port_num via
 devm_cxl_add_dport()
Message-ID: <20250520122335.00004e9d@huawei.com>
In-Reply-To: <20250507004310.3536991-5-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 6 May 2025 17:43:04 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In preparation for delayed dport probing, remove setting of port_num
> through devm_cxl_add_dport(). Will temporarily set the port_num after
> dport is added for now.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
