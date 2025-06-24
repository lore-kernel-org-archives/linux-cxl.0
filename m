Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9A2D5433;
	Tue, 24 Jun 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775904; cv=none; b=ctWj0xvBdmIWCg+dQaDP6MTtLy7NlkKNv26auN9dxpsbjS0ke6dDm5MGEibXenR75H7NQ/uOW1n72Sq4Z8HBAMK132AZXdSmj3XBwhqc+5VNylGtRaMTJNGCB+4mko5TtnhxYaGv5ybHfHOSalRYVcUOvsIz05rpycdiqljoqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775904; c=relaxed/simple;
	bh=Cml1cQ4j/VZ0DPs4TEJ7/ymu+F6EE2al7Tg1RQUEdbs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpscNDTpgbjT53ngRxDdebSBJnO0aQNigdlVa8pu2omlry5sRjygIyuO6NhznsG063x3Qqf7Hv7sJkrmPZCKtoEVL52Nfn5ZW3oAuKTY2GsxYmsnc19gNRE/uFWFI76B3BhYz75zAXxj0+hDLocYnNkHWU4q/R0UIaKWlSAdIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRS9Y04Q6z6J69y;
	Tue, 24 Jun 2025 22:33:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 936C51402E9;
	Tue, 24 Jun 2025 22:38:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Jun
 2025 16:38:20 +0200
Date: Tue, 24 Jun 2025 15:38:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram
 event record
Message-ID: <20250624153818.00000f6b@huawei.com>
In-Reply-To: <20250620052924.138892-1-ming.li@zohomail.com>
References: <20250620052924.138892-1-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 20 Jun 2025 13:29:24 +0800
Li Ming <ming.li@zohomail.com> wrote:

> cxl_find_rec_dram() is used to find a DRAM event record based on the
> inputted attributes. Different repair_type of the inputted attributes
> will check the DRAM event record in different ways.
> When EDAC driver is performing a memory rank sparing, it should use
> CXL_RANK_SPARING rather than CXL_BANK_SPARING as repair_type for DRAM
> event record checking.
> 
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
