Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A2A1DA0E3;
	Thu, 17 Oct 2024 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167598; cv=none; b=cbWsnEZiPLE1ek+Aklc2buwSoT21crCqSTncHt8KY6teBcm5HgO+WpKnnRMb3ThEYyWzY7xDmDe0rpw1PSiutfP+cNxZIng1VQaWEcjMAHpRjA0DNKDa1MaMeS9EmhhBqJx/gdtxScmaTHvYRdbSMPJZ+5owBf48z39m8wkDcZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167598; c=relaxed/simple;
	bh=0Se45DuEVrsFgKoH8uzrFQSCHVbtaNYIrqCbSaxd/z0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS56CsXbUbeQqJUECt2C0AKac7nZDdZCRyYbnWiBjOk7NmZeaYCGFAjvLsXDN4B/sZfVqahV5RPUdQXidFE3wG7p7SZNO5Gy0+k6MFwBtKqSH9VimM2Xew7ZC7nWBTJ9RIC9CZ3i9+h/pv4QinhNk/O9PlaZthd/FAqsHaSAc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTn0w0YMcz6FH3x;
	Thu, 17 Oct 2024 20:18:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CA51140119;
	Thu, 17 Oct 2024 20:19:52 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 14:19:51 +0200
Date: Thu, 17 Oct 2024 13:19:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <shiju.jose@huawei.com>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 1/4] cxl/events: Updates for CXL Common Event Record
 Format
Message-ID: <20241017131949.000047f6@Huawei.com>
In-Reply-To: <20241016163349.1210-2-shiju.jose@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
	<20241016163349.1210-2-shiju.jose@huawei.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 17:33:46 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format has
> updated with Maintenance Operation Subclass information.
> 
> Add updates for the above spec change in the CXL events record and CXL
> common trace event implementations.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
