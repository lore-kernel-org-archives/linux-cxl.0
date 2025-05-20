Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844D20C480
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739961; cv=none; b=mnZJezNqF9aNN+CBMVMo310ZY1QXS2xsScKMbf7EG8AZAUSfdi2L50crvr6MrcwvJi4fu03ysg989mbMwwkpXr7bRaz+nB1VPOUM8fsXlKkMNSrm+sO2B0aTFHa8TbfoDnyLB/o9IozgPkJRHmPdh1Pqp+L7lHZW74IJe5EvnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739961; c=relaxed/simple;
	bh=MA/uK1e3BsBlClhK2+VYEZE6mggk1o84X6CLcH9nPiI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7+bWxOHdH02POzfxqSYxXIv+TgkSt9t3lKFH0OkJCZSl5vmBGMWn/ACqu6fhZNmREGhtWRJVC8XEOS83OiktdUTsy36Za48oGsLJ0mwZHloLu2w6IT3dfh+k86QYDRFevyTbSZqIIlSZOhmhx5SN2XDL2dQkOmSNrMlX904L4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1sS80NK7z6L54m;
	Tue, 20 May 2025 19:16:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 09AC91402F7;
	Tue, 20 May 2025 19:19:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 13:19:15 +0200
Date: Tue, 20 May 2025 12:19:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual
 dport hardware id
Message-ID: <20250520121913.00002fff@huawei.com>
In-Reply-To: <20250507004310.3536991-3-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-3-dave.jiang@intel.com>
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

On Tue, 6 May 2025 17:43:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_num to maintain compatibility and
> introduce a dport->id as the enumeration id.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Given you already fixed the typo in title.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


