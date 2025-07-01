Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721EF1DED52
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368368; cv=none; b=O1vfZUEJLtHpG7d4MM9wxmMapuL0G02AAgx58qVd/M1AH6iwA9qyXgjQRaaKrDougWagOPyCnojRd77IfDrtM3aAXd8E7fq2U7zaMH50127RbXMKTMAyD9oSA3tbEwwv/F3gBDzrE6MKxoHqsOvmsAv/SngxyGTGOgXKAOMZtzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368368; c=relaxed/simple;
	bh=LgvztjXTcyymdScIhXwV3GRIdEcIxnEfjSMzv7XlQuU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xj7fq3Y7XknFJ9ijjAduriAxbriWiv57Id+LMBeVp71S/DNsHaj+/f/SllECFiFeyQugrwESoFl4uO6LQvL6eOfkpWYF3K9Y7CsdifADu1UZIrYmEt1OME9wFOpokYdVrCDfoXQamiNBQMSO/MHBdxofJHDXlF99/CAZU3NPW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWgNP3x86z6L5B0;
	Tue,  1 Jul 2025 19:12:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 06703140373;
	Tue,  1 Jul 2025 19:12:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 13:12:43 +0200
Date: Tue, 1 Jul 2025 12:12:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v4 5/9] cxl/test: Add cxl_test support for new dport
 allocation scheme
Message-ID: <20250701121242.00007738@huawei.com>
In-Reply-To: <20250624213916.1665889-6-dave.jiang@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
	<20250624213916.1665889-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 14:39:12 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In the delayed dport allocation scheme, the total number of dports
> need to be discovered during port probe. Add the mock function
> that does it for cxl_test.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I'm far from an expert on cxl_test but this looks sensible to me
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
 
